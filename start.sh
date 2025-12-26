#!/bin/bash

# Start PostgreSQL if not running
if ! pg_isready -h localhost -p 5432 > /dev/null 2>&1; then
    echo "Starting PostgreSQL..."
    postgres -D ~/pgdata -p 5432 -k /tmp > ~/postgres.log 2>&1 &
    sleep 3
fi

# Check if database exists, create if not
if ! psql -h localhost -U vscode -lqt | cut -d \| -f 1 | grep -qw email_verification_db; then
    echo "Creating database..."
    psql -h localhost -U vscode -d postgres -c "CREATE DATABASE email_verification_db;"
fi

# Activate virtual environment and start Flask
cd /workspaces/python-webapp-email_veri
source venv/bin/activate
echo "Starting Flask app on http://localhost:5000"
python app.py
