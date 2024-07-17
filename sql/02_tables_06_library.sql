-- File: 07_library_management_tables.sql
--     Creates tables for the library management module.
--
-- # Purpose:
--     This script sets up the database structure for managing library resources,
--     including books, authors, publishers, and loans. It establishes relationships
--     between books and other entities, and tracks book loans to students.
--
-- # Tables created:
--     1. author: Stores information about book authors
--     2. publisher: Stores information about book publishers
--     3. book: Contains details about individual books
--     4. book_author: Maps books to their authors (many-to-many relationship)
--     5. topic: Defines topics or genres for books
--     6. book_topic: Maps books to topics (many-to-many relationship)
--     7. book_copy: Represents physical copies of books in libraries
--     8. loan: Tracks book loans to students

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Create the library_management schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS library_management;

-- Author table
CREATE TABLE library_management.author (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL
);

COMMENT ON COLUMN library_management.author.id IS 'Unique identifier for the author';
COMMENT ON COLUMN library_management.author.name IS 'Full name of the author';

-- Publisher table
CREATE TABLE library_management.publisher (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL
);

COMMENT ON COLUMN library_management.publisher.id IS 'Unique identifier for the publisher';
COMMENT ON COLUMN library_management.publisher.name IS 'Name of the publishing company';

-- Book table
CREATE TABLE library_management.book (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    publisher_id UUID REFERENCES library_management.publisher(id),
    isbn VARCHAR(13),
    publication_year INT
);

COMMENT ON COLUMN library_management.book.id IS 'Unique identifier for the book';
COMMENT ON COLUMN library_management.book.title IS 'Title of the book';
COMMENT ON COLUMN library_management.book.publisher_id IS 'Reference to the book''s publisher';
COMMENT ON COLUMN library_management.book.isbn IS 'International Standard Book Number (13 digits)';
COMMENT ON COLUMN library_management.book.publication_year IS 'Year the book was published';

-- Book-Author relationship table
CREATE TABLE library_management.book_author (
    book_id UUID REFERENCES library_management.book(id),
    author_id UUID REFERENCES library_management.author(id),
    PRIMARY KEY (book_id, author_id)
);

COMMENT ON COLUMN library_management.book_author.book_id IS 'Reference to the book';
COMMENT ON COLUMN library_management.book_author.author_id IS 'Reference to the author';

-- Topic table
CREATE TABLE library_management.topic (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL
);

COMMENT ON COLUMN library_management.topic.id IS 'Unique identifier for the topic';
COMMENT ON COLUMN library_management.topic.name IS 'Name of the topic or genre';

-- Book-Topic relationship table
CREATE TABLE library_management.book_topic (
    book_id UUID REFERENCES library_management.book(id),
    topic_id UUID REFERENCES library_management.topic(id),
    PRIMARY KEY (book_id, topic_id)
);

COMMENT ON COLUMN library_management.book_topic.book_id IS 'Reference to the book';
COMMENT ON COLUMN library_management.book_topic.topic_id IS 'Reference to the topic';

-- Book Copy table (replaces book_library)
CREATE TABLE library_management.book_copy (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    book_id UUID NOT NULL REFERENCES library_management.book(id),
    library_id UUID NOT NULL REFERENCES infrastructure_management.library(id),
    status VARCHAR(50) NOT NULL -- e.g., 'available', 'loaned', 'maintenance'
);

COMMENT ON COLUMN library_management.book_copy.id IS 'Unique identifier for the book copy';
COMMENT ON COLUMN library_management.book_copy.book_id IS 'Reference to the book';
COMMENT ON COLUMN library_management.book_copy.library_id IS 'Reference to the library where the copy is located';
COMMENT ON COLUMN library_management.book_copy.status IS 'Current status of the book copy';

-- Loan table
CREATE TABLE library_management.loan (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES student_management.student(id),
    book_copy_id UUID NOT NULL REFERENCES library_management.book_copy(id),
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE
);

COMMENT ON COLUMN library_management.loan.id IS 'Unique identifier for the loan';
COMMENT ON COLUMN library_management.loan.student_id IS 'Reference to the student who borrowed the book';
COMMENT ON COLUMN library_management.loan.book_copy_id IS 'Reference to the specific book copy that was loaned';
COMMENT ON COLUMN library_management.loan.loan_date IS 'Date when the book was loaned';
COMMENT ON COLUMN library_management.loan.due_date IS 'Date by which the book should be returned';
COMMENT ON COLUMN library_management.loan.return_date IS 'Actual date when the book was returned (null if not yet returned)';

-- Create indexes
CREATE INDEX idx_book_publisher ON library_management.book(publisher_id);
CREATE INDEX idx_book_author_book ON library_management.book_author(book_id);
CREATE INDEX idx_book_author_author ON library_management.book_author(author_id);
CREATE INDEX idx_book_topic_book ON library_management.book_topic(book_id);
CREATE INDEX idx_book_topic_topic ON library_management.book_topic(topic_id);
CREATE INDEX idx_book_copy_book ON library_management.book_copy(book_id);
CREATE INDEX idx_book_copy_library ON library_management.book_copy(library_id);
CREATE INDEX idx_loan_student ON library_management.loan(student_id);
CREATE INDEX idx_loan_book_copy ON library_management.loan(book_copy_id);
CREATE INDEX idx_loan_dates ON library_management.loan(loan_date, due_date, return_date);
