-- File: 03-05-academic-ico-f19-program-course.sql
-- Associates courses with the Computer Engineering program (Ingeniería en Computación) (F19 curriculum)

-- Insert program-course associations
INSERT INTO academic.program_course (program_id, course_id, is_required, recommended_semester)
VALUES
-- 1st semester
    -- Common Engineering courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0103000-0000-4000-a000-000000000003', true, 1), -- Álgebra superior
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0105000-0000-4000-a000-000000000005', true, 1), -- Geometría analítica
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0101000-0000-4000-a000-000000000001', true, 1), -- Cálculo I
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0106000-0000-4000-a000-000000000006', true, 1), -- El ingeniero y su entorno socioeconómico
    -- ICO specific courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0102000-0000-4000-a000-000000000002', true, 1), -- Física
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0104000-0000-4000-a000-000000000004', true, 1), -- Programación I

-- 2nd semester
    -- Common Engineering courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0207000-0000-4000-a000-000000000007', true, 2), -- Epistemología
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0202000-0000-4000-a000-000000000002', true, 2), -- Ecuaciones diferenciales
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0203000-0000-4000-a000-000000000003', true, 2), -- Álgebra lineal
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0205000-0000-4000-a000-000000000005', true, 2), -- Química
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0201000-0000-4000-a000-000000000001', true, 2), -- Cálculo II
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0206000-0000-4000-a000-000000000006', true, 2), -- Inglés 5
    -- ICO specific courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0204000-0000-4000-a000-000000000004', true, 2), -- Programación II

-- 3rd semester
    -- Common Engineering courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0302000-0000-4000-a000-000000000002', true, 3), -- Probabilidad y estadística
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0301000-0000-4000-a000-000000000001', true, 3), -- Cálculo III
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0306000-0000-4000-a000-000000000006', true, 3), -- Inglés 6
    -- ICO specific courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0305000-0000-4000-a000-000000000005', true, 3), -- Bases de datos I
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0307000-0000-4000-a000-000000000007', true, 3), -- Comunicación y relaciones humanas
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0303000-0000-4000-a000-000000000003', true, 3), -- Matemáticas discretas
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0304000-0000-4000-a000-000000000004', true, 3), -- Paradigmas de programación I

-- 4th semester
    -- Common Engineering courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0403000-0000-4000-a000-000000000003', true, 4), -- Métodos numéricos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0407000-0000-4000-a000-000000000007', true, 4), -- Inglés 7
    -- ICO specific courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0401000-0000-4000-a000-000000000001', true, 4), -- Arquitectura de computadoras
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0405000-0000-4000-a000-000000000005', true, 4), -- Bases de datos II
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0406000-0000-4000-a000-000000000006', true, 4), -- Electromagnetismo
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0402000-0000-4000-a000-000000000002', true, 4), -- Métodos estadísticos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0404000-0000-4000-a000-000000000004', true, 4), -- Paradigmas de programación II

-- 5th semester
    -- Common Engineering courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0507000-0000-4000-a000-000000000007', true, 5), -- Inglés 8
    -- ICO specific courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0501000-0000-4000-a000-000000000001', true, 5), -- Circuitos eléctricos y electrónicos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0502000-0000-4000-a000-000000000002', true, 5), -- Transmisión de datos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0503000-0000-4000-a000-000000000003', true, 5), -- Investigación de operaciones
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0504000-0000-4000-a000-000000000004', true, 5), -- Ingeniería de software I
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0505000-0000-4000-a000-000000000005', true, 5), -- Ensambladores
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0506000-0000-4000-a000-000000000006', true, 5), -- Inteligencia artificial

-- 6th semester
    -- ICO specific courses (all courses in this semester are specific to ICO)
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0601000-0000-4000-a000-000000000001', true, 6), -- Sistemas analógicos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0602000-0000-4000-a000-000000000002', true, 6), -- Protocolos de comunicación de datos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0603000-0000-4000-a000-000000000003', true, 6), -- Administración de recursos informáticos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0604000-0000-4000-a000-000000000004', true, 6), -- Ingeniería de software II
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0605000-0000-4000-a000-000000000005', true, 6), -- Compiladores
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0606000-0000-4000-a000-000000000006', true, 6), -- Procesamiento de imágenes digitales

-- 7th semester
    -- ICO specific courses (all courses in this semester are specific to ICO)
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0701000-0000-4000-a000-000000000001', true, 7), -- Sistemas digitales
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0702000-0000-4000-a000-000000000002', true, 7), -- Arquitectura de redes
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0703000-0000-4000-a000-000000000003', true, 7), -- Administración de proyectos informáticos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0704000-0000-4000-a000-000000000004', true, 7), -- Ciencia de los datos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0705000-0000-4000-a000-000000000005', true, 7), -- Sistemas operativos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0706000-0000-4000-a000-000000000006', true, 7), -- Robótica

-- 8th semester
    -- ICO specific courses (all courses in this semester are specific to ICO)
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0801000-0000-4000-a000-000000000001', true, 8), -- Sistemas embebidos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0802000-0000-4000-a000-000000000002', true, 8), -- Seguridad de la información
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0803000-0000-4000-a000-000000000003', true, 8), -- Gestión de proyectos de investigación
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0804000-0000-4000-a000-000000000004', true, 8), -- Tecnologías computacionales I
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0805000-0000-4000-a000-000000000005', true, 8), -- Integrativa profesional
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0806000-0000-4000-a000-000000000006', true, 8), -- Ética profesional y sustentabilidad

-- 9th semester
    -- ICO specific courses (all courses in this semester are specific to ICO)
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0901000-0000-4000-a000-000000000001', true, 9), -- Proyecto integral de comunicación de datos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0902000-0000-4000-a000-000000000002', true, 9), -- Proyecto integral de ingeniería de software
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0903000-0000-4000-a000-000000000003', true, 9)  -- Tecnologías computacionales II
;


-- * Note: Optative courses are not included in this insert statement.
-- * They might need to be handled separately
INSERT INTO academic.program_course (program_id, course_id, is_required, recommended_semester)
VALUES

-- 8th semester optional courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0807000-0000-4000-a000-000000000007', false, 8), -- Análisis y diseño de redes
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0808000-0000-4000-a000-000000000008', false, 8), -- Visión artificial
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0809000-0000-4000-a000-000000000009', false, 8), -- Reconocimiento de patrones

-- 9th semester optional courses
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0904000-0000-4000-a000-000000000004', false, 9), -- Gestión de redes
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0905000-0000-4000-a000-000000000005', false, 9), -- Computing in industry
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0906000-0000-4000-a000-000000000006', false, 9), -- Interacción hombre-máquina
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0907000-0000-4000-a000-000000000007', false, 9), -- Tecnologías emergentes
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0908000-0000-4000-a000-000000000008', false, 9), -- Tópicos de tecnologías de datos
    ('ce123456-7890-4321-abcd-ef1234567890', 'c0909000-0000-4000-a000-000000000009', false, 9)  -- Sistemas interactivos
;
