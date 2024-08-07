-- File: 06_student_management_tables.sql
--     Creates tables and functions for the student management module.
--
-- # Purpose:
--     This script sets up the database structure for managing student data, focusing on
--     academic information, enrollments, and grades. It includes utility functions for
--     student management, such as automatic email generation.
--
-- # Tables created:
--     1. student: Stores essential academic information about students
--     2. enrollment: Tracks student enrollments in course offerings
--     3. grade: Records grades for student enrollments
--
-- # Functions created:
--     1. generate_student_email: Generates a unique email address for each student
--
-- # Additional Structures:
--     - exam_type_enum: ENUM type defining different types of exams
--     - enrollment_status_enum: ENUM type defining different enrollment statuses

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Create the student_management schema
CREATE SCHEMA IF NOT EXISTS student_management;

-- Create ENUM for exam types
CREATE TYPE student_management.exam_type_enum AS ENUM (
    'midterm',
    'final',
    'project',
    'quiz',
    'assignment',
    'lab',
    'presentation',
    'thesis_defense'
);

-- Create ENUM for enrollment status
CREATE TYPE student_management.enrollment_status_enum AS ENUM (
    'enrolled',
    'withdrawn',
    'completed',
    'incomplete',
    'on_leave'
);

-- Function to generate student email address
CREATE OR REPLACE FUNCTION student_management.generate_student_email(
    p_first_name VARCHAR(50),
    p_last_name VARCHAR(50)
) RETURNS VARCHAR(100) AS $$
DECLARE
    email_prefix VARCHAR(4);
    domain VARCHAR(50) := 'student.com';
    full_email VARCHAR(100);
    counter INT := 0;
BEGIN
    -- Generate email prefix (first 3 letters of first name + first letter of last name)
    email_prefix := LOWER(LEFT(p_first_name, 3) || LEFT(p_last_name, 1));

    -- Combine prefix and domain
    full_email := email_prefix || '@' || domain;

    -- Check if email already exists and adjust if necessary
    WHILE EXISTS (SELECT 1 FROM student_management.student WHERE email = full_email) LOOP
        counter := counter + 1;
        full_email := email_prefix || counter || '@' || domain;
    END LOOP;

    RETURN full_email;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

COMMENT ON FUNCTION student_management.generate_student_email IS 'Generates a unique email address for a student based on their name, ensuring no duplicates exist';

-- Student table
CREATE TABLE student_management.student (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) GENERATED ALWAYS AS (
        student_management.generate_student_email(first_name, last_name)
    ) STORED,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    program_id UUID NOT NULL REFERENCES academic_management.program(id),
    is_active BOOLEAN DEFAULT true
);

ALTER TABLE student_management.student ADD CONSTRAINT unique_student_email UNIQUE (email);

COMMENT ON COLUMN student_management.student.id IS 'Unique identifier for the student, used across the system for student-related operations';
COMMENT ON COLUMN student_management.student.first_name IS 'Student''s first name, used for identification and communication purposes';
COMMENT ON COLUMN student_management.student.last_name IS 'Student''s last name, used for identification and communication purposes';
COMMENT ON COLUMN student_management.student.email IS 'Student''s automatically generated institutional email address, unique for each student';
COMMENT ON COLUMN student_management.student.enrollment_date IS 'Date when the student first enrolled in the institution, used for academic tenure calculations';
COMMENT ON COLUMN student_management.student.program_id IS 'Reference to the academic program the student is enrolled in, linking to program details';
COMMENT ON COLUMN student_management.student.is_active IS 'Flag indicating if the student is currently active in their studies or on leave';

-- Enrollment table
CREATE TABLE student_management.enrollment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES student_management.student(id),
    course_offering_id UUID NOT NULL REFERENCES course_offering_management.course_offering(id),
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status student_management.enrollment_status_enum NOT NULL DEFAULT 'enrolled',
    CONSTRAINT unique_student_course_offering UNIQUE (student_id, course_offering_id)
);

COMMENT ON COLUMN student_management.enrollment.id IS 'Unique identifier for each enrollment record';
COMMENT ON COLUMN student_management.enrollment.student_id IS 'Reference to the student enrolled in the course';
COMMENT ON COLUMN student_management.enrollment.course_offering_id IS 'Reference to the specific course offering the student is enrolled in';
COMMENT ON COLUMN student_management.enrollment.enrollment_date IS 'Date when the student enrolled in this specific course offering';
COMMENT ON COLUMN student_management.enrollment.status IS 'Current status of the enrollment, tracking the student''s progress in the course';

-- Grade table
CREATE TABLE student_management.grade (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    enrollment_id UUID NOT NULL REFERENCES student_management.enrollment(id),
    exam_type student_management.exam_type_enum NOT NULL,
    grade NUMERIC(4,2) NOT NULL CHECK (grade >= 0 AND grade <= 100),
    grading_date DATE NOT NULL DEFAULT CURRENT_DATE,
    graded_by UUID REFERENCES hr_management.employee(id),
    comments TEXT,
    CONSTRAINT unique_enrollment_exam_type UNIQUE (enrollment_id, exam_type)
);

COMMENT ON COLUMN student_management.grade.id IS 'Unique identifier for each grade entry';
COMMENT ON COLUMN student_management.grade.enrollment_id IS 'Reference to the specific enrollment this grade is associated with';
COMMENT ON COLUMN student_management.grade.exam_type IS 'Type of assessment this grade represents, allowing for multiple grade entries per enrollment';
COMMENT ON COLUMN student_management.grade.grade IS 'Numeric grade value, standardized on a 0-100 scale for consistency across different grading systems';
COMMENT ON COLUMN student_management.grade.grading_date IS 'Date when the grade was recorded, useful for tracking grading timeliness';
COMMENT ON COLUMN student_management.grade.graded_by IS 'Reference to the employee who recorded the grade, ensuring accountability';
COMMENT ON COLUMN student_management.grade.comments IS 'Optional text field for additional context or feedback on the grade';

-- Create indexes
CREATE INDEX idx_student_program ON student_management.student(program_id);
CREATE UNIQUE INDEX idx_student_email ON student_management.student(email);
CREATE INDEX idx_enrollment_student ON student_management.enrollment(student_id);
CREATE INDEX idx_enrollment_course_offering ON student_management.enrollment(course_offering_id);
CREATE INDEX idx_grade_enrollment ON student_management.grade(enrollment_id);

-- Example of how to insert a new student (email will be automatically generated)
-- INSERT INTO student_management.student (first_name, last_name, program_id)
-- VALUES ('John', 'Doe', 'some-program-uuid');
