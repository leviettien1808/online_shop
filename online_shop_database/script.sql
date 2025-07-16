-- Task 1: Create a new database for the shop
CREATE DATABASE online_shop;

-- Task 2: Add a table for products
-- Task 3: Choose appropriate column names + data types
-- MySQL/Postgres
CREATE TABLE products (
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    amount_in_stock INT NOT NULL,
    image VARCHAR(255)
);

-- SQLite
CREATE TABLE products (
    product_name TEXT NOT NULL,
    price REAL NOT NULL,
    description TEXT,
    amount_in_stock INTEGER NOT NULL,
    image TEXT
);

-- Task 4: Insert dummy data into created table
INSERT INTO products (product_name, price, description, amount_in_stock, image) VALUES
('Laptop', 999.99, 'High performance laptop with 16GB RAM and 512GB SSD.', 50, 'laptop.jpg'),
('Smartphone', 499.99, 'Latest model smartphone with excellent camera quality.', 100, 'smartphone.jpg'),
('Headphones', 199.99, 'Noise-cancelling over-ear headphones.', 75, 'headphones.jpg'),
('Smartwatch', 299.99, 'Feature-rich smartwatch with health tracking.', 60, 'smartwatch.jpg'),
('Tablet', 399.99, 'Portable tablet with a vibrant display and long battery life.', 80, 'tablet.jpg');

-- Task 5: Update table and add sensible constraints
-- MySQL/Postgres
ALTER TABLE products
ADD CONSTRAINT chk_price CHECK (price > 0),
ADD CONSTRAINT chk_amount_in_stock CHECK (amount_in_stock >= 0);

-- SQLite
ALTER TABLE products RENAME TO products_old;

CREATE TABLE products (
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    description TEXT,
    amount_in_stock INT NOT NULL CHECK (amount_in_stock >= 0),
    image VARCHAR(255)
);

INSERT INTO products (product_name, price, description, amount_in_stock, image)
SELECT product_name, price, description, amount_in_stock, image FROM products_old;

DROP TABLE products_old;

-- Task 6: Update table and add a primary key
DROP TABLE products;
-- MySQL
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    description TEXT,
    amount_in_stock INT NOT NULL CHECK (amount_in_stock >= 0),
    image VARCHAR(255)
);
-- PostgreSQL
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    description TEXT,
    amount_in_stock INT NOT NULL CHECK (amount_in_stock >= 0),
    image VARCHAR(255)
);
-- SQLite
CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    description TEXT,
    amount_in_stock INT NOT NULL CHECK (amount_in_stock >= 0),
    image VARCHAR(255)
);



-- MySQL/Postgres/SQLite
ALTER TABLE products
RENAME COLUMN product_name TO name;

-- MySQL
ALTER TABLE products
MODIFY COLUMN name VARCHAR(200) NOT NULL,
MODIFY COLUMN price NUMERIC(10, 2) NOT NULL CHECK (price > 0),
MODIFY COLUMN description TEXT NOT NULL,
MODIFY COLUMN amount_in_stock SMALLINT CHECK (amount_in_stock >= 0);

-- Postgres
ALTER TABLE products
ALTER COLUMN name SET NOT NULL,
ALTER COLUMN price SET DATA TYPE NUMERIC(10, 2),
ALTER COLUMN price SET NOT NULL,
ADD CONSTRAINT price_positive CHECK (price > 0),
ALTER COLUMN description SET NOT NULL,
ALTER COLUMN amount_in_stock SET DATA TYPE SMALLINT,
ADD CONSTRAINT amount_in_stock_non_positive CHECK (amount_in_stock >= 0);

-- MySQL/Postgres
ALTER TABLE products
RENAME COLUMN image TO image_path;

-- MySQL
ALTER TABLE products
MODIFY COLUMN image_path VARCHAR(500);

-- Postgres
ALTER TABLE products
ALTER COLUMN image_path SET DATA TYPE VARCHAR(500);

-- SQLite
ALTER TABLE products
RENAME COLUMN image TO image_path;

-- SQLite
ALTER TABLE products RENAME TO products_old;
CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    description TEXT NOT NULL,
    amount_in_stock INTEGER CHECK (amount_in_stock >= 0),
    image_path TEXT
);
INSERT INTO products (name, price, description, amount_in_stock, image_path)
SELECT name, price, description, amount_in_stock, image_path
FROM products_old;
DROP TABLE products_old;