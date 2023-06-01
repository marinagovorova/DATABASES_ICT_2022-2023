import sqlite3

def create_connection():
    conn = sqlite3.connect('books.db')
    return conn

conn = create_connection()
cursor = conn.cursor()

cursor.execute('''
    CREATE TABLE IF NOT EXISTS books (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        genre TEXT NOT NULL
    )
''')

cursor.execute('''
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        full_name TEXT NOT NULL,
        books_read INTEGER NOT NULL
    )
''')

cursor.execute('''
    CREATE TABLE IF NOT EXISTS user_books (
        id INTEGER PRIMARY KEY,
        user_id INTEGER NOT NULL,
        book_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id),
        FOREIGN KEY (book_id) REFERENCES books (id)
    )
''')

books = [
    ('Преступление и наказание', 'Фёдор Михайлович Достоевский', 'роман, психологический реализм, криминальный жанр'),
    ('Властелин колец', 'Джон Рональд Руэл Толкин', 'фэнтези, приключения, эпическая сага'),
    ('Гарри Поттер и философский камень', 'Джоан Роулинг', 'фэнтези, приключения, магия'),
    ('Алиса в Стране чудес', 'Льюис Кэрролл', 'фэнтези, приключения, детская литература'),
    ('Идиот', 'Фёдор Михайлович Достоевский', 'роман, психологическая драма'),
    ('Маленький принц', 'Антуан де Сент-Экзюпери', 'философский роман, приключения'),
    ('1984', 'Джордж Оруэлл', 'антиутопия, политическая сатира'),
    ('Бойцовский клуб', 'Чак Паланик', 'роман, триллер, психологический реализм'),
    ('Приключения Шерлока Холмса', 'Артур Конан Дойл', 'детектив, триллер, приключения'),
    ('Мартин Иден', 'Джек Лондон', 'роман, социальная драма, психологический реализм'),
    ('Темная башня', 'Стивен Кинг', 'фэнтези, ужасы, приключения'),
    ('Дон Кихот', 'Мигель де Сервантес', 'роман, приключения, комедия'),
    ('Хоббит, или Туда и обратно', 'Джон Рональд Руэл Толкин', 'фэнтези, приключения'),
    ('Бойцовский клуб', 'Чак Паланик', 'роман, триллер, социальная критика'),
    ('Джейн Эйр', 'Шарлотта Бронте', 'роман, драма, любовный роман'),
    ('Пикник на обочине', 'Аркадий и Борис Стругацкие', 'научная фантастика, антиутопия'),
    ('Анна Каренина', 'Лев Толстой', 'роман, социальная драма'),
    ('Убить пересмешника', 'Харпер Ли', 'роман, южный готический роман'),
    ('Унесённые ветром', 'Маргарет Митчелл', 'роман, историческая драма'),
    ('Над пропастью во ржи', 'Джером Дэвид Сэлинджер', 'роман, психологическая драма'),
    ('Мастер и Маргарита', 'Михаил Булгаков', 'роман, философская фантазия'),
    ('Три товарища', 'Эрих Мария Ремарк', 'роман, историческая драма'),
    ('Уроки французского', 'Дмитрий Глуховский', 'роман, постапокалипсис'),
    ('Сто лет одиночества', 'Габриэль Гарсиа Маркес', 'роман, магический реализм'),
    ('Граф Монте-Кристо', 'Александр Дюма', 'роман, приключения, историческая драма'),
    ('Война и мир', 'Лев Толстой', 'роман, историческая драма'),
    ('Атлант расправил плечи', 'Айн Рэнд', 'роман, философская пропаганда'),
    ('Записки охотника', 'Иван Тургенев', 'роман, реалистическая проза'),
    ('Грозовой перевал', 'Эмили Бронте', 'роман, любовная история'),
    ('О дивный новый мир', 'Олдос Хаксли', 'антиутопия, научная фантастика'),
    ('Мастер с маргариткой', 'Михаил Афанасьевич Булгаков', 'роман, фантастика, мистика'),
    ('Цветы для Элджернона', 'Даниел Киз', 'роман, научная фантастика'),
    ('Тихий Дон', 'Михаил Шолохов', 'роман, историческая драма'),
    ('Теория большого взрыва: Краткая история времени', 'Стивен Хокинг', 'популярная научная литература, физика'),
    ('Норвежский лес', 'Харуки Мураками', 'роман, современная проза'),
    ('Алхимик', 'Пауло Коэльо', 'роман, мистика, философия'),
    ('Дети капитана Гранта', 'Жюль Верн', 'приключения, морская литература'),
    ('Преступление', 'Андрей Круз', 'триллер, детектив'),
    ('Над кукушкиным гнездом', 'Кен Кизи', 'роман, психологическая драма'),
    ('Дневник Анны Франк', 'Анна Франк', 'автобиографическая проза'),
    ('Атлант расправил плечи', 'Айн Рэнд', 'роман, философская пропаганда'),
    ('451 градус по Фаренгейту', 'Рэй Брэдбери', 'антиутопия, научная фантастика'),
    ('Война миров', 'Герберт Уэллс', 'научная фантастика, инопланетный инвазия'),
    ('Триумфальная арка', 'Эрих Мария Ремарк', 'роман, военная драма'),
    ('Сага о ведьмаке', 'Анджей Сапковский', 'фэнтези, приключения'),
    ('Девушка с татуировкой дракона', 'Стег Ларссон', 'триллер, детектив, криминал'),
    ('Зеленая миля', 'Стивен Кинг', 'роман, фэнтези, драма'),
    ('Архипелаг ГУЛАГ', 'Александр Солженицын', 'художественно-документальная проза'),
    ('Маленькие женщины', 'Луиза Мэй Олкотт', 'роман, семейная сага'),
    ('Мастер и Маргарита', 'Михаил Булгаков', 'роман, философская фантазия'),
    ('Незнайка на Луне', 'Николай Носов', 'детская, приключенческая литература'),
]

cursor.executemany('INSERT INTO books (title, author, genre) VALUES (?, ?, ?)', books)

conn.commit()

def find_book(query):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM books WHERE title LIKE ? OR author LIKE ?", (f"%{query}%", f"%{query}%"))
    result = cursor.fetchone()
    conn.close()
    return result

def add_user(user_id, full_name):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("INSERT OR IGNORE INTO users (id, full_name, books_read) VALUES (?, ?, ?)", (user_id, full_name, 0))
    conn.commit()
    conn.close()

def get_book_by_id(book_id):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM books WHERE id = ?", (book_id,))
    result = cursor.fetchone()
    conn.close()
    return result

def add_book_to_user(user_id, book_id):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO user_books (user_id, book_id) VALUES (?, ?)", (user_id, book_id))
    conn.commit()
    conn.close()

def get_user_books(user_id):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT books.* FROM books
        JOIN user_books ON user_books.book_id = books.id
        WHERE user_books.user_id = ?
    """, (user_id,))
    result = cursor.fetchall()
    conn.close()
    return result

def check_book_added(user_id, book_name):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT * FROM user_books
        WHERE user_id = ? AND book_id = (SELECT id FROM books WHERE title = ?)
    """, (user_id, book_name))
    result = cursor.fetchone()
    conn.close()
    return result is not None

def get_books_by_genre(user_id, genre):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT books.* FROM books
        LEFT JOIN user_books ON user_books.book_id = books.id AND user_books.user_id = ?
        WHERE books.genre LIKE ? AND user_books.book_id IS NULL
    """, (user_id, f"%{genre}%"))
    result = cursor.fetchall()
    conn.close()
    return result

def get_books_by_genre(user_id, genre):
    conn = create_connection()
    cursor = conn.cursor()
    genres = genre.lower().split(', ')
    books = []
    for genre in genres:
        cursor.execute("""
            SELECT books.* FROM books
            LEFT JOIN user_books ON user_books.book_id = books.id AND user_books.user_id = ?
            WHERE LOWER(books.genre) LIKE ? AND user_books.book_id IS NULL
        """, (user_id, f"%{genre}%"))
        books.extend(cursor.fetchall())
    conn.close()
    return books

def delete_user(user_id):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM user_books WHERE user_id = ?", (user_id,))
    cursor.execute("DELETE FROM users WHERE id = ?", (user_id,))
    conn.commit()
    conn.close()

def delete_book_from_user(user_id, book_name):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("""
        DELETE FROM user_books 
        WHERE user_id = ? AND book_id = (SELECT id FROM books WHERE title = ?)
    """, (user_id, book_name))
    conn.commit()
    conn.close()


conn.close()