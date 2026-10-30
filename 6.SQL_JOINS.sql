CREATE TABLE customers1 (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(50),
    country       VARCHAR(50)
);
INSERT INTO customers1 VALUES
(1, 'Alice Smith', 'USA'),
(2, 'Bob Jones', 'Canada'),
(3, 'Charlie Brown', 'UK'),   -- has never placed an order
(4, 'Diana Prince', 'USA');   -- has never placed an order


CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(50),
    price        DECIMAL(10,2)
);
INSERT INTO products VALUES
(101, 'Laptop', 1200.00),
(102, 'Smartphone', 800.00),
(103, 'Wireless Headphones', 150.00),
(104, 'Tablet', 400.00);      -- has never been ordered

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,
    customer_id INT,          -- NULL for guest checkouts
    product_id  INT,
    order_date  DATE
);

INSERT INTO orders VALUES
(5001, 1, 101, '2026-06-01'),     -- Alice bought Laptop
(5002, 2, 102, '2026-06-02'),     -- Bob bought Smartphone
(5003, 1, 103, '2026-06-03'),     -- Alice bought Headphones
(5004, NULL, 101, '2026-06-04');  -- guest checkout bought Laptop

1.They need the order_id, the customer_name, and the product_name.
SELECT * FROM customers1;
SELECT * FROM products;
SELECT * FROM orders;

SELECT o.order_id, 
       c.customer_name,
	   p.product_name
FROM customers1 c
INNER JOIN orders o
ON c.customer_id=o.customer_id
INNER JOIN products p
ON p.product_id=o.product_id;

2.Generate a list of all registered customers and their order_id (if any).
 SELECT c.customer_name,
        o.order_id
 FROM customers1 c
 LEFT JOIN orders o
 ON c.customer_id=o.customer_id;

 Look closely at Diana Prince and Charlie Brown in your results. 
 What value appears in their order_id column, and why?
 Both Diana Prince and Charlie Brown will have NULL in their order_id column 
 Because a LEFT JOIN displays NULL in the right tables colums,
 when there is no matching record for a row in the left table.

3.Write a query returning all products and their associated order_ids?
SELECT p.product_name,
       o.order_id
FROM products p
RIGHT JOIN orders o
ON p.product_id=o.product_id;

4.Show every record across customers and orders, regardless of whether they match.
 Your results should simultaneously show guest checkouts (orders with no customer)
 and inactive users (customers with no orders).
 
SELECT c.customer_id,
       c.customer_name,
	   o.order_id,
	   o.product_id
FROM customers1 c
FULL OUTER JOIN orders o
ON c.customer_id=o.customer_id
WHERE c.customer_id IS NULL
OR o.order_id IS NULL;

5.Write a CROSS JOIN to show all possible customer-to-product combinations?

SELECT c.customer_name,
       p.product_name
FROM customers1 c
CROSS JOIN products p;
	   
How many total rows did this query generate, and why?
Total rows = 4*4 
           = 16 (Rows in the customers1 Table * Rows in the products table)
