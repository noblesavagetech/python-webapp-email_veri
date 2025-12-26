import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

class Config:
    """Application configuration - Email sending only (no receiving)."""
    
    # Flask Settings
    SECRET_KEY = os.getenv('SECRET_KEY', 'dev-secret-key-change-in-production')
    
    # Database Settings
    # Railway provides DATABASE_URL, ensure it's set
    database_url = os.getenv('DATABASE_URL')
    if database_url and database_url.startswith('postgres://'):
        # Fix for SQLAlchemy 1.4+ which requires postgresql://
        database_url = database_url.replace('postgres://', 'postgresql://', 1)
    
    SQLALCHEMY_DATABASE_URI = database_url
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
    # Brevo SMTP Settings (Sending Only - No Email Receiving)
    SMTP_SERVER = os.getenv('SMTP_SERVER', 'smtp-relay.brevo.com')
    SMTP_PORT = int(os.getenv('SMTP_PORT', '587'))
    SMTP_LOGIN = os.getenv('SMTP_LOGIN')
    SMTP_PASSWORD = os.getenv('SMTP_PASSWORD')
    SMTP_TIMEOUT = 10  # Add timeout for SMTP connections
    SENDER_EMAIL = os.getenv('SENDER_EMAIL')  # Send-only address
    SENDER_NAME = os.getenv('SENDER_NAME', 'BBA Services')
    
    # Application Settings
    APP_URL = os.getenv('APP_URL', 'http://localhost:5000')
    TOKEN_EXPIRATION = int(os.getenv('TOKEN_EXPIRATION', 86400))  # 24 hours default
    
    # Security Settings
    SESSION_COOKIE_SECURE = os.getenv('FLASK_ENV') == 'production'
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SAMESITE = 'Lax'
