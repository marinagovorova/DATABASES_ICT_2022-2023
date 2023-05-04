import sqlite3
conn = sqlite3.connect('todo.db') # Warning: This file is created in the current directory
#conn.execute("CREATE TABLE take1 (id INTEGER PRIMARY KEY, reader_id INTEGER NOT NULL, book_id INTEGER NOT NULL, date date NOT NULL, \
#             FOREIGN KEY (reader_id) REFERENCES readers (id), FOREIGN KEY (book_id) REFERENCES books (id), CHECK(date<=date(current_timestamp)))")
'''conn.execute("INSERT INTO take1 (reader_id, book_id, date) VALUES (1, 1, '2023-02-21')")
conn.execute("INSERT INTO take1 (reader_id, book_id, date) VALUES (2, 3, '2023-02-21')")
conn.execute("INSERT INTO take1 (reader_id, book_id, date) VALUES (4, 2, '2023-02-21')")
conn.execute("DROP TABLE take1")'''
conn.execute("DELETE FROM take1")
conn.commit()