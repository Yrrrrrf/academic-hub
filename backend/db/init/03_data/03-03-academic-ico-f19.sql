DO $$
DECLARE
    v_program_id UUID;
BEGIN
    -- First, let's create the ICO program
    INSERT INTO academic.program (id, code, name, description, degree_level, is_active)
    VALUES (
        'ce123456-7890-4321-abcd-ef1234567890'::UUID,
        'ICO',
        'Ingeniería en Computación',
        'Programa de ingeniería enfocado en el diseño y desarrollo de sistemas computacionales',
        'Licenciatura',
        true
    )
    ON CONFLICT (id) DO NOTHING
    RETURNING id INTO v_program_id;

    -- Now, let's add the ICO-specific courses to the program
    -- 1st semester
    CALL add_course_to_program(v_program_id, 'c0102000-0000-4000-a000-000000000002'::UUID, 'ICO-01-01', 7, TRUE, 1, 'Física', 'Principios fundamentales de la física', TRUE);
    CALL add_course_to_program(v_program_id, 'c0104000-0000-4000-a000-000000000004'::UUID, 'ICO-01-02', 7, TRUE, 1, 'Programación I', 'Fundamentos de programación', TRUE);

    -- 2nd semester
    CALL add_course_to_program(v_program_id, 'c0204000-0000-4000-a000-000000000004'::UUID, 'ICO-02-01', 7, TRUE, 2, 'Programación II', 'Programación avanzada y estructuras de datos', TRUE);

    -- 3rd semester
    CALL add_course_to_program(v_program_id, 'c0305000-0000-4000-a000-000000000005'::UUID, 'ICO-03-01', 7, TRUE, 3, 'Bases de datos I', 'Diseño y gestión de bases de datos', TRUE);
    CALL add_course_to_program(v_program_id, 'c0307000-0000-4000-a000-000000000007'::UUID, 'ICO-03-02', 7, TRUE, 3, 'Comunicación y relaciones humanas', 'Desarrollo de habilidades de comunicación y relaciones humanas', TRUE);
    CALL add_course_to_program(v_program_id, 'c0303000-0000-4000-a000-000000000003'::UUID, 'ICO-03-03', 7, TRUE, 3, 'Matemáticas discretas', 'Estructuras matemáticas discretas en ciencias de la computación', TRUE);
    CALL add_course_to_program(v_program_id, 'c0304000-0000-4000-a000-000000000004'::UUID, 'ICO-03-04', 5, TRUE, 3, 'Paradigmas de programación I', 'Estudio de diferentes paradigmas de programación', TRUE);

    -- 4th semester
    CALL add_course_to_program(v_program_id, 'c0401000-0000-4000-a000-000000000001'::UUID, 'ICO-04-01', 7, TRUE, 4, 'Arquitectura de computadoras', 'Estructura y organización de computadoras', TRUE);
    CALL add_course_to_program(v_program_id, 'c0405000-0000-4000-a000-000000000005'::UUID, 'ICO-04-02', 5, TRUE, 4, 'Bases de datos II', 'Administración avanzada de bases de datos', TRUE);
    CALL add_course_to_program(v_program_id, 'c0406000-0000-4000-a000-000000000006'::UUID, 'ICO-04-03', 7, TRUE, 4, 'Electromagnetismo', 'Teoría electromagnética y sus aplicaciones', TRUE);
    CALL add_course_to_program(v_program_id, 'c0402000-0000-4000-a000-000000000002'::UUID, 'ICO-04-04', 7, TRUE, 4, 'Métodos estadísticos', 'Aplicación de métodos estadísticos avanzados', TRUE);
    CALL add_course_to_program(v_program_id, 'c0404000-0000-4000-a000-000000000004'::UUID, 'ICO-04-05', 5, TRUE, 4, 'Paradigmas de programación II', 'Programación avanzada en múltiples paradigmas', TRUE);

    -- 5th semester
    CALL add_course_to_program(v_program_id, 'c0501000-0000-4000-a000-000000000001'::UUID, 'ICO-05-01', 10, TRUE, 5, 'Circuitos eléctricos y electrónicos', 'Fundamentos de circuitos eléctricos y electrónicos', TRUE);
    CALL add_course_to_program(v_program_id, 'c0502000-0000-4000-a000-000000000002'::UUID, 'ICO-05-02', 7, TRUE, 5, 'Transmisión de datos', 'Principios de transmisión de datos en redes', TRUE);
    CALL add_course_to_program(v_program_id, 'c0503000-0000-4000-a000-000000000003'::UUID, 'ICO-05-03', 7, TRUE, 5, 'Investigación de operaciones', 'Métodos de optimización y toma de decisiones', TRUE);
    CALL add_course_to_program(v_program_id, 'c0504000-0000-4000-a000-000000000004'::UUID, 'ICO-05-04', 7, TRUE, 5, 'Ingeniería de software I', 'Fundamentos de ingeniería de software', TRUE);
    CALL add_course_to_program(v_program_id, 'c0505000-0000-4000-a000-000000000005'::UUID, 'ICO-05-05', 7, TRUE, 5, 'Ensambladores', 'Diseño e implementación de ensambladores', TRUE);
    CALL add_course_to_program(v_program_id, 'c0506000-0000-4000-a000-000000000006'::UUID, 'ICO-05-06', 7, TRUE, 5, 'Inteligencia artificial', 'Fundamentos y aplicaciones de la inteligencia artificial', TRUE);

    -- 6th semester
    CALL add_course_to_program(v_program_id, 'c0601000-0000-4000-a000-000000000001'::UUID, 'ICO-06-01', 7, TRUE, 6, 'Sistemas analógicos', 'Análisis y diseño de sistemas analógicos', TRUE);
    CALL add_course_to_program(v_program_id, 'c0602000-0000-4000-a000-000000000002'::UUID, 'ICO-06-02', 7, TRUE, 6, 'Protocolos de comunicación de datos', 'Estudio de protocolos de comunicación en redes', TRUE);
    CALL add_course_to_program(v_program_id, 'c0603000-0000-4000-a000-000000000003'::UUID, 'ICO-06-03', 7, TRUE, 6, 'Administración de recursos informáticos', 'Gestión de recursos en sistemas informáticos', TRUE);
    CALL add_course_to_program(v_program_id, 'c0604000-0000-4000-a000-000000000004'::UUID, 'ICO-06-04', 7, TRUE, 6, 'Ingeniería de software II', 'Técnicas avanzadas de ingeniería de software', TRUE);
    CALL add_course_to_program(v_program_id, 'c0605000-0000-4000-a000-000000000005'::UUID, 'ICO-06-05', 7, TRUE, 6, 'Compiladores', 'Diseño e implementación de compiladores', TRUE);
    CALL add_course_to_program(v_program_id, 'c0606000-0000-4000-a000-000000000006'::UUID, 'ICO-06-06', 7, TRUE, 6, 'Procesamiento de imágenes digitales', 'Técnicas de procesamiento y análisis de imágenes', TRUE);

    -- 7th semester
    CALL add_course_to_program(v_program_id, 'c0701000-0000-4000-a000-000000000001'::UUID, 'ICO-07-01', 7, TRUE, 7, 'Sistemas digitales', 'Diseño y análisis de sistemas digitales', TRUE);
    CALL add_course_to_program(v_program_id, 'c0702000-0000-4000-a000-000000000002'::UUID, 'ICO-07-02', 5, TRUE, 7, 'Arquitectura de redes', 'Diseño y configuración de arquitecturas de red', TRUE);
    CALL add_course_to_program(v_program_id, 'c0703000-0000-4000-a000-000000000003'::UUID, 'ICO-07-03', 7, TRUE, 7, 'Administración de proyectos informáticos', 'Gestión y dirección de proyectos de software', TRUE);
    CALL add_course_to_program(v_program_id, 'c0704000-0000-4000-a000-000000000004'::UUID, 'ICO-07-04', 5, TRUE, 7, 'Ciencia de los datos', 'Análisis y procesamiento de grandes volúmenes de datos', TRUE);
    CALL add_course_to_program(v_program_id, 'c0705000-0000-4000-a000-000000000005'::UUID, 'ICO-07-05', 7, TRUE, 7, 'Sistemas operativos', 'Diseño e implementación de sistemas operativos', TRUE);
    CALL add_course_to_program(v_program_id, 'c0706000-0000-4000-a000-000000000006'::UUID, 'ICO-07-06', 7, TRUE, 7, 'Robótica', 'Fundamentos y aplicaciones de la robótica', TRUE);

    -- 8th semester
    CALL add_course_to_program(v_program_id, 'c0801000-0000-4000-a000-000000000001'::UUID, 'ICO-08-01', 6, TRUE, 8, 'Sistemas embebidos', 'Diseño y programación de sistemas embebidos', TRUE);
    CALL add_course_to_program(v_program_id, 'c0802000-0000-4000-a000-000000000002'::UUID, 'ICO-08-02', 7, TRUE, 8, 'Seguridad de la información', 'Principios y técnicas de seguridad informática', TRUE);
    CALL add_course_to_program(v_program_id, 'c0803000-0000-4000-a000-000000000003'::UUID, 'ICO-08-03', 4, TRUE, 8, 'Gestión de proyectos de investigación', 'Metodología y gestión de proyectos de investigación', TRUE);
    CALL add_course_to_program(v_program_id, 'c0804000-0000-4000-a000-000000000004'::UUID, 'ICO-08-04', 5, TRUE, 8, 'Tecnologías computacionales I', 'Estudio de tecnologías computacionales avanzadas', TRUE);
    CALL add_course_to_program(v_program_id, 'c0805000-0000-4000-a000-000000000005'::UUID, 'ICO-08-05', 8, TRUE, 8, 'Integrativa profesional', 'Integración de conocimientos profesionales', TRUE);
    CALL add_course_to_program(v_program_id, 'c0806000-0000-4000-a000-000000000006'::UUID, 'ICO-08-06', 6, TRUE, 8, 'Ética profesional y sustentabilidad', 'Ética en la práctica profesional y desarrollo sustentable', TRUE);

    -- 9th semester
    CALL add_course_to_program(v_program_id, 'c0901000-0000-4000-a000-000000000001'::UUID, 'ICO-09-01', 5, TRUE, 9, 'Proyecto integral de comunicación de datos', 'Desarrollo de proyectos de redes y comunicaciones', TRUE);
    CALL add_course_to_program(v_program_id, 'c0902000-0000-4000-a000-000000000002'::UUID, 'ICO-09-02', 5, TRUE, 9, 'Proyecto integral de ingeniería de software', 'Desarrollo de proyectos de ingeniería de software', TRUE);
    CALL add_course_to_program(v_program_id, 'c0903000-0000-4000-a000-000000000003'::UUID, 'ICO-09-03', 5, TRUE, 9, 'Tecnologías computacionales II', 'Aplicaciones avanzadas de tecnologías computacionales', TRUE);

    -- Optional courses
    -- 8th semester optional courses
    CALL add_course_to_program(v_program_id, 'c0807000-0000-4000-a000-000000000007'::UUID, 'ICO-08-07', 5, FALSE, 8, 'Análisis y diseño de redes', 'Diseño y análisis de redes de comunicación', FALSE);
    CALL add_course_to_program(v_program_id, 'c0808000-0000-4000-a000-000000000008'::UUID, 'ICO-08-08', 5, FALSE, 8, 'Visión artificial', 'Fundamentos y aplicaciones de visión artificial', FALSE);
    CALL add_course_to_program(v_program_id, 'c0809000-0000-4000-a000-000000000009'::UUID, 'ICO-08-09', 5, FALSE, 8, 'Reconocimiento de patrones', 'Técnicas de reconocimiento de patrones', FALSE);

    -- 9th semester optional courses
    CALL add_course_to_program(v_program_id, 'c0904000-0000-4000-a000-000000000004'::UUID, 'ICO-09-04', 5, FALSE, 9, 'Gestión de redes', 'Diseño y gestión de redes de comunicación', FALSE);
    CALL add_course_to_program(v_program_id, 'c0905000-0000-4000-a000-000000000005'::UUID, 'ICO-09-05', 5, FALSE, 9, 'Computing in industry', 'Aplicaciones de la computación en la industria', FALSE);
    CALL add_course_to_program(v_program_id, 'c0906000-0000-4000-a000-000000000006'::UUID, 'ICO-09-06', 5, FALSE, 9, 'Interacción hombre-máquina', 'Diseño de interfaces de usuario', FALSE);
    CALL add_course_to_program(v_program_id, 'c0907000-0000-4000-a000-000000000007'::UUID, 'ICO-09-07', 5, FALSE, 9, 'Tecnologías emergentes', 'Estudio de tecnologías emergentes', FALSE);
    CALL add_course_to_program(v_program_id, 'c0908000-0000-4000-a000-000000000008'::UUID, 'ICO-09-08', 5, FALSE, 9, 'Tópicos de tecnologías de datos', 'Estudio de tópicos avanzados en tecnologías de datos', FALSE);
    CALL add_course_to_program(v_program_id, 'c0909000-0000-4000-a000-000000000009'::UUID, 'ICO-09-09', 5, FALSE, 9, 'Sistemas interactivos', 'Diseño de sistemas interactivos', FALSE);

    RAISE NOTICE 'All ICO program courses have been added successfully.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error occurred while adding ICO program courses: %', SQLERRM;
END $$;
