-- Set up Engineering Faculty
INSERT INTO infrastructure.faculty (id, name)
VALUES ('f1b0a112-9e88-4d1e-87a7-a5a6e6e73c3f', 'Engineering Faculty');

-- Set up buildings A, B, and C
INSERT INTO infrastructure.building (id, name, address, total_floors)
VALUES 
('a1b2c3d4-e5f6-4a5b-8c7d-9e0f1a2b3c4d', 'Engineering Building A', '123 University Ave', 5),
('b2c3d4e5-f6a7-4b5c-9d0e-1f2a3b4c5d6e', 'Engineering Building B', '124 University Ave', 4),
('c3d4e5f6-a7b8-4c5d-0e1f-2a3b4c5d6e7f', 'Engineering Building C', '125 University Ave', 3);

-- Associate buildings with Engineering Faculty
INSERT INTO infrastructure.faculty_building (faculty_id, building_id)
VALUES 
('f1b0a112-9e88-4d1e-87a7-a5a6e6e73c3f', 'a1b2c3d4-e5f6-4a5b-8c7d-9e0f1a2b3c4d'),
('f1b0a112-9e88-4d1e-87a7-a5a6e6e73c3f', 'b2c3d4e5-f6a7-4b5c-9d0e-1f2a3b4c5d6e'),
('f1b0a112-9e88-4d1e-87a7-a5a6e6e73c3f', 'c3d4e5f6-a7b8-4c5d-0e1f-2a3b4c5d6e7f');

-- Set up Engineering Library in Building B
INSERT INTO infrastructure.facility (id, facility_type, building_id)
VALUES ('f47ac10b-58cc-4372-a567-0e02b2c3d479', 'library', 'b2c3d4e5-f6a7-4b5c-9d0e-1f2a3b4c5d6e');


-- Create Engineering Programs
INSERT INTO academic.program (id, code, name, description, degree_level)
VALUES 
('3b5a8e6f-726d-4b8a-9a6c-8a5b6f8d7e9c', 'ME', 'Mechanical Engineering', 'Study of mechanical systems and their design', 'Bachelor'),
('2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e6f', 'EE', 'Electrical Engineering', 'Study of electrical systems and electronics', 'Bachelor'),
('4d5e6f7a-8b9c-4d5e-6f7a-8b9c0d1e2f3a', 'CS', 'Computer Science', 'Study of computation and information processing', 'Bachelor');

-- Create sample students
INSERT INTO student.student (id, first_name, last_name, enrollment_date, program_id)
VALUES 
('5e6f7a8b-9c0d-4e5f-6a7b-8c9d0e1f2a3b', 'John', 'Doe', '2023-09-01', '3b5a8e6f-726d-4b8a-9a6c-8a5b6f8d7e9c'),
('6f7a8b9c-0d1e-4f5a-6b7c-8d9e0f1a2b3c', 'Jane', 'Smith', '2023-09-01', '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e6f'),
('7a8b9c0d-1e2f-4a5b-6c7d-8e9f0a1b2c3d', 'Alice', 'Johnson', '2023-09-01', '4d5e6f7a-8b9c-4d5e-6f7a-8b9c0d1e2f3a'),
('8b9c0d1e-2f3a-4b5c-6d7e-8f9a0b1c2d3e', 'Bob', 'Williams', '2023-09-01', '3b5a8e6f-726d-4b8a-9a6c-8a5b6f8d7e9c'),
('9c0d1e2f-3a4b-4c5d-6e7f-8a9b0c1d2e3f', 'Carol', 'Brown', '2023-09-01', '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e6f');

-- Create authors
INSERT INTO library.author (id, name)
VALUES 
('a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'John D. Anderson'),
('b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'Robert L. Boylestad'),
('c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'Thomas H. Cormen'),
('d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'Yunus A. Cengel'),
('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'Norman S. Nise');

-- Create publishers
INSERT INTO library.publisher (id, name)
VALUES 
('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'McGraw-Hill Education'),
('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'Pearson'),
('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'MIT Press'),
('c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'Wiley'),
('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'Academic Press');

-- Create books
INSERT INTO library.book (id, title, publisher_id, isbn, publication_year)
VALUES 
('e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'Fundamentals of Aerodynamics', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', '9780073398105', 2016),
('f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'Electronic Devices and Circuit Theory', 'a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', '9780132622264', 2012),
('a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', 'Introduction to Algorithms', 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', '9780262033848', 2009),
('b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'Thermodynamics: An Engineering Approach', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', '9780073398174', 2014),
('c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'Control Systems Engineering', 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', '9781118170519', 2015);

-- Associate books with authors
INSERT INTO library.book_author (book_id, author_id)
VALUES 
('e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d'),
('f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e'),
('a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f'),
('b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a'),
('c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b');

-- Create book copies in the Engineering Library
INSERT INTO library.book_copy (id, book_id, library_facility_id, status)
VALUES 
('d6e7f8a9-b0c1-4d2e-3f4a-5b6c7d8e9f0a', 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'available'),
('e7f8a9b0-c1d2-4e3f-4a5b-6c7d8e9f0a1b', 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'available'),
('f8a9b0c1-d2e3-4f4a-5b6c-7d8e9f0a1b2c', 'a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'available'),
('a9b0c1d2-e3f4-4a5b-6c7d-8e9f0a1b2c3d', 'b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d8e', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'available'),
('b0c1d2e3-f4a5-4b6c-7d8e-9f0a1b2c3d4e', 'c5d6e7f8-a9b0-4c1d-2e3f-4a5b6c7d8e9f', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'available'),
('c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f', 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'available'),
('d2e3f4a5-b6c7-4d8e-9f0a-1b2c3d4e5f6a', 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'available'),
('e3f4a5b6-c7d8-4e9f-0a1b-2c3d4e5f6a7b', 'a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', 'available')
;
