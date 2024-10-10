-- File: 02_infrastructure_views.sql

-- View to show all buildings with their facility types
CREATE OR REPLACE VIEW infrastructure.building_facilities AS
SELECT b.id AS building_id, b.name AS building_name, b.address, 
       f.id AS facility_id, f.facility_type
FROM infrastructure.building b
LEFT JOIN infrastructure.facility f ON b.id = f.building_id;

-- View to show faculties and their associated buildings
CREATE OR REPLACE VIEW infrastructure.faculty_buildings AS
SELECT f.id AS faculty_id, f.name AS faculty_name, 
       b.id AS building_id, b.name AS building_name, b.address
FROM infrastructure.faculty f
JOIN infrastructure.faculty_building fb ON f.id = fb.faculty_id
JOIN infrastructure.building b ON fb.building_id = b.id;

-- View to show room utilization by building
CREATE OR REPLACE VIEW infrastructure.room_utilization AS
SELECT b.id AS building_id, b.name AS building_name, 
       r.room_type, COUNT(*) AS room_count, SUM(r.capacity) AS total_capacity
FROM infrastructure.building b
JOIN infrastructure.room r ON b.id = r.building_id
GROUP BY b.id, b.name, r.room_type;

-- View to show faculties with libraries
CREATE OR REPLACE VIEW infrastructure.faculty_libraries AS
SELECT f.id AS faculty_id, f.name AS faculty_name, 
       b.id AS building_id, b.name AS building_name, 
       fac.id AS library_id
FROM infrastructure.faculty f
JOIN infrastructure.faculty_building fb ON f.id = fb.faculty_id
JOIN infrastructure.building b ON fb.building_id = b.id
JOIN infrastructure.facility fac ON b.id = fac.building_id
WHERE fac.facility_type = 'library';
