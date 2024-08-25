-- File: 00_db_setup.sql
--     Creates the Academic Hub database and its owner role without any parameter prompts.
--     Updates the password for the owner role if it already exists.
--     Grants CREATEROLE permission to the owner role.
--
-- Note: This script should be run by a PostgreSQL superuser.
--
-- # Script steps:
-- 1. Creates a database owner role if it doesn't exist, or updates its password if it does
-- 2. Grants CREATEROLE permission to the owner role
-- 3. Creates a new database with the specified owner if it doesn't exist
-- 4. Enables necessary extensions in the new database

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Set variables for the db_owner and db_owner_password
-- Note: Change these values as needed (it will update the password if the role already exists)
DO $$
DECLARE
    db_owner TEXT := 'academic_hub_owner';
    db_owner_password TEXT := 'some_secure_password'; -- TODO: Use more secure method in production
BEGIN
    IF EXISTS (SELECT FROM pg_roles WHERE rolname = db_owner) THEN
        EXECUTE format('ALTER ROLE %I WITH PASSWORD %L CREATEROLE', db_owner, db_owner_password);
        RAISE NOTICE 'Password updated and CREATEROLE granted for existing role %', db_owner;
    ELSE
        EXECUTE format('CREATE ROLE %I LOGIN PASSWORD %L CREATEROLE', db_owner, db_owner_password);
        RAISE NOTICE 'Role % created successfully with CREATEROLE permission', db_owner;
    END IF;
END $$;

-- Terminate existing connections to the database if it exists
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'academic_hub';

-- Check if the database exists
SELECT EXISTS(SELECT 1 FROM pg_database WHERE datname = 'academic_hub') AS db_exists \gset

-- Create the database if it doesn't exist
\if :db_exists
    \echo 'Database academic_hub already exists'
\else
    CREATE DATABASE academic_hub
    WITH
    OWNER = academic_hub_owner
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TEMPLATE = template0
    CONNECTION LIMIT = -1;

    \echo 'Database academic_hub created successfully'
\endif

-- Set database parameters
ALTER DATABASE academic_hub SET search_path TO public;

-- * Connect to the new database
-- Change the database to academic_hub (if not already connected)
\c academic_hub
