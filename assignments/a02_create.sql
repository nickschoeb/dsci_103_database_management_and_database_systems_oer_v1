/*
Example 03_000
Simple People Table
Same as 02 different data
*/

CREATE TABLE people (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_id VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    date_of_birth DATE,
    year_hired INTEGER NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
