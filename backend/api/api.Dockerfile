# Dockerfile for Academic Hub Backend API

FROM python:3.12-slim

WORKDIR /app

# Set environment variables
# PYTHONDONTWRITEBYTECODE: Prevents Python from writing pyc files to disc (equivalent to python -B option)
# PYTHONUNBUFFERED: Prevents Python from buffering stdout and stderr (equivalent to python -u option)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# * DB_HOST must match the name of the database container
ENV DB_HOST='a-hub-db'
ENV DB_NAME='academic_hub'
ENV DB_OWNER_ADMIN='academic_hub_owner'
ENV DB_OWNER_PWORD='some_secure_password'

# # # Install system dependencies
# RUN apt-get update && apt-get install -y --no-install-recommends

# Copy only the requirements file first
COPY requirements.txt .

# Create and activate a virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# * Run tests
# This step ensures that we don't build images with failing tests
# RUN python -m pytest

# Expose the port the app runs on
EXPOSE 8000

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]

# todo: Impl healthcheck
# 30s interval between checks, 30s timeout for each check, 3 retries before marking as unhealthy
# wait 5 seconds before starting the checks
# HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
#     CMD curl -f http://localhost:8000/health || exit 1
