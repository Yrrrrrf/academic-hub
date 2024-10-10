DO $$
DECLARE
    course_type academic.course_category_enum DEFAULT 'core';
    v_program_id UUID;
BEGIN
    -- First, let's create the ICI program
    INSERT INTO academic.program (id, code, name, description, degree_level, is_active)
    VALUES (
        'aa6e4e1a-6a0f-4a06-aafc-335a74b385d0'::UUID,
        'ICI',
        'Ingeniería Civil',
        'Programa de ingeniería enfocado en el diseño, construcción y mantenimiento de infraestructuras civiles, incluyendo edificios, carreteras, puentes y sistemas de agua.',
        'Licenciatura',
        true
    )
    ON CONFLICT (id) DO NOTHING
    RETURNING id INTO v_program_id;
    -- 1st semester

    -- 2nd semester
    CALL add_course_to_program(v_program_id, 'c0202000-0000-4000-b000-000000000002'::UUID, 'ICI-02-02', 6, TRUE, 2, 'Lenguaje gráfico', 'Técnicas de representación gráfica en ingeniería.', TRUE, course_type);
    -- 3rd semester
    CALL add_course_to_program(v_program_id, 'c0301000-0000-4000-b000-000000000001'::UUID, 'ICI-03-01', 7, TRUE, 3, 'Dinámica', 'Estudio del movimiento de los cuerpos y las fuerzas que lo causan.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0302000-0000-4000-b000-000000000002'::UUID, 'ICI-03-02', 7, TRUE, 3, 'Mecánica de materiales', 'Análisis de propiedades mecánicas de materiales.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0305000-0000-4000-b000-000000000005'::UUID, 'ICI-03-05', 9, TRUE, 3, 'Geomática', 'Técnicas de medición y representación de la Tierra.', TRUE, course_type);
    -- 4th semester
    CALL add_course_to_program(v_program_id, 'c0401000-0000-4000-b000-000000000001'::UUID, 'ICI-04-01', 8, TRUE, 4, 'Materiales para Ingeniería Civil', 'Estudio de materiales utilizados en construcción civil.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0402000-0000-4000-b000-000000000002'::UUID, 'ICI-04-02', 8, TRUE, 4, 'Teoría estructural', 'Principios fundamentales del análisis estructural.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0403000-0000-4000-b000-000000000003'::UUID, 'ICI-04-03', 8, TRUE, 4, 'Geología', 'Estudio de la estructura y composición de la Tierra.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0404000-0000-4000-b000-000000000004'::UUID, 'ICI-04-04', 7, TRUE, 4, 'Mecánica del medio continuo', 'Análisis del comportamiento de materiales continuos.', TRUE, course_type);
    -- 5th semester
    CALL add_course_to_program(v_program_id, 'c0501000-0000-4000-b000-000000000001'::UUID, 'ICI-05-01', 7, TRUE, 5, 'Procesos constructivos', 'Técnicas y métodos de construcción civil.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0502000-0000-4000-b000-000000000002'::UUID, 'ICI-05-02', 7, TRUE, 5, 'Análisis estructural I', 'Análisis avanzado de estructuras.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0503000-0000-4000-b000-000000000003'::UUID, 'ICI-05-03', 6, TRUE, 5, 'Geotecnia I', 'Estudio de las propiedades mecánicas del suelo.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0504000-0000-4000-b000-000000000004'::UUID, 'ICI-05-04', 7, TRUE, 5, 'Hidráulica', 'Principios de mecánica de fluidos aplicados a ingeniería.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0505000-0000-4000-b000-000000000005'::UUID, 'ICI-05-05', 7, TRUE, 5, 'Termodinámica y electromagnetismo', 'Principios de termodinámica y electromagnetismo en ingeniería.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0506000-0000-4000-b000-000000000006'::UUID, 'ICI-05-06', 7, TRUE, 5, 'Economía', 'Principios económicos aplicados a la ingeniería.', TRUE, course_type);
    -- 6th semester
    CALL add_course_to_program(v_program_id, 'c0601000-0000-4000-b000-000000000001'::UUID, 'ICI-06-01', 6, TRUE, 6, 'Instalaciones', 'Diseño y planificación de instalaciones en edificios.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0602000-0000-4000-b000-000000000002'::UUID, 'ICI-06-02', 7, TRUE, 6, 'Análisis estructural II', 'Continuación de Análisis estructural I.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0603000-0000-4000-b000-000000000003'::UUID, 'ICI-06-03', 6, TRUE, 6, 'Geotecnia II', 'Continuación de Geotecnia I.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0604000-0000-4000-b000-000000000004'::UUID, 'ICI-06-04', 6, TRUE, 6, 'Hidráulica de canales', 'Estudio del flujo de agua en canales abiertos.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0605000-0000-4000-b000-000000000005'::UUID, 'ICI-06-05', 7, TRUE, 6, 'Ingeniería de sistemas I', 'Introducción al enfoque sistémico en ingeniería.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0606000-0000-4000-b000-000000000006'::UUID, 'ICI-06-06', 7, TRUE, 6, 'Ingeniería económica', 'Análisis económico de proyectos de ingeniería.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0607000-0000-4000-b000-000000000007'::UUID, 'ICI-06-07', 5, TRUE, 6, 'Habilidades directivas', 'Desarrollo de habilidades de liderazgo y gestión.', TRUE, course_type);
    -- 7th semester
    CALL add_course_to_program(v_program_id, 'c0701000-0000-4000-b000-000000000001'::UUID, 'ICI-07-01', 6, TRUE, 7, 'Programación y presupuestación', 'Planificación y estimación de costos en proyectos.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0702000-0000-4000-b000-000000000002'::UUID, 'ICI-07-02', 5, TRUE, 7, 'Diseño de estructuras de concreto', 'Diseño de estructuras utilizando concreto.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0703000-0000-4000-b000-000000000003'::UUID, 'ICI-07-03', 7, TRUE, 7, 'Sustentabilidad e impacto ambiental', 'Consideraciones ambientales en ingeniería civil.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0704000-0000-4000-b000-000000000004'::UUID, 'ICI-07-04', 6, TRUE, 7, 'Hidrología', 'Estudio del ciclo del agua y su gestión.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0705000-0000-4000-b000-000000000005'::UUID, 'ICI-07-05', 7, TRUE, 7, 'Ingeniería de sistemas II', 'Continuación de Ingeniería de sistemas I.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0706000-0000-4000-b000-000000000006'::UUID, 'ICI-07-06', 9, TRUE, 7, 'Transporte', 'Estudio de sistemas de transporte y su planificación.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0707000-0000-4000-b000-000000000007'::UUID, 'ICI-07-07', 7, TRUE, 7, 'Evaluación de proyectos', 'Métodos de evaluación de proyectos de ingeniería.', TRUE, course_type);

    -- todo: CORREGIR ESTOS DESTOS...
    -- 8th semester
    CALL add_course_to_program(v_program_id, 'c0801000-0000-4000-b000-000000000001'::UUID, 'ICI-08-01', 5, TRUE, 8, 'Software de transporte', 'Aplicaciones informáticas para planificación de transporte.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0802000-0000-4000-b000-000000000002'::UUID, 'ICI-08-02', 5, TRUE, 8, 'Proyecto ejecutivo de carreteras', 'Diseño y planificación detallada de carreteras.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0803000-0000-4000-b000-000000000003'::UUID, 'ICI-08-03', 5, TRUE, 8, 'Estructuras de mampostería', 'Diseño y análisis de estructuras de mampostería.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0804000-0000-4000-b000-000000000004'::UUID, 'ICI-08-04', 5, TRUE, 8, 'Concreto preforzado', 'Tecnología y diseño de estructuras de concreto preforzado.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0805000-0000-4000-b000-000000000005'::UUID, 'ICI-08-05', 5, TRUE, 8, 'Hidráulica de ríos', 'Estudio del comportamiento hidráulico de ríos.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0806000-0000-4000-b000-000000000006'::UUID, 'ICI-08-06', 5, TRUE, 8, 'Aprovechamientos hidráulicos', 'Gestión y aprovechamiento de recursos hídricos.', TRUE, course_type);
    -- 9th semester (required courses)
    CALL add_course_to_program(v_program_id, 'c0901000-0000-4000-b000-000000000001'::UUID, 'ICI-09-01', 5, TRUE, 9, 'Ferrocarriles', 'Diseño y planificación de sistemas ferroviarios.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0902000-0000-4000-b000-000000000002'::UUID, 'ICI-09-02', 5, TRUE, 9, 'Carreteras', 'Diseño avanzado y mantenimiento de carreteras.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0903000-0000-4000-b000-000000000003'::UUID, 'ICI-09-03', 5, TRUE, 9, 'Puentes', 'Diseño y análisis de estructuras de puentes.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0904000-0000-4000-b000-000000000004'::UUID, 'ICI-09-04', 5, TRUE, 9, 'Proyecto estructural', 'Desarrollo de proyectos estructurales complejos.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0905000-0000-4000-b000-000000000005'::UUID, 'ICI-09-05', 5, TRUE, 9, 'Tratamiento de agua residual municipal', 'Técnicas de tratamiento de aguas residuales.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0906000-0000-4000-b000-000000000006'::UUID, 'ICI-09-06', 5, TRUE, 9, 'Modelación computacional en hidráulica', 'Aplicación de métodos computacionales en hidráulica.', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0907000-0000-4000-b000-000000000007'::UUID, 'ICI-09-07', 5, TRUE, 9, 'Supervisión de obra', 'Gestión y supervisión de proyectos de construcción.', TRUE, course_type);


    -- todo: Fix these courses... (add the correct ones)
    -- * Optional courses
    -- Optional courses (8th semester)
    CALL add_course_to_program(v_program_id, 'c0807000-0000-4000-b000-000000000007'::UUID, 'ICI-08-07', 5, FALSE, 8, 'Sustainable buildings', 'Diseño y construcción de edificios sostenibles.', FALSE, course_type);
    CALL add_course_to_program(v_program_id, 'c0808000-0000-4000-b000-000000000008'::UUID, 'ICI-08-08', 5, FALSE, 8, 'Software de optimización', 'Herramientas de software para optimización en ingeniería.', FALSE, course_type);
    -- Optional courses (9th semester)
    CALL add_course_to_program(v_program_id, 'c0908000-0000-4000-b000-000000000008'::UUID, 'ICI-09-08', 5, FALSE, 9, 'Disposición de residuos sólidos', 'Gestión y disposición de residuos sólidos urbanos.', FALSE, course_type);
    CALL add_course_to_program(v_program_id, 'c0909000-0000-4000-b000-000000000009'::UUID, 'ICI-09-09', 5, FALSE, 9, 'Estrategias competitivas', 'Desarrollo de estrategias competitivas en ingeniería civil.', FALSE, course_type);

    RAISE NOTICE 'All ICI program courses have been added successfully.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error occurred while adding ICI program courses: %', SQLERRM;
END $$;
