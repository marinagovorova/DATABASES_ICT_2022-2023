import sqlite3


def create_connection():
    conn = sqlite3.connect("films.db")
    return conn


conn = create_connection()
cursor = conn.cursor()

cursor.execute(
    """
    CREATE TABLE IF NOT EXISTS films (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        director TEXT NOT NULL,
        genre TEXT NOT NULL
    )
"""
)

cursor.execute(
    """
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        full_name TEXT NOT NULL,
        films_watched INTEGER NOT NULL
    )
"""
)

cursor.execute(
    """
    CREATE TABLE IF NOT EXISTS user_films (
        id INTEGER PRIMARY KEY,
        user_id INTEGER NOT NULL,
        film_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id),
        FOREIGN KEY (film_id) REFERENCES films (id)
    )
"""
)

films = [
    ("Звездные войны", "Джордж Лукас", "фантастика, приключения"),
    ("Властелин колец: Братство Кольца", "Питер Джексон", "фэнтези, приключения"),
    ("Побег из Шоушенка", "Фрэнк Дарабонт", "драма, криминал"),
    ("Форрест Гамп", "Роберт Земекис", "драма, комедия"),
    ("В бой идут одни старики", "Леонид Быков", "военная драма"),
    ("Зеленая миля", "Фрэнк Дарабонт", "драма, фэнтези"),
    ("Игры разума", "Рон Ховард", "драма, биография"),
    ("Темный рыцарь", "Кристофер Нолан", "боевик, триллер"),
    ("Крестный отец", "Фрэнсис Форд Коппола", "криминал, драма"),
    ("Бриллиантовая рука", "Леонид Гайдай", "комедия, криминал"),
    ("Заводной апельсин", "Стэнли Кубрик", "драма, криминал, научная фантастика"),
    ("Леон", "Люк Бессон", "боевик, триллер"),
    ("Молчание ягнят", "Джонатан Демми", "триллер, детектив, криминал"),
    ("Титаник", "Джеймс Кэмерон", "драма, романтика"),
    ("Пианист", "Роман Полански", "драма, военная драма"),
    ("Шоу Трумана", "Питер Вир", "комедия, драма"),
    ("Исходный код", "Дункан Джонс", "фантастика, триллер"),
    ("Пятый элемент", "Люк Бессон", "фантастика, приключения"),
    ("Семь", "Дэвид Финчер", "триллер, детектив"),
    ("Гладиатор", "Ридли Скотт", "боевик, драма"),
    ("Список Шиндлера", "Стивен Спилберг", "драма, военная драма"),
    ("Помни", "Кристофер Нолан", "драма, триллер, загадочный"),
    ("Интерстеллар", "Кристофер Нолан", "фантастика, драма"),
    ("Матрица", "Лана и Лилли Вачовски", "фантастика, боевик"),
    ("В джазе только девушки", "Билли Уайлдер", "комедия, музыкальный"),
    ("Поймай меня, если сможешь", "Стивен Спилберг", "криминал, биография"),
    ("Американская история X", "Тони Кэй", "драма, криминал"),
    ("Храброе сердце", "Мел Гибсон", "эпическая драма, военная драма"),
    ("Город Бога", "Катия Лунд", "криминал, драма"),
    ("Зеркало", "Андрей Тарковский", "драма, искусство"),
]

cursor.executemany("INSERT INTO films (title, director, genre) VALUES (?, ?, ?)", films)

conn.commit()


def find_film(query):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute(
        "SELECT * FROM films WHERE title LIKE ? OR director LIKE ?",
        (f"%{query}%", f"%{query}%"),
    )
    result = cursor.fetchone()
    conn.close()
    return result


def add_user(user_id, full_name):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT OR IGNORE INTO users (id, full_name, films_watched) VALUES (?, ?, ?)",
        (user_id, full_name, 0),
    )
    conn.commit()
    conn.close()


def get_film_by_id(film_id):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM films WHERE id = ?", (film_id,))
    result = cursor.fetchone()
    conn.close()
    return result


def add_film_to_user(user_id, film_id):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO user_films (user_id, film_id) VALUES (?, ?)", (user_id, film_id)
    )
    conn.commit()
    conn.close()


def get_user_films(user_id):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute(
        """
        SELECT films.* FROM films
        JOIN user_films ON user_films.film_id = films.id
        WHERE user_films.user_id = ?
    """,
        (user_id,),
    )
    result = cursor.fetchall()
    conn.close()
    return result


def check_film_added(user_id, film_name):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute(
        """
        SELECT * FROM user_films
        WHERE user_id = ? AND film_id = (SELECT id FROM films WHERE title = ?)
    """,
        (user_id, film_name),
    )
    result = cursor.fetchone()
    conn.close()
    return result is not None


def get_films_by_genre(user_id, genre):
    conn = create_connection()
    cursor = conn.cursor()
    genres = genre.lower().split(", ")
    films = []
    for genre in genres:
        cursor.execute(
            """
            SELECT films.* FROM films
            LEFT JOIN user_films ON user_films.film_id = films.id AND user_films.user_id = ?
            WHERE LOWER(films.genre) LIKE ? AND user_films.film_id IS NULL
        """,
            (user_id, f"%{genre}%"),
        )
        films.extend(cursor.fetchall())
    conn.close()
    return films


def delete_user(user_id):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM user_films WHERE user_id = ?", (user_id,))
    cursor.execute("DELETE FROM users WHERE id = ?", (user_id,))
    conn.commit()
    conn.close()


def delete_film_from_user(user_id, film_name):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute(
        """
        DELETE FROM user_films 
        WHERE user_id = ? AND film_id = (SELECT id FROM films WHERE title = ?)
    """,
        (user_id, film_name),
    )
    conn.commit()
    conn.close()


def update_film_director(title, new_director):
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE films SET director = ? WHERE title = ?", (new_director, title)
    )
    conn.commit()
    conn.close()


conn.close()
