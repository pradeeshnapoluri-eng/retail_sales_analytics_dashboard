USE retail_db;

CREATE VIEW vw_monthly_sales AS
SELECT 
    MONTH(order_date) AS month,
    YEAR(order_date) AS year,
    COUNT(*) AS total_orders,
    SUM(p.amount) AS total_revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY MONTH(order_date), YEAR(order_date);

CREATE VIEW vw_customer_lifetime_value AS
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(p.amount) AS lifetime_value,
    COUNT(o.order_id) AS total_orders,
    AVG(p.amount) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id;

CREATE VIEW vw_top_products AS
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.price) AS total_revenue,
    AVG(r.rating) AS avg_rating
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN product_reviews r ON p.product_id = r.product_id
GROUP BY p.product_id
ORDER BY total_revenue DESC;

CREATE VIEW vw_inventory_status AS
SELECT 
    p.product_id,
    p.product_name,
    i.stock_quantity,
    w.warehouse_name,
    CASE 
        WHEN i.stock_quantity = 0 THEN 'Out of Stock'
        WHEN i.stock_quantity < 20 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS stock_status
FROM products p
JOIN inventory i ON p.product_id = i.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id;

CREATE VIEW vw_profit_analysis AS
SELECT 
    p.product_id,
    p.product_name,
    p.cost_price,
    p.selling_price,
    (p.selling_price - p.cost_price) AS profit_per_unit,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.quantity * (p.selling_price - p.cost_price)) AS total_profit
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id;

DELIMITER //

CREATE PROCEDURE sp_generate_monthly_sales(IN sales_year INT)
BEGIN
    SELECT 
        MONTH(order_date) AS month,
        COUNT(*) AS total_orders,
        SUM(p.amount) AS total_revenue,
        AVG(p.amount) AS avg_order_value
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    WHERE YEAR(order_date) = sales_year
    GROUP BY MONTH(order_date)
    ORDER BY MONTH(order_date);
END //

CREATE PROCEDURE sp_customer_segmentation()
BEGIN
    SELECT 
        c.customer_id,
        c.customer_name,
        SUM(p.amount) AS total_spent,
        CASE 
            WHEN SUM(p.amount) > 100000 THEN 'Platinum'
            WHEN SUM(p.amount) BETWEEN 50000 AND 100000 THEN 'Gold'
            WHEN SUM(p.amount) BETWEEN 20000 AND 50000 THEN 'Silver'
            ELSE 'Bronze'
        END AS segment
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY c.customer_id;
END //

CREATE PROCEDURE sp_inventory_alerts()
BEGIN
    SELECT 
        p.product_id,
        p.product_name,
        i.stock_quantity,
        w.warehouse_name
    FROM products p
    JOIN inventory i ON p.product_id = i.product_id
    JOIN warehouses w ON i.warehouse_id = w.warehouse_id
    WHERE i.stock_quantity < 20
    ORDER BY i.stock_quantity ASC;
END //

CREATE PROCEDURE sp_profit_report()
BEGIN
    SELECT 
        p.product_id,
        p.product_name,
        p.cost_price,
        p.selling_price,
        (p.selling_price - p.cost_price) AS profit_per_unit,
        SUM(oi.quantity) AS total_sold,
        SUM(oi.quantity * (p.selling_price - p.cost_price)) AS total_profit,
        ((p.selling_price - p.cost_price) / p.cost_price * 100) AS profit_margin_percent
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id
    ORDER BY total_profit DESC;
END //

CREATE PROCEDURE sp_forecast_generation(IN forecast_year INT)
BEGIN
    SELECT 
        MONTH(order_date) AS month,
        SUM(p.amount) AS actual_sales,
        AVG(SUM(p.amount)) OVER (ORDER BY MONTH(order_date)) AS moving_avg
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    WHERE YEAR(order_date) = forecast_year
    GROUP BY MONTH(order_date)
    ORDER BY MONTH(order_date);
END //

CREATE TRIGGER trg_inventory_auto_update
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE inventory 
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
    
    INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date)
    VALUES (NEW.product_id, 'OUT', NEW.quantity, NOW());
END //

CREATE TRIGGER trg_return_processing
AFTER INSERT ON returns
FOR EACH ROW
BEGIN
    UPDATE inventory 
    SET stock_quantity = stock_quantity + NEW.quantity
    WHERE product_id = NEW.product_id;
    
    INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date)
    VALUES (NEW.product_id, 'IN', NEW.quantity, NOW());
END //

CREATE TRIGGER trg_purchase_update
AFTER INSERT ON purchase_items
FOR EACH ROW
BEGIN
    UPDATE inventory 
    SET stock_quantity = stock_quantity + NEW.quantity
    WHERE product_id = NEW.product_id;
    
    INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date)
    VALUES (NEW.product_id, 'IN', NEW.quantity, NOW());
END //

CREATE TRIGGER trg_audit_log
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs (table_name, action_type, action_date)
    VALUES ('orders', 'INSERT', NOW());
END //

DELIMITER ;

SELECT 
    customer_id,
    customer_name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS spending_rank
FROM vw_customer_lifetime_value;

SELECT 
    product_id,
    product_name,
    total_revenue,
    ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM vw_top_products;

SELECT 
    product_id,
    product_name,
    total_sold,
    DENSE_RANK() OVER (ORDER BY total_sold DESC) AS sales_rank
FROM vw_top_products;

SELECT 
    customer_id,
    customer_name,
    lifetime_value,
    NTILE(4) OVER (ORDER BY lifetime_value DESC) AS quartile
FROM vw_customer_lifetime_value;

SELECT 
    customer_id,
    customer_name,
    lifetime_value,
    LAG(lifetime_value) OVER (ORDER BY lifetime_value) AS prev_customer_value
FROM vw_customer_lifetime_value;

SELECT 
    customer_id,
    customer_name,
    lifetime_value,
    LEAD(lifetime_value) OVER (ORDER BY lifetime_value) AS next_customer_value
FROM vw_customer_lifetime_value;

SELECT 
    month,
    year,
    total_revenue,
    SUM(total_revenue) OVER (ORDER BY year, month) AS running_total
FROM vw_monthly_sales;

SELECT 
    month,
    year,
    total_revenue,
    AVG(total_revenue) OVER (ORDER BY year, month ROWS 2 PRECEDING) AS moving_avg
FROM vw_monthly_sales;