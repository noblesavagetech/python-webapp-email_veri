"""
Flask Email Verification App
Main application entry point
"""
import os
from flask import Flask
from flask_login import LoginManager
from models import db, User
from routes.auth import auth_bp
from routes.main import main_bp
from config import Config

def create_app():
    """Application factory pattern"""
    app = Flask(__name__)
    app.config.from_object(Config)
    
    # Validate required configuration
    if not app.config.get('SQLALCHEMY_DATABASE_URI'):
        print("\n" + "="*80)
        print("ERROR: DATABASE_URL environment variable is not set!")
        print("="*80)
        print("\nIn Railway:")
        print("1. Click '+ New' button")
        print("2. Select 'Database' → 'Add PostgreSQL'")
        print("3. Railway will automatically set DATABASE_URL")
        print("4. Redeploy your service")
        print("="*80 + "\n")
        raise RuntimeError("DATABASE_URL is required. Add PostgreSQL database in Railway.")
    
    # Initialize database
    db.init_app(app)
    
    # Initialize Flask-Login
    login_manager = LoginManager()
    login_manager.init_app(app)
    login_manager.login_view = 'auth.login'
    login_manager.login_message = 'Please log in to access this page.'
    
    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))
    
    # Register blueprints
    app.register_blueprint(auth_bp)
    app.register_blueprint(main_bp)
    
    # Create tables
    with app.app_context():
        db.create_all()
    
    return app

# Create app instance for gunicorn
app = create_app()

if __name__ == '__main__':
    # Use PORT from environment (Railway sets this) or default to 5000
    port = int(os.getenv('PORT', 5000))
    # Only use debug mode in development
    debug = os.getenv('FLASK_ENV') != 'production'
    app.run(host='0.0.0.0', port=port, debug=debug)

# Gunicorn configuration (for Railway deployment)
bind = f"0.0.0.0:{os.getenv('PORT', '5000')}"
