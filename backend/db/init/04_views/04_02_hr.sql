-- File: 03_hr_views.sql

-- View for active employees with their current primary position
CREATE OR REPLACE VIEW hr.active_employees_with_position AS
SELECT
    e.id AS employee_id,
    e.first_name,
    e.last_name,
    e.email,
    e.job_category,
    d.name AS department_name,
    p.title AS position_title,
    ep.start_date AS position_start_date
FROM
    hr.employee e
LEFT JOIN hr.department d ON e.department_id = d.id
LEFT JOIN hr.employee_position ep ON e.id = ep.employee_id
LEFT JOIN hr.position p ON ep.position_id = p.id
WHERE
    e.is_active = true
    AND ep.is_primary = true
    AND (ep.end_date IS NULL OR ep.end_date > CURRENT_DATE);

-- View for department heads
CREATE OR REPLACE VIEW hr.department_heads AS
SELECT
    d.id AS department_id,
    d.name AS department_name,
    e.id AS head_id,
    e.first_name AS head_first_name,
    e.last_name AS head_last_name,
    e.email AS head_email
FROM
    hr.department d
JOIN hr.employee e ON d.head_id = e.id;

-- View for leave requests with employee and approver details
CREATE OR REPLACE VIEW hr.leave_requests_detailed AS
SELECT
    l.id AS leave_id,
    e.id AS employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    e.email AS employee_email,
    l.leave_type,
    l.start_date,
    l.end_date,
    l.status,
    a.id AS approver_id,
    a.first_name || ' ' || a.last_name AS approver_name
FROM
    hr.leave l
JOIN hr.employee e ON l.employee_id = e.id
LEFT JOIN hr.employee a ON l.approved_by = a.id;
