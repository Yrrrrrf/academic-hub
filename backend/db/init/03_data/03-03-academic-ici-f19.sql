DO $$
DECLARE
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

    -- Now, let's add the ICI-specific courses to the program
    -- 1st semester
    CALL add_course_to_program(v_program_id, 'c0101000-0000-4000-b000-000000000001'::UUID, 'ICI-01-01', 7, TRUE, 1, 'Mecánica de la partícula', 'Estudio de las leyes fundamentales del movimiento de partículas.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0102000-0000-4000-b000-000000000002'::UUID, 'ICI-01-02', 6, TRUE, 1, 'Programación básica', 'Introducción a los conceptos básicos de programación.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0103000-0000-4000-b000-000000000003'::UUID, 'ICI-01-03', 7, TRUE, 1, 'Geometría analítica', 'Estudio de geometría utilizando un sistema de coordenadas.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0104000-0000-4000-b000-000000000004'::UUID, 'ICI-01-04', 7, TRUE, 1, 'Cálculo I', 'Introducción al cálculo diferencial e integral.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0105000-0000-4000-b000-000000000005'::UUID, 'ICI-01-05', 7, TRUE, 1, 'El ingeniero y su entorno socioeconómico', 'Análisis del papel del ingeniero en la sociedad y la economía.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0106000-0000-4000-b000-000000000006'::UUID, 'ICI-01-06', 7, TRUE, 1, 'Comunicación oral y escrita', 'Desarrollo de habilidades de comunicación efectiva.', TRUE);

    -- 2nd semester
    CALL add_course_to_program(v_program_id, 'c0201000-0000-4000-b000-000000000001'::UUID, 'ICI-02-01', 7, TRUE, 2, 'Estática', 'Estudio de fuerzas en equilibrio.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0202000-0000-4000-b000-000000000002'::UUID, 'ICI-02-02', 6, TRUE, 2, 'Lenguaje gráfico', 'Técnicas de representación gráfica en ingeniería.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0203000-0000-4000-b000-000000000003'::UUID, 'ICI-02-03', 7, TRUE, 2, 'Ecuaciones diferenciales', 'Estudio y aplicación de ecuaciones diferenciales.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0204000-0000-4000-b000-000000000004'::UUID, 'ICI-02-04', 7, TRUE, 2, 'Cálculo II', 'Continuación de Cálculo I, enfocado en funciones multivariables.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0205000-0000-4000-b000-000000000005'::UUID, 'ICI-02-05', 7, TRUE, 2, 'Epistemología', 'Estudio de la naturaleza del conocimiento.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0206000-0000-4000-b000-000000000006'::UUID, 'ICI-02-06', 6, TRUE, 2, 'Inglés 5', 'Curso avanzado de inglés.', TRUE);

    -- 3rd semester
    CALL add_course_to_program(v_program_id, 'c0301000-0000-4000-b000-000000000001'::UUID, 'ICI-03-01', 7, TRUE, 3, 'Dinámica', 'Estudio del movimiento de los cuerpos y las fuerzas que lo causan.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0302000-0000-4000-b000-000000000002'::UUID, 'ICI-03-02', 7, TRUE, 3, 'Mecánica de materiales', 'Análisis de propiedades mecánicas de materiales.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0303000-0000-4000-b000-000000000003'::UUID, 'ICI-03-03', 5, TRUE, 3, 'Métodos numéricos', 'Técnicas computacionales para resolver problemas matemáticos.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0304000-0000-4000-b000-000000000004'::UUID, 'ICI-03-04', 7, TRUE, 3, 'Cálculo III', 'Cálculo avanzado incluyendo series y transformadas.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0305000-0000-4000-b000-000000000005'::UUID, 'ICI-03-05', 9, TRUE, 3, 'Geomática', 'Técnicas de medición y representación de la Tierra.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0306000-0000-4000-b000-000000000006'::UUID, 'ICI-03-06', 6, TRUE, 3, 'Inglés 6', 'Continuación de Inglés 5.', TRUE);

    -- 4th semester
    CALL add_course_to_program(v_program_id, 'c0401000-0000-4000-b000-000000000001'::UUID, 'ICI-04-01', 8, TRUE, 4, 'Materiales para Ingeniería Civil', 'Estudio de materiales utilizados en construcción civil.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0402000-0000-4000-b000-000000000002'::UUID, 'ICI-04-02', 8, TRUE, 4, 'Teoría estructural', 'Principios fundamentales del análisis estructural.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0403000-0000-4000-b000-000000000003'::UUID, 'ICI-04-03', 8, TRUE, 4, 'Geología', 'Estudio de la estructura y composición de la Tierra.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0404000-0000-4000-b000-000000000004'::UUID, 'ICI-04-04', 7, TRUE, 4, 'Mecánica del medio continuo', 'Análisis del comportamiento de materiales continuos.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0405000-0000-4000-b000-000000000005'::UUID, 'ICI-04-05', 7, TRUE, 4, 'Química', 'Principios fundamentales de química aplicados a ingeniería.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0406000-0000-4000-b000-000000000006'::UUID, 'ICI-04-06', 6, TRUE, 4, 'Inglés 7', 'Continuación de Inglés 6.', TRUE);

    -- 5th semester
    CALL add_course_to_program(v_program_id, 'c0501000-0000-4000-b000-000000000001'::UUID, 'ICI-05-01', 7, TRUE, 5, 'Procesos constructivos', 'Técnicas y métodos de construcción civil.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0502000-0000-4000-b000-000000000002'::UUID, 'ICI-05-02', 7, TRUE, 5, 'Análisis estructural I', 'Análisis avanzado de estructuras.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0503000-0000-4000-b000-000000000003'::UUID, 'ICI-05-03', 6, TRUE, 5, 'Geotecnia I', 'Estudio de las propiedades mecánicas del suelo.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0504000-0000-4000-b000-000000000004'::UUID, 'ICI-05-04', 7, TRUE, 5, 'Hidráulica', 'Principios de mecánica de fluidos aplicados a ingeniería.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0505000-0000-4000-b000-000000000005'::UUID, 'ICI-05-05', 7, TRUE, 5, 'Termodinámica y electromagnetismo', 'Principios de termodinámica y electromagnetismo en ingeniería.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0506000-0000-4000-b000-000000000006'::UUID, 'ICI-05-06', 7, TRUE, 5, 'Economía', 'Principios económicos aplicados a la ingeniería.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0507000-0000-4000-b000-000000000007'::UUID, 'ICI-05-07', 6, TRUE, 5, 'Inglés 8', 'Curso final de inglés.', TRUE);

    -- 6th semester
    CALL add_course_to_program(v_program_id, 'c0601000-0000-4000-b000-000000000001'::UUID, 'ICI-06-01', 6, TRUE, 6, 'Instalaciones', 'Diseño y planificación de instalaciones en edificios.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0602000-0000-4000-b000-000000000002'::UUID, 'ICI-06-02', 7, TRUE, 6, 'Análisis estructural II', 'Continuación de Análisis estructural I.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0603000-0000-4000-b000-000000000003'::UUID, 'ICI-06-03', 6, TRUE, 6, 'Geotecnia II', 'Continuación de Geotecnia I.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0604000-0000-4000-b000-000000000004'::UUID, 'ICI-06-04', 6, TRUE, 6, 'Hidráulica de canales', 'Estudio del flujo de agua en canales abiertos.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0605000-0000-4000-b000-000000000005'::UUID, 'ICI-06-05', 7, TRUE, 6, 'Ingeniería de sistemas I', 'Introducción al enfoque sistémico en ingeniería.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0606000-0000-4000-b000-000000000006'::UUID, 'ICI-06-06', 7, TRUE, 6, 'Ingeniería económica', 'Análisis económico de proyectos de ingeniería.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0607000-0000-4000-b000-000000000007'::UUID, 'ICI-06-07', 5, TRUE, 6, 'Habilidades directivas', 'Desarrollo de habilidades de liderazgo y gestión.', TRUE);

    -- 7th semester
    CALL add_course_to_program(v_program_id, 'c0701000-0000-4000-b000-000000000001'::UUID, 'ICI-07-01', 6, TRUE, 7, 'Programación y presupuestación', 'Planificación y estimación de costos en proyectos.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0702000-0000-4000-b000-000000000002'::UUID, 'ICI-07-02', 5, TRUE, 7, 'Diseño de estructuras de concreto', 'Diseño de estructuras utilizando concreto.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0703000-0000-4000-b000-000000000003'::UUID, 'ICI-07-03', 7, TRUE, 7, 'Sustentabilidad e impacto ambiental', 'Consideraciones ambientales en ingeniería civil.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0704000-0000-4000-b000-000000000004'::UUID, 'ICI-07-04', 6, TRUE, 7, 'Hidrología', 'Estudio del ciclo del agua y su gestión.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0705000-0000-4000-b000-000000000005'::UUID, 'ICI-07-05', 7, TRUE, 7, 'Ingeniería de sistemas II', 'Continuación de Ingeniería de sistemas I.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0706000-0000-4000-b000-000000000006'::UUID, 'ICI-07-06', 9, TRUE, 7, 'Transporte', 'Estudio de sistemas de transporte y su planificación.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0707000-0000-4000-b000-000000000007'::UUID, 'ICI-07-07', 7, TRUE, 7, 'Evaluación de proyectos', 'Métodos de evaluación de proyectos de ingeniería.', TRUE);

    -- todo: CORREGIR ESTOS DESTOS...

    -- 8th semester (required courses)
    CALL add_course_to_program(v_program_id, 'c0801000-0000-4000-b000-000000000001'::UUID, 'ICI-08-01', 5, TRUE, 8, 'Software de transporte', 'Aplicaciones informáticas para planificación de transporte.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0802000-0000-4000-b000-000000000002'::UUID, 'ICI-08-02', 5, TRUE, 8, 'Proyecto ejecutivo de carreteras', 'Diseño y planificación detallada de carreteras.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0803000-0000-4000-b000-000000000003'::UUID, 'ICI-08-03', 5, TRUE, 8, 'Estructuras de mampostería', 'Diseño y análisis de estructuras de mampostería.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0804000-0000-4000-b000-000000000004'::UUID, 'ICI-08-04', 5, TRUE, 8, 'Concreto preforzado', 'Tecnología y diseño de estructuras de concreto preforzado.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0805000-0000-4000-b000-000000000005'::UUID, 'ICI-08-05', 5, TRUE, 8, 'Hidráulica de ríos', 'Estudio del comportamiento hidráulico de ríos.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0806000-0000-4000-b000-000000000006'::UUID, 'ICI-08-06', 5, TRUE, 8, 'Aprovechamientos hidráulicos', 'Gestión y aprovechamiento de recursos hídricos.', TRUE);

    -- 9th semester (required courses)
    CALL add_course_to_program(v_program_id, 'c0901000-0000-4000-b000-000000000001'::UUID, 'ICI-09-01', 5, TRUE, 9, 'Ferrocarriles', 'Diseño y planificación de sistemas ferroviarios.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0902000-0000-4000-b000-000000000002'::UUID, 'ICI-09-02', 5, TRUE, 9, 'Carreteras', 'Diseño avanzado y mantenimiento de carreteras.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0903000-0000-4000-b000-000000000003'::UUID, 'ICI-09-03', 5, TRUE, 9, 'Puentes', 'Diseño y análisis de estructuras de puentes.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0904000-0000-4000-b000-000000000004'::UUID, 'ICI-09-04', 5, TRUE, 9, 'Proyecto estructural', 'Desarrollo de proyectos estructurales complejos.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0905000-0000-4000-b000-000000000005'::UUID, 'ICI-09-05', 5, TRUE, 9, 'Tratamiento de agua residual municipal', 'Técnicas de tratamiento de aguas residuales.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0906000-0000-4000-b000-000000000006'::UUID, 'ICI-09-06', 5, TRUE, 9, 'Modelación computacional en hidráulica', 'Aplicación de métodos computacionales en hidráulica.', TRUE);
    CALL add_course_to_program(v_program_id, 'c0907000-0000-4000-b000-000000000007'::UUID, 'ICI-09-07', 5, TRUE, 9, 'Supervisión de obra', 'Gestión y supervisión de proyectos de construcción.', TRUE);

    -- Optional courses (8th semester)
    CALL add_course_to_program(v_program_id, 'c0807000-0000-4000-b000-000000000007'::UUID, 'ICI-08-07', 5, FALSE, 8, 'Sustainable buildings', 'Diseño y construcción de edificios sostenibles.', FALSE);
    CALL add_course_to_program(v_program_id, 'c0808000-0000-4000-b000-000000000008'::UUID, 'ICI-08-08', 5, FALSE, 8, 'Software de optimización', 'Herramientas de software para optimización en ingeniería.', FALSE);

    -- Optional courses (9th semester)
    CALL add_course_to_program(v_program_id, 'c0908000-0000-4000-b000-000000000008'::UUID, 'ICI-09-08', 5, FALSE, 9, 'Disposición de residuos sólidos', 'Gestión y disposición de residuos sólidos urbanos.', FALSE);
    CALL add_course_to_program(v_program_id, 'c0909000-0000-4000-b000-000000000009'::UUID, 'ICI-09-09', 5, FALSE, 9, 'Estrategias competitivas', 'Desarrollo de estrategias competitivas en ingeniería civil.', FALSE);

    RAISE NOTICE 'All ICI program courses have been added successfully.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error occurred while adding ICI program courses: %', SQLERRM;
END $$;
