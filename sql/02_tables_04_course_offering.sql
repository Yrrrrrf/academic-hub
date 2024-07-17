-- File: 05_course_offering_management_tables.sql
--     Creates tables for managing course offerings, schedules, and related operational aspects.
--
-- # Purpose:
--     This script sets up the database structure for managing the operational aspects of course offerings.
--     It handles scheduling, term-specific details, and enrollment management for courses
--     across different academic terms.
--
-- # Tables created:
--     1. academic_term: Defines academic terms (e.g., semesters, quarters)
--     2. course_offering: Represents specific instances of courses offered in a given term
--     3. course_schedule: Contains detailed scheduling information for course offerings
--     4. instructor_assignment: Maps instructors to course offerings
--
-- # Relationships:
--     - Course offerings are associated with specific courses (from academic_management schema)
--     - Course offerings are linked to specific academic terms
--     - Each course offering can have multiple schedule entries (for different days/times)
--     - Instructors (from hr_management schema) are assigned to course offerings
--
-- # Note:
--     Ensure that the academic_management and hr_management schemas exist before running this script.

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Create the course_offering_management schema
CREATE SCHEMA IF NOT EXISTS course_offering_management;

-- Academic Term table
CREATE TABLE course_offering_management.academic_term (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_current BOOLEAN DEFAULT false,
    CONSTRAINT valid_term_dates CHECK (start_date < end_date)
);

COMMENT ON COLUMN course_offering_management.academic_term.id IS 'Unique identifier for the academic term';
COMMENT ON COLUMN course_offering_management.academic_term.name IS 'Name of the academic term (e.g., Fall 2023)';
COMMENT ON COLUMN course_offering_management.academic_term.start_date IS 'Start date of the term';
COMMENT ON COLUMN course_offering_management.academic_term.end_date IS 'End date of the term';
COMMENT ON COLUMN course_offering_management.academic_term.is_current IS 'Indicates if this is the current academic term';

-- Course Offering table
CREATE TABLE course_offering_management.course_offering (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    course_id UUID NOT NULL REFERENCES academic_management.course(id),
    term_id UUID NOT NULL REFERENCES course_offering_management.academic_term(id),
    section_number VARCHAR(10) NOT NULL,
    max_enrollment INT NOT NULL,
    current_enrollment INT DEFAULT 0,
    status VARCHAR(20) NOT NULL DEFAULT 'scheduled', -- e.g., 'scheduled', 'in_progress', 'completed', 'cancelled'
    CONSTRAINT unique_course_offering UNIQUE (course_id, term_id, section_number),
    CONSTRAINT valid_enrollment CHECK (current_enrollment <= max_enrollment)
);

COMMENT ON COLUMN course_offering_management.course_offering.id IS 'Unique identifier for the course offering';
COMMENT ON COLUMN course_offering_management.course_offering.course_id IS 'Reference to the course being offered';
COMMENT ON COLUMN course_offering_management.course_offering.term_id IS 'Academic term in which the course is offered';
COMMENT ON COLUMN course_offering_management.course_offering.section_number IS 'Section number for the course offering';
COMMENT ON COLUMN course_offering_management.course_offering.max_enrollment IS 'Maximum number of students that can enroll';
COMMENT ON COLUMN course_offering_management.course_offering.current_enrollment IS 'Current number of enrolled students';
COMMENT ON COLUMN course_offering_management.course_offering.status IS 'Current status of the course offering';

-- Course Schedule table
CREATE TABLE course_offering_management.course_schedule (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    course_offering_id UUID NOT NULL REFERENCES course_offering_management.course_offering(id),
    day_of_week INT NOT NULL CHECK (day_of_week BETWEEN 0 AND 6), -- 0 = Sunday, 6 = Saturday
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    location_id UUID REFERENCES infrastructure_management.room(id),
    CONSTRAINT valid_schedule_time CHECK (start_time < end_time)
);

COMMENT ON COLUMN course_offering_management.course_schedule.id IS 'Unique identifier for the schedule entry';
COMMENT ON COLUMN course_offering_management.course_schedule.course_offering_id IS 'Reference to the course offering';
COMMENT ON COLUMN course_offering_management.course_schedule.day_of_week IS 'Day of the week (0 = Sunday, 6 = Saturday)';
COMMENT ON COLUMN course_offering_management.course_schedule.start_time IS 'Start time of the class';
COMMENT ON COLUMN course_offering_management.course_schedule.end_time IS 'End time of the class';
COMMENT ON COLUMN course_offering_management.course_schedule.location_id IS 'Reference to the room where the class is held';

-- Instructor Assignment table
CREATE TABLE course_offering_management.instructor_assignment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    course_offering_id UUID NOT NULL REFERENCES course_offering_management.course_offering(id),
    instructor_id UUID NOT NULL REFERENCES hr_management.employee(id),
    is_primary BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT unique_instructor_assignment UNIQUE (course_offering_id, instructor_id)
);

COMMENT ON COLUMN course_offering_management.instructor_assignment.id IS 'Unique identifier for the instructor assignment';
COMMENT ON COLUMN course_offering_management.instructor_assignment.course_offering_id IS 'Reference to the course offering';
COMMENT ON COLUMN course_offering_management.instructor_assignment.instructor_id IS 'Reference to the assigned instructor';
COMMENT ON COLUMN course_offering_management.instructor_assignment.is_primary IS 'Indicates if this is the primary instructor for the course offering';

-- Create necessary indexes
CREATE INDEX idx_academic_term_dates ON course_offering_management.academic_term(start_date, end_date);
CREATE INDEX idx_course_offering_course ON course_offering_management.course_offering(course_id);
CREATE INDEX idx_course_offering_term ON course_offering_management.course_offering(term_id);
CREATE INDEX idx_course_schedule_offering ON course_offering_management.course_schedule(course_offering_id);
CREATE INDEX idx_course_schedule_day_time ON course_offering_management.course_schedule(day_of_week, start_time, end_time);
CREATE INDEX idx_instructor_assignment_offering ON course_offering_management.instructor_assignment(course_offering_id);
CREATE INDEX idx_instructor_assignment_instructor ON course_offering_management.instructor_assignment(instructor_id);
