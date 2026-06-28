import mysql.connector

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Pradee@2007#',
    database='retail_db'
)

query = """
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(p.amount) as total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
"""

cursor = conn.cursor()
cursor.execute(query)
rows = cursor.fetchall()

print("=== CUSTOMER SEGMENTATION ===")
print("Platinum: > Rs.100,000")
print("Gold: Rs.50,000 - Rs.100,000")
print("Silver: Rs.20,000 - Rs.50,000")
print("Bronze: < Rs.20,000")
print()

for row in rows:
    customer_id, customer_name, total_spent = row
    
    if total_spent > 100000:
        segment = "Platinum"
    elif total_spent >= 50000:
        segment = "Gold"
    elif total_spent >= 20000:
        segment = "Silver"
    else:
        segment = "Bronze"
    
    print(f"{customer_name}: Rs.{total_spent:,.2f} -> {segment}")

conn.close()