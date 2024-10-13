DO $$
DECLARE
    course_type academic.course_category DEFAULT 'basic';
BEGIN
    -- English courses
    PERFORM add_course('c0206000-0000-4000-a000-000000000006'::UUID,'ENGLISH-05', 6, 'Inglés 5', 'Curso avanzado de inglés', course_type);
    PERFORM add_course('c0306000-0000-4000-a000-000000000306'::UUID,'ENGLISH-06', 6, 'Inglés 6', 'Curso avanzado de inglés', course_type);
    PERFORM add_course('c0407000-0000-4000-a000-000000000007'::UUID,'ENGLISH-07', 6, 'Inglés 7', 'Curso avanzado de inglés', course_type);
    PERFORM add_course('c0507000-0000-4000-a000-000000000007'::UUID,'ENGLISH-08', 6, 'Inglés 8', 'Curso avanzado de inglés', course_type);

    -- Fundamentals
        -- Physics
    PERFORM add_course('c0102000-0000-4000-a000-000000000002'::UUID, 'PHYSICS-01', 7, 'Física', 'Principios fundamentales de la física', course_type);
    PERFORM add_course('c0204000-0000-4000-a000-000000000004'::UUID, 'PHYSICS-02', 7, 'Electromagnetismo', 'Estudio de campos eléctricos y magnéticos', course_type);
    -- Civil Engineering specific basic courses
    PERFORM add_course('c0108000-0000-4000-a000-000000000008'::UUID, 'MECH-01', 7, 'Mecánica de la partícula', 'Estudio de las leyes fundamentales del movimiento de partículas', course_type);
    PERFORM add_course('c0208000-0000-4000-a000-000000000008'::UUID, 'MECH-02', 7, 'Estática', 'Estudio de fuerzas en equilibrio', course_type);
    PERFORM add_course('c0308000-0000-4000-a000-000000000008'::UUID, 'MECH-03', 7, 'Dinámica', 'Estudio del movimiento de los cuerpos y las fuerzas que lo causan', course_type);
    PERFORM add_course('c0305000-0000-4000-a000-000000000005'::UUID, 'PHYSICS-04', 7, 'Termodinámica', 'Estudio de la energía y sus transformaciones', course_type);
        -- Chemistry
    PERFORM add_course('c0205000-0000-4000-a000-000000000005'::UUID, 'CHEM-01', 7, 'Química', 'Fundamentos de química general', course_type);
        -- Logic
    PERFORM add_course('c0306000-0000-4000-a000-000000000606'::UUID, 'COMP-01', 7, 'Programación', 'Introducción a la programación', course_type);
    PERFORM add_course('c0404000-0000-4000-a000-000000000004'::UUID, 'COMP-02', 7, 'Estructuras de datos', 'Estudio de estructuras de datos y algoritmos', course_type);

    -- Mathematics
        -- Algebra & Geometry
    PERFORM add_course('c0103000-0000-4000-a000-000000000003'::UUID, 'MATH-01', 7, 'Álgebra superior', 'Fundamentos de álgebra y sus aplicaciones', course_type);
    PERFORM add_course('c0203000-0000-4000-a000-000000000003'::UUID, 'MATH-02', 7, 'Álgebra lineal', 'Estudio de espacios vectoriales y transformaciones lineales', course_type);
    PERFORM add_course('c0105000-0000-4000-a000-000000000005'::UUID, 'MATH-03', 4, 'Geometría analítica', 'Estudio de geometría con métodos algebraicos', course_type);
    PERFORM add_course('c0304000-0000-4000-a000-000000000012'::UUID, 'MATH-04', 7, 'Matemáticas discretas', 'Estructuras matemáticas discretas en ciencias de la computación', course_type);

        -- Calculus
    PERFORM add_course('c0101000-0000-4000-a000-000000000101'::UUID, 'CALC-01', 7, 'Cálculo I', 'Fundamentos de cálculo diferencial e integral', course_type);
    PERFORM add_course('c0201000-0000-4000-a000-000000000001'::UUID, 'CALC-02', 7, 'Cálculo II', 'Cálculo avanzado y sus aplicaciones', course_type);
    PERFORM add_course('c0301000-0000-4000-a000-000000000001'::UUID, 'CALC-03', 7, 'Cálculo III', 'Cálculo multivariable y vectorial', course_type);
    PERFORM add_course('c0202000-0000-4000-a000-000000000002'::UUID, 'MATH-05', 7, 'Ecuaciones diferenciales', 'Estudio de ecuaciones diferenciales y sus aplicaciones', course_type);

        -- Statistics
    PERFORM add_course('c0302000-0000-4000-a000-000000000002'::UUID, 'STAT-01', 7, 'Probabilidad y estadística', 'Fundamentos de probabilidad y estadística', course_type);
    PERFORM add_course('c0403000-0000-4000-a000-000000000003'::UUID, 'MATH-06', 5, 'Métodos numéricos', 'Técnicas numéricas para resolución de problemas matemáticos', course_type);
    PERFORM add_course('c0402000-0000-4000-a000-000000000002'::UUID, 'STAT-02', 7, 'Métodos estadísticos', 'Estudio de métodos estadísticos y su aplicación', course_type);
    -- Ethics
    PERFORM add_course('c0106000-0000-4000-a000-000000000006'::UUID, 'ENGR-01', 7, 'El ingeniero y su entorno socioeconómico', 'Contextualización del rol del ingeniero en la sociedad', course_type);
    PERFORM add_course('c0207000-0000-4000-a000-000000000007'::UUID, 'PHIL-01', 4, 'Epistemología', 'Estudio de la teoría del conocimiento', course_type);
    PERFORM add_course('c0307000-0000-4000-a000-000000000007'::UUID, 'COMM-01', 7, 'Comunicación y relaciones humanas', 'Desarrollo de habilidades de comunicación y relaciones humanas', course_type);
    PERFORM add_course('c0406000-0000-4000-a000-000000000006'::UUID, 'COMM-02', 7, 'Comunicación oral y escrita', 'Desarrollo de habilidades de comunicación efectiva', course_type);
    PERFORM add_course('c0506000-0000-4000-a000-000000000006'::UUID, 'CULT-01', 5, 'Cultura y comunicación', 'Estudio de la cultura y su relación con la comunicación', course_type);

    RAISE NOTICE 'All common courses have been added successfully.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error occurred while adding common courses: %', SQLERRM;
END $$;