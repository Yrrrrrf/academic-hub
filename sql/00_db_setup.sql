-- File: 00_db_setup.sql
--     Creates the Academic Hub database and its owner role without any parameter prompts.
--
-- Note: This script should be run by a PostgreSQL superuser.
--
-- # Script steps:
-- 1. Creates a database owner role if it doesn't exist
-- 2. Creates a new database with the specified owner if it doesn't exist
-- 3. Enables necessary extensions in the new database

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Create owner role
DO $$
DECLARE
    db_owner TEXT := 'academic_hub_owner';
    db_owner_password TEXT := 'ah_secure_password'; -- TODO: Use more secure method in production
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = db_owner) THEN
        EXECUTE format('CREATE ROLE %I LOGIN PASSWORD %L', db_owner, db_owner_password);
        RAISE NOTICE 'Role % created successfully', db_owner;
    ELSE
        RAISE NOTICE 'Role % already exists', db_owner;
    END IF;
END $$;

-- Terminate existing connections to the database if it exists
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'academic_hub';

-- Create the database if it doesn't exist
CREATE DATABASE academic_hub
    WITH
    OWNER = academic_hub_owner
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TEMPLATE = template0
    CONNECTION LIMIT = -1;

-- Set database parameters
ALTER DATABASE academic_hub SET search_path TO public;

-- Connect to the new database
\c academic_hub

-- Enable necessary extensions
DO $$
DECLARE
    ext TEXT;
    extensions TEXT[] := ARRAY[
        'uuid-ossp',  -- generate universally unique identifiers (UUIDs)
        'pgcrypto',   -- cryptographic functions
        'pg_trgm'     -- trigram matching for similarity search (for example, in full-text search)
    ];
BEGIN
    FOREACH ext IN ARRAY extensions
    LOOP
        EXECUTE format('CREATE EXTENSION IF NOT EXISTS %I', ext);
        RAISE NOTICE 'Extension % enabled', ext;
    END LOOP;
END $$;

RAISE NOTICE 'Database setup completed successfully.';