-- people excel demo
CREATE TABLE people(
	person_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	last_name VARCHAR(255) NOT NULL,
	first_name VARCHAR(255) NOT NULL,
	age INTEGER NOT NULL
);

-- data style 1
INSERT INTO people
(last_name, first_name, age)
VALUES
('Ackley', 'Larry', 23);

INSERT INTO people
(last_name, first_name, age)
VALUES
('Carpenter', 'Sam', 34);

INSERT INTO people
(last_name, first_name, age)
VALUES
('Bahe', 'Paul', 45);

-- data style 2
INSERT INTO people
(last_name, first_name, age)
VALUES
('Ackley', 'Larry', 23),
('Carpenter', 'Sam', 34),
('Bahe', 'Paul', 45);

-- test query
SELECT * FROM people;
