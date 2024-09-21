-- File: 01_schema_setup.sql
--     Sets up schemas and roles for the Academic Hub database.
--
-- # Purpose:
--     This script creates the necessary schemas for the Academic Hub system and sets up
--     appropriate roles with specific permissions for each schema. It establishes the
--     foundational structure for managing various aspects of an academic institution,
--     from infrastructure and HR to academic programs and student management.
--
-- # Script steps:
--     1. Creates specified schemas with a logical structure
--     2. Creates roles with appropriate permissions
--     3. Establishes cross-schema access where necessary
--
-- # Note:
--     Ensure this script is run by a user with sufficient privileges to create schemas and roles.

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- ^ Enable necessary extensions in the database
--    These extensions provide additional functionality for data management and analysis.
DO $$
DECLARE
    ext TEXT;  -- Extension name
    extensions TEXT[] := ARRAY[  -- List of extensions to enable
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

-- ^ Function to create schemas
CREATE OR REPLACE FUNCTION create_schemas(schema_names TEXT[])
RETURNS VOID AS $$
DECLARE
    schema_name TEXT;
BEGIN
    FOREACH schema_name IN ARRAY schema_names
    LOOP
        EXECUTE format('CREATE SCHEMA IF NOT EXISTS %I', schema_name);
        RAISE NOTICE 'Schema % created or already exists', schema_name;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- ^ Function to create role and grant privileges
CREATE OR REPLACE FUNCTION create_and_grant_role(
    role_name TEXT,
    role_password TEXT,
    primary_schemas TEXT[],
    read_schemas TEXT[]
) RETURNS VOID AS $$
DECLARE
    schema_name TEXT;
BEGIN
    -- Create role if it doesn't exist, otherwise update password
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = role_name) THEN
        EXECUTE format('CREATE ROLE %I WITH LOGIN PASSWORD %L', role_name, role_password);
        RAISE NOTICE 'Role % created successfully', role_name;
    ELSE
        EXECUTE format('ALTER ROLE %I WITH PASSWORD %L', role_name, role_password);
        RAISE NOTICE 'Password updated for existing role %', role_name;
    END IF;

    -- Grant full privileges on primary schemas (for data management)
    FOREACH schema_name IN ARRAY primary_schemas
    LOOP
        EXECUTE format('GRANT ALL PRIVILEGES ON SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL PRIVILEGES ON TABLES TO %I', schema_name, role_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL PRIVILEGES ON SEQUENCES TO %I', schema_name, role_name);
    END LOOP;

    -- Grant read privileges on specified schemas (for cross-schema access)
    FOREACH schema_name IN ARRAY read_schemas
    LOOP
        EXECUTE format('GRANT USAGE ON SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('GRANT SELECT ON ALL TABLES IN SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT SELECT ON TABLES TO %I', schema_name, role_name);
    END LOOP;

    RAISE NOTICE 'Privileges granted to % on primary schemas % and read access to %', role_name, primary_schemas, read_schemas;
END;
$$ LANGUAGE plpgsql;

-- todo: Break it into many instances to expose the db partially


-- * Create schemas
SELECT create_schemas(ARRAY[
    'auth',
    'agnostic',
    'infrastructure',
    'hr',
    'academic',
    'course_offering',
    'student',
    'library'
]);

-- Create roles and grant privileges for each schema

-- Infrastructure Management Schema
SELECT create_and_grant_role(
    'infrastructure_admin',
    'in_password',
    ARRAY['infrastructure'],
    ARRAY['hr']
);

-- HR Management Schema
SELECT create_and_grant_role(
    'hr_admin',
    'hr_password',
    ARRAY['hr', 'auth'],
    ARRAY['academic']
);

-- Academic Management Schema
SELECT create_and_grant_role(
    'academic_admin',
    'ac_password',
    ARRAY['academic', 'course_offering', 'agnostic'],
    ARRAY['student', 'library']
);

-- Course Offering Management Schema
SELECT create_and_grant_role(
    'course_offering_admin',
    'co_password',
    ARRAY['course_offering'],
    ARRAY['academic', 'hr']
);

-- Student Management Schema
SELECT create_and_grant_role(
    'student_admin',
    'st_password',
    ARRAY['student', 'auth'],
    ARRAY['academic', 'course_offering', 'library', 'agnostic']
);

-- Library Management Schema
SELECT create_and_grant_role(
    'library_admin',
    'li_password',
    ARRAY['library', 'agnostic'],
    ARRAY['student', 'infrastructure']
);