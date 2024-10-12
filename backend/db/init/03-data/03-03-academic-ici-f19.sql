-- File: 03-03-academic-icv-f19.sql
DO $$
DECLARE
    v_program_id UUID;
    course_type academic.course_category_enum DEFAULT 'advanced';
BEGIN
    -- Retrieve the existing ICV program ID or create it if it doesn't exist
    SELECT id INTO v_program_id
    FROM academic.program
    WHERE code = 'ICV';

    IF v_program_id IS NULL THEN
        INSERT INTO academic.program (id, code, name, description, degree_level, is_active)
        VALUES (
            '9a173283-6a6c-44bd-8899-e00840511262'::UUID,
            'ICI',
            'Ingeniería Civil',
            'Programa de ingeniería enfocado en el diseño, construcción y mantenimiento de infraestructuras',
            'Licenciatura',
            true
        )
        RETURNING id INTO v_program_id;
    END IF;

    -- Semester 1
    PERFORM associate_course_with_program(v_program_id, 'c0108000-0000-4000-a000-000000000008', TRUE, 1); -- Mecánica de la partícula
    PERFORM associate_course_with_program(v_program_id, 'c0306000-0000-4000-a000-000000000606', TRUE, 1); -- Programación
    PERFORM associate_course_with_program(v_program_id, 'c0105000-0000-4000-a000-000000000005', TRUE, 1); -- Geometría analítica
    PERFORM associate_course_with_program(v_program_id, 'c0101000-0000-4000-a000-000000000101', TRUE, 1); -- Cálculo I
    PERFORM associate_course_with_program(v_program_id, 'c0106000-0000-4000-a000-000000000006', TRUE, 1); -- El ingeniero y su entorno socioeconómico
    PERFORM associate_course_with_program(v_program_id, 'c0103000-0000-4000-a000-000000000003', TRUE, 1); -- Álgebra superior
    PERFORM associate_course_with_program(v_program_id, 'c0406000-0000-4000-a000-000000000006', TRUE, 1); -- Comunicación oral y escrita

    -- Semester 2
    PERFORM associate_course_with_program(v_program_id, 'c0208000-0000-4000-a000-000000000008', TRUE, 2); -- Estática
    PERFORM associate_course_with_program(v_program_id, 'c0209000-0000-4000-a000-000000000009', TRUE, 2); -- Lenguaje gráfico (corrected)
    PERFORM associate_course_with_program(v_program_id, 'c0202000-0000-4000-a000-000000000002', TRUE, 2); -- Ecuaciones diferenciales
    PERFORM associate_course_with_program(v_program_id, 'c0201000-0000-4000-a000-000000000001', TRUE, 2); -- Cálculo II
    PERFORM associate_course_with_program(v_program_id, 'c0207000-0000-4000-a000-000000000007', TRUE, 2); -- Epistemología
    PERFORM associate_course_with_program(v_program_id, 'c0203000-0000-4000-a000-000000000003', TRUE, 2); -- Álgebra lineal
    PERFORM associate_course_with_program(v_program_id, 'c0206000-0000-4000-a000-000000000006', TRUE, 2); -- Inglés 5

    -- Semester 3
    PERFORM associate_course_with_program(v_program_id, 'c0308000-0000-4000-a000-000000000008', TRUE, 3); -- Dinámica
    PERFORM associate_course_with_program(v_program_id, 'c0403000-0000-4000-a000-000000000003', TRUE, 3); -- Métodos numéricos
    PERFORM associate_course_with_program(v_program_id, 'c0301000-0000-4000-a000-000000000001', TRUE, 3); -- Cálculo III
    PERFORM associate_course_with_program(v_program_id, 'c0302000-0000-4000-a000-000000000002', TRUE, 3); -- Probabilidad y estadística
    PERFORM associate_course_with_program(v_program_id, 'c0306000-0000-4000-a000-000000000306', TRUE, 3); -- Inglés 6

    -- Semester 4
--     PERFORM associate_course_with_program(v_program_id, 'c0408000-0000-4000-a000-000000000008', TRUE, 4); -- Materiales para Ingeniería Civil
--     PERFORM associate_course_with_program(v_program_id, 'c0708000-0000-4000-a000-000000000008', TRUE, 4); -- Teoría estructural
--     PERFORM associate_course_with_program(v_program_id, 'c1008000-0000-4000-a000-000000000008', TRUE, 4); -- Geología
--     PERFORM associate_course_with_program(v_program_id, 'c1308000-0000-4000-a000-000000000008', TRUE, 4); -- Mecánica del medio continuo
    PERFORM associate_course_with_program(v_program_id, 'c0205000-0000-4000-a000-000000000005', TRUE, 4); -- Química
    PERFORM associate_course_with_program(v_program_id, 'c0407000-0000-4000-a000-000000000007', TRUE, 4); -- Inglés 7

--     -- Semester 5
    PERFORM associate_course_with_program(v_program_id, 'c0508000-0000-4000-a000-000000000008', TRUE, 5); -- Procesos constructivos
    PERFORM associate_course_with_program(v_program_id, 'c0808000-0000-4000-a000-000000000008', TRUE, 5); -- Análisis estructural I
--     PERFORM associate_course_with_program(v_program_id, 'c1108000-0000-4000-a000-000000000008', TRUE, 5); -- Geotecnia I
--     PERFORM associate_course_with_program(v_program_id, 'c1408000-0000-4000-a000-000000000008', TRUE, 5); -- Hidráulica
    PERFORM associate_course_with_program(v_program_id, 'c0204000-0000-4000-a000-000000000004', TRUE, 5); -- Electromagnetismo (Termodinámica y electromagnetismo)
    PERFORM associate_course_with_program(v_program_id, 'c0507000-0000-4000-a000-000000000007', TRUE, 5); -- Inglés 8
-- --
-- --     -- Semester 6
--     PERFORM associate_course_with_program(v_program_id, 'c0608000-0000-4000-a000-000000000008', TRUE, 6); -- Instalaciones
--     PERFORM associate_course_with_program(v_program_id, 'c0908000-0000-4000-a000-000000000008', TRUE, 6); -- Análisis estructural II
--     PERFORM associate_course_with_program(v_program_id, 'c1208000-0000-4000-a000-000000000008', TRUE, 6); -- Geotecnia II
--     PERFORM associate_course_with_program(v_program_id, 'c1508000-0000-4000-a000-000000000008', TRUE, 6); -- Hidráulica de canales
    PERFORM associate_course_with_program(v_program_id, 'c0603000-0000-4000-a000-000000000003', TRUE, 6); -- Administración de recursos informáticos (Ingeniería económica)

    -- Semester 7
    CALL add_course_to_program(v_program_id, 'c0701000-0000-4000-a000-000000000701'::UUID, 'ICV-07-01', 6, TRUE, 7, 'Programación y presupuestación', 'Planificación y estimación de costos en proyectos de construcción', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0702000-0000-4000-a000-000000000702'::UUID, 'ICV-07-02', 5, TRUE, 7, 'Diseño de estructuras de concreto', 'Diseño y análisis de estructuras de concreto reforzado', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0704000-0000-4000-a000-000000000704'::UUID, 'ICV-07-04', 6, TRUE, 7, 'Hidrología', 'Estudio del ciclo hidrológico y sus aplicaciones en ingeniería', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0705000-0000-4000-a000-000000000705'::UUID, 'ICV-07-05', 7, TRUE, 7, 'Ingeniería de sistemas I', 'Aplicación de la teoría de sistemas en ingeniería civil', TRUE, course_type);

    -- Semester 8

    -- Semester 8 (continuing from where we left off)
    CALL add_course_to_program(v_program_id, 'c0801000-0000-4000-a000-000000000801'::UUID, 'ICV-08-01', 7, TRUE, 8, 'Legislación en la construcción', 'Marco legal y normativo en la industria de la construcción', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0802000-0000-4000-a000-000000000802'::UUID, 'ICV-08-02', 5, TRUE, 8, 'Diseño de estructuras de acero', 'Diseño y análisis de estructuras de acero', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0803000-0000-4000-a000-000000000803'::UUID, 'ICV-08-03', 7, TRUE, 8, 'Obras de hidráulica', 'Diseño y construcción de obras hidráulicas', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0804000-0000-4000-a000-000000000804'::UUID, 'ICV-08-04', 9, TRUE, 8, 'Vías terrestres', 'Diseño y construcción de carreteras y vías férreas', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0805000-0000-4000-a000-000000000805'::UUID, 'ICV-08-05', 7, TRUE, 8, 'Ingeniería de sistemas II', 'Aplicaciones avanzadas de la teoría de sistemas en ingeniería civil', TRUE, course_type);

    -- Semester 9
    CALL add_course_to_program(v_program_id, 'c0901000-0000-4000-a000-000000000901'::UUID, 'ICV-09-01', 4, TRUE, 9, 'Proyecto de investigación', 'Desarrollo de un proyecto de investigación en ingeniería civil', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0902000-0000-4000-a000-000000000902'::UUID, 'ICV-09-02', 7, TRUE, 9, 'Administración de la construcción', 'Gestión y administración de proyectos de construcción', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0903000-0000-4000-a000-000000000903'::UUID, 'ICV-09-03', 5, TRUE, 9, 'Pavimentos', 'Diseño y construcción de pavimentos', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0904000-0000-4000-a000-000000000904'::UUID, 'ICV-09-04', 4, TRUE, 9, 'Software de construcción', 'Aplicaciones informáticas en la industria de la construcción', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0905000-0000-4000-a000-000000000905'::UUID, 'ICV-09-05', 5, TRUE, 9, 'Sistemas de tratamiento', 'Diseño de sistemas de tratamiento de agua y residuos', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0906000-0000-4000-a000-000000000906'::UUID, 'ICV-09-06', 8, TRUE, 9, 'Abastecimiento de agua potable y alcantarillado', 'Diseño de sistemas de distribución de agua y recolección de aguas residuales', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0907000-0000-4000-a000-000000000907'::UUID, 'ICV-09-07', 8, TRUE, 9, 'Integrativa profesional', 'Integración de conocimientos y habilidades en ingeniería civil', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0908000-0000-4000-a000-000000000908'::UUID, 'ICV-09-08', 4, TRUE, 9, 'Ética y responsabilidad profesional', 'Ética en la práctica de la ingeniería civil', TRUE, course_type);

    RAISE NOTICE 'All ICV program courses have been added successfully.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error occurred while adding ICV program courses: %', SQLERRM;
END $$;