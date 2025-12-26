#!/usr/bin/env python3
"""Initialize or migrate the database schema."""

import sys
from app import app
from models import db

def init_database():
    """Create all database tables based on SQLAlchemy models."""
    with app.app_context():
        try:
            # Create all tables
            db.create_all()
            print("✓ Database schema initialized successfully")
            return 0
        except Exception as e:
            print(f"✗ Database initialization failed: {e}", file=sys.stderr)
            return 1

if __name__ == '__main__':
    sys.exit(init_database())
