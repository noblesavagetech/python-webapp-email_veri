"""Gunicorn configuration for Railway deployment."""
import os

# Bind to the PORT environment variable provided by Railway
bind = f"0.0.0.0:{os.environ.get('PORT', '5000')}"

# Worker configuration
workers = 2
worker_class = 'sync'

# Logging
accesslog = '-'
errorlog = '-'
loglevel = 'info'
