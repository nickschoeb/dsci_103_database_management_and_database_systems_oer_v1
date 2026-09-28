/*
Example_06_010_GroupBy1
Group By Lesson 1
Single Tables - No Joins
GROUP BY - Like Pivot Tables???
*/

DROP TABLE IF EXISTS employees; -- New idea here? This might be easier?

CREATE TABLE employees (
    id SERIAL PRIMARY KEY, -- This is is the older syntax, do not use on a regular basis
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    salary INT NOT NULL
);

INSERT INTO employees (name, department, job_title, salary) VALUES
('Alice', 'Sales', 'Representative', 60000),
('Bob', 'Engineering', 'Developer', 80000),
('Charlie', 'Sales', 'Representative', 55000),
('Diana', 'Engineering', 'Manager', 120000),
('Evan', 'HR', 'Coordinator', 50000),
('Fiona', 'Engineering', 'Developer', 85000),
('George', 'Sales', 'Manager', 95000),
('Hannah', 'Marketing', 'Designer', 70000),
('Ian', 'Marketing', 'Manager', 105000);

-- Queries

-- TEST
SELECT * FROM employees;

-- GROUP BY - Like Pivot Tables

-- Example A: Counting
-- How many employees work in each department?

SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC;

-- Example B: Math
-- Total payroll and average salary for each department?

SELECT 
    department, 
    SUM(salary) AS total_payroll,
    ROUND(AVG(salary), 0) AS average_salary
FROM employees
GROUP BY department
ORDER BY total_payroll DESC;

-- Example C: Multiple Columns
-- Buckets and sub-buckets

SELECT 
    department, 
    job_title, 
    COUNT(*) AS role_count,
    AVG(salary) AS role_average_salary
FROM employees
GROUP BY department, job_title
ORDER BY department, role_count DESC;

-- Example D: Filtering with HAVING
-- WHERE clause filters individual rows before grouping
-- Filter the groups after they are calculated use the HAVING clause
-- Only the departments with an average salary over $80,000.

SELECT 
    department, 
    ROUND(AVG(salary), 0) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 80000;

/*
Citation:
Adapted from Gemini prompt
"make sql creates, inserts, and example queries to teach group by on a single table in postgresql"
Google. (2026). Gemini (September 28 version) [Large language model]. https://gemini.google.com

AI Disclosure/Disclaimer:
This is an example of a positive use of AI as referenced in the first week of classes
AI used to teach via simple lessons
Always be careful as LLMs can be incorrect
*/
