-- Start a transaction
BEGIN;

-- Disable triggers temporarily
SET session_replication_role = 'replica';

-- Delete data from all tables in reverse order of dependencies
DO $$
DECLARE
    schemas text[] := ARRAY['library_management', 'student_management', 'course_offering_management', 'academic_management', 'hr_management', 'infrastructure_management', 'auth'];
    schema_name text;
    table_name text;
BEGIN
    FOREACH schema_name IN ARRAY schemas
    LOOP
        FOR table_name IN (SELECT tablename FROM pg_tables WHERE schemaname = schema_name)
        LOOP
            EXECUTE format('TRUNCATE TABLE %I.%I CASCADE', schema_name, table_name);
            RAISE NOTICE 'Truncated table: %.%', schema_name, table_name;
        END LOOP;
    END LOOP;
END $$;

-- Reset all sequences
DO $$
DECLARE
    schema_name text;
    seq_name text;
BEGIN
    FOR schema_name, seq_name IN (
        SELECT schemaname, sequencename 
        FROM pg_sequences 
        WHERE schemaname IN ('library_management', 'student_management', 'course_offering_management', 'academic_management', 'hr_management', 'infrastructure_management', 'auth')
    )
    LOOP
        EXECUTE format('ALTER SEQUENCE %I.%I RESTART WITH 1', schema_name, seq_name);
        RAISE NOTICE 'Reset sequence: %.%', schema_name, seq_name;
    END LOOP;
END $$;

-- Re-enable triggers
SET session_replication_role = 'origin';

-- Commit the transaction
COMMIT;

-- Vacuum the database to reclaim storage and update statistics
VACUUM FULL ANALYZE;