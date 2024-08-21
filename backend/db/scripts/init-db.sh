#!/bin/bash
set -e

echo "Executing database initialization scripts..."

# Function to execute SQL file with variable substitution
execute_sql_file() {
    local file=$1
    echo "Executing $file..."
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
$(sed \
  -e "s|:'SCHEMA_AUTH'|'$SCHEMA_AUTH'|g" \
  -e "s|:'SCHEMA_INFRASTRUCTURE'|'$SCHEMA_INFRASTRUCTURE'|g" \
  -e "s|:'SCHEMA_HR'|'$SCHEMA_HR'|g" \
  -e "s|:'SCHEMA_ACADEMIC'|'$SCHEMA_ACADEMIC'|g" \
  -e "s|:'SCHEMA_COURSE_OFFERING'|'$SCHEMA_COURSE_OFFERING'|g" \
  -e "s|:'SCHEMA_STUDENT'|'$SCHEMA_STUDENT'|g" \
  -e "s|:'SCHEMA_LIBRARY'|'$SCHEMA_LIBRARY'|g" \
  -e "s|:'PASSWORD_INFRASTRUCTURE'|'$PASSWORD_INFRASTRUCTURE'|g" \
  -e "s|:'PASSWORD_HR'|'$PASSWORD_HR'|g" \
  -e "s|:'PASSWORD_ACADEMIC'|'$PASSWORD_ACADEMIC'|g" \
  -e "s|:'PASSWORD_COURSE_OFFERING'|'$PASSWORD_COURSE_OFFERING'|g" \
  -e "s|:'PASSWORD_STUDENT'|'$PASSWORD_STUDENT'|g" \
  -e "s|:'PASSWORD_LIBRARY'|'$PASSWORD_LIBRARY'|g" \
  "$file")
EOSQL
    echo "Completed executing $file."
}

# Execute schema setup script
execute_sql_file "/init/01_schema_setup.sql"

# Execute all SQL files in the /init directory (excluding 01_schema_setup.sql)
for file in /init/*.sql; do
    if [ "$file" != "/init/01_schema_setup.sql" ]; then
        execute_sql_file "$file"
    fi
done

echo "Database initialization completed successfully."