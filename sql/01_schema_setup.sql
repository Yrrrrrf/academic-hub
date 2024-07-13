-- File: 01_schema_setup.sql
--     Sets up schemas and roles for the database.
--
-- # Script steps:
-- 1. Defines the 'create_schemas' function to create schemas
-- 2. Defines the 'create_and_grant_role' function to create roles and grant privileges over schemas
-- 2. Creates roles for different administrative functions
-- 3. Grants appropriate permissions to roles for their respective schemas


-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Function to create schemas
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

-- Function to create role and grant privileges
CREATE OR REPLACE FUNCTION create_and_grant_role(
    role_name TEXT,
    role_password TEXT,
    schema_names TEXT[]
) RETURNS VOID AS $$
DECLARE
    schema_name TEXT;
BEGIN
    -- Create role if it doesn't exist
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = role_name) THEN
        EXECUTE format('CREATE ROLE %I WITH LOGIN PASSWORD %L', role_name, role_password);
        RAISE NOTICE 'Role % created successfully', role_name;
    ELSE
        RAISE NOTICE 'Role % already exists', role_name;
    END IF;

    -- Grant privileges
    FOREACH schema_name IN ARRAY schema_names
    LOOP
        EXECUTE format('GRANT USAGE, CREATE ON SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL PRIVILEGES ON TABLES TO %I', schema_name, role_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL PRIVILEGES ON SEQUENCES TO %I', schema_name, role_name);
    END LOOP;
    RAISE NOTICE 'Privileges granted to % on schemas %', role_name, schema_names;
END;
$$ LANGUAGE plpgsql;

-- Create schemas
SELECT create_schemas(ARRAY[
    'public',
    'auth',
    'infrastructure_management',
    'school_management',
    'library_management',
    'finance_management',
    'hr_management',
    'research_management'
]);

-- Create roles and grant privileges
SELECT create_and_grant_role(
    'infrastructure_admin',
    'infra_password',
    ARRAY['public', 'infrastructure_management']
);

SELECT create_and_grant_role(
    'school_admin',
    'school_password',
    ARRAY['public', 'infrastructure_management', 'school_management']
);

SELECT create_and_grant_role(
    'library_admin',
    'library_password',
    ARRAY['public', 'infrastructure_management', 'library_management']
);

-- SELECT create_and_grant_role(
--     'finance_admin',
--     'finance_password',
--     ARRAY['public', 'finance_management']
-- );
--
-- SELECT create_and_grant_role(
--     'hr_admin',
--     'hr_password',
--     ARRAY['public', 'hr_management']
-- );
--
-- SELECT create_and_grant_role(
--     'research_admin',
--     'research_password',
--     ARRAY['public', 'research_management']
-- );

-- -- Grant additional privileges to specific roles if needed
-- DO $$
-- BEGIN
--     -- Example: Grant school_admin access to finance_management schema
--     EXECUTE format('GRANT USAGE ON SCHEMA %I TO %I', 'finance_management', 'school_admin');
--     EXECUTE format('GRANT SELECT ON ALL TABLES IN SCHEMA %I TO %I', 'finance_management', 'school_admin');
--     RAISE NOTICE 'Additional privileges granted to school_admin';
-- END $$;
--
-- RAISE NOTICE 'Schema and role setup completed successfully.';