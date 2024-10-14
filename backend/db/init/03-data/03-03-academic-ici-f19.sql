-- 03-03-academic-icv-f19.sql
DO $$
DECLARE
    v_program_id UUID;
    course_type academic.course_category DEFAULT 'advanced';
BEGIN
    SELECT id INTO v_program_id FROM academic.program WHERE code = 'ICV';
    IF v_program_id IS NULL THEN  -- ! If the program doesn't exist, create it
        INSERT INTO academic.program (id, code, name, description, degree_level) VALUES (
            '9a173283-6a6c-44bd-8899-e00840511262'::UUID,
            'ICI',
            'Ingeniería Civil',
            'Programa de ingeniería enfocado en el diseño, construcción y mantenimiento de infraestructuras',
            'Licenciatura'
        )
        RETURNING id INTO v_program_id;
    END IF;

    -- * Semester 1
    PERFORM associate_course_with_program(v_program_id, 'c0108000-0000-4000-a000-000000000008', TRUE, 1); -- Mecánica de la partícula
    PERFORM associate_course_with_program(v_program_id, 'c0306000-0000-4000-a000-000000000606', TRUE, 1); -- Programación
    PERFORM associate_course_with_program(v_program_id, 'c0105000-0000-4000-a000-000000000005', TRUE, 1); -- Geometría analítica
    PERFORM associate_course_with_program(v_program_id, 'c0101000-0000-4000-a000-000000000101', TRUE, 1); -- Cálculo I
    PERFORM associate_course_with_program(v_program_id, 'c0106000-0000-4000-a000-000000000006', TRUE, 1); -- El ingeniero y su entorno socioeconómico
    PERFORM associate_course_with_program(v_program_id, 'c0103000-0000-4000-a000-000000000003', TRUE, 1); -- Álgebra superior
    PERFORM associate_course_with_program(v_program_id, 'c0406000-0000-4000-a000-000000000006', TRUE, 1); -- Comunicación oral y escrita
    -- * Semester 2
    PERFORM associate_course_with_program(v_program_id, 'c0208000-0000-4000-a000-000000000008', TRUE, 2); -- Estática
    PERFORM associate_course_with_program(v_program_id, 'c0209000-0000-4000-a000-000000000009', TRUE, 2); -- Lenguaje gráfico (corrected)
    PERFORM associate_course_with_program(v_program_id, 'c0202000-0000-4000-a000-000000000002', TRUE, 2); -- Ecuaciones diferenciales
    PERFORM associate_course_with_program(v_program_id, 'c0201000-0000-4000-a000-000000000001', TRUE, 2); -- Cálculo II
    PERFORM associate_course_with_program(v_program_id, 'c0207000-0000-4000-a000-000000000007', TRUE, 2); -- Epistemología
    PERFORM associate_course_with_program(v_program_id, 'c0203000-0000-4000-a000-000000000003', TRUE, 2); -- Álgebra lineal
    PERFORM associate_course_with_program(v_program_id, 'c0206000-0000-4000-a000-000000000006', TRUE, 2); -- Inglés 5
    -- * Semester 3
    PERFORM associate_course_with_program(v_program_id, 'c0308000-0000-4000-a000-000000000008', TRUE, 3); -- Dinámica
    PERFORM associate_course_with_program(v_program_id, 'c0308000-0000-4000-a000-000000000019', TRUE, 3); -- Mecánica de materiales
    PERFORM associate_course_with_program(v_program_id, 'c0403000-0000-4000-a000-000000000003', TRUE, 3); -- Métodos numéricos
    PERFORM associate_course_with_program(v_program_id, 'c0301000-0000-4000-a000-000000000001', TRUE, 3); -- Cálculo III
    PERFORM associate_course_with_program(v_program_id, 'c0309000-0000-4000-a000-000000000039', TRUE, 3); -- Geomática
    PERFORM associate_course_with_program(v_program_id, 'c0302000-0000-4000-a000-000000000002', TRUE, 3); -- Probabilidad y estadística
    PERFORM associate_course_with_program(v_program_id, 'c0306000-0000-4000-a000-000000000306', TRUE, 3); -- Inglés 6
    -- * Semester 4
    PERFORM associate_course_with_program(v_program_id, 'c0402000-0000-4000-a000-000000000002', TRUE, 4); -- Métodos estadísticos
    PERFORM associate_course_with_program(v_program_id, 'c0205000-0000-4000-a000-000000000005', TRUE, 4); -- Química
    PERFORM associate_course_with_program(v_program_id, 'c0407000-0000-4000-a000-000000000007', TRUE, 4); -- Inglés 7
    PERFORM associate_course_with_program(v_program_id, 'c0401000-0000-4000-a000-000000011102', TRUE, 4); -- Materiales para Ingeniería Civil
    PERFORM associate_course_with_program(v_program_id, 'c0402000-0000-4000-a000-000000011103', TRUE, 4); -- Teoría estructural
    PERFORM associate_course_with_program(v_program_id, 'c0404000-0000-4000-a000-000000011105', TRUE, 4); -- Mecánica del medio continuo
    PERFORM associate_course_with_program(v_program_id, 'c0403000-0000-4000-a000-000000011104', TRUE, 4); -- Geología
    -- * Semester 5
    PERFORM associate_course_with_program(v_program_id, 'c0507000-0000-4000-a000-000000011107', TRUE, 5);  -- Procesos constructivo
    PERFORM associate_course_with_program(v_program_id, 'c0508000-0000-4000-a000-000000011108', TRUE, 5); -- Análisis estructural I
    PERFORM associate_course_with_program(v_program_id, 'c0509000-0000-4000-a000-000000011109', TRUE, 5); -- Geotecnia I
    PERFORM associate_course_with_program(v_program_id, 'c0510000-0000-4000-a000-000000011110', TRUE, 5); -- Hidráulica
    PERFORM associate_course_with_program(v_program_id, 'c0501000-0000-4000-a000-000000011101', TRUE, 5); -- Economía
    -- ^ still need to add 'Termodinámica y electromagnetismo'
    PERFORM associate_course_with_program(v_program_id, 'c0507000-0000-4000-a000-000000000007', TRUE, 5); -- Inglés 8
    -- * Semester 6
    PERFORM associate_course_with_program(v_program_id, 'c0607000-0000-4000-a000-000000011107', TRUE, 6); -- Instalaciones
    PERFORM associate_course_with_program(v_program_id, 'c0608000-0000-4000-a000-000000011108', TRUE, 6); -- Análisis estructural II
    PERFORM associate_course_with_program(v_program_id, 'c0609000-0000-4000-a000-000000011109', TRUE, 6); -- Geotecnia II
    PERFORM associate_course_with_program(v_program_id, 'c0610000-0000-4000-a000-000000011110', TRUE, 6); -- Hidráulica de canales
    PERFORM associate_course_with_program(v_program_id, 'c0611000-0000-4000-a000-000000011111', TRUE, 6); -- Ingeniería en sistemas I
    PERFORM associate_course_with_program(v_program_id, 'c0612000-0000-4000-a000-000000011112', TRUE, 6); -- Ingeniería económica
    PERFORM associate_course_with_program(v_program_id, 'c0613000-0000-4000-a000-000000011113', TRUE, 6); -- Habilidades directivas
    -- * Semester 7
    PERFORM associate_course_with_program(v_program_id, 'c0708000-0000-4000-a000-000000011108', TRUE, 7); -- Diseño de estructuras de concreto
    PERFORM associate_course_with_program(v_program_id, 'c0709000-0000-4000-a000-000000011109', TRUE, 7); -- Sustentabilidad e impacto ambiental
    PERFORM associate_course_with_program(v_program_id, 'c0710000-0000-4000-a000-000000011110', TRUE, 7); -- Hidrología
    PERFORM associate_course_with_program(v_program_id, 'c0711000-0000-4000-a000-000000011111', TRUE, 7); -- Ingeniería en sistemas II
    CALL add_course_to_program(v_program_id, 'c0702000-0000-4000-a000-000000000702'::UUID, 'ICV-07-02', 6, TRUE, 7, 'Programación y presupuestación', 'Estudio de programación y presupuestación de proyectos de ingeniería civil', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0703000-0000-4000-a000-000000000703'::UUID, 'ICV-07-03', 9, TRUE, 7, 'Transporte', 'Diseño y planificación de sistemas de transporte', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0704000-0000-4000-a000-000000000704'::UUID, 'ICV-07-04', 7, TRUE, 7, 'Evaluación de proyectos', 'Estudio de evaluación de proyectos de ingeniería civil', TRUE, course_type);
    -- * Semester 8
    PERFORM associate_course_with_program(v_program_id, 'c0808000-0000-4000-a000-000000011108', TRUE, 8); -- Diseño de estructuras de acero
    CALL add_course_to_program(v_program_id, 'c0801000-0000-4000-a000-000000000801'::UUID, 'ICV-08-01', 7, TRUE, 8, 'Legislación en la construcción', 'Marco legal y normativo en la industria de la construcción', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0803000-0000-4000-a000-000000000803'::UUID, 'ICV-08-03', 7, TRUE, 8, 'Obras de hidráulica', 'Diseño y construcción de obras hidráulicas', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0804000-0000-4000-a000-000000000804'::UUID, 'ICV-08-04', 8, TRUE, 8, 'Abastecimiento de agua potable y alcantarillado', 'Sistemas de distribución de agua potable y manejo de aguas residuales', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0805000-0000-4000-a000-000000000805'::UUID, 'ICV-08-05', 7, TRUE, 8, 'Vías terrestres', 'Diseño y construcción de carreteras y vías férreas', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0806000-0000-4000-a000-000000000806'::UUID, 'ICV-08-06', 8, TRUE, 8, 'Integrativa profesional', 'Proyecto integrador de conocimientos y habilidades profesionales', TRUE, course_type);
    -- Optional courses for Semester 8
    CALL add_course_to_program(v_program_id, 'c0807000-0000-4000-a000-000000000807'::UUID, 'ICV-08-OP1', 5, FALSE, 8, 'Software de transporte', 'Aplicaciones informáticas para el diseño y análisis de sistemas de transporte', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0808000-0000-4000-a000-000000000808'::UUID, 'ICV-08-OP2', 5, FALSE, 8, 'Proyecto ejecutivo de carreteras', 'Desarrollo de proyectos ejecutivos para la construcción de carreteras', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0809000-0000-4000-a000-000000000809'::UUID, 'ICV-08-OP3', 5, FALSE, 8, 'Estructuras de mampostería', 'Diseño y análisis de estructuras de mampostería', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0810000-0000-4000-a000-000000000810'::UUID, 'ICV-08-OP4', 5, FALSE, 8, 'Concreto presforzado', 'Diseño y aplicación de estructuras de concreto presforzado', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0811000-0000-4000-a000-000000000811'::UUID, 'ICV-08-OP5', 5, FALSE, 8, 'Hidráulica de ríos', 'Estudio del comportamiento hidráulico de ríos y su aplicación en ingeniería', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0812000-0000-4000-a000-000000000812'::UUID, 'ICV-08-OP6', 5, FALSE, 8, 'Aprovechamientos hidráulicos', 'Diseño y gestión de proyectos de aprovechamiento de recursos hídricos', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0813000-0000-4000-a000-000000000813'::UUID, 'ICV-08-OP7', 5, FALSE, 8, 'Sustainable buildings', 'Diseño y construcción de edificios sostenibles y eficientes energéticamente', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0814000-0000-4000-a000-000000000814'::UUID, 'ICV-08-OP8', 5, FALSE, 8, 'Software de optimización', 'Uso de software especializado para optimización en proyectos de ingeniería civil', TRUE, course_type);
    -- * Semester 9
    CALL add_course_to_program(v_program_id, 'c0901000-0000-4000-a000-000000000901'::UUID, 'ICV-09-01', 4, TRUE, 9, 'Proyecto de investigación', 'Desarrollo de proyectos de investigación en ingeniería civil', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0902000-0000-4000-a000-000000000902'::UUID, 'ICV-09-02', 7, TRUE, 9, 'Administración de la construcción', 'Gestión y administración de proyectos de construcción', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0903000-0000-4000-a000-000000000903'::UUID, 'ICV-09-03', 4, TRUE, 9, 'Software de construcción', 'Aplicaciones informáticas para la gestión y diseño en construcción', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0906000-0000-4000-a000-000000000906'::UUID, 'ICV-09-06', 6, TRUE, 9, 'Sistemas de tratamiento', 'Diseño y operación de sistemas de tratamiento de aguas', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0904000-0000-4000-a000-000000000904'::UUID, 'ICV-09-04', 6, TRUE, 9, 'Pavimentos', 'Diseño, construcción y mantenimiento de pavimentos', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0905000-0000-4000-a000-000000000905'::UUID, 'ICV-09-05', 6, TRUE, 9, 'Ética y responsabilidad profesional', 'Principios éticos y responsabilidad en la práctica profesional de la ingeniería civil', TRUE, course_type);
    -- Optional courses for Semester 9
    CALL add_course_to_program(v_program_id, 'c0906000-0000-4000-a000-000000000906'::UUID, 'ICV-09-OP1', 5, FALSE, 9, 'Ferrocarriles', 'Diseño, construcción y mantenimiento de sistemas ferroviarios', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0907000-0000-4000-a000-000000000907'::UUID, 'ICV-09-OP2', 5, FALSE, 9, 'Carreteras', 'Diseño avanzado y gestión de proyectos de carreteras', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0908000-0000-4000-a000-000000000908'::UUID, 'ICV-09-OP3', 5, FALSE, 9, 'Puentes', 'Diseño, análisis y construcción de puentes', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0909000-0000-4000-a000-000000000909'::UUID, 'ICV-09-OP4', 5, FALSE, 9, 'Proyecto estructural', 'Desarrollo de proyectos estructurales completos', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0910000-0000-4000-a000-000000000910'::UUID, 'ICV-09-OP5', 5, FALSE, 9, 'Tratamiento de agua residual municipal', 'Diseño y operación de sistemas de tratamiento de aguas residuales municipales', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0911000-0000-4000-a000-000000000911'::UUID, 'ICV-09-OP6', 5, FALSE, 9, 'Modelación computacional en hidráulica', 'Uso de modelos computacionales para el análisis y diseño de sistemas hidráulicos', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0912000-0000-4000-a000-000000000912'::UUID, 'ICV-09-OP7', 5, FALSE, 9, 'Disposición de residuos sólidos', 'Gestión y diseño de sistemas para la disposición de residuos sólidos', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0913000-0000-4000-a000-000000000913'::UUID, 'ICV-09-OP8', 5, FALSE, 9, 'Estrategias competitivas', 'Desarrollo de estrategias competitivas en el campo de la ingeniería civil', TRUE, course_type);
    CALL add_course_to_program(v_program_id, 'c0914000-0000-4000-a000-000000000914'::UUID, 'ICV-09-OP9', 5, FALSE, 9, 'Supervisión de obra', 'Técnicas y métodos para la supervisión efectiva de obras de construcción', TRUE, course_type);

    RAISE NOTICE 'All ICI program courses have been added successfully.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error occurred while adding ICI program courses: %', SQLERRM;
END $$;


-- * Add the course prerequisites for the Civil Engineering program (Ingeniería Civil - F19)
INSERT INTO academic.course_prerequisite (course_id, prerequisite_course_id)
VALUES
    ('c0306000-0000-4000-a000-000000000306', 'c0206000-0000-4000-a000-000000000006'), -- Inglés 6 requires Inglés 5
    ('c0407000-0000-4000-a000-000000000007', 'c0306000-0000-4000-a000-000000000306'), -- Inglés 7 requires Inglés 6
    ('c0507000-0000-4000-a000-000000000007', 'c0407000-0000-4000-a000-000000000007'), -- Inglés 8 requires Inglés 7
    ('c0201000-0000-4000-a000-000000000001', 'c0101000-0000-4000-a000-000000000101'), -- Cálculo II requires Cálculo I
    ('c0301000-0000-4000-a000-000000000001', 'c0201000-0000-4000-a000-000000000001'), -- Cálculo III requires Cálculo II
    ('c0201000-0000-4000-a000-000000000001', 'c0105000-0000-4000-a000-000000000005'), -- Cálculo II requires Geometría analítica
    ('c0202000-0000-4000-a000-000000000002', 'c0101000-0000-4000-a000-000000000101'), -- Ecuaciones diferenciales requires Cálculo I
    ('c0203000-0000-4000-a000-000000000003', 'c0103000-0000-4000-a000-000000000003'), -- Álgebra lineal requires Álgebra superior
    ('c0308000-0000-4000-a000-000000000008', 'c0208000-0000-4000-a000-000000000008'), -- Dinámica requires Estática
    ('c0402000-0000-4000-a000-000000011103', 'c0308000-0000-4000-a000-000000000019'), -- Teoría estructural requires Mecánica de materiales
    ('c0608000-0000-4000-a000-000000011108', 'c0508000-0000-4000-a000-000000011108'), -- Análisis estructural II requires Análisis estructural I    ('c0509000-0000-4000-a000-000000011109', 'c0403000-0000-4000-a000-000000011104'), -- Geotecnia I requires Geología
    ('c0609000-0000-4000-a000-000000011109', 'c0509000-0000-4000-a000-000000011109'), -- Geotecnia II requires Geotecnia I
    ('c0610000-0000-4000-a000-000000011110', 'c0510000-0000-4000-a000-000000011110'), -- Hidráulica de canales requires Hidráulica
    ('c0711000-0000-4000-a000-000000011111', 'c0611000-0000-4000-a000-000000011111'), -- Ingeniería en sistemas II requires Ingeniería en sistemas I
    ('c0906000-0000-4000-a000-000000000906', 'c0804000-0000-4000-a000-000000000804')  -- Sistemas de tratamiento requires Abastecimiento de agua potable y alcantarillado
;