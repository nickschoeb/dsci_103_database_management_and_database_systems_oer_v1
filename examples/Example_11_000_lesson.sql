-- POSTGRESQL JOINS LESSON

CREATE TABLE departments (
    dept_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    emp_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INT, -- Can be null for employees not assigned to a department
    CONSTRAINT fk_department FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE projects (
    project_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    emp_id INT, -- Can be null for projects without a lead employee
    CONSTRAINT fk_employee FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO departments (dept_name) VALUES 
('Human Resources'),
('Information Technology'),
('Sales'),
('Marketing'); -- Note: We will deliberately not assign anyone to Marketing

INSERT INTO employees (emp_name, dept_id) VALUES 
('Alice', 1),   -- Alice is in HR
('Bob', 2),     -- Bob is in IT
('Charlie', 2), -- Charlie is in IT
('Diana', 3),   -- Diana is in Sales
('Eve', NULL);  -- Eve is NOT assigned to any department yet

INSERT INTO projects (project_name, emp_id) VALUES 
('Project Alpha', 1), -- Led by Alice
('Project Beta', 2),  -- Led by Bob
('Project Gamma', NULL), -- No lead assigned yet
('Project Delta', 3); -- Led by Charlie

-- INNER JOIN
-- Returns records that have matching values in both tables.
SELECT 
    e.emp_name, 
    d.dept_name
FROM 
    employees e
INNER JOIN 
    departments d ON e.dept_id = d.dept_id;

-- LEFT JOIN (or LEFT OUTER JOIN)
-- Returns all records from the left table, and the matched 
-- records from the right table. The result is NULL from the 
-- right side if there is no match.
SELECT 
    e.emp_name, 
    d.dept_name
FROM 
    employees e
LEFT JOIN 
    departments d ON e.dept_id = d.dept_id;

-- RIGHT JOIN (or RIGHT OUTER JOIN)
-- Returns all records from the right table, and the matched 
-- records from the left table. The result is NULL from the 
-- left side when there is no match.
SELECT 
    e.emp_name, 
    d.dept_name
FROM 
    employees e
RIGHT JOIN 
    departments d ON e.dept_id = d.dept_id;

-- FULL OUTER JOIN
-- Returns all records when there is a match in either left 
-- or right table. Missing matches are filled with NULLs.
SELECT 
    e.emp_name, 
    d.dept_name
FROM 
    employees e
FULL OUTER JOIN 
    departments d ON e.dept_id = d.dept_id;

-- CROSS JOIN
-- Returns the Cartesian product of the two tables (every 
-- row from the first table combined with every row from the second).
SELECT 
    e.emp_name, 
    d.dept_name
FROM 
    employees e
CROSS JOIN 
    departments d;

-- MULTIPLE JOINS
-- You can chain joins together to link multiple tables.
SELECT 
    p.project_name, 
    e.emp_name, 
    d.dept_name
FROM 
    projects p
LEFT JOIN 
    employees e ON p.emp_id = e.emp_id
LEFT JOIN 
    departments d ON e.dept_id = d.dept_id;
