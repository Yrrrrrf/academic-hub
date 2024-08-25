-- File: 07_library_views.sql
-- Creates useful views for the library management schema

-- View: library.vw_book_details
-- Purpose: Provides a comprehensive view of book details including authors and publisher
CREATE OR REPLACE VIEW library.vw_book_details AS
SELECT
    b.id AS book_id,
    b.title,
    b.isbn,
    b.publication_year,
    p.name AS publisher_name,
    STRING_AGG(a.name, ', ' ORDER BY a.name) AS authors
FROM
    library.book b
    LEFT JOIN library.publisher p ON b.publisher_id = p.id
    LEFT JOIN library.book_author ba ON b.id = ba.book_id
    LEFT JOIN library.author a ON ba.author_id = a.id
GROUP BY
    b.id, b.title, b.isbn, b.publication_year, p.name;

COMMENT ON VIEW library.vw_book_details IS 'Comprehensive view of book details including authors and publisher';

-- View: library.vw_book_availability
-- Purpose: Shows the availability status of all book copies
CREATE OR REPLACE VIEW library.vw_book_availability AS
SELECT
    b.id AS book_id,
    b.title,
    bc.id AS copy_id,
    f.name AS library_name,
    bc.status,
    CASE
        WHEN l.return_date IS NULL AND l.due_date < CURRENT_DATE THEN 'Overdue'
        WHEN l.return_date IS NULL THEN 'On Loan'
        ELSE 'Available'
    END AS availability
FROM
    library.book b
    JOIN library.book_copy bc ON b.id = bc.book_id
    JOIN infrastructure.facility f ON bc.library_facility_id = f.id
    LEFT JOIN library.loan l ON bc.id = l.book_copy_id AND l.return_date IS NULL;

COMMENT ON VIEW library.vw_book_availability IS 'Shows the availability status of all book copies';

-- View: library.vw_overdue_loans
-- Purpose: Lists all overdue loans
CREATE OR REPLACE VIEW library.vw_overdue_loans AS
SELECT
    l.id AS loan_id,
    s.first_name || ' ' || s.last_name AS student_name,
    b.title AS book_title,
    l.loan_date,
    l.due_date,
    CURRENT_DATE - l.due_date AS days_overdue
FROM
    library.loan l
    JOIN student.student s ON l.student_id = s.id
    JOIN library.book_copy bc ON l.book_copy_id = bc.id
    JOIN library.book b ON bc.book_id = b.id
WHERE
    l.return_date IS NULL AND l.due_date < CURRENT_DATE;

COMMENT ON VIEW library.vw_overdue_loans IS 'Lists all overdue loans';

-- View: library.vw_popular_books
-- Purpose: Shows the most frequently borrowed books
CREATE OR REPLACE VIEW library.vw_popular_books AS
SELECT
    b.id AS book_id,
    b.title,
    COUNT(l.id) AS loan_count
FROM
    library.book b
    JOIN library.book_copy bc ON b.id = bc.book_id
    JOIN library.loan l ON bc.id = l.book_copy_id
WHERE
    l.loan_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY
    b.id, b.title
ORDER BY
    loan_count DESC;

COMMENT ON VIEW library.vw_popular_books IS 'Shows the most frequently borrowed books in the past year';

-- View: library.vw_library_inventory
-- Purpose: Provides a summary of book inventory across all libraries
CREATE OR REPLACE VIEW library.vw_library_inventory AS
SELECT
    f.name AS library_name,
    b.title AS book_title,
    COUNT(bc.id) AS copy_count,
    SUM(CASE WHEN bc.status = 'available' THEN 1 ELSE 0 END) AS available_copies
FROM
    infrastructure.facility f
    JOIN library.book_copy bc ON f.id = bc.library_facility_id
    JOIN library.book b ON bc.book_id = b.id
WHERE
    f.facility_type = 'library'
GROUP BY
    f.name, b.title
ORDER BY
    f.name, b.title;

COMMENT ON VIEW library.vw_library_inventory IS 'Provides a summary of book inventory across all libraries';
