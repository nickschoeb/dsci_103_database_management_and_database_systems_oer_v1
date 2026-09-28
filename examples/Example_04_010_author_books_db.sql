-- authors books database
-- one to many

create table authors(
	author_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL
);

INSERT INTO authors
(first_name, last_name)
VALUES
('Joe', 'Nobody'),
('Jane', 'Plain'),
('George', 'Orwell'),
('Jane', 'Austen');

--  select * from authors;

create table books(
	book_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	title varchar(255) NOT NULL,
	author_id INT REFERENCES authors(author_id) ON DELETE CASCADE
);

INSERT INTO books
(title, author_id)
VALUES
('1984', (select author_id from authors where first_name = 'George' and last_name = 'Orwell')),
('Animal Farm', (select author_id from authors where first_name = 'George' and last_name = 'Orwell')),
('Pride and Prejudice', (select author_id from authors where first_name = 'Jane' and last_name = 'Austen'));

-- select * from books;

/*
select *
from books
inner join authors ON authors.author_id = books.author_id;
*/

