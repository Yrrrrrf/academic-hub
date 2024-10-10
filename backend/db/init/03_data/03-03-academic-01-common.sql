DO $$
BEGIN
    -- English courses
    PERFORM add_course('c0206000-0000-4000-a000-000000000006'::UUID,    'ENG-02-05', 6, 'Inglés 5', 'Curso avanzado de inglés');
    PERFORM add_course('c0306000-0000-4000-a000-000000000006'::UUID,    'ENG-03-06', 6, 'Inglés 6', 'Curso avanzado de inglés');
    PERFORM add_course('c0407000-0000-4000-a000-000000000007'::UUID,    'ENG-04-07', 6, 'Inglés 7', 'Curso avanzado de inglés');
    PERFORM add_course('c0507000-0000-4000-a000-000000000007'::UUID,    'ENG-05-08', 6, 'Inglés 8', 'Curso avanzado de inglés');
    -- 1st semester common courses
    PERFORM add_course('c0103000-0000-4000-a000-000000000003'::UUID, 'COMMON-01-01', 7, 'Álgebra superior', 'Fundamentos de álgebra y sus aplicaciones');
    PERFORM add_course('c0105000-0000-4000-a000-000000000005'::UUID, 'COMMON-01-02', 4, 'Geometría analítica', 'Estudio de geometría con métodos algebraicos');
    PERFORM add_course('c0101000-0000-4000-a000-000000000001'::UUID, 'COMMON-01-03', 7, 'Cálculo I', 'Fundamentos de cálculo diferencial e integral');
    PERFORM add_course('c0106000-0000-4000-a000-000000000006'::UUID, 'COMMON-01-04', 7, 'El ingeniero y su entorno socioeconómico', 'Contextualización del rol del ingeniero en la sociedad');
    -- 2nd semester common courses
    PERFORM add_course('c0207000-0000-4000-a000-000000000007'::UUID, 'COMMON-02-01', 4, 'Epistemología', 'Estudio de la teoría del conocimiento');
    PERFORM add_course('c0202000-0000-4000-a000-000000000002'::UUID, 'COMMON-02-02', 7, 'Ecuaciones diferenciales', 'Estudio de ecuaciones diferenciales y sus aplicaciones');
    PERFORM add_course('c0203000-0000-4000-a000-000000000003'::UUID, 'COMMON-02-03', 7, 'Álgebra lineal', 'Estudio de espacios vectoriales y transformaciones lineales');
    PERFORM add_course('c0205000-0000-4000-a000-000000000005'::UUID, 'COMMON-02-04', 7, 'Química', 'Fundamentos de química general');
    PERFORM add_course('c0201000-0000-4000-a000-000000000001'::UUID, 'COMMON-02-05', 7, 'Cálculo II', 'Cálculo avanzado y sus aplicaciones');
    PERFORM add_course('c0206000-0000-4000-a000-000000000206'::UUID, 'COMMON-02-06', 6, 'Inglés 5', 'Curso avanzado de inglés');
    -- 3rd semester common courses
    PERFORM add_course('c0302000-0000-4000-a000-000000000002'::UUID, 'COMMON-03-01', 7, 'Probabilidad y estadística', 'Fundamentos de probabilidad y estadística');
    PERFORM add_course('c0301000-0000-4000-a000-000000000001'::UUID, 'COMMON-03-02', 7, 'Cálculo III', 'Cálculo multivariable y vectorial');
    PERFORM add_course('c0306000-0000-4000-a000-000000000306'::UUID, 'COMMON-03-03', 6, 'Inglés 6', 'Curso avanzado de inglés');
    -- 4th semester common course
    PERFORM add_course('c0403000-0000-4000-a000-000000000003'::UUID, 'COMMON-04-01', 5, 'Métodos numéricos', 'Técnicas numéricas para resolución de problemas matemáticos');

    RAISE NOTICE 'All common courses have been added successfully.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An error occurred while adding common courses: %', SQLERRM;
END $$;
