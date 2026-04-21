                    --- FINAL SQL PROJECT : Retail Sales Analysis System

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50)
);
INSERT INTO products VALUES
(1, 'Dell Laptop i7', 'Electronics'),
(2, 'Samsung Galaxy S21', 'Electronics'),
(3, 'Nike Running Shoes', 'Fashion'),
(4, 'Casio Wrist Watch', 'Accessories'),
(5, 'HP Laptop i5', 'Electronics');
Select * From products;

      --- Second_table :

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    customer VARCHAR(50),
    city VARCHAR(50),
    amount INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO sales VALUES
(1, 1, 'Ali Khan', 'Lahore', 95000),
(2, 2, 'Ahmed Raza', 'Karachi', 48000),
(3, 3, 'Sara Ahmed', 'Islamabad', 12000),
(4, 1, 'Ali Khan', 'Lahore', 105000),
(5, 3, 'Usman Tariq', 'Faisalabad', 15000),
(6, 4, 'Fatima Noor', 'Karachi', 22000),
(7, 2, 'Ali Khan', 'Lahore', 52000),
(8, 4, 'Ahmed Raza', 'Karachi', 30000),
(9, 1, 'Bilal Hussain', 'Islamabad', 98000),
(10, 2, 'Sara Ahmed', 'Islamabad', 45000),
(11, 3, 'Fatima Noor', 'Karachi', NULL), -- NULL case
(12, 4, 'Usman Tariq', 'Faisalabad', 27000);
Select * from sales;

-- Q1.Maximum sale(highest_amount)
SELECT MAX(amount) AS max_sale
FROM sales;

-- Q2.Max sale per customer
SELECT customer, MAX(amount) AS max_sale
FROM sales
GROUP BY customer;


-- Q3.Total sales per city
SELECT city, SUM(amount) AS total_sales
FROM sales
GROUP BY city;

-- Q4.Customers with total spending > 100000
SELECT customer, SUM(amount) AS total
FROM sales
GROUP BY customer
HAVING SUM(amount) > 100000;

-- Q5. Top 3 customers by spending
SELECT customer, SUM(amount) AS total
FROM sales
GROUP BY customer
ORDER BY total DESC
LIMIT 3;

-- Q6. City with lowest sales
SELECT city, SUM(amount) AS total
FROM sales
GROUP BY city
ORDER BY total ASC
LIMIT 1;

-- Q7.Sales with product details
SELECT 
    s.sale_id,
    p.product_name,
    s.amount
FROM sales s
INNER JOIN products p
ON s.product_id = p.product_id;

          
 -- Q8.All products including those with no sales(Join)
 SELECT p.product_name, SUM(s.amount) AS total_sales
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name;

-- Q9.All unique cities
SELECT DISTINCT city FROM sales;

-- Q10.Number of orders per customer
SELECT customer, COUNT(*) AS total_orders
FROM sales
GROUP BY customer;

-- Q11.Total number of sales
SELECT COUNT(*) AS total_orders
FROM sales;

-- Q12.Customers based on sales amount
SELECT customer, amount,
       RANK() OVER (ORDER BY amount DESC) AS rank_position
FROM sales;

-- Q13.Number each sale per customer
SELECT customer, amount,
       ROW_NUMBER() OVER (PARTITION BY customer ORDER BY amount DESC) AS rn
FROM sales;

-- Q14.Sales only from Lahore
SELECT *
FROM sales
WHERE city = 'Lahore';

-- Q15.Sales from Lahore AND amount > 95000
SELECT *
FROM sales
WHERE city = 'Lahore'
AND amount > 95000;

-- Q16.Sales from Lahore OR Karachi
SELECT *
FROM sales
WHERE city = 'Lahore'
OR city = 'Karachi';

-- Q17.sales that are greater than the average sale amount
SELECT *
FROM sales
WHERE amount > (
    SELECT AVG(amount)
    FROM sales
);


-- Q18.Sales as High or low
SELECT customer, amount,
       CASE 
           WHEN amount > 50000 THEN 'High Sale'
           ELSE 'Low Sale'
       END AS sale_type
FROM sales;

-- Q19.Multiple conditions 
SELECT customer, amount,
       CASE 
           WHEN amount > 80000 THEN 'High'
           WHEN amount BETWEEN 30000 AND 80000 THEN 'Medium'
           ELSE 'Low'
       END AS category
FROM sales;


 
