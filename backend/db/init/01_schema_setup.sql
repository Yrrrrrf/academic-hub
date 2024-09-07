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
    -- * Core schemas
    --     These are the main schemas that contain core data for the ORGANIZATION
    'agnostic',              -- For shared data and cross-schema access
    :'SCHEMA_AUTH',                  -- For authentication and authorization
    'infrastructure',        -- For infrastructure-related (buildings, equipment, etc.)
    :'SCHEMA_HR',                    -- For HR-related (employees, payroll, etc.)

    -- * Functional schemas
    --     These schemas are related to specific functions within the organization
    'academic',              -- For academic management (academic programs, syllabi, etc.)
    'course_offering',       -- For course offering-related (schedules, assignments, etc.)
    'student',               -- For student-related (enrollment, grades, etc.)
    'library'                -- For library-related (books, loans, etc.)

    -- * Additional schemas (commented out for future use)
    --     These schemas are for additional functions or departments
    -- :'SCHEMA_FINANCE',            -- For finance-related (budgets, expenses, etc.)
    -- :'SCHEMA_RESEARCH'            -- For research-related (projects, publications, etc.)
]);


-- * Create roles and grant privileges for each schema

-- Infrastructure Management Schema
--     Purpose: Handles all aspects of physical and digital infrastructure.
--     Rationale: Centralizes management of buildings, rooms, equipment, and IT infrastructure,
--                facilitating efficient resource allocation and maintenance planning.
SELECT create_and_grant_role(
    'infrastructure_admin',
    :'PASSWORD_INFRASTRUCTURE',
    ARRAY['infrastructure'],
    ARRAY[:'SCHEMA_HR']  -- Read access to HR for asset assignment
);

-- HR Management Schema
--     Purpose: Manages all employee-related data and processes.
--     Rationale: Centralizes employee information, including faculty, staff, and administrators.
--                Crucial for maintaining consistent employee records, payroll, and organizational structure.
SELECT create_and_grant_role(
    'hr_admin',
    :'PASSWORD_HR',
    ARRAY[:'SCHEMA_HR', :'SCHEMA_AUTH'],
    ARRAY['academic']  -- Read access for academic roles
);

-- Academic Management Schema
--     Purpose: Manages academic programs, curricula, and long-term academic planning.
--     Rationale: Focuses on the structural aspects of academic offerings, supporting
--                strategic academic planning and accreditation processes.
SELECT create_and_grant_role(
    'academic_admin',
    :'PASSWORD_ACADEMIC',
    ARRAY['academic', 'course_offering', 'agnostic'],
    ARRAY['student', 'library']  -- Read access for student and library data
);

-- Course Offering Management Schema
--     Purpose: Handles the operational aspects of course offerings, including scheduling and delivery.
--     Rationale: Manages the dynamic, term-based course operations, allowing for efficient
--                handling of course offering-specific data and processes.
SELECT create_and_grant_role(
    'course_offering_admin',
    :'PASSWORD_COURSE_OFFERING',
    ARRAY['course_offering'],
    ARRAY['academic', :'SCHEMA_HR']  -- Read access for related data
);

-- Student Management Schema
--     Purpose: Handles all student-related data and processes.
--     Rationale: Centralizes student information, supporting the entire student lifecycle from admission to alumni.
--                Separation allows for specialized handling of student data, including privacy and regulatory compliance.
SELECT create_and_grant_role(
    'student_admin',
    :'PASSWORD_STUDENT',
    ARRAY['student', :'SCHEMA_AUTH'],
    ARRAY['academic', 'course_offering', 'library', 'agnostic']  -- Read access for academic and library data
);

-- Library Management Schema
--     Purpose: Manages library resources, loans, and related services.
--     Rationale: Supports the specific needs of library operations, including cataloging,
--                circulation, and integration with academic resources.
SELECT create_and_grant_role(
    'library_admin',
    :'PASSWORD_LIBRARY',
    ARRAY['library', 'agnostic'],  -- Library and shared data access
    ARRAY['student', 'infrastructure']  -- Read access for student, academic, and infrastructure data
);

-- -- todo: Create the 'additional-schemas' roles and grant privileges
-- -- -- Finance Management Schema
-- -- --     Purpose: Manages financial data, budgets, and expenses.
-- -- --     Rationale: Centralizes financial information, supporting budget planning, expense tracking, and financial reporting.

-- -- -- Research Management Schema
-- -- --     Purpose: Supports research projects, publications, and collaboration.
-- -- --     Rationale: Facilitates research data management, collaboration, and dissemination, supporting the research community.

-- -- todo: Check if the following code is necessary, I mean, the db_owner role already has all the privileges on the database, so why do we need to grant privileges to the super_admin role?
-- -- Create a super_admin role with access to all schemas
-- CREATE ROLE super_admin WITH LOGIN PASSWORD :'PASSWORD_SUPER_ADMIN';
-- GRANT ALL PRIVILEGES ON ALL SCHEMAS TO super_admin;
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA
--     :'SCHEMA_AUTH',
--     'infrastructure',
--     :'SCHEMA_HR',
--     'course_offering',
--     'academic',
--     'student',
--     'library'
--     -- :'SCHEMA_FINANCE',
--     -- :'SCHEMA_RESEARCH'
-- TO super_admin;
