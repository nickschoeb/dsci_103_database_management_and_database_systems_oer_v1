-- POSTGRESQL JOINS AND NULL

-- ================================================================
-- QUICK REFERENCE
-- INNER: matching pairs only.
-- LEFT:  matching pairs + unmatched left rows.
-- RIGHT: matching pairs + unmatched right rows.
-- FULL:  matching pairs + unmatched rows from both sides.
-- CROSS: every possible pair.
-- Self join and non-equi join describe patterns/conditions.
-- ON, USING, and NATURAL describe how matching is specified.
-- EXISTS / NOT EXISTS express semi-join / anti-join patterns.
-- NULL: missing/unknown. Use IS NULL, not = NULL.
-- A join can produce many rows per input row when multiple rows match.
-- ================================================================

-- ================================================================
-- 1. SETUP: one department can have many employees
-- ================================================================
CREATE TABLE join_demo_departments (
    department_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_name TEXT NOT NULL
);

CREATE TABLE join_demo_employees (
    employee_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_name TEXT NOT NULL,
    department_id INTEGER REFERENCES join_demo_departments(department_id),
    manager_id INTEGER REFERENCES join_demo_employees(employee_id),
    bonus NUMERIC(8,2) -- NULL means unknown/not recorded, not zero
);

INSERT INTO join_demo_departments
(department_name) VALUES
    ('Engineering'),
    ('Sales'),
    ('History'); -- No employees in this department.

INSERT INTO join_demo_employees
(employee_name, department_id, manager_id, bonus) VALUES
    ('Maya', (SELECT department_id FROM join_demo_departments WHERE department_name = 'Engineering'), NULL, 500.00),
	('Leo', (SELECT department_id FROM join_demo_departments WHERE department_name = 'Sales'),
		(SELECT employee_id FROM join_demo_employees WHERE employee_name = 'Maya'), NULL),
    ('Ava', (SELECT department_id FROM join_demo_departments WHERE department_name = 'History'), NULL, 0.00),
    ('Noah', NULL, 1, NULL); -- No assigned department.

SELECT * FROM join_demo_departments ORDER BY department_id;
SELECT * FROM join_demo_employees ORDER BY employee_id;

-- In result grids, NULL may appear as a blank or a special marker.
-- Below, the word NULL in expected results means SQL NULL.

-- ================================================================
-- 2. INNER JOIN: return only matching pairs
-- ================================================================
SELECT e.employee_name, d.department_name
FROM join_demo_employees AS e
INNER JOIN join_demo_departments AS d
    ON e.department_id = d.department_id
ORDER BY e.employee_id;

SELECT e.employee_name, d.department_name
FROM join_demo_employees AS e
JOIN join_demo_departments AS d
    ON e.department_id = d.department_id
ORDER BY e.employee_id;

-- Maya | Engineering
-- Leo  | Engineering
-- Ava  | Sales
-- Noah has no matching department. History has no matching employee.
-- JOIN without a qualifier means INNER JOIN.

-- ================================================================
-- 3. LEFT JOIN: keep every row from the left table
-- ================================================================
SELECT e.employee_name, d.department_name
FROM join_demo_employees AS e
LEFT JOIN join_demo_departments AS d
    ON e.department_id = d.department_id
ORDER BY e.employee_id;

SELECT e.employee_name, d.department_name
FROM join_demo_employees AS e
LEFT OUTER JOIN join_demo_departments AS d
    ON e.department_id = d.department_id
ORDER BY e.employee_id;

-- Maya | Engineering
-- Leo  | Engineering
-- Ava  | Sales
-- Noah | NULL
-- The unmatched row is extended with NULL for the department columns.
-- LEFT OUTER JOIN is another spelling of LEFT JOIN.

-- ================================================================
-- 4. RIGHT JOIN: keep every row from the right table
-- ================================================================
SELECT e.employee_name, d.department_name
FROM join_demo_employees AS e
RIGHT JOIN join_demo_departments AS d
    ON e.department_id = d.department_id
ORDER BY d.department_id, e.employee_id;
-- Maya | Engineering
-- Leo  | Engineering
-- Ava  | Sales
-- NULL | History
-- RIGHT OUTER JOIN means the same thing.
-- Swapping the tables and using LEFT JOIN produces equivalent matches.

-- ================================================================
-- 5. FULL JOIN: keep unmatched rows from both sides
-- ================================================================
SELECT e.employee_name, d.department_name
FROM join_demo_employees AS e
FULL OUTER JOIN join_demo_departments AS d
    ON e.department_id = d.department_id
ORDER BY e.employee_id NULLS LAST, d.department_id;
-- Maya | Engineering
-- Leo  | Engineering
-- Ava  | Sales
-- Noah | NULL
-- NULL | History
-- FULL JOIN is another spelling of FULL OUTER JOIN.

-- ================================================================
-- 6. CROSS JOIN: every possible pair, no matching condition
-- ================================================================
SELECT e.employee_name, d.department_name
FROM join_demo_employees AS e
CROSS JOIN join_demo_departments AS d
ORDER BY e.employee_id, d.department_id;
-- 4 employees x 3 departments = 12 rows.
-- Each employee appears with Engineering, Sales, and History.
-- Noah is included: CROSS JOIN does not compare department IDs.
-- CROSS JOIN is useful for combinations, such as sizes x colors.

-- ================================================================
-- 7. SELF JOIN: join a table to itself using different aliases
-- ================================================================
SELECT e.employee_name, m.employee_name AS manager_name
FROM join_demo_employees AS e
LEFT JOIN join_demo_employees AS m
    ON e.manager_id = m.employee_id
ORDER BY e.employee_id;
-- Maya | NULL
-- Leo  | Maya
-- Ava  | NULL
-- Noah | Maya
-- A self join is a pattern, not a separate join operator.
-- LEFT JOIN keeps employees who have no manager.

-- ================================================================
-- OPTIONAL EXAMPLES: LESS COMMON JOINS and ANTI PATTERNS
-- ================================================================

-- ================================================================
-- 8. NON-EQUI JOIN: use comparisons other than equality
-- ================================================================
SELECT a.employee_name AS first_employee,
       b.employee_name AS second_employee
FROM join_demo_employees AS a
JOIN join_demo_employees AS b
    ON a.employee_id < b.employee_id
ORDER BY a.employee_id, b.employee_id;
-- Maya | Leo
-- Maya | Ava
-- Maya | Noah
-- Leo  | Ava
-- Leo  | Noah
-- Ava  | Noah
-- The < condition gives each pair once and excludes self-pairs.
-- This is an INNER JOIN with a non-equality condition.

-- ================================================================
-- 9. USING: shorthand for equality on same-named columns
-- ================================================================
SELECT department_id, e.employee_name, d.department_name
FROM join_demo_employees AS e
JOIN join_demo_departments AS d USING (department_id)
ORDER BY e.employee_id;
-- 10 | Maya | Engineering
-- 10 | Leo  | Engineering
-- 20 | Ava  | Sales
-- USING merges the two join-key columns into one output column.
-- With ON, SELECT * would include both department_id columns.
-- USING is also available with LEFT, RIGHT, and FULL joins.

-- ================================================================
-- 10. NATURAL JOIN: automatically use all same-named columns
-- ================================================================
SELECT department_id, employee_name, department_name
FROM join_demo_employees
NATURAL INNER JOIN join_demo_departments
ORDER BY employee_id;
-- Same three rows as the USING example: department_id is the only
-- column name shared by these two tables.
-- NATURAL can also be used with LEFT, RIGHT, and FULL joins.
-- Prefer explicit ON or USING in class projects: adding another
-- same-named column would silently change a NATURAL JOIN's condition.
-- If there are no shared column names, NATURAL JOIN acts as CROSS JOIN.

-- ================================================================
-- 11. NULL AND EQUALITY: NULL does not equal NULL
-- ================================================================
SELECT NULL = NULL AS null_equals_null,
       NULL <> NULL AS null_not_equals_null,
       NULL IS NULL AS null_test,
       NULL IS NOT DISTINCT FROM NULL AS null_safe_equality;
-- NULL | NULL | true | true
-- A comparison involving NULL normally yields UNKNOWN (SQL NULL).
-- ON and WHERE accept only TRUE; FALSE and UNKNOWN do not qualify.

-- This query returns NO ROWS. It does not find missing departments.
SELECT employee_name
FROM join_demo_employees
WHERE department_id = NULL;

-- Correct missing-value test:
SELECT employee_name
FROM join_demo_employees
WHERE department_id IS NULL;
-- Noah

-- With regular equality, Noah does not even match himself here:
SELECT a.employee_name, b.employee_name
FROM join_demo_employees AS a
JOIN join_demo_employees AS b
    ON a.department_id = b.department_id
WHERE a.employee_id = 4
ORDER BY b.employee_id;
-- No rows: NULL = NULL is UNKNOWN.

-- PostgreSQL provides a NULL-safe comparison when that is intended:
SELECT a.employee_name, b.employee_name
FROM join_demo_employees AS a
JOIN join_demo_employees AS b
    ON a.department_id IS NOT DISTINCT FROM b.department_id
WHERE a.employee_id = 4
ORDER BY b.employee_id;
-- Noah | Noah
-- Here, two missing department IDs count as equal. Only use this rule
-- if it fits your meaning: two unknown values are not necessarily
-- the same real-world department. This example uses an INNER JOIN.

-- ================================================================
-- 12. ON VS. WHERE: filtering can change an outer join
-- ================================================================
SELECT e.employee_name, d.department_name
FROM join_demo_employees AS e
LEFT JOIN join_demo_departments AS d
    ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering'
ORDER BY e.employee_id;
-- Maya | Engineering
-- Leo  | Engineering
-- WHERE is applied to the joined result. Noah's NULL department name
-- fails the comparison, and Ava's Sales department also fails it.

SELECT e.employee_name, d.department_name
FROM join_demo_employees AS e
LEFT JOIN join_demo_departments AS d
    ON e.department_id = d.department_id
   AND d.department_name = 'Engineering'
ORDER BY e.employee_id;
-- Maya | Engineering
-- Leo  | Engineering
-- Ava  | NULL
-- Noah | NULL
-- ON limits which department rows match. LEFT JOIN still keeps every
-- employee. Ava has a department, but none matching this ON condition.
-- This shows why an output NULL does not always mean missing source data.

-- ================================================================
-- 13. FIND UNMATCHED ROWS: LEFT JOIN ... IS NULL (anti-join pattern)
-- ================================================================
SELECT d.department_name
FROM join_demo_departments AS d
LEFT JOIN join_demo_employees AS e
    ON e.department_id = d.department_id
WHERE e.employee_id IS NULL
ORDER BY d.department_id;
-- History
-- Test a non-nullable column from the optional side, such as its PK.
-- Testing e.bonus IS NULL would also find real employees with unknown
-- bonuses, so it would NOT be a reliable unmatched-row test.

-- ================================================================
-- 14. EXISTS: find rows with matches without duplicating them
-- ================================================================
SELECT d.department_name
FROM join_demo_departments AS d
WHERE EXISTS (
    SELECT 1
    FROM join_demo_employees AS e
    WHERE e.department_id = d.department_id
)
ORDER BY d.department_id;
-- Engineering
-- Sales
-- This is a semi-join pattern, written with EXISTS in PostgreSQL.
-- Engineering appears once even though two employees match.

SELECT d.department_name
FROM join_demo_departments AS d
WHERE NOT EXISTS (
    SELECT 1
    FROM join_demo_employees AS e
    WHERE e.department_id = d.department_id
)
ORDER BY d.department_id;
-- History (another anti-join pattern)

-- NULL trap: the subquery contains Noah's NULL department_id.
SELECT d.department_name
FROM join_demo_departments AS d
WHERE d.department_id NOT IN (
    SELECT e.department_id FROM join_demo_employees AS e
);
-- NO ROWS. For History, 30 NOT IN (10, 10, 20, NULL) is UNKNOWN.
-- Use NOT EXISTS above, or exclude NULL from the NOT IN subquery.

-- ================================================================
-- 15. COUNT AND NULL AFTER AN OUTER JOIN
-- ================================================================
SELECT d.department_name,
       COUNT(*) AS joined_rows,
       COUNT(e.employee_id) AS employee_count,
       COUNT(e.bonus) AS known_bonus_count
FROM join_demo_departments AS d
LEFT JOIN join_demo_employees AS e
    ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;
-- Engineering | 2 | 2 | 1
-- Sales       | 1 | 1 | 1
-- History     | 1 | 0 | 0
-- COUNT(*) counts rows, including the NULL-extended History row.
-- COUNT(column) counts only non-NULL values in that column.
-- Ava's zero bonus is a known value, so COUNT(e.bonus) includes it.

-- ================================================================
-- 16. COALESCE: choose a display value for NULL
-- ================================================================
SELECT e.employee_name,
       COALESCE(d.department_name, 'Unassigned') AS department_label,
       e.bonus,
       COALESCE(e.bonus, 0) AS bonus_if_missing_treated_as_zero
FROM join_demo_employees AS e
LEFT JOIN join_demo_departments AS d
    ON e.department_id = d.department_id
ORDER BY e.employee_id;
-- Maya | Engineering | 500.00 | 500.00
-- Leo  | Engineering | NULL   | 0.00
-- Ava  | Sales       | 0.00   | 0.00
-- Noah | Unassigned  | NULL   | 0.00
-- COALESCE returns the first non-NULL argument; it does not update data.
-- Turning unknown bonuses into zero is an assumption, so label it clearly.

-- ================================================================
-- 17. LATERAL (a FROM/JOIN feature, not a join type)
-- ================================================================
-- For each department, find the employee with the lowest employee_id.
SELECT d.department_name, first_employee.employee_name
FROM join_demo_departments AS d
LEFT JOIN LATERAL (
    SELECT e.employee_name
    FROM join_demo_employees AS e
    WHERE e.department_id = d.department_id
    ORDER BY e.employee_id
    LIMIT 1
) AS first_employee ON TRUE
ORDER BY d.department_id;
-- Engineering | Maya
-- Sales       | Ava
-- History     | NULL
-- LATERAL lets the subquery reference d from the preceding FROM item.
-- LEFT JOIN keeps a department when the subquery produces no rows.

/*
AI Disclosure:
Most of the content of this example was generated using Codex
AI makes mistakes

OpenAI. (2026, November 2). PostgreSQL joins demo [AI-generated SQL script]. ChatGPT.
GPT-6.1 Sol

I used ChatGPT to generate example PostgreSQL tables, sample data, and join queries with explanations of NULL behavior.
This was then edited by a human to remove older style syntax and unnecessary syntax.
I encourage you to try this technique on your own as a study tool.
When using your own LLM account you can make this more interactive

Prompt "make a code example to show different joins in postgresql, make creates, inserts, and queries to demonstrate, show all types of joins, show how null works into it"
*/
