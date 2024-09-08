-- File: 03-04-academic-ico-f19-prerequisites.sql
-- Course prerequisite data for the Computer Engineering program (Ingeniería en Computación) (F19 curriculum)

INSERT INTO academic.course_prerequisite (course_id, prerequisite_course_id)
VALUES
    -- English course prerequisites
    ('c0306000-0000-4000-a000-000000000006', 'c0206000-0000-4000-a000-000000000006'), -- Inglés 6 requires Inglés 5
    ('c0407000-0000-4000-a000-000000000007', 'c0306000-0000-4000-a000-000000000006'), -- Inglés 7 requires Inglés 6
    ('c0507000-0000-4000-a000-000000000007', 'c0407000-0000-4000-a000-000000000007'), -- Inglés 8 requires Inglés 7

    -- Programming prerequisites
    ('c0204000-0000-4000-a000-000000000004', 'c0104000-0000-4000-a000-000000000004'), -- Programación II requires Programación I

    -- Mathematics prerequisites
    ('c0202000-0000-4000-a000-000000000002', 'c0101000-0000-4000-a000-000000000001'), -- Ecuaciones diferenciales requires Cálculo I
    ('c0203000-0000-4000-a000-000000000003', 'c0103000-0000-4000-a000-000000000003'), -- Álgebra lineal requires Álgebra superior
    ('c0201000-0000-4000-a000-000000000001', 'c0105000-0000-4000-a000-000000000005'), -- Cálculo II requires Geometría analítica
    ('c0201000-0000-4000-a000-000000000001', 'c0101000-0000-4000-a000-000000000001'), -- Cálculo II requires Cálculo I
    ('c0301000-0000-4000-a000-000000000001', 'c0201000-0000-4000-a000-000000000001'), -- Cálculo III requires Cálculo II

    -- Programming paradigms prerequisites
    ('c0404000-0000-4000-a000-000000000004', 'c0304000-0000-4000-a000-000000000004'), -- Paradigmas de programación II requires Paradigmas de programación I

    -- Database prerequisites
    ('c0405000-0000-4000-a000-000000000005', 'c0305000-0000-4000-a000-000000000005'), -- Bases de datos II requires Bases de datos I
    ('c0704000-0000-4000-a000-000000000004', 'c0405000-0000-4000-a000-000000000005'), -- Ciencia de los datos requires Bases de datos II

    -- Software engineering prerequisites
    ('c0604000-0000-4000-a000-000000000004', 'c0504000-0000-4000-a000-000000000004'), -- Ingeniería de software II requires Ingeniería de software I

    -- Electronics prerequisites
    ('c0601000-0000-4000-a000-000000000001', 'c0501000-0000-4000-a000-000000000001'), -- Sistemas analógicos requires Circuitos eléctricos y electrónicos

    -- Network prerequisites
    ('c0602000-0000-4000-a000-000000000002', 'c0502000-0000-4000-a000-000000000002'), -- Protocolos de comunicación de datos requires Transmisión de datos
    ('c0702000-0000-4000-a000-000000000002', 'c0602000-0000-4000-a000-000000000002'), -- Arquitectura de redes requires Protocolos de comunicación de datos

    -- Digital systems prerequisites
    ('c0801000-0000-4000-a000-000000000001', 'c0701000-0000-4000-a000-000000000001'), -- Sistemas embebidos requires Sistemas digitales

    -- Computational technologies prerequisites
    ('c0903000-0000-4000-a000-000000000003', 'c0804000-0000-4000-a000-000000000004')  -- Tecnologías computacionales II requires Tecnologías computacionales I
;
