-- Function to add a new course
CREATE OR REPLACE FUNCTION add_course(
    p_id UUID,
    p_code VARCHAR(20),
    p_credits INTEGER,
    p_title VARCHAR(255),
    p_description TEXT,
    p_category academic.course_category_enum DEFAULT 'basic',
    p_is_active BOOLEAN DEFAULT TRUE
) RETURNS UUID AS $$
DECLARE
    v_course_id UUID;
BEGIN
    INSERT INTO academic.course (id, code, title, description, credits, category, is_active)
    VALUES (p_id, p_code, p_title, p_description, p_credits, p_category, p_is_active)
    ON CONFLICT (id) DO UPDATE
    SET code = EXCLUDED.code,
        title = EXCLUDED.title,
        description = EXCLUDED.description,
        credits = EXCLUDED.credits,
        category = EXCLUDED.category,
        is_active = EXCLUDED.is_active
    RETURNING id INTO v_course_id;

    RETURN v_course_id;
END;
$$ LANGUAGE plpgsql;

-- Function to associate a course with a program (unchanged)
CREATE OR REPLACE FUNCTION associate_course_with_program(
    p_program_id UUID,
    p_course_id UUID,
    p_is_required BOOLEAN,
    p_recommended_semester INTEGER
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO academic.program_course (program_id, course_id, is_required, recommended_semester)
    VALUES (p_program_id, p_course_id, p_is_required, p_recommended_semester)
    ON CONFLICT (program_id, course_id) DO UPDATE
    SET is_required = EXCLUDED.is_required,
        recommended_semester = EXCLUDED.recommended_semester;

    RETURN FOUND;
END;
$$ LANGUAGE plpgsql;

-- Procedure to add a course and associate it with a program
CREATE OR REPLACE PROCEDURE add_course_to_program(
    p_program_id UUID,
    p_course_id UUID,
    p_code VARCHAR(20),
    p_credits INTEGER,
    p_is_required BOOLEAN,
    p_recommended_semester INTEGER,
    p_title VARCHAR(255),
    p_description TEXT,
    p_is_active BOOLEAN DEFAULT TRUE,
    p_category academic.course_category_enum DEFAULT 'basic'
) AS $$
DECLARE
    v_course_id UUID;
BEGIN
    -- First, try to add the course
    v_course_id := add_course(p_course_id, p_code, p_credits, p_title, p_description, p_category, p_is_active);

    -- If the course was added successfully or already exists, associate it with the program
    IF v_course_id IS NOT NULL THEN
        PERFORM associate_course_with_program(p_program_id, v_course_id, p_is_required, p_recommended_semester);
        RAISE NOTICE 'Course % added and associated with program successfully.', p_code;
    ELSE
        RAISE NOTICE 'Failed to add course %', p_code;
    END IF;
END;
$$ LANGUAGE plpgsql;