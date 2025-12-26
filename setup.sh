#!/bin/bash

echo "🚀 Email Verification App - Setup Script"
echo "=========================================="
echo ""

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "📥 Installing Python dependencies..."
pip install -q -r requirements.txt

# Check if PostgreSQL is running
if ! pg_isready -h localhost -p 5432 > /dev/null 2>&1; then
    echo "🐘 PostgreSQL not running. Initializing..."
    
    # Initialize database if needed
    if [ ! -d ~/pgdata ]; then
        echo "   Initializing database cluster..."
        initdb -D ~/pgdata
    fi
    
    # Start PostgreSQL
    echo "   Starting PostgreSQL..."
    postgres -D ~/pgdata -p 5432 -k /tmp > ~/postgres.log 2>&1 &
    sleep 3
fi

# Create database if it doesn't exist
echo "🗄️  Setting up database..."
psql -h localhost -U vscode -d postgres -c "SELECT 1 FROM pg_database WHERE datname = 'email_verification_db';" | grep -q 1 || \
    psql -h localhost -U vscode -d postgres -c "CREATE DATABASE email_verification_db;"

# Check if .env exists
if [ ! -f .env ]; then
    echo "⚠️  No .env file found. Copying from .env.example..."
    cp .env.example .env
    echo ""
    echo "⚙️  IMPORTANT: Edit .env and add your Brevo API credentials:"
    echo "   - BREVO_API_KEY"
    echo "   - SENDER_EMAIL"
    echo "   - SENDER_NAME"
    echo ""
fi

echo "✅ Setup complete!"
echo ""
echo "To start the app, run:"
echo "  ./start.sh"
echo ""
echo "Or manually:"
echo "  source venv/bin/activate"
echo "  python app.py"
echo ""
