-- File: 03-03-academic-common.sql
-- Insters the course data for the Common Engineering program (Ingeniería Común) (required for any engineering program)

INSERT INTO academic.course (id, code, title, description, credits, is_active)
VALUES
-- * ENGLISH COURSES (for 2..=5 semesters respectively) == (2nd:E5, 3rd:E6, 4th:E7, 5th:E8)
    ('c0206000-0000-4000-a000-000000000006', 'ICO-02-06', 'Inglés 5', 'Curso avanzado de inglés', 6, true),
    ('c0306000-0000-4000-a000-000000000006', 'ICO-03-06', 'Inglés 6', 'Curso avanzado de inglés', 6, true),
    ('c0407000-0000-4000-a000-000000000007', 'ICO-04-07', 'Inglés 7', 'Curso avanzado de inglés', 6, true),
    ('c0507000-0000-4000-a000-000000000007', 'ICO-05-07', 'Inglés 8', 'Curso avanzado de inglés', 6, true),

-- 1st semester
    ('c0103000-0000-4000-a000-000000000003', 'COMMON-01-01', 'Álgebra superior', 'Fundamentos de álgebra y sus aplicaciones', 7, true),
    ('c0105000-0000-4000-a000-000000000005', 'COMMON-01-02', 'Geometría analítica', 'Estudio de geometría con métodos algebraicos', 4, true),
    ('c0101000-0000-4000-a000-000000000001', 'COMMON-01-03', 'Cálculo I', 'Fundamentos de cálculo diferencial e integral', 7, true),
    ('c0106000-0000-4000-a000-000000000006', 'COMMON-01-04', 'El ingeniero y su entorno socioeconómico', 'Contextualización del rol del ingeniero en la sociedad', 7, true),

-- 2nd semester
    ('c0207000-0000-4000-a000-000000000007', 'COMMON-02-01', 'Epistemología', 'Estudio de la teoría del conocimiento', 4, true),
    ('c0202000-0000-4000-a000-000000000002', 'COMMON-02-02', 'Ecuaciones diferenciales', 'Estudio de ecuaciones diferenciales y sus aplicaciones', 7, true),
    ('c0203000-0000-4000-a000-000000000003', 'COMMON-02-03', 'Álgebra lineal', 'Estudio de espacios vectoriales y transformaciones lineales', 7, true),
    ('c0205000-0000-4000-a000-000000000005', 'COMMON-02-04', 'Química', 'Fundamentos de química general', 7, true),
    ('c0201000-0000-4000-a000-000000000001', 'COMMON-02-05', 'Cálculo II', 'Cálculo avanzado y sus aplicaciones', 7, true),
    ('c0206000-0000-4000-a000-000000000206', 'COMMON-02-06', 'Inglés 5', 'Curso avanzado de inglés', 6, true),

-- 3rd semester
    ('c0302000-0000-4000-a000-000000000002', 'COMMON-03-01', 'Probabilidad y estadística', 'Fundamentos de probabilidad y estadística', 7, true),
    ('c0301000-0000-4000-a000-000000000001', 'COMMON-03-02', 'Cálculo III', 'Cálculo multivariable y vectorial', 7, true),
    ('c0306000-0000-4000-a000-000000000306', 'COMMON-03-03', 'Inglés 6', 'Curso avanzado de inglés', 6, true),

-- 4th semester
    ('c0403000-0000-4000-a000-000000000003', 'COMMON-04-01', 'Métodos numéricos', 'Técnicas numéricas para resolución de problemas matemáticos', 5, true)
;

-- * DOUBLE COMMENTED LINES MEANS THAT THESE ARE COURSES THAT DO NOT BELONG TO THE CS PROGRAM, BUT TO THE COMMON ENGINEERING PROGRAM
    -- -- ('c0104000-0000-4000-a000-000000000004', 'ICO-01-04', 'Comunicación oral y escrita', 'Desarrollo de habilidades de comunicación oral y escrita', 7, true),
    -- -- ('c0204000-0000-4000-a000-000000000004', 'ICO-02-04', 'Estática', 'Estudio de la mecánica de cuerpos en equilibrio', 7, true),
    -- -- ('c0205000-0000-4000-a000-000000000012', 'ICO-02-05', 'Mecánica de la partícula', 'Estudio de la mecánica de partículas', 7, true),
    -- -- ('c0107000-0000-4000-a000-000000000007', 'ICO-01-07', 'Programación básica', 'Introducción a la programación', 7, true),
    -- -- ('c0205000-0000-4000-a000-000000000005', 'ICO-02-05', 'Química General', 'Fundamentos de química general', 7, true),
