-- File: 03-03-academic-ico-f19.sql
-- Course data for the Computer Engineering program (Ingeniería en Computación) (F19 curriculum)

INSERT INTO academic.program (id, code, name, description, degree_level, is_active)
VALUES (
    'ce123456-7890-4321-abcd-ef1234567890',
    'ICO-F19',
    'Licenciatura de Ingeniería en Computación',
    'Programa de ingeniería en computación que forma profesionales capaces de desarrollar sistemas computacionales, gestionar redes de cómputo y evaluar nuevas tecnologías.',
    'Licenciatura',
    true
);

INSERT INTO academic.course (id, code, title, description, credits, is_active)
VALUES
-- 1st semester
    ('c0102000-0000-4000-a000-000000000002', 'ICO-01-01', 'Física', 'Principios fundamentales de la física', 7, true),
    ('c0104000-0000-4000-a000-000000000004', 'ICO-01-02', 'Programación I', 'Fundamentos de programación', 7, true),

-- 2nd semester
    ('c0204000-0000-4000-a000-000000000004', 'ICO-02-01', 'Programación II', 'Programación avanzada y estructuras de datos', 7, true),

-- 3rd semester
    ('c0305000-0000-4000-a000-000000000005', 'ICO-03-01', 'Bases de datos I', 'Diseño y gestión de bases de datos', 7, true),
    ('c0307000-0000-4000-a000-000000000007', 'ICO-03-02', 'Comunicación y relaciones humanas', 'Desarrollo de habilidades de comunicación y relaciones humanas', 7, true),
    ('c0303000-0000-4000-a000-000000000003', 'ICO-03-03', 'Matemáticas discretas', 'Estructuras matemáticas discretas en ciencias de la computación', 7, true),
    ('c0304000-0000-4000-a000-000000000004', 'ICO-03-04', 'Paradigmas de programación I', 'Estudio de diferentes paradigmas de programación', 5, true),

-- 4th semester
    ('c0401000-0000-4000-a000-000000000001', 'ICO-04-01', 'Arquitectura de computadoras', 'Estructura y organización de computadoras', 7, true),
    ('c0405000-0000-4000-a000-000000000005', 'ICO-04-02', 'Bases de datos II', 'Administración avanzada de bases de datos', 5, true),
    ('c0406000-0000-4000-a000-000000000006', 'ICO-04-03', 'Electromagnetismo', 'Teoría electromagnética y sus aplicaciones', 7, true),
    ('c0402000-0000-4000-a000-000000000002', 'ICO-04-04', 'Métodos estadísticos', 'Aplicación de métodos estadísticos avanzados', 7, true),
    ('c0404000-0000-4000-a000-000000000004', 'ICO-04-05', 'Paradigmas de programación II', 'Programación avanzada en múltiples paradigmas', 5, true),

-- 5th semester
    ('c0501000-0000-4000-a000-000000000001', 'ICO-05-01', 'Circuitos eléctricos y electrónicos', 'Fundamentos de circuitos eléctricos y electrónicos', 10, true),
    ('c0502000-0000-4000-a000-000000000002', 'ICO-05-02', 'Transmisión de datos', 'Principios de transmisión de datos en redes', 7, true),
    ('c0503000-0000-4000-a000-000000000003', 'ICO-05-03', 'Investigación de operaciones', 'Métodos de optimización y toma de decisiones', 7, true),
    ('c0504000-0000-4000-a000-000000000004', 'ICO-05-04', 'Ingeniería de software I', 'Fundamentos de ingeniería de software', 7, true),
    ('c0505000-0000-4000-a000-000000000005', 'ICO-05-05', 'Ensambladores', 'Diseño e implementación de ensambladores', 7, true),
    ('c0506000-0000-4000-a000-000000000006', 'ICO-05-06', 'Inteligencia artificial', 'Fundamentos y aplicaciones de la inteligencia artificial', 7, true),

-- 6th semester
    ('c0601000-0000-4000-a000-000000000001', 'ICO-06-01', 'Sistemas analógicos', 'Análisis y diseño de sistemas analógicos', 7, true),
    ('c0602000-0000-4000-a000-000000000002', 'ICO-06-02', 'Protocolos de comunicación de datos', 'Estudio de protocolos de comunicación en redes', 7, true),
    ('c0603000-0000-4000-a000-000000000003', 'ICO-06-03', 'Administración de recursos informáticos', 'Gestión de recursos en sistemas informáticos', 7, true),
    ('c0604000-0000-4000-a000-000000000004', 'ICO-06-04', 'Ingeniería de software II', 'Técnicas avanzadas de ingeniería de software', 7, true),
    ('c0605000-0000-4000-a000-000000000005', 'ICO-06-05', 'Compiladores', 'Diseño e implementación de compiladores', 7, true),
    ('c0606000-0000-4000-a000-000000000006', 'ICO-06-06', 'Procesamiento de imágenes digitales', 'Técnicas de procesamiento y análisis de imágenes', 7, true),

-- 7th semester
    ('c0701000-0000-4000-a000-000000000001', 'ICO-07-01', 'Sistemas digitales', 'Diseño y análisis de sistemas digitales', 7, true),
    ('c0702000-0000-4000-a000-000000000002', 'ICO-07-02', 'Arquitectura de redes', 'Diseño y configuración de arquitecturas de red', 5, true),
    ('c0703000-0000-4000-a000-000000000003', 'ICO-07-03', 'Administración de proyectos informáticos', 'Gestión y dirección de proyectos de software', 7, true),
    ('c0704000-0000-4000-a000-000000000004', 'ICO-07-04', 'Ciencia de los datos', 'Análisis y procesamiento de grandes volúmenes de datos', 5, true),
    ('c0705000-0000-4000-a000-000000000005', 'ICO-07-05', 'Sistemas operativos', 'Diseño e implementación de sistemas operativos', 7, true),
    ('c0706000-0000-4000-a000-000000000006', 'ICO-07-06', 'Robótica', 'Fundamentos y aplicaciones de la robótica', 7, true),

-- 8th semester
    ('c0801000-0000-4000-a000-000000000001', 'ICO-08-01', 'Sistemas embebidos', 'Diseño y programación de sistemas embebidos', 6, true),
    ('c0802000-0000-4000-a000-000000000002', 'ICO-08-02', 'Seguridad de la información', 'Principios y técnicas de seguridad informática', 7, true),
    ('c0803000-0000-4000-a000-000000000003', 'ICO-08-03', 'Gestión de proyectos de investigación', 'Metodología y gestión de proyectos de investigación', 4, true),
    ('c0804000-0000-4000-a000-000000000004', 'ICO-08-04', 'Tecnologías computacionales I', 'Estudio de tecnologías computacionales avanzadas', 5, true),
    ('c0805000-0000-4000-a000-000000000005', 'ICO-08-05', 'Integrativa profesional', 'Integración de conocimientos profesionales', 8, true),
    ('c0806000-0000-4000-a000-000000000006', 'ICO-08-06', 'Ética profesional y sustentabilidad', 'Ética en la práctica profesional y desarrollo sustentable', 6, true),

-- 9th semester
    ('c0901000-0000-4000-a000-000000000001', 'ICO-09-01', 'Proyecto integral de comunicación de datos', 'Desarrollo de proyectos de redes y comunicaciones', 5, true),
    ('c0902000-0000-4000-a000-000000000002', 'ICO-09-02', 'Proyecto integral de ingeniería de software', 'Desarrollo de proyectos de ingeniería de software', 5, true),
    ('c0903000-0000-4000-a000-000000000003', 'ICO-09-03', 'Tecnologías computacionales II', 'Aplicaciones avanzadas de tecnologías computacionales', 5, true)
;

INSERT INTO academic.course (id, code, title, description, credits, is_active)
VALUES
-- * Optional courses
    -- 8th semester 1 optative course (5 credits)    
        ('c0807000-0000-4000-a000-000000000007', 'ICO-08-07', 'Análisis y diseño de redes', 'Diseño y análisis de redes de comunicación', 5, true),
        ('c0808000-0000-4000-a000-000000000008', 'ICO-08-08', 'Visión artificial', 'Fundamentos y aplicaciones de visión artificial', 5, true),
        ('c0809000-0000-4000-a000-000000000009', 'ICO-08-09', 'Reconocimiento de patrones', 'Técnicas de reconocimiento de patrones', 5, true),
    -- 9th semester 2 optative courses (5 credits each)
        ('c0904000-0000-4000-a000-000000000004', 'ICO-09-04', 'Gestión de redes', 'Diseño y gestión de redes de comunicación', 5, true),
        ('c0905000-0000-4000-a000-000000000005', 'ICO-09-05', 'Computing in industry', 'Aplicaciones de la computación en la industria', 5, true),
        ('c0906000-0000-4000-a000-000000000006', 'ICO-09-06', 'Interacción hombre-máquina', 'Diseño de interfaces de usuario', 5, true),
        ('c0907000-0000-4000-a000-000000000007', 'ICO-09-07', 'Tecnologías emergentes', 'Estudio de tecnologías emergentes', 5, true),
        ('c0908000-0000-4000-a000-000000000008', 'ICO-09-08', 'Tópicos de tecnologías de datos', 'Estudio de tópicos avanzados en tecnologías de datos', 5, true),
        ('c0909000-0000-4000-a000-000000000009', 'ICO-09-09', 'Sistemas interactivos', 'Diseño de sistemas interactivos', 5, true)
;