import sqlite3
conn = sqlite3.connect('todo.db') # Warning: This file is created in the current directory
conn.execute("CREATE TABLE readers (id INTEGER PRIMARY KEY, name char(50) NOT NULL, surname char(50) NOT NULL, birthday char(50) NOT NULL)")
'''conn.execute("INSERT INTO readers (name, surname, birthday) VALUES ('Mike', 'Black', '04.05.2002')")
conn.execute("INSERT INTO readers (name, surname, birthday) VALUES ('Sasha', 'White', '09.12.2001')")
conn.execute("INSERT INTO readers (name, surname, birthday) VALUES ('Lena', 'Star', '11.10.2000')")
conn.execute("DROP TABLE readers")'''
conn.commit()
