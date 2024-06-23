from flask import Flask, render_template
import pymssql
import os

# Configure database connection
server = os.environ.get('DATABASE_SERVER')
database = os.environ.get('DATABASE_NAME')
username = os.environ.get('DATABASE_USERNAME')
password = os.environ.get('DATABASE_PASSWORD')

app = Flask(__name__)

@app.route('/')
def list_books():
  try:
    # Connect to the database
    connection = pymssql.connect(server, username, password, database)
    cursor = connection.cursor()

    # Execute query to get all books
    cursor.execute("SELECT * FROM books")
    books = cursor.fetchall()  # Fetch all results

    # Close connection
    connection.close()

    return render_template('books.html', books=books)
  except Exception as e:
    return f"Error connecting to database: {e}"

if __name__ == '__main__':
    app.run(debug=False,hostname='0.0.0.0', port=80)