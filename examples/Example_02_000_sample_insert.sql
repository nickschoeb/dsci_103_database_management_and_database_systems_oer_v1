-- example 1
INSERT INTO people
(employee_id, first_name, last_name, email, date_of_birth, year_hired, is_active)
VALUES
	('EMP00716','Nicole','Valdez','alicia75@example.com','1990-03-09',2015,False);

-- example 2
INSERT INTO people
(employee_id, first_name, last_name, email, date_of_birth, year_hired, is_active)
VALUES
	('EMP00716','Nicole','Valdez','alicia75@example.com','1990-03-09',2015,False),
	('EMP00414','Gabriel','Townsend','xbrooks@example.org','1980-03-23',2008,True),
	('EMP00727','Deanna','Butler','meganphillips@example.org','1994-03-09',2016,True),
	('EMP00688','Diamond','Walters','alexander60@example.org','1996-11-20',2016,True);

-- Run with caution!!!
-- DELETE FROM people
