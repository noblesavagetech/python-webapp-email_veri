#!/usr/bin/env python3
"""Clear all users from the database."""

import sys
from app import app
from models import db, User

def clear_users():
    """Delete all users from the database."""
    with app.app_context():
        try:
            count = User.query.count()
            User.query.delete()
            db.session.commit()
            print(f"✓ Deleted {count} user(s) from database")
            return 0
        except Exception as e:
            db.session.rollback()
            print(f"✗ Failed to clear users: {e}", file=sys.stderr)
            return 1

if __name__ == '__main__':
    sys.exit(clear_users())
