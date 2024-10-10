-- File: 02_hr_tables.sql
--     Creates enhanced tables for the human resources management module.
--
-- # Tables created:
--     1. employee: Stores information about all employees
--     2. department: Contains details about different departments
--     3. position: Defines various job positions
--     4. employee_position: Maps employees to their positions (including history)
--     6. leave: Manages employee leave requests and approvals (vacation, sick, etc.)
--
-- # Additional Structures:
--     - job_category: ENUM type defining different job categories

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Create ENUM for job categories
-- This allows for a predefined set of job categories, ensuring data consistency
CREATE TYPE hr.job_category AS ENUM (
    'faculty',              -- Academic teaching staff
    'administrative',       -- Administrative personnel
    'technical_support',    -- IT and technical support staff
    'research',             -- Research-focused positions
    'facilities',           -- Maintenance and facilities management
    'student_services',     -- Roles focused on student support
    'library',              -- Library staff
    'security',             -- Campus security personnel
    'healthcare',           -- On-campus health services staff
    'food_services',        -- Cafeteria and food service workers
    'finance',              -- Financial and accounting roles
    'legal',                -- Legal department staff
    'external_relations'    -- Alumni relations and fundraising staff
);

-- Function to generate email address
CREATE OR REPLACE FUNCTION hr.generate_email(
    p_first_name VARCHAR(50),
    p_last_name VARCHAR(50),
    p_job_category hr.job_category
) RETURNS VARCHAR(100) AS $$
DECLARE
    email_prefix VARCHAR(4);
    domain VARCHAR(50);
BEGIN
    -- Generate email prefix (first 3 letters of first name + first letter of last name)
    email_prefix := LOWER(LEFT(p_first_name, 3) || LEFT(p_last_name, 1));

    -- Generate domain based on job category
    domain := LOWER(p_job_category::text) || '.school.com';

    -- Combine prefix and domain
    RETURN email_prefix || '@' || domain;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Employee table: Base table for all employees
DROP TABLE IF EXISTS hr.employee CASCADE;
CREATE TABLE hr.employee (
    -- employee metadata
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    -- employment details and status
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    job_category hr.job_category NOT NULL,
    department_id UUID,
    is_active BOOLEAN DEFAULT true,  -- true for active employees, false for inactive (e.g., retired)
    -- Auto-generated email
    email VARCHAR(100) GENERATED ALWAYS AS (
        hr.generate_email(first_name, last_name, job_category)
    ) STORED
);

COMMENT ON COLUMN hr.employee.id IS 'Unique identifier for each employee';
COMMENT ON COLUMN hr.employee.first_name IS 'Employee''s first name';
COMMENT ON COLUMN hr.employee.last_name IS 'Employee''s last name';
COMMENT ON COLUMN hr.employee.email IS 'Employee''s auto-generated institutional email address';
COMMENT ON COLUMN hr.employee.hire_date IS 'Date when the employee was hired';
COMMENT ON COLUMN hr.employee.job_category IS 'General category of the employee''s job';
COMMENT ON COLUMN hr.employee.department_id IS 'ID of the department to which the employee belongs';
COMMENT ON COLUMN hr.employee.is_active IS 'Indicates whether the employee is currently active (true) or inactive (false)';

-- Department table
DROP TABLE IF EXISTS hr.department CASCADE;
CREATE TABLE hr.department (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    head_id UUID REFERENCES hr.employee(id)
);

COMMENT ON COLUMN hr.department.id IS 'Unique identifier for each department';
COMMENT ON COLUMN hr.department.name IS 'Official name of the department';
COMMENT ON COLUMN hr.department.description IS 'Brief description of the department''s function or purpose';
COMMENT ON COLUMN hr.department.head_id IS 'ID of the employee who heads this department';

CREATE INDEX idx_department_head ON hr.department(head_id);

-- Add foreign key constraint for department in employee table
ALTER TABLE hr.employee
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (department_id) REFERENCES hr.department(id);

CREATE UNIQUE INDEX idx_employee_email ON hr.employee(email);
CREATE INDEX idx_employee_department ON hr.employee(department_id);

-- Position table
DROP TABLE IF EXISTS hr.position CASCADE;
CREATE TABLE hr.position (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(100) NOT NULL,
    description TEXT
);

COMMENT ON COLUMN hr.position.id IS 'Unique identifier for each position';
COMMENT ON COLUMN hr.position.title IS 'Official title of the position';
COMMENT ON COLUMN hr.position.description IS 'Detailed description of the position''s responsibilities and requirements';

-- Employee Position table (for handling multiple positions per employee)
DROP TABLE IF EXISTS hr.employee_position CASCADE;
CREATE TABLE hr.employee_position (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id UUID REFERENCES hr.employee(id),
    position_id UUID REFERENCES hr.position(id),
    start_date DATE NOT NULL,
    end_date DATE,
    is_primary BOOLEAN DEFAULT false
);

COMMENT ON COLUMN hr.employee_position.id IS 'Unique identifier for each employee position assignment';
COMMENT ON COLUMN hr.employee_position.employee_id IS 'ID of the employee';
COMMENT ON COLUMN hr.employee_position.position_id IS 'ID of the position held by the employee';
COMMENT ON COLUMN hr.employee_position.start_date IS 'Date when the employee started in this position';
COMMENT ON COLUMN hr.employee_position.end_date IS 'Date when the employee ended this position (if applicable)';
COMMENT ON COLUMN hr.employee_position.is_primary IS 'Indicates if this is the employee''s primary position';

CREATE INDEX idx_employee_position_employee ON hr.employee_position(employee_id);
CREATE INDEX idx_employee_position_position ON hr.employee_position(position_id);
CREATE INDEX idx_employee_position_dates ON hr.employee_position(start_date, end_date);

-- Leave table
DROP TABLE IF EXISTS hr.leave CASCADE;
CREATE TABLE hr.leave (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id UUID REFERENCES hr.employee(id),
    leave_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    approved_by UUID REFERENCES hr.employee(id)
);

COMMENT ON COLUMN hr.leave.id IS 'Unique identifier for each leave request';
COMMENT ON COLUMN hr.leave.employee_id IS 'ID of the employee requesting leave';
COMMENT ON COLUMN hr.leave.leave_type IS 'Type of leave requested (e.g., Vacation, Sick, Sabbatical)';
COMMENT ON COLUMN hr.leave.start_date IS 'Start date of the requested leave';
COMMENT ON COLUMN hr.leave.end_date IS 'End date of the requested leave';
COMMENT ON COLUMN hr.leave.status IS 'Current status of the leave request (e.g., Pending, Approved, Rejected)';
COMMENT ON COLUMN hr.leave.approved_by IS 'ID of the employee who approved or processed the leave request';

CREATE INDEX idx_leave_employee ON hr.leave(employee_id);
