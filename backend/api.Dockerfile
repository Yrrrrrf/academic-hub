# Use Python 3.12 slim image as the base
# The slim version is smaller than the full image but still includes necessary libraries
FROM python:3.12

# Metadata and labels
LABEL maintainer="Academic Hub Team <some.team@academichub.com>"
LABEL version="0.2.1"
LABEL description="Backend API for Academic Hub - Comprehensive academic data management system"

# Set environment variables
# PYTHONDONTWRITEBYTECODE: Prevents Python from writing pyc files to disc (equivalent to python -B option)
# PYTHONUNBUFFERED: Prevents Python from buffering stdout and stderr (equivalent to python -u option)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory in the container
# * This Docker image will alloc the 'backend' directory as the working directory
# This is where our app will live inside the container
WORKDIR /backend
# * Set the working directory to /backend (inside the container)
# * This name is arbitrary and can be anything

# # Install system dependencies
# # We use --no-install-recommends to not install recommended but not required deps, reducing image size
RUN apt-get update && apt-get install -y --no-install-recommends

# Copy only the requirements file first
# This step is separated from the app code copy to leverage Docker cache
COPY requirements.txt .

# Create and activate a virtual environment
# Using a virtual environment is a best practice to isolate our app dependencies
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install dependencies
# We use --no-cache-dir to reduce the image size by not caching the downloaded packages
# * This is also useful when we want to rebuild the image to get the latest dependencies
# RUN pip install --no-cache-dir --upgrade pip && \
#     pip install --no-cache-dir -r requirements.txt

# ^ same as above but without the option --no-cache-dir
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy the rest of the application
# This step is done after installing dependencies to leverage Docker cache
COPY . .
# ^ Same as: COPY . /backend

# * Run tests
# This step ensures that we don't build images with failing tests
# todo: Impl tests
# RUN python -m pytest

# Set the default environment variables
# # This is equivalent to running the command: export PORT=8000
# ENV PORT=8000
# Expose the port the app runs on
EXPOSE 8000

# * Add some environment variables
# * These are used by the FastAPI app to connect to the database
# * Database configuration settings
ENV DB_NAME='academic_hub'
ENV DB_HOST='localhost'
ENV DB_OWNER_ADMIN='academic_hub_user'
ENV DB_OWNER_PWORD='some_password'

# Command to run the application
# Using gunicorn as the WSGI server is recommended for production
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "4", "app.main:app"]
# - guinicorn: The Gunicorn server
# - --bind: The host and port to bind to port 8000
# - --workers: The number of worker processes (4 in this case)
# - app.main:app: The module and app instance to run
# A more simple command to run the app is:
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]

# # Health check
# # This helps Docker determine if our container is healthy
# HEALTHCHECK CMD curl --fail http://localhost:8000/health || exit 1
