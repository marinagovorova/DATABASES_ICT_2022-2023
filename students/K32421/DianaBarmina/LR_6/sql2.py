import sqlite3
conn = sqlite3.connect('todo.db') # Warning: This file is created in the current directory
conn.execute("CREATE TABLE books (id INTEGER PRIMARY KEY, name char(100) NOT NULL, author_name char(50) NOT NULL)")
'''conn.execute("INSERT INTO books (name, author_name) VALUES ('Biology', 'Komarov V.V')")
conn.execute("INSERT INTO books (name, author_name) VALUES ('Good Omens', 'Neil Geiman')")
conn.execute("INSERT INTO books (name, author_name) VALUES ('Harry Potter', 'J.K.Rowling')")
conn.execute("DROP TABLE books")'''
conn.commit()
