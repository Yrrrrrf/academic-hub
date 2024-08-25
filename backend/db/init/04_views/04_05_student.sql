-- File: 06_student_views.sql
-- Creates views for the student management module.

-- Active students with program information
CREATE OR REPLACE VIEW student.active_students_with_program AS
SELECT
    s.id AS student_id,
    s.first_name,
    s.last_name,
    s.email,
    s.enrollment_date,
    p.code AS program_code,
    p.name AS program_name
FROM
    student.student s
JOIN academic.program p ON s.program_id = p.id
WHERE
    s.is_active = true;

COMMENT ON VIEW student.active_students_with_program IS 'Shows active students with their program information';

-- Current enrollments with course details
CREATE OR REPLACE VIEW student.current_enrollments AS
SELECT
    e.id AS enrollment_id,
    s.id AS student_id,
    s.first_name,
    s.last_name,
    c.code AS course_code,
    c.title AS course_title,
    co.section_number,
    e.enrollment_date,
    e.status
FROM
    student.enrollment e
JOIN student.student s ON e.student_id = s.id
JOIN course_offering.course_offering co ON e.course_offering_id = co.id
JOIN academic.course c ON co.course_id = c.id
WHERE
    e.status = 'enrolled';

COMMENT ON VIEW student.current_enrollments IS 'Displays current student enrollments with course details';

-- Student grades summary
CREATE OR REPLACE VIEW student.student_grades_summary AS
SELECT
    s.id AS student_id,
    s.first_name,
    s.last_name,
    c.code AS course_code,
    c.title AS course_title,
    g.exam_type,
    g.grade,
    g.grading_date
FROM
    student.grade g
JOIN student.enrollment e ON g.enrollment_id = e.id
JOIN student.student s ON e.student_id = s.id
JOIN course_offering.course_offering co ON e.course_offering_id = co.id
JOIN academic.course c ON co.course_id = c.id
ORDER BY
    s.last_name, s.first_name, c.code, g.exam_type;

COMMENT ON VIEW student.student_grades_summary IS 'Provides a summary of student grades across all courses';