import random

import psycopg2
from psycopg2 import Error
import yaml
import os
from generating_data import *


def setup(config_path: str = os.path.join(os.path.dirname(__file__), 'config.yml')):
    with open(config_path, "r") as f:
        raw_config = yaml.safe_load(f)
    config = {"user": raw_config["user"],
              "password": raw_config["password"],
              "host": raw_config["host"],
              "port": raw_config["port"],
              "database": raw_config["database"]}
    return config


def connect_to_db():
    try:
        connection = psycopg2.connect(**setup())
        cursor = connection.cursor()
        print("PostgreSQL server information")
        print(connection.get_dsn_parameters(), "\n")
        cursor.execute("SELECT version();")
        record = cursor.fetchone()
        print("You are connected to - ", record, "\n")
        return cursor, connection
    except (Exception, Error) as error:
        print("Error while connecting to PostgreSQL", error)


def disconnect_from_db(cursor, connection):
    if connection:
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed")


if __name__ == '__main__':
    try:
        cursor, connection = connect_to_db()

        # cursor.execute('SELECT * from "School_schema"."Class"')
        # record = cursor.fetchall()
        # print("Result ", record)

        # insert_query = '''INSERT INTO "School_schema"."Student"(student_code, full_name, birth_date, address, phone_number, email)
        #                     VALUES (%s, %s, %s, %s, %s, %s)
        #                     '''
        # vals = generate_students(1000)
        # cursor.executemany(insert_query, vals)
        # connection.commit()
        # print("Records inserted successfully")

        # delete_query = """TRUNCATE TABLE "School_schema"."Plan" CASCADE"""
        # cursor.execute(delete_query)
        # connection.commit()
        # count = cursor.rowcount
        # cursor.execute("""ALTER TABLE "School_schema"."Plan" ALTER COLUMN plan_id RESTART SET START 1""")
        # connection.commit()
        # print(count, "Record deleted successfully ")

        # insert_query = '''INSERT INTO "School_schema"."Teacher"(teacher_personnel_number, full_name, birth_date, address, phone_number, email, passport_number)
        #                             VALUES (%s, %s, %s, %s, %s, %s, %s)
        #                             '''
        # vals = generate_teachers(30)
        # cursor.executemany(insert_query, vals)
        # connection.commit()
        # print("Records inserted successfully")

        # insert_query = '''INSERT INTO "School_schema"."Class"(class_name, status)
        #                             VALUES (%s, %s)
        #                             '''
        # vals = generate_classes(100)
        # cursor.executemany(insert_query, vals)
        # connection.commit()
        # print("Records inserted successfully")

        # cursor.execute('SELECT * from "School_schema"."Teacher"')
        # record = cursor.fetchall()
        # teachers = set(record)
        # print("Result ", teachers)
        #
        # cursor.execute('SELECT * from "School_schema"."Class"')
        # record_class = cursor.fetchall()
        # print("Result ", record_class)
        #
        # insert_query = '''INSERT INTO "School_schema"."Headteacher"(class_id, teacher_personnel_number,
        # date_from, date_to) VALUES (%s, %s, %s, %s)'''
        #
        # for cl in record_class:
        #     class_id = cl[0]
        #     if cl[2] == "Действует":
        #         headteacher = teachers.pop()
        #         date_from, date_to = 2022, 2023
        #     elif cl[2] == "Расформирован":
        #         headteacher = list(teachers)[random.randint(1, len(teachers) - 1)]
        #         date_from = random.randint(2018, 2023)
        #         date_to = date_from + 1
        #     else:
        #         continue
        #     cursor.execute(insert_query, [class_id, headteacher[0], date(date_from, 8, 15), date(date_to, 7, 30)])
        # connection.commit()
        #

        # cursor.execute('SELECT * from "School_schema"."Student"')
        # record_students = cursor.fetchall()
        # print("Result ", record_students)
        #
        # insert_query = '''INSERT INTO "School_schema"."Student_in_class"(class_id, student_code, date_from, date_to, status)
        #                                             VALUES (%s, %s, %s, %s, %s)
        #                                             '''
        #
        # random.shuffle(record_students)
        # for student in record_students:
        #     class_n = random.randint(0, n_cl-1)
        #     if record_class[class_n][2] == "Действует":
        #         date_from = 2022
        #         date_to = 2023
        #     elif record_class[class_n][2] == "Формируется":
        #         date_from = 2023
        #         date_to = 2024
        #     else:
        #         date_from = random.randint(2018, 2024)
        #         date_to = date_from + 1
        #     cursor.execute(insert_query, [record_class[class_n][0],
        #                                   student[0],
        #                                   date(date_from, 8, 15),
        #                                   date(date_to, 7, 30),
        #                                   random.choice(['Числится', 'Числился', 'Отчислен', 'В академ. отпуске']) if
        #                                                 date_from != 2023 else "Числится"
        #                                   ])
        # connection.commit()
        # print("Records inserted successfully")

        # insert_query = '''INSERT INTO "School_schema"."Classroom"(classroom_number, having_projector, number_of_seats)
        #                                     VALUES (%s, %s, %s)
        #                                     '''
        # vals = generate_classrooms(40)
        # cursor.executemany(insert_query, vals)
        # connection.commit()
        # print("Records inserted successfully")

        # education = []
        # # (education_id: auto, teacher_presonnel_number, diploma_number, education_level,
        # # qualifications, specialization, year)
        # for _ in range(2):
        #     for rec in record:
        #         teacher_presonnel_number = rec[0]
        #         diploma_number = random.randint(1, 99999)  # понятия не имею, какого формата номер диплома
        #         education_level = random.choice(['Среднее профессиональное образование',
        #                                         'Бакалавриат', 'Магистратура', 'Специалитет',
        #                                          'Аспирантура', 'Докторантура'])
        #         qualifications = 'Среднее профессиональное образование' if education_level == 'Среднее профессиональное образование' \
        #         else 'Бакалавр' if education_level == 'Бакалавриат' else 'Магистр' if education_level == 'Магистратура' else \
        #         'Специалист' if education_level == 'Специалитет' else 'Кандидат' if education_level == 'Аспирантура' else "Доктор"
        #
        #         specialization = "Педагог"  # потому что почему бы и нет
        #         year = int(rec[2].year) + 18 + random.randint(2, 10)
        #         if year > 2022:
        #             year = 2022
        #         education.append((teacher_presonnel_number, diploma_number, education_level,
        #         qualifications, specialization, date(year, 1, 1)))
        #     insert_query = '''INSERT INTO "School_schema"."Education"(teacher_presonnel_number,
        #     diploma_number, education_level, qualifications, specialization, year)
        #     VALUES (%s, %s, %s, %s, %s, %s)'''
        #     cursor.executemany(insert_query, education)
        #     connection.commit()
        #     print("Records inserted successfully")

        # cursor.execute('SELECT * from "School_schema"."Classroom"')
        # record = cursor.fetchall()
        # print("Result ", record)

        # cursor.execute('SELECT * from "School_schema"."Discipline"')
        # record = cursor.fetchall()
        # print("Result ", record)

        # insert_query = '''INSERT INTO "School_schema"."Discipline"(subject_area, subject_name, discipline_code,
        # hours_in_curriculum, curriculum_id)
        #                                             VALUES (%s, %s, %s, %s, %s)
        #                                             '''
        # vals = [
        #     ["Русский язык и литература", "Русский язык", 1, 5 * 36, 2],
        #     ["Русский язык и литература", "Литература", 18, 3 * 36, 2],
        #     ["Иностранный язык", "Английский язык", 9, 3 * 36, 2],
        #     ["Математика и информатика", "Математика", 2, 5 * 36, 2],
        #     ["Общественно-научные предметы", "История России", 7, 2 * 36, 2],
        #     ["Общественно-научные предметы", "География", 8, 1 * 36, 2],
        #     ["Естественно-научные предметы", "Биология", 6, 1 * 36, 2],
        #     ["Физическая культура", "Физическая культура", 0, 2*36, 2],
        #
        #     ["Русский язык и литература", "Русский язык", 1, 6 * 36, 3],
        #     ["Русский язык и литература", "Литература", 18, 3 * 36, 3],
        #     ["Иностранный язык", "Английский язык", 9, 2 * 36, 3],
        #     ["Математика и информатика", "Математика", 2, 5 * 36, 3],
        #     ["Общественно-научные предметы", "История России", 7, 2 * 36, 3],
        #     ["Общественно-научные предметы", "Обществознание", 12, 2 * 36, 3],
        #     ["Общественно-научные предметы", "География", 8, 1 * 36, 3],
        #     ["Естественно-научные предметы", "Биология", 6, 1 * 36, 3],
        #     ["Физическая культура", "Физическая культура", 0, 3 * 36, 3],
        #
        #     ["Русский язык и литература", "Русский язык", 1, 4 * 36, 4],
        #     ["Русский язык и литература", "Литература", 18, 2 * 36, 4],
        #     ["Иностранный язык", "Английский язык", 9, 3 * 36, 4],
        #     ["Математика и информатика", "Алгебра", 2, 3 * 36, 4],
        #     ["Математика и информатика", "Геометрия", 2, 2 * 36, 4],
        #     ["Математика и информатика", "Информатика", 5, 1 * 36, 4],
        #     ["Общественно-научные предметы", "История России", 7, 2 * 36, 4],
        #     ["Общественно-научные предметы", "Обществознание", 12, 2 * 36, 4],
        #     ["Общественно-научные предметы", "География", 8, 2 * 36, 4],
        #     ["Естественно-научные предметы", "Биология", 6, 1 * 36, 4],
        #     ["Естественно-научные предметы", "Физика", 3, 2 * 36, 4],
        #     ["Физическая культура", "Физическая культура", 0, 3 * 36, 4],
        #
        #     ["Русский язык и литература", "Русский язык", 1, 3 * 36, 5],
        #     ["Русский язык и литература", "Литература", 18, 2 * 36, 5],
        #     ["Иностранный язык", "Английский язык", 9, 3 * 36, 5],
        #     ["Математика и информатика", "Алгебра", 2, 3 * 36, 5],
        #     ["Математика и информатика", "Геометрия", 2, 2 * 36, 5],
        #     ["Математика и информатика", "Информатика", 5, 1 * 36, 5],
        #     ["Общественно-научные предметы", "История России", 7, 2 * 36, 5],
        #     ["Общественно-научные предметы", "Обществознание", 12, 2 * 36, 5],
        #     ["Общественно-научные предметы", "География", 8, 2 * 36, 5],
        #     ["Естественно-научные предметы", "Биология", 6, 2 * 36, 5],
        #     ["Естественно-научные предметы", "Физика", 3, 2 * 36, 5],
        #     ["Естественно-научные предметы", "Химия", 4, 2 * 36, 5],
        #     ["Физическая культура", "Физическая культура", 0, 3 * 36, 5],
        #
        #     ["Русский язык и литература", "Русский язык", 1, 3 * 36, 6],
        #     ["Русский язык и литература", "Литература", 18, 2 * 36, 6],
        #     ["Иностранный язык", "Английский язык", 9, 3 * 36, 6],
        #     ["Математика и информатика", "Алгебра", 2, 3 * 36, 6],
        #     ["Математика и информатика", "Геометрия", 2, 2 * 36, 6],
        #     ["Математика и информатика", "Информатика", 5, 1 * 36, 6],
        #     ["Общественно-научные предметы", "История России", 7, 2 * 36, 6],
        #     ["Общественно-научные предметы", "Обществознание", 12, 2 * 36, 6],
        #     ["Общественно-научные предметы", "География", 8, 2 * 36, 6],
        #     ["Естественно-научные предметы", "Биология", 6, 2 * 36, 6],
        #     ["Естественно-научные предметы", "Физика", 3, 2 * 36, 6],
        #     ["Естественно-научные предметы", "Химия", 4, 2 * 36, 6],
        #     ["Физическая культура", "Физическая культура", 0, 3 * 36, 6],
        #
        #     ["Русский язык и литература", "Русский язык", 1, 3 * 36, 7],
        #     ["Иностранный язык", "Английский язык", 9, 3 * 36, 7],
        #     ["Математика и информатика", "Алгебра", 2, 6 * 36, 7],
        #     ["Математика и информатика", "Геометрия", 2, 4 * 36, 7],
        #     ["Математика и информатика", "Информатика", 5, 5 * 36, 7],
        #     ["Общественно-научные предметы", "История России", 7, 2 * 36, 7],
        #     ["Естественно-научные предметы", "Физика", 3, 5 * 36, 7],
        #     ["Физическая культура", "Физическая культура", 0, 3 * 36, 7],
        #
        #     ["Русский язык и литература", "Русский язык", 1, 6 * 36, 8],
        #     ["Русский язык и литература", "Литература", 18, 4 * 36, 8],
        #     ["Иностранный язык", "Английский язык", 9, 4 * 36, 8],
        #     ["Математика и информатика", "Алгебра", 2, 3 * 36, 8],
        #     ["Математика и информатика", "Геометрия", 2, 2 * 36, 8],
        #     ["Общественно-научные предметы", "История России", 7, 3 * 36, 8],
        #     ["Общественно-научные предметы", "Обществознание", 12, 4 * 36, 8],
        #     ["Физическая культура", "Физическая культура", 0, 3 * 36, 8],
        #
        #     ["Русский язык и литература", "Русский язык", 1, 6 * 36, 9],
        #     ["Русский язык и литература", "Литература", 18, 5 * 36, 9],
        #     ["Иностранный язык", "Английский язык", 9, 5 * 36, 9],
        #     ["Иностранный язык", " Немецкий язык", 9, 4 * 36, 9],
        #     ["Математика и информатика", "Алгебра", 2, 3 * 36, 9],
        #     ["Математика и информатика", "Геометрия", 2, 2 * 36, 9],
        #     ["Общественно-научные предметы", "История России", 7, 3 * 36, 9],
        #     ["Общественно-научные предметы", "Обществознание", 12, 2 * 36, 9],
        #     ["Физическая культура", "Физическая культура", 0, 3 * 36, 9],
        #
        #     ["Русский язык и литература", "Русский язык", 1, 3 * 36, 10],
        #     ["Иностранный язык", "Английский язык", 9, 3 * 36, 10],
        #     ["Математика и информатика", "Алгебра", 2, 6 * 36, 10],
        #     ["Математика и информатика", "Геометрия", 2, 4 * 36, 10],
        #     ["Математика и информатика", "Информатика", 5, 5 * 36, 10],
        #     ["Общественно-научные предметы", "История России", 7, 2 * 36, 10],
        #     ["Естественно-научные предметы", "Физика", 3, 5 * 36, 10],
        #     ["Физическая культура", "Физическая культура", 0, 3 * 36, 10],
        #
        # ]
        # cursor.executemany(insert_query, vals)
        # connection.commit()

        # cursor.execute('SELECT teacher_personnel_number from "School_schema"."Teacher"')
        # record_teacher = cursor.fetchall()
        # #print("Result ", record)
        # random.shuffle(record_teacher)
        #
        # cursor.execute('SELECT class_id from "School_schema"."Class"')
        # record_classes = cursor.fetchall()
        # #print("Result ", record)
        # random.shuffle(record_classes)
        #
        # cursor.execute('SELECT discipline_id from "School_schema"."Discipline"')
        # record_disc = cursor.fetchall()
        # #print("Result ", record)
        # random.shuffle(record_disc)
        #
        # for _ in range(32):
        #     t = random.choice(record_teacher)[0]
        #     disc = random.choice(record_disc)[0]
        #     cl = random.choice(record_classes)[0]
        #     cursor.execute('''INSERT INTO "School_schema"."Workload"(class_id, teacher_personnel_number,
        #     discipline_id, hours, date_from, date_to) VALUES (%s, %s, %s, %s, %s, %s)''',
        #                    [cl, t, disc, random.randint(1, 2), date(2022, 8, 15), date(2023, 7, 30)])
        #     connection.commit()

        # cursor.execute('SELECT DISTINCT subject_name from "School_schema"."Discipline"')
        # wrecord = list(map(lambda t: t[0], cursor.fetchall()))
        # print("Result ", wrecord)

        cursor.execute('SELECT workload_id from "School_schema"."Workload"')
        wrecord = list(map(lambda t: t[0], cursor.fetchall()))
        print("Result ", wrecord)
        cursor.execute('SELECT classroom_number from "School_schema"."Classroom"')
        crecord = list(map(lambda t: t[0], cursor.fetchall()))
        print("Result ", crecord)

        weekdays = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"]
        subjects = ['Информатика', 'Английский язык', 'Алгебра', 'География', 'Математика', 'Русский язык',
                     'Биология', 'История России', 'Литература', 'Химия', 'Геометрия', 'Обществознание',
                    'Физическая культура', 'Физика']
        time_from = [time(8,0,0), time(8,55,0), time(10,0,0), time(11,0,0), time(12,0,0), time(12,55,0), time(13,50,0)]
        time_to = [time(8, 45, 0), time(9, 40, 0), time(10, 45, 0), time(11, 45, 0), time(12, 45, 0), time(13, 40, 0),
                     time(14, 35, 0)]
        date_from = [date(2022,9,1), date(2023,1,14)]
        date_to = [date(2022, 12, 29), date(2023, 5, 30)]

        for weekday in weekdays:
            for i in range(random.randint(4, 7)):
                subject = random.choice(subjects)
                lesson_type = random.choice(['Основное', 'Дополнительное', 'Факультатив'])
                cab = random.choice(crecord)
                m = random.choice([0,1])
                cursor.execute('''INSERT INTO "School_schema"."Schedule"(classroom_number,
                workload_id, weekday, lesson_type, date_from, date_to, time_from, time_to) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)''',
                               [cab, wrecord.pop(), weekday, lesson_type, date_from[m], date_to[m],
                                time_from[i], time_to[i]])
                connection.commit()


        # typ = ['К/р', 'С/р', 'Д/з', 'Ведение тетради', 'Работа на уроке', 'Иное']
        # descr = ""
        # for pid in record:
        #     cursor.execute('''INSERT INTO "School_schema"."Evaluation_tool"(plan_id, name,
        #     type, description) VALUES (%s, %s, %s, %s)''',
        #                        [pid[0], "Название оценочного средства", random.choice(typ), descr])
        #     connection.commit()
    finally:
        disconnect_from_db(cursor, connection)
