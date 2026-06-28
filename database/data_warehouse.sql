USE retail_db;

DROP TABLE IF EXISTS FACT_SALES;
DROP TABLE IF EXISTS DIM_DATE;
DROP TABLE IF EXISTS DIM_CUSTOMER;
DROP TABLE IF EXISTS DIM_PRODUCT;
DROP TABLE IF EXISTS DIM_LOCATION;
DROP TABLE IF EXISTS DIM_EMPLOYEE;
DROP TABLE IF EXISTS DIM_PAYMENT;

CREATE TABLE DIM_DATE (
    date_id INT AUTO_INCREMENT PRIMARY KEY,
    full_date DATE NOT NULL,
    day INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL,
    quarter INT NOT NULL,
    day_name VARCHAR(10) NOT NULL,
    month_name VARCHAR(10) NOT NULL,
    is_weekend BOOLEAN NOT NULL
);

CREATE TABLE DIM_CUSTOMER (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(200) NOT NULL,
    gender VARCHAR(10),
    age INT,
    city_name VARCHAR(100),
    state_name VARCHAR(100),
    country_name VARCHAR(100),
    registration_date DATE,
    segment_name VARCHAR(50)
);

CREATE TABLE DIM_PRODUCT (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(300) NOT NULL,
    category_name VARCHAR(100),
    sub_category_name VARCHAR(100),
    brand_name VARCHAR(100),
    supplier_name VARCHAR(200),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2)
);

CREATE TABLE DIM_LOCATION (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    state_name VARCHAR(100) NOT NULL,
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE DIM_EMPLOYEE (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(200) NOT NULL,
    designation VARCHAR(100)
);

CREATE TABLE DIM_PAYMENT (
    payment_id INT PRIMARY KEY,
    payment_method VARCHAR(20) NOT NULL,
    payment_date TIMESTAMP
);

CREATE TABLE FACT_SALES (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    date_id INT NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    location_id INT NOT NULL,
    employee_id INT,
    payment_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    cost_price DECIMAL(10,2) NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    revenue DECIMAL(10,2) NOT NULL,
    profit DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (date_id) REFERENCES DIM_DATE(date_id),
    FOREIGN KEY (customer_id) REFERENCES DIM_CUSTOMER(customer_id),
    FOREIGN KEY (product_id) REFERENCES DIM_PRODUCT(product_id),
    FOREIGN KEY (location_id) REFERENCES DIM_LOCATION(location_id),
    FOREIGN KEY (employee_id) REFERENCES DIM_EMPLOYEE(employee_id),
    FOREIGN KEY (payment_id) REFERENCES DIM_PAYMENT(payment_id)
);

INSERT INTO DIM_DATE (full_date, day, month, year, quarter, day_name, month_name, is_weekend)
SELECT DISTINCT
    DATE(order_date) AS full_date,
    DAY(order_date) AS day,
    MONTH(order_date) AS month,
    YEAR(order_date) AS year,
    QUARTER(order_date) AS quarter,
    DAYNAME(order_date) AS day_name,
    MONTHNAME(order_date) AS month_name,
    CASE WHEN DAYOFWEEK(order_date) IN (1, 7) THEN TRUE ELSE FALSE END AS is_weekend
FROM orders;

INSERT INTO DIM_CUSTOMER (customer_id, customer_name, gender, age, city_name, state_name, country_name, registration_date, segment_name)
SELECT 
    c.customer_id,
    c.customer_name,
    c.gender,
    TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) AS age,
    ct.city_name,
    st.state_name,
    co.country_name,
    c.registration_date,
    cs.segment_name
FROM customers c
LEFT JOIN cities ct ON c.city_id = ct.city_id
LEFT JOIN states st ON ct.state_id = st.state_id
LEFT JOIN countries co ON st.country_id = co.country_id
LEFT JOIN customer_segment_mapping csm ON c.customer_id = csm.customer_id
LEFT JOIN customer_segments cs ON csm.segment_id = cs.segment_id;

INSERT INTO DIM_PRODUCT (product_id, product_name, category_name, sub_category_name, brand_name, supplier_name, cost_price, selling_price)
SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    sc.sub_category_name,
    b.brand_name,
    s.supplier_name,
    p.cost_price,
    p.selling_price
FROM products p
LEFT JOIN categories c ON p.category_id = c.category_id
LEFT JOIN sub_categories sc ON p.sub_category_id = sc.sub_category_id
LEFT JOIN brands b ON p.brand_id = b.brand_id
LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id;

INSERT INTO DIM_LOCATION (city_name, state_name, country_name)
SELECT DISTINCT
    ct.city_name,
    st.state_name,
    co.country_name
FROM cities ct
JOIN states st ON ct.state_id = st.state_id
JOIN countries co ON st.country_id = co.country_id;

INSERT INTO DIM_EMPLOYEE (employee_id, employee_name, designation)
SELECT employee_id, employee_name, designation FROM employees;

INSERT INTO DIM_PAYMENT (payment_id, payment_method, payment_date)
SELECT payment_id, 'Cash', payment_date FROM payments;

INSERT INTO FACT_SALES (date_id, customer_id, product_id, location_id, employee_id, payment_id, quantity, unit_price, cost_price, selling_price, discount_amount, revenue, profit)
SELECT 
    d.date_id,
    o.customer_id,
    oi.product_id,
    l.location_id,
    o.employee_id,
    p.payment_id,
    oi.quantity,
    oi.price AS unit_price,
    pr.cost_price,
    pr.selling_price,
    0 AS discount_amount,
    (oi.quantity * oi.price) AS revenue,
    (oi.quantity * (oi.price - pr.cost_price)) AS profit
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN payments p ON o.order_id = p.order_id
JOIN DIM_DATE d ON DATE(o.order_date) = d.full_date
JOIN DIM_LOCATION l ON l.city_name = (SELECT ct.city_name FROM customers c JOIN cities ct ON c.city_id = ct.city_id WHERE c.customer_id = o.customer_id)
JOIN products pr ON oi.product_id = pr.product_id;