-- File: 06_student_tables.sql
-- Creates tables and types for the student management module.

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Create the student schema
CREATE SCHEMA IF NOT EXISTS student;

-- Create ENUM for exam types
CREATE TYPE student.exam_type AS ENUM (
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
CREATE TYPE student.enrollment_status AS ENUM (
    'enrolled',
    'withdrawn',
    'completed',
    'incomplete',
    'on_leave'
);

-- Function to generate student email address
CREATE OR REPLACE FUNCTION student.generate_student_email(
    p_first_name VARCHAR(50),
    p_last_name VARCHAR(50)
) RETURNS VARCHAR(100) AS $$
DECLARE
    email_prefix VARCHAR(4);
    domain VARCHAR(50) := 'student.com';
    full_email VARCHAR(100);
    counter INT := 0;
BEGIN
    email_prefix := LOWER(LEFT(p_first_name, 3) || LEFT(p_last_name, 1));
    full_email := email_prefix || '@' || domain;

    WHILE EXISTS (SELECT 1 FROM student.student WHERE email = full_email) LOOP
        counter := counter + 1;
        full_email := email_prefix || counter || '@' || domain;
    END LOOP;

    RETURN full_email;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

COMMENT ON FUNCTION student.generate_student_email IS 'Generates a unique email address for a student based on their name, ensuring no duplicates exist';

-- Student: Stores essential academic information about students
CREATE TABLE student.student (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) GENERATED ALWAYS AS (
        student.generate_student_email(first_name, last_name)
    ) STORED,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    program_id UUID NOT NULL REFERENCES academic.program(id),
    is_active BOOLEAN DEFAULT true
);

COMMENT ON TABLE student.student IS 'Stores essential academic information about students';
COMMENT ON COLUMN student.student.id IS 'Unique identifier for the student';
COMMENT ON COLUMN student.student.first_name IS 'Student''s first name';
COMMENT ON COLUMN student.student.last_name IS 'Student''s last name';
COMMENT ON COLUMN student.student.email IS 'Student''s automatically generated institutional email address';
COMMENT ON COLUMN student.student.enrollment_date IS 'Date when the student first enrolled in the institution';
COMMENT ON COLUMN student.student.program_id IS 'Reference to the academic program the student is enrolled in';
COMMENT ON COLUMN student.student.is_active IS 'Flag indicating if the student is currently active in their studies';

ALTER TABLE student.student ADD CONSTRAINT unique_student_email UNIQUE (email);
CREATE INDEX idx_student_program ON student.student(program_id);
CREATE UNIQUE INDEX idx_student_email ON student.student(email);

-- Enrollment: Tracks student enrollments in course offerings
CREATE TABLE student.enrollment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES student.student(id),
    course_offering_id UUID NOT NULL REFERENCES course_offering.course_offering(id),
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status student.enrollment_status NOT NULL DEFAULT 'enrolled',
    CONSTRAINT unique_student_course_offering UNIQUE (student_id, course_offering_id)
);

COMMENT ON TABLE student.enrollment IS 'Tracks student enrollments in course offerings';
COMMENT ON COLUMN student.enrollment.id IS 'Unique identifier for each enrollment record';
COMMENT ON COLUMN student.enrollment.student_id IS 'Reference to the student enrolled in the course';
COMMENT ON COLUMN student.enrollment.course_offering_id IS 'Reference to the specific course offering';
COMMENT ON COLUMN student.enrollment.enrollment_date IS 'Date of enrollment in the course offering';
COMMENT ON COLUMN student.enrollment.status IS 'Current status of the enrollment';

CREATE INDEX idx_enrollment_student ON student.enrollment(student_id);
CREATE INDEX idx_enrollment_course_offering ON student.enrollment(course_offering_id);

-- Grade: Records grades for student enrollments
CREATE TABLE student.grade (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    enrollment_id UUID NOT NULL REFERENCES student.enrollment(id),
    exam_type student.exam_type NOT NULL,
    grade NUMERIC(4,2) NOT NULL CHECK (grade >= 0 AND grade <= 100),
    grading_date DATE NOT NULL DEFAULT CURRENT_DATE,
    graded_by UUID REFERENCES hr.employee(id),
    comments TEXT,
    CONSTRAINT unique_enrollment_exam_type UNIQUE (enrollment_id, exam_type)
);

COMMENT ON TABLE student.grade IS 'Records grades for student enrollments';
COMMENT ON COLUMN student.grade.id IS 'Unique identifier for each grade entry';
COMMENT ON COLUMN student.grade.enrollment_id IS 'Reference to the specific enrollment';
COMMENT ON COLUMN student.grade.exam_type IS 'Type of assessment for this grade';
COMMENT ON COLUMN student.grade.grade IS 'Numeric grade value (0-100)';
COMMENT ON COLUMN student.grade.grading_date IS 'Date when the grade was recorded';
COMMENT ON COLUMN student.grade.graded_by IS 'Reference to the employee who recorded the grade';
COMMENT ON COLUMN student.grade.comments IS 'Optional comments on the grade';

CREATE INDEX idx_grade_enrollment ON student.grade(enrollment_id);
CREATE INDEX idx_grade_graded_by ON student.grade(graded_by);
