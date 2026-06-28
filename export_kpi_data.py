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
    with open(f'H:/retail_sales_analytics/csv/{filename}', 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(headers)
        writer.writerows(rows)
    print(f"Exported: {filename}")

# Total Profit
export('total_profit.csv', """
    SELECT SUM(oi.quantity * (oi.price - p.cost_price))
    FROM order_items oi JOIN products p ON oi.product_id = p.product_id
""", ['Total_Profit'])

# Total Customers
export('total_customers.csv', """
    SELECT COUNT(*) FROM customers
""", ['Total_Customers'])

# Total Orders
export('total_orders.csv', """
    SELECT COUNT(*) FROM orders
""", ['Total_Orders'])

# Total Products
export('total_products.csv', """
    SELECT COUNT(*) FROM products
""", ['Total_Products'])

print("All KPI data exported!")
conn.close()