import mysql.connector
try:
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='Pradee@2007#',
        database='retail_db'
    )
    print("Connected!")
    conn.close()
except Exception as e:
    print(f"Error: {e}")