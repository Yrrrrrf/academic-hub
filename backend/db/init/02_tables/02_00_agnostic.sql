-- 00_agnostic.sql
-- This schema is agnostic to specific modules and contains shared concepts

CREATE SCHEMA IF NOT EXISTS agnostic;

-- Topic: Represents a topic (subject area)
-- Can be associated with courses, articles, books, etc.
CREATE TABLE agnostic.topic (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    parent_topic_id UUID REFERENCES agnostic.topic(id)
);

COMMENT ON COLUMN agnostic.topic.parent_topic_id IS 'Reference to a parent topic, allowing for hierarchical topic structure';

CREATE INDEX idx_topic_name ON agnostic.topic(name);
CREATE INDEX idx_topic_parent ON agnostic.topic(parent_topic_id);

-- Tag: Represents tags that can be applied to various entities
CREATE TABLE agnostic.tag (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

CREATE INDEX idx_tag_name ON agnostic.tag(name);

-- Function to ensure topic hierarchies don't form cycles
CREATE OR REPLACE FUNCTION agnostic.check_topic_hierarchy()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.parent_topic_id IS NOT NULL THEN
        IF NEW.id = NEW.parent_topic_id THEN
            RAISE EXCEPTION 'A topic cannot be its own parent';
        END IF;
        IF EXISTS (
            WITH RECURSIVE topic_hierarchy AS (
                SELECT id, parent_topic_id FROM agnostic.topic WHERE id = NEW.parent_topic_id
                UNION ALL
                SELECT t.id, t.parent_topic_id 
                FROM agnostic.topic t
                JOIN topic_hierarchy th ON t.id = th.parent_topic_id
            )
            SELECT 1 FROM topic_hierarchy WHERE id = NEW.id
        ) THEN
            RAISE EXCEPTION 'Circular reference detected in topic hierarchy';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_topic_hierarchy
BEFORE INSERT OR UPDATE ON agnostic.topic
FOR EACH ROW EXECUTE FUNCTION agnostic.check_topic_hierarchy();