FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Make init script executable
RUN chmod +x init_db.py

# Default command (overridden in docker-compose)
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:5000"]
