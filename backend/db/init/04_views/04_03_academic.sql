-- File: 03_academic_views.sql
-- Creates views for the academic management module.

-- Active programs with course count
CREATE OR REPLACE VIEW academic.active_programs_with_course_count AS
SELECT 
    p.id AS program_id,
    p.code AS program_code,
    p.name AS program_name,
    p.degree_level,
    COUNT(pc.course_id) AS total_courses,
    COUNT(CASE WHEN pc.is_required THEN 1 END) AS required_courses
FROM 
    academic.program p
LEFT JOIN academic.program_course pc ON p.id = pc.program_id
WHERE 
    p.is_active = true
GROUP BY 
    p.id, p.code, p.name, p.degree_level;

COMMENT ON VIEW academic.active_programs_with_course_count IS 'Shows active programs with their total and required course counts';

-- Courses with prerequisites
CREATE OR REPLACE VIEW academic.courses_with_prerequisites AS
SELECT 
    c.id AS course_id,
    c.code AS course_code,
    c.title AS course_title,
    c.credits,
    STRING_AGG(pc.code, ', ') AS prerequisites
FROM 
    academic.course c
LEFT JOIN academic.course_prerequisite cp ON c.id = cp.course_id
LEFT JOIN academic.course pc ON cp.prerequisite_course_id = pc.id
WHERE 
    c.is_active = true
GROUP BY 
    c.id, c.code, c.title, c.credits;

COMMENT ON VIEW academic.courses_with_prerequisites IS 'Lists all active courses with their prerequisites';

-- Program curriculum
CREATE OR REPLACE VIEW academic.program_curriculum AS
SELECT 
    p.id AS program_id,
    p.code AS program_code,
    p.name AS program_name,
    c.id AS course_id,
    c.code AS course_code,
    c.title AS course_title,
    c.credits,
    pc.is_required,
    pc.recommended_semester
FROM 
    academic.program p
JOIN academic.program_course pc ON p.id = pc.program_id
JOIN academic.course c ON pc.course_id = c.id
WHERE 
    p.is_active = true AND c.is_active = true
ORDER BY 
    p.code, pc.recommended_semester, c.code;

COMMENT ON VIEW academic.program_curriculum IS 'Displays the curriculum for each active program, including course details';

-- Latest syllabus for each course
CREATE OR REPLACE VIEW academic.latest_syllabi AS
SELECT DISTINCT ON (s.course_id)
    s.id AS syllabus_id,
    c.id AS course_id,
    c.code AS course_code,
    c.title AS course_title,
    s.version AS syllabus_version,
    s.approved_date
FROM 
    academic.syllabus s
JOIN academic.course c ON s.course_id = c.id
WHERE 
    c.is_active = true
ORDER BY 
    s.course_id, s.approved_date DESC, s.version DESC;

COMMENT ON VIEW academic.latest_syllabi IS 'Shows the most recent syllabus for each active course';