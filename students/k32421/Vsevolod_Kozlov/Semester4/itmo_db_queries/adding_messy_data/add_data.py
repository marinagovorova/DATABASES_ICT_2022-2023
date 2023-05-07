from itertools import product
from datetime import date

import db_connection

def empty_db(cursor, db_name):
    cursor.execute(f'delete from {db_name}')


def add_study_courses():
    with db_connection.ConnectionCursor() as cursor:
        # добавляю учебные курсы


        insert = """
            insert into study_courses (id_study_course, id_study_plan, id_discipline, semester, certification) values (%s, %s, %s, %s, %s)
        """

        cursor.execute("""
            delete from study_courses where id_study_course>39
        """)

        cursor.execute("""
        select id_discipline from disciplines
        """)
        certification = 'экзамен'
        disciplines = cursor.fetchall()

        semesters = range(1, 9)
        study_plans = range(3, 7)
        combinations = product(study_plans, disciplines, semesters)
        id_study_course = 40
        for arr in combinations:
            arr = list(arr)
            arr.insert(0, id_study_course)
            arr.append(certification)
            cursor.execute(insert, arr)
            id_study_course +=1



def add_students_groups():
    with db_connection.ConnectionCursor() as cursor:
        insert = """
            insert into students 
            (id_record_book, name, surname, patronimic) 
            values 
            (%s, %s, %s, %s)
        """

        cursor.execute("""
            delete from students where id_record_book > 19
        """)
        id_record_book = 20

        for _ in range(10000):
            name = f'student_name{id_record_book}'
            surname = f'student_surname{id_record_book}'
            patronimic = f'student_patronimic{id_record_book}'
            arr = [id_record_book, name, surname, patronimic]
            cursor.execute(insert, arr)
            id_record_book += 1

        cursor.execute("""
                    delete from groups where id_group > 3
                """)

        cursor.execute("""
                    insert into groups
                    (id_group, id_study_plan, start_date, end_date, group_name, course) 
                    values 
                    (%s, %s, %s, %s, %s, %s)
                """, [4, 3, date(year=2020, month=1, day=3),
                      date(year=2020, month=1, day=4), 'K____', 1])
        id_group = 4

        insert = """
            insert into student_groups
            (id_group_row, id_record_book, id_group) 
            values 
            (%s, %s, %s)
            
        """
        cursor.execute("""
            delete from student_groups where id_record_book > 19
        """)

        id_group_row = 40
        id_record_book = 20
        for i in range(10000):
            arr = [id_group_row, id_record_book, id_group]
            cursor.execute(insert, arr)
            id_group_row += 1
            id_record_book += 1

def add_teachers():
    with db_connection.ConnectionCursor() as cursor:
        insert = """
             insert into teachers
             (id_teacher, name, surname, patronymic) 
             values 
             (%s, %s, %s, %s)
         """

        cursor.execute("""
             delete from teachers where teachers.id_teacher > 39
         """)
        id_teacher = 40

        for _ in range(10000):
            name = f'teacher_name{id_teacher}'
            surname = f'teacher_surname{id_teacher}'
            patronimic = f'teacher_patronimic{id_teacher}'
            arr = [id_teacher, name, surname, patronimic]
            cursor.execute(insert, arr)
            id_teacher += 1


if __name__ == '__main__':
    add_teachers()
    add_students_groups()
    add_study_courses()