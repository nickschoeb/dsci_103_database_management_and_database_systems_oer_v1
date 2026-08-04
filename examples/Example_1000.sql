/*
Example 1000
Simple People Table

Notes:
NO Primary Key or datetime stamps yet
*/

-- Table Definition
CREATE TABLE people (
    employee_id VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    year_hired INTEGER NOT NULL
);

-- Data
INSERT INTO people
(employee_id, first_name, last_name, year_hired)
VALUES
    ('ABC3931', 'Paul', 'Dias', 2024),
    ('ABC3464', 'Cameron', 'Vargas', 2023),
    ('ABC0291', 'Allison', 'Williams', 2010),
    ('ABC8255', 'April', 'Reeve', 2026);

-- First Query
SELECT * FROM people;
