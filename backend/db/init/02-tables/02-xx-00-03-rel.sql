-- 02-xx-00-03-rel.sql
--     - 02: Tables
--     - XX: Common (post last table script)
--     - 00: relational schema (agnostic)
--     - 03: dependant schema (academic) 
-- * Si, this file relates the schemas 'agnostic' and 'academic' by creating a table that maps courses to topics.

-- Course Topic: Maps courses to topics from the agnostic schema
CREATE TABLE academic.course_topic (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    course_id UUID NOT NULL REFERENCES academic.course(id),
    topic_id UUID NOT NULL REFERENCES agnostic.topic(id),
    relevance_level INT CHECK (relevance_level BETWEEN 1 AND 5),
    CONSTRAINT unique_course_topic UNIQUE (course_id, topic_id)
);

COMMENT ON COLUMN academic.course_topic.id IS 'Unique identifier for the course-topic relationship';
COMMENT ON COLUMN academic.course_topic.course_id IS 'Reference to the course';
COMMENT ON COLUMN academic.course_topic.topic_id IS 'Reference to the topic from the agnostic schema';
COMMENT ON COLUMN academic.course_topic.relevance_level IS 'Indicates the relevance of the topic to the course (1-5)';

CREATE INDEX idx_course_topic_course ON academic.course_topic(course_id);
CREATE INDEX idx_course_topic_topic ON academic.course_topic(topic_id);
