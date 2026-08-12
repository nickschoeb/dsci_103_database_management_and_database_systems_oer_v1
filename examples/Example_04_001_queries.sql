-- Queries to Study

-- Get all customers
SELECT * FROM customers;

-- Get all orders
SELECT * FROM orders;

-- Get all order and customer information
SELECT *
FROM orders
INNER JOIN customers
ON orders.Customer_ID = customers.Customer_Id;

-- Add where
SELECT *
FROM orders
INNER JOIN customers
ON orders.Customer_ID = customers.Customer_Id
WHERE customers.Customer_Id = 1;

-- Only get text info and alias
SELECT
orders.Order_Dpn AS "Order Description",
customers.FirstName As "First Name",
customers.LastName AS "Last Name"
FROM orders
INNER JOIN customers
ON orders.Customer_ID = customers.Customer_Id
WHERE Customers.Customer_Id = 1;
