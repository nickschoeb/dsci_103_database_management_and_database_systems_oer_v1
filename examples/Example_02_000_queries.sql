-- Example 02 000 Query Examples
-- Exercise: study these, pull up data in Excel and compare methods (SQL vs. Excel)
-- Map data science "questions" to queries

-- Select All, usually start from this and add
SELECT * FROM people;

-- Only certain columns
SELECT first_name, last_name FROM people

-- You can change the order
SELECT last_name, first_name FROM people

-- Filter
SELECT * FROM people WHERE last_name = 'Smith';

-- Combine these
SELECT first_name, last_name FROM people WHERE last_name = 'Smith';

-- Style can be different but be consistent
SELECT
	first_name, last_name
FROM people
WHERE
	last_name = 'Smith';

SELECT first_name FROM people WHERE last_name = 'Smith';

-- last names containing ith
SELECT * FROM people WHERE last_name like '%ith%'

-- emails from .biz sites
SELECT * FROM people WHERE email like '%.biz%'

-- Dates and numerics ranges
SELECT * FROM people WHERE year_hired >= 2025;

-- Booleans
SELECT *
FROM people
WHERE
	year_hired >= 2025
	AND
	is_active = TRUE;

-- Ordering
SELECT * FROM people ORDER BY year_hired;

SELECT * FROM people ORDER BY year_hired ASC;

SELECT * FROM people ORDER BY year_hired DESC;
