# Use the official PostgreSQL image as a base
FROM postgres:16

# Copy the SQL files into the container
COPY ./sql/*.sql /docker-entrypoint-initdb.d/

# The official PostgreSQL image automatically runs scripts in 
# /docker-entrypoint-initdb.d/ in alphabetical order on startup
