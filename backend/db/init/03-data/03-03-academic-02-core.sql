-- File: core_courses.sql
DO $$
DECLARE
    course_type academic.course_category_enum DEFAULT 'core';
BEGIN
    -- Add this new course for Civil Engineering
    PERFORM add_course('c0209000-0000-4000-a000-000000000009'::UUID, 'CIVL-GRAPH', 6, 'Lenguaje gráfico', 'Técnicas de dibujo y representación gráfica para ingeniería civil', course_type);

    -- Semester 2
    PERFORM add_course('c0204000-0000-4000-a000-000000000014'::UUID, 'PRO-02-01', 7, 'Programación II', 'Programación avanzada y estructuras de datos', course_type);


    -- Semester 3
    PERFORM add_course('c0305000-0000-4000-a000-000000000005'::UUID, 'DAT-03-01', 7, 'Bases de datos I', 'Diseño y gestión de bases de datos', course_type);
    PERFORM add_course('c0304000-0000-4000-a000-000000000004'::UUID, 'PRO-03-02', 5, 'Paradigmas de programación I', 'Estudio de diferentes paradigmas de programación', course_type);

    -- Semester 4
    PERFORM add_course('c0401000-0000-4000-a000-000000000001'::UUID, 'ARQ-04-01', 7, 'Arquitectura de computadoras', 'Estructura y organización de computadoras', course_type);
    PERFORM add_course('c0405000-0000-4000-a000-000000000005'::UUID, 'DAT-04-02', 5, 'Bases de datos II', 'Administración avanzada de bases de datos', course_type);
    PERFORM add_course('c0404000-0000-4000-a000-000000000004'::UUID, 'PRO-04-03', 5, 'Paradigmas de programación II', 'Programación avanzada en múltiples paradigmas', course_type);

    -- Semester 5
    PERFORM add_course('c0501000-0000-4000-a000-000000000001'::UUID, 'CIR-05-01', 10, 'Circuitos eléctricos y electrónicos', 'Fundamentos de circuitos eléctricos y electrónicos', course_type);
    PERFORM add_course('c0502000-0000-4000-a000-000000000002'::UUID, 'RED-05-02', 7, 'Transmisión de datos', 'Principios de transmisión de datos en redes', course_type);
    PERFORM add_course('c0503000-0000-4000-a000-000000000003'::UUID, 'OPE-05-03', 7, 'Investigación de operaciones', 'Métodos de optimización y toma de decisiones', course_type);
    PERFORM add_course('c0504000-0000-4000-a000-000000000004'::UUID, 'SOF-05-04', 7, 'Ingeniería de software I', 'Fundamentos de ingeniería de software', course_type);
    PERFORM add_course('c0505000-0000-4000-a000-000000000005'::UUID, 'ENS-05-05', 7, 'Ensambladores', 'Diseño e implementación de ensambladores', course_type);
    PERFORM add_course('c0506000-0000-4000-a000-000000000006'::UUID, 'IAR-05-06', 7, 'Inteligencia artificial', 'Fundamentos y aplicaciones de la inteligencia artificial', course_type);

    -- Semester 6
    PERFORM add_course('c0601000-0000-4000-a000-000000000001'::UUID, 'SIS-06-01', 7, 'Sistemas analógicos', 'Análisis y diseño de sistemas analógicos', course_type);
    PERFORM add_course('c0602000-0000-4000-a000-000000000002'::UUID, 'RED-06-02', 7, 'Protocolos de comunicación de datos', 'Estudio de protocolos de comunicación en redes', course_type);
    PERFORM add_course('c0603000-0000-4000-a000-000000000003'::UUID, 'ADM-06-03', 7, 'Administración de recursos informáticos', 'Gestión de recursos en sistemas informáticos', course_type);
    PERFORM add_course('c0604000-0000-4000-a000-000000000004'::UUID, 'SOF-06-04', 7, 'Ingeniería de software II', 'Técnicas avanzadas de ingeniería de software', course_type);
    PERFORM add_course('c0605000-0000-4000-a000-000000000005'::UUID, 'COM-06-05', 7, 'Compiladores', 'Diseño e implementación de compiladores', course_type);
    PERFORM add_course('c0606000-0000-4000-a000-000000000006'::UUID, 'IMG-06-06', 7, 'Procesamiento de imágenes digitales', 'Técnicas de procesamiento y análisis de imágenes', course_type);

    -- Semester 7
    PERFORM add_course('c0701000-0000-4000-a000-000000000001'::UUID, 'SIS-07-01', 7, 'Sistemas digitales', 'Diseño y análisis de sistemas digitales', course_type);
    PERFORM add_course('c0702000-0000-4000-a000-000000000002'::UUID, 'RED-07-02', 5, 'Arquitectura de redes', 'Diseño y configuración de arquitecturas de red', course_type);
    PERFORM add_course('c0703000-0000-4000-a000-000000000003'::UUID, 'ADM-07-03', 7, 'Administración de proyectos informáticos', 'Gestión y dirección de proyectos de software', course_type);
    PERFORM add_course('c0705000-0000-4000-a000-000000000005'::UUID, 'SOP-07-04', 7, 'Sistemas operativos', 'Diseño e implementación de sistemas operativos', course_type);
    PERFORM add_course('c0706000-0000-4000-a000-000000000006'::UUID, 'ROB-07-05', 7, 'Robótica', 'Fundamentos y aplicaciones de la robótica', course_type);
    PERFORM add_course('c0707000-0000-4000-a000-000000000007'::UUID, 'GRAF-07-06', 7, ' Graficación computacional', 'Fundamentos y aplicaciones de la graficación por computadora', course_type);

    -- Semester 8
    PERFORM add_course('c0802000-0000-4000-a000-000000000002'::UUID, 'ICO-08-02', 7, 'Seguridad de la información', 'Principios y técnicas de seguridad informática', course_type);

    RAISE NOTICE 'All core courses have been added successfully.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error occurred while adding core courses: %', SQLERRM;
END $$;
