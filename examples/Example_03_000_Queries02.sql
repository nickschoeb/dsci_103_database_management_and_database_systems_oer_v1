-- Queries 2
-- on ex 02_000
-- Distinct and Functions

SELECT * FROM people;

SELECT COUNT(*) FROM people;

SELECT last_name from people;

SELECT DISTINCT last_name from people;

SELECT DISTINCT year_hired from people ORDER BY year_hired;

SELECT COUNT(DISTINCT last_name) AS UniqueValues
FROM people;

SELECT year_hired FROM people;

SELECT MIN(year_hired) FROM people;

SELECT AVG(year_hired) FROM people;

SELECT
	MIN(year_hired),
	MAX(year_hired)
FROM people;
