/*
Example 04_000
One to many
*/

-- Create the customer table
create table customers(
	Customer_ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,	-- ID for each record
  LastName varchar(255) not null,								-- Last name
	FirstName varchar(255) not null								-- First name
);

-- Customer Data
INSERT INTO customers (LastName, FirstName) VALUES ('Bergstrom', 'Deanna');
INSERT INTO customers (LastName, FirstName) VALUES ('Kemmer', 'Marcos');
INSERT INTO customers (LastName, FirstName) VALUES ('Yost', 'Jaycee');
INSERT INTO customers (LastName, FirstName) VALUES ('Larkin', 'Carlos');
INSERT INTO customers (LastName, FirstName) VALUES ('Strosin', 'Alvena');

-- Check work
-- SELECT * FROM customers;

-- Create the orders table
create table orders(
	Order_ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,	-- ID for each record
  Order_Dpn varchar(255) not null,
	Customer_ID INT REFERENCES customers(Customer_ID) ON DELETE CASCADE
);

-- Orders Data
INSERT INTO orders (Order_Dpn, Customer_ID) VALUES
('Bought books',
(select Customer_ID from customers WHERE LastName = 'Bergstrom' and FirstName = 'Deanna'));

INSERT INTO orders (Order_Dpn, Customer_ID) VALUES
('Bought more books',
(select Customer_ID from customers WHERE LastName = 'Bergstrom' and FirstName = 'Deanna'));

INSERT INTO orders (Order_Dpn, Customer_ID) VALUES
('First order',
(select Customer_ID from customers WHERE LastName = 'Kemmer' and FirstName = 'Marcos'));

INSERT INTO orders (Order_Dpn, Customer_ID) VALUES
('Second order',
(select Customer_ID from customers WHERE LastName = 'Kemmer' and FirstName = 'Marcos'));

INSERT INTO orders (Order_Dpn, Customer_ID) VALUES
('Only order',
(select Customer_ID from customers WHERE LastName = 'Strosin' and FirstName = 'Alvena'));

-- Check work
-- SELECT * FROM orders;
