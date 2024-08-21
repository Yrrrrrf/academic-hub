# Dockerfile for Academic Hub Database

FROM postgres:16

# Set environment variables for database configuration
ENV POSTGRES_DB="academic_hub"
ENV POSTGRES_USER="academic_hub_owner"
ENV POSTGRES_PASSWORD="some_secure_password"
ENV LANG=en_US.utf8
ENV TZ=Etc/UTC

# Set schema-specific variables
ENV SCHEMA_AUTH="auth"
ENV SCHEMA_INFRASTRUCTURE="infrastructure_management"
ENV SCHEMA_HR="hr_management"
ENV SCHEMA_ACADEMIC="academic_management"
ENV SCHEMA_COURSE_OFFERING="course_offering_management"
ENV SCHEMA_STUDENT="student_management"
ENV SCHEMA_LIBRARY="library_management"

# Set role-specific passwords (in production, use secrets management)
ENV PASSWORD_INFRASTRUCTURE="infra_password"
ENV PASSWORD_HR="hr_password"
ENV PASSWORD_ACADEMIC="academic_password"
ENV PASSWORD_COURSE_OFFERING="course_offering_password"
ENV PASSWORD_STUDENT="student_password"
ENV PASSWORD_LIBRARY="library_password"

# Copy the schema setup SQL file
COPY init/01_schema_setup.sql /init/
COPY init/02_tables/*.sql /init/
COPY init/03_data/*.sql /init/

# Copy the initialization script
COPY scripts/init-db.sh /docker-entrypoint-initdb.d/

# Make sure the script is executable
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

# Expose the default PostgreSQL port
EXPOSE 5432
