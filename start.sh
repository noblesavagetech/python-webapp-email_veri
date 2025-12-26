#!/bin/bash
set -e

echo "Running database initialization..."
python init_db.py

echo "Starting application on port ${PORT}"
exec gunicorn app:app --bind "0.0.0.0:${PORT}"
if ! psql -h localhost -U vscode -lqt | cut -d \| -f 1 | grep -qw email_verification_db; then
    echo "Creating database..."
    psql -h localhost -U vscode -d postgres -c "CREATE DATABASE email_verification_db;"
fi

# Activate virtual environment and start Flask
cd /workspaces/python-webapp-email_veri
source venv/bin/activate
echo "Starting Flask app on http://localhost:5000"
python app.py
