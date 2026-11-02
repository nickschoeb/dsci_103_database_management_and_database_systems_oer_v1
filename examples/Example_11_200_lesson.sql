-- "Database Surgery": ALTER TABLE

BEGIN;

-- 1. Create a practice table and insert sample data.
CREATE TABLE alter_demo_products (
    product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name TEXT NOT NULL,
    price NUMERIC(6,2)
);

INSERT INTO alter_demo_products (product_name, price)
VALUES ('Notebook', 3.00),
       ('Pen', 1.50),
       ('Backpack', 25.00);

SELECT * FROM alter_demo_products ORDER BY product_id;

-- 2. ADD COLUMN: add a place to store more information.
ALTER TABLE alter_demo_products
ADD COLUMN category TEXT;
-- Existing rows have NULL in category because no default was supplied.

SELECT * FROM alter_demo_products ORDER BY product_id;

-- UPDATE fills the new column; ALTER TABLE changes the structure.
UPDATE alter_demo_products
SET category = 'School supplies';

-- 3. Add a column with a default value.
ALTER TABLE alter_demo_products
ADD COLUMN in_stock BOOLEAN DEFAULT TRUE;
-- Existing products get TRUE. Future inserts that omit in_stock
-- also get TRUE. An explicitly supplied NULL would still be allowed.

SELECT * FROM alter_demo_products ORDER BY product_id;

-- 4. RENAME COLUMN: change its name without changing its data.
ALTER TABLE alter_demo_products
RENAME COLUMN product_name TO name;
-- Use name instead of product_name in later queries.

SELECT * FROM alter_demo_products ORDER BY product_id;

-- 5. Change a column's data type.
ALTER TABLE alter_demo_products
ALTER COLUMN price TYPE NUMERIC(8,2);
-- Increase the allowed total digits from 6 to 8; keep 2 decimal places.
-- Existing prices stay the same.
-- Be careful with this!

-- 6. Require a value with SET NOT NULL.
ALTER TABLE alter_demo_products
ALTER COLUMN price SET NOT NULL;
-- This succeeds because all existing prices are non-NULL.
-- It would fail if any existing price were NULL.

-- 7. Add a named CHECK constraint.
ALTER TABLE alter_demo_products
ADD CONSTRAINT alter_demo_nonnegative_price CHECK (price >= 0);
-- Future inserts and updates cannot store negative prices.
-- Existing rows must also satisfy the new constraint.

-- 8. Change a default.
ALTER TABLE alter_demo_products
ALTER COLUMN in_stock SET DEFAULT FALSE;
-- Existing rows stay TRUE. The new default applies to future writes.

INSERT INTO alter_demo_products (name, price, category)
VALUES ('Folder', 2.00, 'School supplies');
-- The new Folder row gets FALSE because in_stock was omitted.

SELECT * FROM alter_demo_products ORDER BY product_id;
-- 1 | Notebook | true
-- 2 | Pen      | true
-- 3 | Backpack | true
-- 4 | Folder   | false

-- 9. DROP COLUMN: remove a column and all its stored values.
ALTER TABLE alter_demo_products
DROP COLUMN category;
-- The products and their other columns remain.
-- Be careful with this!

-- 10. RENAME TABLE: change the table's name.
ALTER TABLE alter_demo_products
RENAME TO alter_demo_inventory;
-- Be careful with this!

SELECT * FROM alter_demo_inventory ORDER BY product_id;

-- Remember:
-- ALTER TABLE changes the table's structure or rules.
-- UPDATE changes values stored in rows.
-- DROP TABLE removes the entire table.

ROLLBACK;
-- Undo the whole demo, including its initial table creation.

/*
AI Disclosure:
Most of the content of this example was generated using Codex
AI makes mistakes

OpenAI. (2026, November 2). PostgreSQL alter demo [AI-generated SQL script]. ChatGPT.
GPT-6.1 Sol

Prompt "make a code example for alter table"
Note that this chat history has other context/memory to it so your results may vary
*/
