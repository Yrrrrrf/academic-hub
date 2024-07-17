-- File: 04_academic_management_tables.sql
--     Creates tables for the academic management module, including programs, courses, and syllabi.
--
-- # Purpose:
--     This script sets up the database structure for managing academic programs, courses,
--     and their relationships within an educational institution. It provides the foundation
--     for curriculum management, course cataloging, and program structuring.
--
-- # Tables created:
--     1. program: Defines academic programs offered by the institution
--     2. course: Defines individual courses offered by the institution
--     3. course_prerequisite: Defines prerequisites for courses
--     4. syllabus: Contains syllabus information for courses
--     5. program_course: Maps courses to programs
--
-- # Relationships:
--     - Courses are associated with departments (from hr_management schema)
--     - Programs consist of multiple courses (defined in program_course)
--     - Courses can have prerequisites (defined in course_prerequisite)
--     - Each course can have multiple syllabus versions
--
-- # Note:
--     Ensure that the hr_management schema and its department table exist before running this script.

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Create the academic_management schema
CREATE SCHEMA IF NOT EXISTS academic_management;

-- Program table
CREATE TABLE academic_management.program (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    degree_level VARCHAR(50) NOT NULL,  -- e.g., 'Bachelor', 'Master', 'PhD', 'Professional License'
    is_active BOOLEAN DEFAULT true
);

COMMENT ON COLUMN academic_management.program.id IS 'Unique identifier for the program';
COMMENT ON COLUMN academic_management.program.code IS 'Program code (e.g., MEng (Mechanical Engineering), CS (Computer Science))';
COMMENT ON COLUMN academic_management.program.name IS 'Full name of the program';
COMMENT ON COLUMN academic_management.program.description IS 'Detailed description of the program';
COMMENT ON COLUMN academic_management.program.degree_level IS 'Level of the degree or type of program';
COMMENT ON COLUMN academic_management.program.is_active IS 'Indicates if the program is currently active';

-- Course table
CREATE TABLE academic_management.course (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    credits NUMERIC(2,0) NOT NULL,  -- from 0 to 99 credits
    department_id UUID REFERENCES hr_management.department(id),
    is_active BOOLEAN DEFAULT true
);

COMMENT ON COLUMN academic_management.course.id IS 'Unique identifier for the course';
COMMENT ON COLUMN academic_management.course.code IS 'Course code (e.g., CS101)';
COMMENT ON COLUMN academic_management.course.title IS 'Title of the course';
COMMENT ON COLUMN academic_management.course.description IS 'Detailed description of the course';
COMMENT ON COLUMN academic_management.course.credits IS 'Number of credits for the course';
COMMENT ON COLUMN academic_management.course.department_id IS 'Department offering the course';
COMMENT ON COLUMN academic_management.course.is_active IS 'Indicates if the course is currently active';

-- Course Prerequisite table
CREATE TABLE academic_management.course_prerequisite (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    course_id UUID NOT NULL REFERENCES academic_management.course(id),
    prerequisite_course_id UUID NOT NULL REFERENCES academic_management.course(id),
    CONSTRAINT unique_prerequisite UNIQUE (course_id, prerequisite_course_id)
);

COMMENT ON COLUMN academic_management.course_prerequisite.id IS 'Unique identifier for the prerequisite relationship';
COMMENT ON COLUMN academic_management.course_prerequisite.course_id IS 'Reference to the course that has the prerequisite';
COMMENT ON COLUMN academic_management.course_prerequisite.prerequisite_course_id IS 'Reference to the course that is a prerequisite';

-- Syllabus table
CREATE TABLE academic_management.syllabus (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    course_id UUID NOT NULL REFERENCES academic_management.course(id),
    version VARCHAR(20) NOT NULL,
    content TEXT NOT NULL,
    approved_date DATE DEFAULT CURRENT_DATE,
    CONSTRAINT unique_syllabus_version UNIQUE (course_id, version)
);

COMMENT ON COLUMN academic_management.syllabus.id IS 'Unique identifier for the syllabus';
COMMENT ON COLUMN academic_management.syllabus.course_id IS 'Reference to the course this syllabus is for';
COMMENT ON COLUMN academic_management.syllabus.version IS 'Version of the syllabus';
COMMENT ON COLUMN academic_management.syllabus.content IS 'Full content of the syllabus';
COMMENT ON COLUMN academic_management.syllabus.approved_date IS 'Date when the syllabus was approved';

-- Program Course table
CREATE TABLE academic_management.program_course (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    program_id UUID NOT NULL REFERENCES academic_management.program(id),
    course_id UUID NOT NULL REFERENCES academic_management.course(id),
    is_required BOOLEAN NOT NULL DEFAULT true,
    recommended_semester INT,
    CONSTRAINT unique_program_course UNIQUE (program_id, course_id)
);

COMMENT ON COLUMN academic_management.program_course.id IS 'Unique identifier for the program-course relationship';
COMMENT ON COLUMN academic_management.program_course.program_id IS 'Reference to the academic program';
COMMENT ON COLUMN academic_management.program_course.course_id IS 'Reference to the course';
COMMENT ON COLUMN academic_management.program_course.is_required IS 'Indicates if the course is required for the program';
COMMENT ON COLUMN academic_management.program_course.recommended_semester IS 'Recommended semester to take the course in the program';

-- Create necessary indexes
CREATE INDEX idx_course_department ON academic_management.course(department_id);
CREATE INDEX idx_course_prerequisite_course ON academic_management.course_prerequisite(course_id);
CREATE INDEX idx_course_prerequisite_prereq ON academic_management.course_prerequisite(prerequisite_course_id);
CREATE INDEX idx_syllabus_course ON academic_management.syllabus(course_id);
CREATE INDEX idx_program_course_program ON academic_management.program_course(program_id);
CREATE INDEX idx_program_course_course ON academic_management.program_course(course_id);
