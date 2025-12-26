"""Gunicorn configuration for Railway deployment."""
import os
import sys

# Get PORT from environment
port = os.environ.get('PORT')
print(f"DEBUG: PORT environment variable = {port}", file=sys.stderr)

if not port:
    print("WARNING: PORT not set, using default 5000", file=sys.stderr)
    port = '5000'

# Bind to the PORT environment variable provided by Railway
bind = f"0.0.0.0:{port}"
print(f"DEBUG: Binding to {bind}", file=sys.stderr)

# Worker configuration
workers = 2
worker_class = 'sync'

# Logging
accesslog = '-'
errorlog = '-'
loglevel = 'info'
