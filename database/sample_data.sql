INSERT INTO countries (country_name) VALUES ('India');

INSERT INTO states (state_name, country_id) VALUES 
('Maharashtra', 1),
('Karnataka', 1),
('Telangana', 1),
('Tamil Nadu', 1),
('Delhi', 1);

INSERT INTO cities (city_name, state_id) VALUES 
('Mumbai', 1),
('Pune', 1),
('Bangalore', 2),
('Hyderabad', 3),
('Chennai', 4),
('New Delhi', 5);

INSERT INTO customers (customer_name, gender, dob, email, phone, city_id, registration_date) VALUES 
('Rahul Sharma', 'Male', '1990-05-15', 'rahul@gmail.com', '9876543210', 1, '2024-01-10'),
('Priya Patel', 'Female', '1995-08-22', 'priya@gmail.com', '9876543211', 2, '2024-02-15'),
('Amit Kumar', 'Male', '1988-12-05', 'amit@gmail.com', '9876543212', 3, '2024-03-20'),
('Sneha Reddy', 'Female', '1992-04-18', 'sneha@gmail.com', '9876543213', 4, '2024-04-10'),
('Vikram Singh', 'Male', '1985-09-30', 'vikram@gmail.com', '9876543214', 5, '2024-05-05'),
('Neha Gupta', 'Female', '1998-01-25', 'neha@gmail.com', '9876543215', 6, '2024-06-15'),
('Arjun Nair', 'Male', '1993-07-12', 'arjun@gmail.com', '9876543216', 1, '2024-07-20'),
('Kavita Iyer', 'Female', '1996-11-08', 'kavita@gmail.com', '9876543217', 3, '2024-08-10');

INSERT INTO categories (category_name) VALUES 
('Electronics'),
('Clothing'),
('Footwear'),
('Home Appliances'),
('Books');

INSERT INTO sub_categories (category_id, sub_category_name) VALUES 
(1, 'Mobile Phones'),
(1, 'Laptops'),
(2, 'Men Wear'),
(2, 'Women Wear'),
(3, 'Sports Shoes'),
(3, 'Casual Shoes'),
(4, 'Kitchen Appliances'),
(4, 'Cleaning Appliances'),
(5, 'Fiction'),
(5, 'Non-Fiction');

INSERT INTO brands (brand_name) VALUES 
('Samsung'),
('Apple'),
('Nike'),
('Adidas'),
('Sony'),
('LG'),
('Puma'),
('HP');

INSERT INTO suppliers (supplier_name, contact_person, phone, email) VALUES 
('Tech Solutions Pvt Ltd', 'Rajesh Kumar', '9876543218', 'rajesh@techsol.com'),
('Fashion Hub', 'Anita Desai', '9876543219', 'anita@fashionhub.com'),
('Sports World', 'Suresh Menon', '9876543220', 'suresh@sportsworld.com'),
('Home Comforts', 'Meera Joshi', '9876543221', 'meera@homecomforts.com'),
('Book Depot', 'Ravi Sharma', '9876543222', 'ravi@bookdepot.com');

INSERT INTO warehouses (warehouse_name, location) VALUES 
('Mumbai Central Warehouse', 'Andheri, Mumbai'),
('Bangalore South Warehouse', 'Electronic City, Bangalore'),
('Hyderabad East Warehouse', 'Hitech City, Hyderabad');

INSERT INTO employees (employee_name, designation) VALUES 
('Ramesh Iyer', 'Sales Manager'),
('Sunitha Rao', 'Store Supervisor'),
('Deepak Malhotra', 'Inventory Manager'),
('Lakshmi Nair', 'Customer Service'),
('Karthik Reddy', 'Delivery Head');

INSERT INTO products (product_name, category_id, sub_category_id, brand_id, supplier_id, cost_price, selling_price) VALUES 
('Samsung Galaxy S24', 1, 1, 1, 1, 45000.00, 55000.00),
('iPhone 15 Pro', 1, 1, 2, 1, 70000.00, 85000.00),
('HP Pavilion Laptop', 1, 2, 8, 1, 35000.00, 42000.00),
('Nike Air Max', 3, 5, 3, 3, 3000.00, 4500.00),
('Adidas Ultraboost', 3, 5, 4, 3, 3500.00, 5000.00),
('Puma Casual Sneakers', 3, 6, 7, 3, 2000.00, 3200.00),
('Men Cotton T-Shirt', 2, 3, 3, 2, 500.00, 800.00),
('Women Kurti', 2, 4, 4, 2, 700.00, 1200.00),
('Sony Bravia TV', 4, 7, 5, 4, 25000.00, 32000.00),
('LG Washing Machine', 4, 7, 6, 4, 15000.00, 20000.00),
('The Alchemist', 5, 9, 5, 5, 200.00, 350.00),
('Atomic Habits', 5, 10, 6, 5, 250.00, 400.00);

INSERT INTO product_images (product_id, image_url) VALUES 
(1, 'https://example.com/s24.jpg'),
(2, 'https://example.com/iphone15.jpg'),
(3, 'https://example.com/hp_laptop.jpg');

INSERT INTO product_reviews (product_id, customer_id, rating, review_text) VALUES 
(1, 1, 5, 'Excellent phone, great camera'),
(2, 2, 4, 'Good but expensive'),
(4, 3, 5, 'Very comfortable shoes'),
(7, 4, 4, 'Nice quality t-shirt');

INSERT INTO orders (customer_id, employee_id, order_date, payment_method) VALUES 
(1, 1, '2024-10-15 10:30:00', 'UPI'),
(2, 1, '2024-10-16 14:20:00', 'Card'),
(3, 2, '2024-10-17 09:15:00', 'Cash'),
(4, 2, '2024-10-18 16:45:00', 'UPI'),
(5, 3, '2024-10-19 11:00:00', 'Net Banking'),
(1, 1, '2024-11-05 13:30:00', 'Card'),
(6, 2, '2024-11-10 15:20:00', 'UPI'),
(7, 3, '2024-11-15 10:00:00', 'Cash'),
(8, 1, '2024-11-20 14:00:00', 'Card'),
(2, 2, '2024-12-01 09:30:00', 'UPI');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES 
(1, 1, 1, 55000.00),
(1, 4, 2, 4500.00),
(2, 2, 1, 85000.00),
(3, 7, 3, 800.00),
(4, 9, 1, 32000.00),
(5, 10, 1, 20000.00),
(6, 3, 1, 42000.00),
(6, 5, 1, 5000.00),
(7, 8, 2, 1200.00),
(8, 11, 2, 350.00),
(9, 6, 1, 3200.00),
(10, 12, 3, 400.00);

INSERT INTO payments (order_id, amount, payment_date) VALUES 
(1, 64000.00, '2024-10-15 10:35:00'),
(2, 85000.00, '2024-10-16 14:25:00'),
(3, 2400.00, '2024-10-17 09:20:00'),
(4, 32000.00, '2024-10-18 16:50:00'),
(5, 20000.00, '2024-10-19 11:05:00'),
(6, 47000.00, '2024-11-05 13:35:00'),
(7, 2400.00, '2024-11-10 15:25:00'),
(8, 700.00, '2024-11-15 10:05:00'),
(9, 3200.00, '2024-11-20 14:05:00'),
(10, 1200.00, '2024-12-01 09:35:00');

INSERT INTO returns (order_id, product_id, quantity, reason, return_date) VALUES 
(1, 4, 1, 'Size too small', '2024-10-18 12:00:00'),
(6, 5, 1, 'Defective product', '2024-11-08 10:00:00');

INSERT INTO inventory (product_id, warehouse_id, stock_quantity) VALUES 
(1, 1, 50),
(2, 1, 30),
(3, 2, 25),
(4, 1, 100),
(5, 1, 80),
(6, 2, 60),
(7, 1, 200),
(8, 2, 150),
(9, 1, 20),
(10, 2, 15),
(11, 1, 500),
(12, 2, 400);

INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date) VALUES 
(1, 'IN', 50, '2024-10-01 09:00:00'),
(4, 'IN', 100, '2024-10-01 09:00:00'),
(1, 'OUT', 1, '2024-10-15 10:30:00'),
(4, 'OUT', 2, '2024-10-15 10:30:00');

INSERT INTO purchase_orders (supplier_id, purchase_date) VALUES 
(1, '2024-09-15 10:00:00'),
(2, '2024-09-20 11:00:00'),
(3, '2024-09-25 12:00:00');

INSERT INTO purchase_items (purchase_id, product_id, quantity) VALUES 
(1, 1, 50),
(1, 2, 30),
(2, 7, 200),
(2, 8, 150),
(3, 4, 100),
(3, 5, 80);

INSERT INTO campaigns (campaign_name) VALUES 
('Diwali Sale 2024'),
('New Year Offer'),
('Summer Discount');

INSERT INTO campaign_customers (campaign_id, customer_id) VALUES 
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(3, 6);

INSERT INTO customer_segments (segment_name) VALUES 
('Platinum'),
('Gold'),
('Silver'),
('Bronze');

INSERT INTO customer_segment_mapping (customer_id, segment_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 3),
(6, 4),
(7, 2),
(8, 3);

INSERT INTO sales_targets (month, year, target_amount) VALUES 
(10, 2024, 500000.00),
(11, 2024, 600000.00),
(12, 2024, 800000.00);

INSERT INTO forecast_sales (month, year, predicted_sales) VALUES 
(1, 2025, 450000.00),
(2, 2025, 480000.00),
(3, 2025, 520000.00);

INSERT INTO user_roles (role_name) VALUES 
('Admin'),
('Manager'),
('Sales Executive');

INSERT INTO users (username, password_hash, role_id) VALUES 
('admin_user', 'hashed_password_123', 1),
('manager_user', 'hashed_password_456', 2),
('sales_user', 'hashed_password_789', 3);