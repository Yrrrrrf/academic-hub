# Dockerfile for Academic Hub Database
FROM postgres:16

# Set environment variables for database configuration
ENV LANG=en_US.utf8
ENV TZ=Etc/UTC


# * Password-related variables
# * In production, use secrets management to store these values
ENV PASSWORD_INFRASTRUCTURE="infra_password"
ENV PASSWORD_HR="hr_password"
ENV PASSWORD_ACADEMIC="academic_password"
ENV PASSWORD_COURSE_OFFERING="course_offering_password"
ENV PASSWORD_STUDENT="student_password"
ENV PASSWORD_LIBRARY="library_password"

# Copy the schema setup SQL file
COPY init/01-schema-setup.sql /init/
COPY init/02-tables/*.sql /init/
COPY init/03-data/*.sql /init/
# COPY init/04_data/*.sql /init/

# Copy the initialization script
COPY scripts/init-db.sh /docker-entrypoint-initdb.d/

# Make sure the script is executable
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

# Expose the default PostgreSQL port
EXPOSE 5432
