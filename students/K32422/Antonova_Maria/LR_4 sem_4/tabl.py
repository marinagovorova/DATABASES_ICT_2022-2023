# создание файла с данными
import sqlite3
conn = sqlite3.connect('students.db') # Warning: This file is created in the current directory
conn.execute("CREATE TABLE students (id INTEGER PRIMARY KEY, student char(100) NOT NULL, status bool NOT NULL)")
conn.execute("INSERT INTO students (student,status) VALUES ('Антонов Николай',0)")
conn.execute("INSERT INTO students (student,status) VALUES ('Петров Иван',1)")
conn.execute("INSERT INTO students (student,status) VALUES ('Иванов Дмитрий',1)")
conn.execute("INSERT INTO students (student,status) VALUES ('Денисов Артем',0)")
conn.commit()