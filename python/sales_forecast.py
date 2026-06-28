import mysql.connector

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Pradee@2007#',
    database='retail_db'
)

query = """
SELECT 
    MONTH(order_date) as month,
    YEAR(order_date) as year,
    SUM(p.amount) as revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month
"""

cursor = conn.cursor()
cursor.execute(query)
rows = cursor.fetchall()

print("=== SALES DATA ===")
for row in rows:
    print(f"{row[1]}-{row[0]:02d}: Rs.{row[2]:,.2f}")

if len(rows) >= 2:
    avg_growth = (rows[-1][2] - rows[0][2]) / (len(rows) - 1)
    last_month = rows[-1][1] * 12 + rows[-1][0]
    print("\n=== FORECAST ===")
    for i in range(1, 4):
        next_month = last_month + i
        year = next_month // 12
        month = next_month % 12
        if month == 0:
            month = 12
            year -= 1
        forecast = rows[-1][2] + (avg_growth * i)
        print(f"{year}-{month:02d}: Rs.{forecast:,.2f}")

conn.close()