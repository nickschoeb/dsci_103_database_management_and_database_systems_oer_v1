/*
Many to Many Pattern Example # 2
To assist with A04
Also as we move into design see how this might need more tables
*/

/**/
-- above is for multiline comments, write in between the *s as we get larger schemas

/*
==================
= Subject Matter =
==================

E-Commerce Company
* Products show all products the company sells
* Orders contain information about an order
* OrderItems related items for each order including quantity

Notes:
* This does not relate full customer information as we would need more tables
* This design could also include a lot of other columns/data points
* OrderItems is a junction or bridging table
* This is the strength of this pattern
*/

-- clear out the db
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;
-- this helps us rerun the script easier

/*
============
= PRODUCTS =
============
*/

DROP TABLE IF EXISTS products;

CREATE TABLE products(
  product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  sku VARCHAR(50) UNIQUE NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  msrp NUMERIC(12, 4) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products (sku, product_name, description, msrp) 
VALUES
    ('TECH-SSD-4TB', '4TB NVMe SSD', 'PCIe Gen4 x4 M.2 2280 internal solid state drive', 499.0000),
    ('TECH-KB-001', 'Mechanical Keyboard', 'Tenkeyless with tactile switches and RGB lighting', 129.9900),
    ('HOME-MUG-001', 'Ceramic Coffee Mug', '16oz matte black ceramic mug, microwave safe', 14.2500),
    ('APP-TSHIRT-L', 'Cotton Graphic T-Shirt', 'Large, 100% organic cotton, pre-shrunk', 24.0000),
    ('OFF-CHAIR-01', 'Ergonomic Office Chair', 'Mesh back with adjustable lumbar support', 195.9900),
    ('TECH-CBL-USB', 'USB-C to USB-C Cable', '2-meter braided cable, 100W power delivery', 18.9900);

-- TEST
-- SELECT * from products;

/*
==========
= ORDERS =
==========
*/

DROP TABLE IF EXISTS orders;

CREATE TABLE orders(
	order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_number VARCHAR(255) NOT NULL,
		-- This is where we could link a customer table
		-- for this example we will just put a number here as a placeholder
	status VARCHAR(50) DEFAULT 'pending',
		-- Once again we could have a look up table here for status
		-- note the default value here
	order_date DATE NOT NULL DEFAULT CURRENT_DATE,
	order_notes TEXT,
		-- design for the margins, allow a lot of text here
		-- this probably should be another related table with multiple entries and a datetime stamp
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO orders (customer_number, status, order_date, order_notes) 
VALUES
    ('CUST-10042', 'pending', CURRENT_DATE, 'Please leave package at the back door near the garage.'),
    ('CUST-08991', 'shipped', '2026-10-20', 'Expedited 2-day shipping requested by customer.'),
    ('CUST-11204', 'cancelled', '2026-10-22', NULL),
    ('CUST-09455', 'processing', '2026-10-24', 'Customer called support to verify billing address.');

-- TEST
-- SELECT * from orders;

/*
===============
= ORDER_ITEMS =
===============
*/

DROP TABLE IF EXISTS order_items;

CREATE TABLE order_items(
  order_item_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
  product_id INTEGER REFERENCES products(product_id) ON DELETE CASCADE,
  quantity INTEGER NOT NULL CHECK (quantity > 0),
  sort_order INTEGER NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- remember we are not doing this in our scripts although this does work
-- Order 1 buys one 4TB SSD and two USB-C cables
INSERT INTO order_items (order_id, product_id, quantity, sort_order) 
VALUES
	(1, 1, 1, 1),
	(1, 2, 2, 2);

-- do this instead
-- subqueries emulate what the rest of the application process will run when adding data
-- these resolve to the same number but is not dependent on hard coded numbers
-- this allows our test data here to be more dynamic and editable
INSERT INTO order_items (order_id, product_id, quantity, sort_order) 
VALUES
	((SELECT order_id FROM orders WHERE customer_number = 'CUST-08991' AND order_date = '2026-10-20'),
	(SELECT product_id FROM products WHERE sku = 'TECH-KB-001'),
	1, 1);
	-- Order 2 buys one mechanical keyboard

-- some more data
INSERT INTO order_items (order_id, product_id, quantity, sort_order) 
VALUES
	((SELECT order_id FROM orders WHERE customer_number = 'CUST-11204' AND order_date = '2026-10-22'),
	(SELECT product_id FROM products WHERE sku = 'TECH-KB-001'),
	4, 1),
	-- Order 3 buys four ceramic mugs

	((SELECT order_id FROM orders WHERE customer_number = 'CUST-09455' AND order_date = '2026-10-24'),
	(SELECT product_id FROM products WHERE sku = 'OFF-CHAIR-01'),
	1, 1);
	-- Order 4 buys an office chair

-- TEST
-- SELECT * from order_items;

/*
===========
= QUERIES =
===========

-- TESTING
SELECT * from products;
SELECT * from orders;
SELECT * from order_items;

-- All orders with items
SELECT *
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;

-- A specific order sorted
SELECT *
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.order_id = 1
ORDER BY oi.sort_order;

-- Add more data of your own and experiment with the queries
*/

/*
=======
= ERD =
=======
this is a rough ascii erd

 +---------------------+               +-----------------------+               +----------------------+
 |       orders        |               |      order_items      |               |       products       |
 +---------------------+               +-----------------------+               +----------------------+
 | PK | order_id       | 1           M | PK | order_item_id    |          /--1 | PK | product_id      |
 |    | customer_number|--------------<| FK | order_id         |M        /     |    | sku (UNIQUE)    |
 |    | status         |               | FK | product_id       |>-------/      |    | product_name    |
 |    | order_date     |               |    | quantity         |               |    | description     |
 |    | order_notes    |               |    | sort_order       |               |    | msrp            |
 |    | created_at     |               |    | created_at       |               |    | created_at      |
 +---------------------+               +-----------------------+               +----------------------+

*/

-- END EXAMPLE
