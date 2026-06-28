import mysql.connector
import csv

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Pradee@2007#',
    database='retail_db'
)

def export(filename, query, headers):
    cursor = conn.cursor()
    cursor.execute(query)
    rows = cursor.fetchall()
    with open(f'H:/retail_sales_analytics/{filename}', 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(headers)
        writer.writerows(rows)
    print(f"Exported: {filename}")

# 1. Monthly Sales (already have)
export('monthly_sales.csv', """
    SELECT MONTH(order_date), SUM(p.amount)
    FROM orders o JOIN payments p ON o.order_id = p.order_id
    GROUP BY MONTH(order_date)
""", ['Month', 'Revenue'])

# 2. Product Sales
export('product_sales.csv', """
    SELECT p.product_name, SUM(oi.quantity), SUM(oi.quantity * oi.price)
    FROM products p JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id ORDER BY SUM(oi.quantity * oi.price) DESC
""", ['Product', 'Quantity_Sold', 'Revenue'])

# 3. Customer Segmentation
export('customer_segmentation.csv', """
    SELECT c.customer_name, SUM(p.amount),
        CASE 
            WHEN SUM(p.amount) > 100000 THEN 'Platinum'
            WHEN SUM(p.amount) >= 50000 THEN 'Gold'
            WHEN SUM(p.amount) >= 20000 THEN 'Silver'
            ELSE 'Bronze'
        END
    FROM customers c JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY c.customer_id
""", ['Customer', 'Total_Spent', 'Segment'])

# 4. Inventory Status
export('inventory_status.csv', """
    SELECT p.product_name, i.stock_quantity,
        CASE 
            WHEN i.stock_quantity = 0 THEN 'Out of Stock'
            WHEN i.stock_quantity < 20 THEN 'Low Stock'
            ELSE 'In Stock'
        END
    FROM products p JOIN inventory i ON p.product_id = i.product_id
""", ['Product', 'Stock', 'Status'])

# 5. Product Profit
export('product_profit.csv', """
    SELECT p.product_name, p.cost_price, p.selling_price,
        (p.selling_price - p.cost_price),
        SUM(oi.quantity * (oi.price - p.cost_price))
    FROM products p LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id
""", ['Product', 'Cost', 'Selling', 'Profit_Per_Unit', 'Total_Profit'])

# 6. Regional Sales
export('regional_sales.csv', """
    SELECT ct.city_name, st.state_name, SUM(p.amount)
    FROM cities ct JOIN states st ON ct.state_id = st.state_id
    JOIN customers c ON ct.city_id = c.city_id
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY ct.city_id
""", ['City', 'State', 'Revenue'])

print("All CSV files exported!")
conn.close()