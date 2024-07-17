-- File: 02_infrastructure_tables.sql
--     Creates enhanced tables for the infrastructure management module.
--
-- # Tables created:
--     1. building: Stores information about campus buildings
--     2. room: Contains attributes for all room types
--     3. faculty: Stores information about academic faculties
--     4. faculty_building: Maps faculties to their buildings
--     5. library: Represents libraries associated with faculties and buildings
--
-- # Additional Structures:
--     - room_type_enum: ENUM type defining different types of rooms

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Create ENUM for room types
-- This allows for a predefined set of room types, ensuring data consistency
CREATE TYPE infrastructure_management.room_type_enum AS ENUM (
    'classroom',
    'laboratory',
    'office',
    'conference_room',
    'auditorium',
    'study_room',
    'computer_lab',
    'workshop',
    'storage',
    'cafeteria'
);

-- Building table
-- This table is the foundation for all physical structures on campus
DROP TABLE IF EXISTS infrastructure_management.building CASCADE;
CREATE TABLE infrastructure_management.building (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Unique identifier for each building
    name VARCHAR(255) NOT NULL,  -- Human-readable name of the building
    address TEXT,  -- Full address of the building
    total_floors INT,  -- Total number of floors, including basement levels if any
    accessibility_features BOOLEAN DEFAULT false  -- Indicates presence of accessibility features
);

-- Add descriptive comments to the building table and its columns
COMMENT ON COLUMN infrastructure_management.building.id IS 'Unique identifier for the building';
COMMENT ON COLUMN infrastructure_management.building.name IS 'Official name of the building';
COMMENT ON COLUMN infrastructure_management.building.address IS 'Full postal address of the building';
COMMENT ON COLUMN infrastructure_management.building.total_floors IS 'Total number of floors in the building, including any basement levels';
COMMENT ON COLUMN infrastructure_management.building.accessibility_features IS 'Boolean indicating if the building is equipped with accessibility features';

-- Add a constraint to ensure the number of floors is positive
ALTER TABLE infrastructure_management.building
ADD CONSTRAINT check_positive_floors CHECK (total_floors > 0);

-- Create an index on the building name for faster searches
CREATE INDEX idx_building_name ON infrastructure_management.building(name);

-- Room table
-- This table represents individual rooms within buildings
DROP TABLE IF EXISTS infrastructure_management.room CASCADE;
CREATE TABLE infrastructure_management.room (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Unique identifier for each room
    room_type infrastructure_management.room_type_enum NOT NULL,  -- Type of room, using the ENUM created earlier
    name VARCHAR(32),  -- Room number or name
    building_id UUID NOT NULL REFERENCES infrastructure_management.building(id),  -- Link to the building containing this room
    capacity INT,  -- Maximum number of people the room can accommodate
    equipment_details JSONB DEFAULT '{}'  -- Flexible storage for equipment information
);

COMMENT ON COLUMN infrastructure_management.room.id IS 'Unique identifier for the room';
COMMENT ON COLUMN infrastructure_management.room.room_type IS 'Categorizes the room (e.g., classroom, laboratory) using predefined types';
COMMENT ON COLUMN infrastructure_management.room.name IS 'Room number or name as it appears on the building directory';
COMMENT ON COLUMN infrastructure_management.room.building_id IS 'References the building where this room is located';
COMMENT ON COLUMN infrastructure_management.room.capacity IS 'Maximum number of occupants the room can safely accommodate';
COMMENT ON COLUMN infrastructure_management.room.equipment_details IS 'JSON object containing details about equipment present in the room';

-- Add a constraint to ensure room capacity is positive
ALTER TABLE infrastructure_management.room
ADD CONSTRAINT check_positive_capacity CHECK (capacity > 0);

-- Create indexes to optimize queries related to rooms
CREATE INDEX idx_room_building ON infrastructure_management.room(building_id);
CREATE INDEX idx_room_type ON infrastructure_management.room(room_type);

-- Faculty table
-- Represents academic faculties or departments within the institution
DROP TABLE IF EXISTS infrastructure_management.faculty CASCADE;
CREATE TABLE infrastructure_management.faculty (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Unique identifier for each faculty
    name VARCHAR(255) NOT NULL  -- Name of the faculty or department
);

COMMENT ON COLUMN infrastructure_management.faculty.id IS 'Unique identifier for the faculty';
COMMENT ON COLUMN infrastructure_management.faculty.name IS 'Official name of the faculty or department';

-- Create a unique index on faculty name to prevent duplicates
CREATE UNIQUE INDEX idx_faculty_name ON infrastructure_management.faculty(name);

-- Faculty Building table
-- Maps the relationship between faculties and the buildings they occupy
DROP TABLE IF EXISTS infrastructure_management.faculty_building CASCADE;
CREATE TABLE infrastructure_management.faculty_building (
    faculty_id UUID NOT NULL REFERENCES infrastructure_management.faculty(id),  -- Reference to the faculty
    building_id UUID NOT NULL REFERENCES infrastructure_management.building(id),  -- Reference to the building
    PRIMARY KEY (faculty_id, building_id)  -- Composite primary key to allow multiple buildings per faculty
);

COMMENT ON COLUMN infrastructure_management.faculty_building.faculty_id IS 'Reference to the faculty occupying the building';
COMMENT ON COLUMN infrastructure_management.faculty_building.building_id IS 'Reference to the building occupied by the faculty';

-- Library table
-- Represents libraries associated with faculties and located in specific buildings
DROP TABLE IF EXISTS infrastructure_management.library CASCADE;
CREATE TABLE infrastructure_management.library (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Unique identifier for each library
    name VARCHAR(255) NOT NULL,  -- Name of the library
    faculty_id UUID NOT NULL,  -- Associated faculty
    building_id UUID NOT NULL,  -- Building where the library is located
    FOREIGN KEY (faculty_id, building_id)
        REFERENCES infrastructure_management.faculty_building(faculty_id, building_id)  -- Ensures library is in a building associated with its faculty
);

COMMENT ON COLUMN infrastructure_management.library.id IS 'Unique identifier for the library';
COMMENT ON COLUMN infrastructure_management.library.name IS 'Official name of the library';
COMMENT ON COLUMN infrastructure_management.library.faculty_id IS 'Reference to the faculty associated with this library';
COMMENT ON COLUMN infrastructure_management.library.building_id IS 'Reference to the building where the library is physically located';

-- Create indexes to optimize queries related to libraries
CREATE INDEX idx_library_faculty ON infrastructure_management.library(faculty_id);
CREATE INDEX idx_library_building ON infrastructure_management.library(building_id);
