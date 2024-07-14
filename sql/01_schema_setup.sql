-- File: 01_schema_setup.sql
--     Sets up schemas and roles for the database.
--
-- # Script steps:
--     1. Creates specified schemas with a logical structure
--     2. Creates roles with appropriate permissions
--     3. Establishes cross-schema access where necessary

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
    primary_schemas TEXT[],
    read_schemas TEXT[]
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

    -- Grant full privileges on primary schemas
    FOREACH schema_name IN ARRAY primary_schemas
    LOOP
        EXECUTE format('GRANT ALL PRIVILEGES ON SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL PRIVILEGES ON TABLES TO %I', schema_name, role_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL PRIVILEGES ON SEQUENCES TO %I', schema_name, role_name);
    END LOOP;

    -- Grant read privileges on specified schemas
    FOREACH schema_name IN ARRAY read_schemas
    LOOP
        EXECUTE format('GRANT USAGE ON SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('GRANT SELECT ON ALL TABLES IN SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT SELECT ON TABLES TO %I', schema_name, role_name);
    END LOOP;

    RAISE NOTICE 'Privileges granted to % on primary schemas % and read access to %', role_name, primary_schemas, read_schemas;
END;
$$ LANGUAGE plpgsql;

-- Create schemas
SELECT create_schemas(ARRAY[
    -- Core schemas
    --     These are the main schemas that contain core data for the ORGANIZATION
    'auth',                      -- For authentication and authorization
    'infrastructure_management',  -- For infrastructure-related (buildings, equipment, etc.)
    'hr_management',             -- For HR-related (employees, payroll, etc.)

    -- Functional schemas
    --     These schemas are related to specific functions within the organization
    'course_management',         -- For course-related (schedules, assignments, etc.)
    'academic_management',       -- For academic management (academic programs, syllabi, etc.)
    'student_management',        -- For student-related (enrollment, grades, etc.)
    'library_management'        -- For library-related (books, loans, etc.)

    -- Additional schemas (commented out for future use)
    --     These schemas are for additional functions or departments
    -- 'finance_management',     -- For finance-related (budgets, expenses, etc.)
--     'research_management'     -- For research-related (projects, publications, etc.)
]);

-- Create roles and grant privileges for each schema

-- Infrastructure Management Schema
--     Purpose: Handles all aspects of physical and digital infrastructure.
--     Rationale: Centralizes management of buildings, rooms, equipment, and IT infrastructure,
--                facilitating efficient resource allocation and maintenance planning.
SELECT create_and_grant_role(
    'infrastructure_admin',
    'infra_password',
    ARRAY['infrastructure_management'],
    ARRAY['hr_management']  -- Read access to HR for asset assignment
);

-- HR Management Schema
--     Purpose: Manages all employee-related data and processes.
--     Rationale: Centralizes employee information, including faculty, staff, and administrators.
--                Crucial for maintaining consistent employee records, payroll, and organizational structure.
SELECT create_and_grant_role(
    'hr_admin',
    'hr_password',
    ARRAY['hr_management', 'auth'],
    ARRAY['academic_management']  -- Read access for academic roles
);

-- Course Management Schema
--     Purpose: Handles the operational aspects of courses, including scheduling and delivery.
--     Rationale: Separates the dynamic, term-based course operations from the more stable academic program structure,
--                allowing for efficient handling of course-specific data and processes.
SELECT create_and_grant_role(
    'course_admin',
    'course_password',
    ARRAY['course_management'],
    ARRAY['academic_management', 'hr_management', 'student_management']  -- Read access for related data
);

-- Academic Management Schema
--     Purpose: Manages academic programs, curricula, and long-term academic planning.
--     Rationale: Focuses on the structural aspects of academic offerings, separate from the
--                operational course management, supporting strategic academic planning and accreditation processes.
SELECT create_and_grant_role(
    'academic_admin',
    'academic_password',
    ARRAY['academic_management'],
    ARRAY['hr_management', 'course_management', 'student_management']  -- Read access for comprehensive academic overview
);

-- Student Management Schema
--     Purpose: Handles all student-related data and processes.
--     Rationale: Centralizes student information, supporting the entire student lifecycle from admission to alumni.
--                Separation allows for specialized handling of student data, including privacy and regulatory compliance.
SELECT create_and_grant_role(
    'student_admin',
    'student_password',
    ARRAY['student_management', 'auth'],
    ARRAY['academic_management', 'course_management']  -- Read access for comprehensive student management
);

-- Library Management Schema
--     Purpose: Manages library resources, loans, and related services.
--     Rationale: Supports the specific needs of library operations, including cataloging,
--                circulation, and integration with academic resources.
SELECT create_and_grant_role(
    'library_admin',
    'library_password',
    ARRAY['library_management'],
    ARRAY['student_management', 'academic_management']  -- Read access for user info and academic resources
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
-- CREATE ROLE super_admin WITH LOGIN PASSWORD 'super_secure_password';
-- GRANT ALL PRIVILEGES ON ALL SCHEMAS TO super_admin;
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA
--     auth,
--     infrastructure_management,
--     hr_management,
--     course_management,
--     academic_management,
--     student_management,
--     library_management,
--     finance_management,
--     research_management
-- TO super_admin;
