import mysql.connector
import csv

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Pradee@2007#',
    database='retail_db'
)

cursor = conn.cursor()
cursor.execute("""
    SELECT 
        MONTH(o.order_date) as Month,
        SUM(oi.quantity * (oi.price - p.cost_price)) as Profit
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY MONTH(o.order_date)
    ORDER BY MONTH(o.order_date)
""")

rows = cursor.fetchall()

with open('H:/retail_sales_analytics/csv/monthly_profit.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['Month', 'Profit'])
    writer.writerows(rows)

print("Exported: monthly_profit.csv")
conn.close()