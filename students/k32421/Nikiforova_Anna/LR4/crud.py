import sqlite3
from datetime import date

connect = sqlite3.connect('octobot.db')
cursor = connect.cursor()


def create_db():
    cursor.execute("""CREATE TABLE IF NOT EXISTS instructor(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        isu TEXT,
        email TEXT,
        telegram TEXT
        )
    """)

    cursor.execute("""CREATE TABLE IF NOT EXISTS subject(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        instructor_id INTEGER,
        assessment_table TEXT, 
        FOREIGN KEY(instructor_id) REFERENCES instructor(id)
        )
    """)

    cursor.execute("""CREATE TABLE IF NOT EXISTS task(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subject_id INTEGER,
        name TEXT,
        deadline DATE DEFAULT (date('now', '+14 day')),
        description TEXT,
        status TEXT NOT NULL DEFAULT 'not started',
        note TEXT,
        FOREIGN KEY(subject_id) REFERENCES subject(id)
        )
    """)

    connect.commit()


def delete_db():
    cursor.execute("DROP TABLE IF EXISTS instructor")
    cursor.execute("DROP TABLE IF EXISTS subject")
    cursor.execute("DROP TABLE IF EXISTS task")
    cursor.execute("DROP TABLE IF EXISTS doing_task")

    connect.commit()


def init_inserts():
    instructors_list = [
        ["Чернышева Анастасия Вадимовна",
         "https://isu.ifmo.ru/pls/apex/f?p=2143:PERSON:108214562555001::NO:RP:PID:182049",
         "avchernysheva@itmo.ru", "@avchernysheva"],
        ["Милованович Екатерина Воиславовна",
         "https://isu.ifmo.ru/pls/apex/f?p=2143:PERSON:108214562555001::NO:RP:PID:106026",
         "evmilovanovich@itmo.ru", None],
        ["Дмитракова Янина Александровна", None, "iadmitrakova@itmo.ru", None],
    ]
    cursor.executemany("INSERT INTO instructor(name, isu, email, telegram) VALUES(?, ?, ?, ?);", instructors_list)

    subjects_list = [
        ["Методы визуализации данных", 1,
         "https://docs.google.com/spreadsheets/d/1QrV8MHMRSDXMxDKDLmsR9u_Ewyjljo6LsP4iN5pJfAU/edit#gid=0"],
        ["Теория вероятностей", 2, None],
        ["Дискретная математика", 2, None],
        ["Экология", 3, None],
    ]
    cursor.executemany("INSERT INTO subject(name, instructor_id, assessment_table) VALUES(?, ?, ?);", subjects_list)

    tasks_list = [
        [1, "Разведочный анализ данных", date(2023, 4, 19), None, "done",
         "У субботней группы дедлайн в ближайшую субботу"],
        [1, "Проверка гипотез", date(2023, 5, 3), None, "not started", None],
        [3, "Типовик", None, None, "in progress", "Задания по вариантам из ИСУ"],
        [4, "Практика 5", date(2023, 4, 23), "Оценка рисков", "done", None]
    ]
    cursor.executemany("INSERT INTO task(subject_id, name, deadline, description, status, note) "
                       "VALUES(?, ?, ?, ?, ?, ?);", tasks_list)

    connect.commit()


if __name__ == "__main__":
    delete_db()
    create_db()
    init_inserts()
