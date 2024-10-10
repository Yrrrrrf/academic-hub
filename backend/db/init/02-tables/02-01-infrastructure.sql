-- File: 01_infrastructure_tables.sql

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Create ENUM types for room and facility types
CREATE TYPE infrastructure.room_type AS ENUM (
    'classroom',
    'laboratory',
    'office',
    'conference_room',
    'auditorium',
    'study_room',
    'computer_lab',
    'workshop',
    'storage',
    'cafeteria',
    'infirmary'
);

CREATE TYPE infrastructure.facility_type AS ENUM (
    'library',
    'research_center',
    'administrative_office',
    'sports_facility',
    'dining_hall',
    'health_center',
    'gymnasium',
    'auditorium'
);

-- Building table
DROP TABLE IF EXISTS infrastructure.building CASCADE;
CREATE TABLE infrastructure.building (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    address TEXT,
    total_floors INT,
    accessibility_features BOOLEAN DEFAULT false
);

COMMENT ON COLUMN infrastructure.building.id IS 'Unique identifier for the building';
COMMENT ON COLUMN infrastructure.building.name IS 'Official name of the building';
COMMENT ON COLUMN infrastructure.building.address IS 'Full postal address of the building';
COMMENT ON COLUMN infrastructure.building.total_floors IS 'Total number of floors in the building, including any basement levels';
COMMENT ON COLUMN infrastructure.building.accessibility_features IS 'Indicates if the building is equipped with accessibility features';

ALTER TABLE infrastructure.building
ADD CONSTRAINT check_positive_floors CHECK (total_floors > 0);

CREATE INDEX idx_building_name ON infrastructure.building(name);

-- Room table
DROP TABLE IF EXISTS infrastructure.room CASCADE;
CREATE TABLE infrastructure.room (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    room_type infrastructure.room_type NOT NULL,
    name VARCHAR(32),
    building_id UUID NOT NULL REFERENCES infrastructure.building(id),
    capacity INT
);

COMMENT ON COLUMN infrastructure.room.id IS 'Unique identifier for the room';
COMMENT ON COLUMN infrastructure.room.room_type IS 'Type of room (e.g., classroom, laboratory)';
COMMENT ON COLUMN infrastructure.room.name IS 'Room number or name';
COMMENT ON COLUMN infrastructure.room.building_id IS 'Reference to the building containing this room';
COMMENT ON COLUMN infrastructure.room.capacity IS 'Maximum occupancy of the room';

ALTER TABLE infrastructure.room
ADD CONSTRAINT check_positive_capacity CHECK (capacity > 0);

CREATE INDEX idx_room_building ON infrastructure.room(building_id);
CREATE INDEX idx_room_type ON infrastructure.room(room_type);

-- Faculty table
DROP TABLE IF EXISTS infrastructure.faculty CASCADE;
CREATE TABLE infrastructure.faculty (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL UNIQUE
);

COMMENT ON COLUMN infrastructure.faculty.id IS 'Unique identifier for the faculty';
COMMENT ON COLUMN infrastructure.faculty.name IS 'Official name of the faculty or department';

-- Faculty Building table
DROP TABLE IF EXISTS infrastructure.faculty_building CASCADE;
CREATE TABLE infrastructure.faculty_building (
    faculty_id UUID NOT NULL REFERENCES infrastructure.faculty(id),
    building_id UUID NOT NULL REFERENCES infrastructure.building(id),
    PRIMARY KEY (faculty_id, building_id)
);

COMMENT ON COLUMN infrastructure.faculty_building.faculty_id IS 'Reference to the faculty';
COMMENT ON COLUMN infrastructure.faculty_building.building_id IS 'Reference to the building';

CREATE INDEX idx_faculty_building_faculty ON infrastructure.faculty_building(faculty_id);
CREATE INDEX idx_faculty_building_building ON infrastructure.faculty_building(building_id);

-- Facility table
DROP TABLE IF EXISTS infrastructure.facility CASCADE;
CREATE TABLE infrastructure.facility (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    facility_type infrastructure.facility_type NOT NULL,
    building_id UUID NOT NULL REFERENCES infrastructure.building(id),
    CONSTRAINT unique_facility_per_building UNIQUE (facility_type, building_id)
);

COMMENT ON COLUMN infrastructure.facility.id IS 'Unique identifier for the facility';
COMMENT ON COLUMN infrastructure.facility.facility_type IS 'Type of facility';
COMMENT ON COLUMN infrastructure.facility.building_id IS 'Reference to the building containing this facility';


-- * CONSTRAINS...

-- Create a function to be used by the trigger
CREATE OR REPLACE FUNCTION infrastructure.check_one_library_per_faculty()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.facility_type = 'library' THEN
        IF EXISTS (
            SELECT 1
            FROM infrastructure.facility f
            JOIN infrastructure.faculty_building fb ON f.building_id = fb.building_id
            WHERE f.facility_type = 'library'
              AND fb.faculty_id = (
                  SELECT faculty_id
                  FROM infrastructure.faculty_building
                  WHERE building_id = NEW.building_id
              )
              AND f.id != NEW.id
        ) THEN
            RAISE EXCEPTION 'Only one library is allowed per faculty';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER enforce_one_library_per_faculty
BEFORE INSERT OR UPDATE ON infrastructure.facility
FOR EACH ROW EXECUTE FUNCTION infrastructure.check_one_library_per_faculty();
