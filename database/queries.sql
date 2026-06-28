USE retail_db;

SELECT COUNT(*) AS total_orders FROM orders;

SELECT SUM(amount) AS total_revenue FROM payments;

SELECT AVG(amount) AS avg_order_value FROM payments;

SELECT MAX(amount) AS highest_payment FROM payments;

SELECT MIN(amount) AS lowest_payment FROM payments;

SELECT MONTH(order_date) AS month, COUNT(*) AS order_count FROM orders GROUP BY MONTH(order_date);

SELECT YEAR(order_date) AS year, COUNT(*) AS order_count FROM orders GROUP BY YEAR(order_date);

SELECT payment_method, COUNT(*) AS count FROM orders GROUP BY payment_method;

SELECT c.customer_name, COUNT(o.order_id) AS total_orders FROM customers c JOIN orders o ON c.customer_id = o.customer_id GROUP BY c.customer_id;

SELECT c.customer_name, SUM(p.amount) AS total_spent FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN payments p ON o.order_id = p.order_id GROUP BY c.customer_id;

SELECT c.customer_name, AVG(p.amount) AS avg_spent FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN payments p ON o.order_id = p.order_id GROUP BY c.customer_id;

SELECT c.customer_name, MAX(p.amount) AS max_spent FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN payments p ON o.order_id = p.order_id GROUP BY c.customer_id;

SELECT c.customer_name, p.amount AS first_order_amount FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN payments p ON o.order_id = p.order_id WHERE o.order_date = (SELECT MIN(order_date) FROM orders WHERE customer_id = c.customer_id);

SELECT c.customer_name, DATEDIFF(CURDATE(), MAX(o.order_date)) AS days_since_last_order FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id GROUP BY c.customer_id;

SELECT c.customer_name, COUNT(o.order_id) AS order_count FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id GROUP BY c.customer_id HAVING order_count > 2;

SELECT c.customer_name, SUM(p.amount) AS total_revenue FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN payments p ON o.order_id = p.order_id GROUP BY c.customer_id ORDER BY total_revenue DESC LIMIT 5;

SELECT c.customer_name, SUM(p.amount) AS total_revenue FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN payments p ON o.order_id = p.order_id GROUP BY c.customer_id ORDER BY total_revenue ASC LIMIT 5;

SELECT c.customer_name, TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) AS age FROM customers c;

SELECT c.customer_name, ct.city_name, st.state_name FROM customers c JOIN cities ct ON c.city_id = ct.city_id JOIN states st ON ct.state_id = st.state_id;

SELECT gender, COUNT(*) AS count FROM customers GROUP BY gender;

SELECT city_id, COUNT(*) AS customer_count FROM customers GROUP BY city_id;

SELECT registration_date, COUNT(*) AS new_customers FROM customers GROUP BY registration_date;

SELECT c.customer_name, COUNT(r.review_id) AS total_reviews FROM customers c LEFT JOIN product_reviews r ON c.customer_id = r.customer_id GROUP BY c.customer_id;

SELECT p.product_name, COUNT(oi.item_id) AS times_ordered FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id;

SELECT p.product_name, SUM(oi.quantity) AS total_quantity_sold FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id;

SELECT p.product_name, SUM(oi.quantity * oi.price) AS total_revenue FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id;

SELECT p.product_name, AVG(oi.price) AS avg_selling_price FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id;

SELECT p.product_name, p.cost_price, p.selling_price, (p.selling_price - p.cost_price) AS profit_margin FROM products p;

SELECT p.product_name, COUNT(oi.item_id) AS order_count FROM products p LEFT JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id HAVING order_count = 0;

SELECT p.product_name, AVG(r.rating) AS avg_rating FROM products p LEFT JOIN product_reviews r ON p.product_id = r.product_id GROUP BY p.product_id;

SELECT p.product_name, COUNT(r.review_id) AS review_count FROM products p LEFT JOIN product_reviews r ON p.product_id = r.product_id GROUP BY p.product_id;

SELECT c.category_name, COUNT(p.product_id) AS product_count FROM categories c LEFT JOIN products p ON c.category_id = p.category_id GROUP BY c.category_id;

SELECT b.brand_name, COUNT(p.product_id) AS product_count FROM brands b LEFT JOIN products p ON b.brand_id = p.brand_id GROUP BY b.brand_id;

SELECT s.supplier_name, COUNT(p.product_id) AS supplied_products FROM suppliers s LEFT JOIN products p ON s.supplier_id = p.supplier_id GROUP BY s.supplier_id;

SELECT p.product_name, i.stock_quantity FROM products p JOIN inventory i ON p.product_id = i.product_id;

SELECT p.product_name, i.stock_quantity FROM products p JOIN inventory i ON p.product_id = i.product_id WHERE i.stock_quantity < 20;

SELECT p.product_name, i.stock_quantity FROM products p JOIN inventory i ON p.product_id = i.product_id ORDER BY i.stock_quantity DESC LIMIT 5;

SELECT p.product_name, SUM(oi.quantity) AS total_sold FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id ORDER BY total_sold DESC LIMIT 5;

SELECT p.product_name, SUM(oi.quantity) AS total_sold FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id ORDER BY total_sold ASC LIMIT 5;

SELECT p.product_name, i.stock_quantity FROM products p JOIN inventory i ON p.product_id = i.product_id WHERE i.stock_quantity = 0;

SELECT w.warehouse_name, COUNT(i.product_id) AS product_count FROM warehouses w LEFT JOIN inventory i ON w.warehouse_id = i.warehouse_id GROUP BY w.warehouse_id;

SELECT w.warehouse_name, SUM(i.stock_quantity) AS total_stock FROM warehouses w LEFT JOIN inventory i ON w.warehouse_id = i.warehouse_id GROUP BY w.warehouse_id;

SELECT p.product_name, SUM(sm.quantity) AS total_in FROM products p JOIN stock_movements sm ON p.product_id = sm.product_id WHERE sm.movement_type = 'IN' GROUP BY p.product_id;

SELECT p.product_name, SUM(sm.quantity) AS total_out FROM products p JOIN stock_movements sm ON p.product_id = sm.product_id WHERE sm.movement_type = 'OUT' GROUP BY p.product_id;

SELECT p.product_name, (p.selling_price - p.cost_price) AS profit_per_unit FROM products p;

SELECT p.product_name, SUM(oi.quantity * (oi.price - p.cost_price)) AS total_profit FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id;

SELECT c.category_name, SUM(oi.quantity * (oi.price - p.cost_price)) AS category_profit FROM categories c JOIN products p ON c.category_id = p.category_id JOIN order_items oi ON p.product_id = oi.product_id GROUP BY c.category_id;

SELECT b.brand_name, SUM(oi.quantity * (oi.price - p.cost_price)) AS brand_profit FROM brands b JOIN products p ON b.brand_id = p.brand_id JOIN order_items oi ON p.product_id = oi.product_id GROUP BY b.brand_id;

SELECT MONTH(o.order_date) AS month, SUM(oi.quantity * (oi.price - p.cost_price)) AS monthly_profit FROM orders o JOIN order_items oi ON o.order_id = oi.order_id JOIN products p ON oi.product_id = p.product_id GROUP BY MONTH(o.order_date);

SELECT p.product_name, SUM(oi.quantity * oi.price) AS revenue, SUM(oi.quantity * p.cost_price) AS cost, SUM(oi.quantity * (oi.price - p.cost_price)) AS profit FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id;

SELECT p.product_name, ((p.selling_price - p.cost_price) / p.cost_price * 100) AS profit_margin_percent FROM products p;

SELECT p.product_name, SUM(oi.quantity * (oi.price - p.cost_price)) AS profit FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id ORDER BY profit DESC LIMIT 5;

SELECT p.product_name, SUM(oi.quantity * (oi.price - p.cost_price)) AS profit FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id ORDER BY profit ASC LIMIT 5;

SELECT f.month, f.year, f.predicted_sales, t.target_amount FROM forecast_sales f LEFT JOIN sales_targets t ON f.month = t.month AND f.year = t.year;

SELECT t.month, t.year, t.target_amount, SUM(p.amount) AS actual_sales FROM sales_targets t LEFT JOIN orders o ON MONTH(o.order_date) = t.month AND YEAR(o.order_date) = t.year LEFT JOIN payments p ON o.order_id = p.order_id GROUP BY t.month, t.year;

SELECT t.month, t.year, (t.target_amount - IFNULL(SUM(p.amount), 0)) AS shortfall FROM sales_targets t LEFT JOIN orders o ON MONTH(o.order_date) = t.month AND YEAR(o.order_date) = t.year LEFT JOIN payments p ON o.order_id = p.order_id GROUP BY t.month, t.year;

SELECT f.month, f.year, f.predicted_sales, ((f.predicted_sales - LAG(f.predicted_sales) OVER (ORDER BY f.year, f.month)) / LAG(f.predicted_sales) OVER (ORDER BY f.year, f.month) * 100) AS growth_percent FROM forecast_sales f;

SELECT AVG(predicted_sales) AS avg_forecast FROM forecast_sales;

SELECT COUNT(DISTINCT customer_id) AS total_customers FROM orders;

SELECT COUNT(DISTINCT customer_id) AS repeat_customers FROM orders GROUP BY customer_id HAVING COUNT(*) > 1;

SELECT (COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_id END) / COUNT(DISTINCT customer_id) * 100) AS retention_rate FROM (SELECT customer_id, COUNT(*) AS order_count FROM orders GROUP BY customer_id) t;

SELECT COUNT(DISTINCT o.customer_id) AS active_customers FROM orders o WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT SUM(p.amount) AS total_revenue FROM payments p WHERE p.payment_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT COUNT(*) AS total_orders FROM orders WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT e.employee_name, COUNT(o.order_id) AS orders_handled FROM employees e LEFT JOIN orders o ON e.employee_id = o.employee_id GROUP BY e.employee_id;

SELECT ct.city_name, SUM(p.amount) AS city_revenue FROM cities ct JOIN customers c ON ct.city_id = c.city_id JOIN orders o ON c.customer_id = o.customer_id JOIN payments p ON o.order_id = p.order_id GROUP BY ct.city_id;

SELECT st.state_name, SUM(p.amount) AS state_revenue FROM states st JOIN cities ct ON st.state_id = ct.state_id JOIN customers c ON ct.city_id = c.city_id JOIN orders o ON c.customer_id = o.customer_id JOIN payments p ON o.order_id = p.order_id GROUP BY st.state_id;

SELECT COUNT(*) AS total_returns FROM returns;

SELECT r.reason, COUNT(*) AS return_count FROM returns r GROUP BY r.reason;

SELECT (COUNT(*) / (SELECT COUNT(*) FROM orders) * 100) AS return_rate FROM returns;