import random

import db_connection
from datetime import datetime
import calendar


def empty_db(cursor, db_name):
    cursor.execute(f'delete from {db_name}')


def main():
    with db_connection.ConnectionCursor() as cursor:

        # subdivisions
        # empty_db(cursor, 'public.subdivisions')

        subdivisions = """
        insert into public.subdivisions 
        (id_subdivision, name, headquarter_address, type)
        VALUES 
        (%s, %s, %s, %s)
        """

        subdivision_ids = list(range(10))
        for _id_awarded_scholarship in subdivision_ids:
            name = f'name {_id_awarded_scholarship}'
            address = f'address {_id_awarded_scholarship}'
            subdiv_type = 'основной' if _id_awarded_scholarship < 5 else 'филиал'
            arr = (_id_awarded_scholarship, name, address, subdiv_type)
            # cursor.execute(subdivisions, arr)

        # edu_tracks
        # empty_db(cursor, 'public.edu_tracks')
        edu_tracks = """
                insert into public.edu_tracks 
                (id_edu_track, code_edu_track, name)
                VALUES 
                (%s, %s, %s)
                """

        edu_track_ids = list(range(10))
        for _id_awarded_scholarship in edu_track_ids:
            code = f'45.0{_id_awarded_scholarship}'
            name = f'eduname {_id_awarded_scholarship}'
            arr = (_id_awarded_scholarship, code, name)
            # cursor.execute(edu_tracks, arr)

        # study_plans
        # empty_db(cursor, 'public.study_plans')
        study_plans = """
                    insert into public.study_plans
                    (id_study_plan, id_subdivision, year, id_edu_track)
                    VALUES 
                    (%s, %s, %s, %s)
                    """

        study_plan_ids = list(range(10))

        for _id_awarded_scholarship in study_plan_ids:
            id_subdivision = _id_awarded_scholarship // 5
            year = f'{2010 + _id_awarded_scholarship// 2}'
            id_edu_track = _id_awarded_scholarship // 3
            arr = (_id_awarded_scholarship, id_subdivision, year, id_edu_track)
            # cursor.execute(study_plans, arr)

        # groups
        # empty_db(cursor, 'public.groups')
        groups = """
                        insert into public.groups
                        (id_group, id_study_plan, start_date, end_date, group_name, course)
                        VALUES 
                        (%s, %s, %s, %s, %s, %s)
                        """

        group_ids = list(range(4))


        for _id_awarded_scholarship in group_ids:
            id_study_plan = _id_awarded_scholarship % 2
            course = _id_awarded_scholarship // 2 + 1
            year = 2011 + course
            start_date = datetime(year=year, month=9, day=1)
            end_date  =  datetime(year=year+1, month=7, day=1)
            arr = (_id_awarded_scholarship, id_study_plan, start_date, end_date,
                   f'K{course}{id_study_plan}',
                   course)
            # cursor.execute(groups, arr)

        # students
        # empty_db(cursor, 'public.students')
        students = """
                                insert into public.students
                                (id_record_book, name, surname, patronimic)
                                VALUES 
                                (%s, %s, %s, %s)
                                """

        students_ids = list(range(20))
        for _id_awarded_scholarship in students_ids:
            name = f'student_name{_id_awarded_scholarship}'
            surname = f'student_surname{_id_awarded_scholarship}'
            patronimic = f'student_patronimic{_id_awarded_scholarship}'
            arr = [_id_awarded_scholarship, name, surname, patronimic]
            # cursor.execute(students, arr)

        # studen_groups
        # empty_db(cursor, 'public.student_groups')
        student_groups = """
                                            insert into public.student_groups
                                            (id_group_row, id_record_book, id_group)
                                            VALUES 
                                            (%s, %s, %s)
                                            """

        _id_awarded_scholarship = 0
        for _stud_id in students_ids:
            for course in range(2):
                group_id = course*2+_stud_id//10
                arr = (_id_awarded_scholarship, _stud_id, group_id)
                # cursor.execute(student_groups, arr)
                _id_awarded_scholarship += 1

        student_groups_ids = list(range(2 * len(students_ids)))

        # dispilines
        # empty_db(cursor, 'public.disciplines')
        disciplines = """
                                                       insert into public.disciplines
                                                       (id_discipline, name, selfstudy_hours, practice_hours, lecture_hours)
                                                       VALUES 
                                                       (%s, %s, %s, %s, %s)
                                                       """

        displine_ids = list(range(20))

        for _id_awarded_scholarship in displine_ids:
            name = f'name{_id_awarded_scholarship}'
            self_study_hours = _id_awarded_scholarship * 10 + 5
            practice_hours = lecture_hours = self_study_hours
            arr = [_id_awarded_scholarship, name, self_study_hours, practice_hours, lecture_hours]
            # cursor.execute(disciplines, arr)

        # study_courses
        # empty_db(cursor, 'public.study_courses')
        study_courses = """
                                                           insert into public.study_courses
                                                           (id_study_course, id_study_plan, id_discipline, semester, certification)
                                                           VALUES 
                                                           (%s, %s, %s, %s, %s)
                                                           """

        _id_awarded_scholarship = 0
        for study_plan_id in range(2):
            for semester in range(4):
                discipline_start = (study_plan_id * 2 + semester // 2) * 5
                for discipline_add in range(5):
                    discipline_id = discipline_start + discipline_add
                    cerification = random.choice(['дифзачет', 'экзамен'])
                    arr = [_id_awarded_scholarship, study_plan_id, discipline_id, semester+1, cerification]
                    # cursor.execute(study_courses, arr)
                    _id_awarded_scholarship += 1

        id_study_courses = list(range(40))

        # teachers
        # empty_db(cursor, 'public.teachers')
        teachers = """
                                                           insert into public.teachers
                                                           (id_teacher, name, surname, patronymic)
                                                           VALUES 
                                                           (%s, %s, %s, %s)
                                                           """
        teacher_ids = list(range(40))
        for _id_awarded_scholarship in teacher_ids:
            name = f'student_name{_id_awarded_scholarship}'
            surname = f'student_surname{_id_awarded_scholarship}'
            patronimic = f'student_patronimic{_id_awarded_scholarship}'
            arr = [_id_awarded_scholarship, name, surname, patronimic]
            # cursor.execute(teachers, arr)

        # campuses
        # empty_db(cursor, 'public.campuses')
        sql = """
                   insert into public.campuses
                   (id_campus, address, name)
                   VALUES 
                   (%s, %s, %s)
                   """

        campuses_ids = range(3)
        for campus_id in campuses_ids:
            name = f'campus_name{campus_id}'
            address = f'campus_addrress{campus_id}'
            arr = [campus_id, address, name]
            # cursor.execute(sql, arr)

        # аудитории
        # empty_db(cursor, 'public.rooms')
        sql = """
                           insert into public.rooms
                           (id_room, id_campus, room_number, room_type)
                           VALUES 
                           (%s, %s, %s, %s)
                           """

        rooms_ids = range(20)
        for room_id in rooms_ids:
            campus_id = random.choice(campuses_ids)
            type = random.choice(['лекционная', 'практическая'])
            room_number= room_id
            arr = [room_id, campus_id, room_number, type]
            # cursor.execute(sql, arr)

        # record_book
        empty_db(cursor, 'public.record_book')
        insert_record_book = """
               insert into public.record_book
               (id_row_record_book, id_group_row, id_teacher, id_study_course, mark, try_number)
               VALUES 
               (%s, %s, %s, %s, %s, %s)"""
        select_group_id = """
            select id_group from student_groups where  id_group_row=%s
        """
        _id_awarded_scholarship = 0
        for student_group_id in student_groups_ids:
            # get id group
            cursor.execute(select_group_id, [student_group_id])
            id_group = cursor.fetchone()[0]

            course = id_group // 2
            study_plan = id_group % 2
            study_courses_start = (course % 2) * 10 + study_plan * 20

            for study_course_plus in range(10):
                # добавляем в зачетную книжку
                study_course_id = study_courses_start + study_course_plus
                teacher_id = study_course_id
                mark = random.randrange(3, 6)
                try_number = random.randrange(1, 4)
                arr = (_id_awarded_scholarship, student_group_id, teacher_id, study_course_id, mark, try_number)
                cursor.execute(insert_record_book, arr)
                _id_awarded_scholarship += 1


        # session schedule
        # empty_db(cursor, 'session_schedule')
        insert_schedule = """
                           insert into public.session_schedule
                           (id_schedule, id_group, id_teacher, id_room, id_study_course, date_time)
                           VALUES 
                           (%s, %s, %s, %s, %s, %s)"""
        select_semester = """
                    select semester from study_courses where id_study_course=%s
                """

        _id_awarded_scholarship = 0
        for id_group in group_ids:
            course = id_group // 2
            study_plan = id_group % 2
            study_courses_start = (course % 2) * 10 + study_plan * 20

            for study_course_plus in range(10):
                study_course_id = study_courses_start + study_course_plus
                teacher_id = study_course_id
                # добавляем в расписание
                id_room = random.choice(rooms_ids)

                cursor.execute(select_semester, [study_course_id])
                semester = cursor.fetchone()[0]

                year_half = (semester - 1) % 2 + 1
                year = 2012 + course
                month = 1 if year_half == 1 else 9
                day = random.randrange(1, 29)
                dt = datetime(year=year, month=month, day=day, hour=10, minute=0, second=0)
                arr = (_id_awarded_scholarship, id_group, teacher_id, id_room, study_course_id, dt)
                # cursor.execute(insert_schedule, arr)
                _id_awarded_scholarship += 1

        # empty_db(cursor, 'public.employment_contracts')
        sql = """
                              insert into public.employment_contracts
                              (id_contract, id_teacher, share_rate, id_subdivision)
                              VALUES 
                              (%s, %s, %s, %s)
                              """

        for contract_id in teacher_ids:
            id_subdivision = random.choice(subdivision_ids)
            share_rate = random.choice([0.25, 0.5, 1])
            arr = [contract_id, contract_id , share_rate, id_subdivision ]
            # cursor.execute(sql, arr)

        # существующие стипендии
        # empty_db(cursor, 'scholarships')
        sql = """
                                     insert into scholarships
                                     (id_scholarship, name, money_amount, type_of_scholarship)
                                     VALUES 
                                     (%s, %s, %s, %s)
                                     """

        scholarships_ids = list(range(3))


        for _id_awarded_scholarship in scholarships_ids:
            name = ['социальная имя', 'академическая имя', 'именная имя'][_id_awarded_scholarship]
            money_amount = [30000, 2000, 100000.9][_id_awarded_scholarship]
            type_of_scholariship = ['социальная', 'академическая', 'именная'][_id_awarded_scholarship]
            arr = [_id_awarded_scholarship, name, money_amount, type_of_scholariship]
            # cursor.execute(sql, arr)


        # назначаем стипендии
        # empty_db(cursor,'scholarship_payments')
        # empty_db(cursor, 'awarded_scholarships')
        sql_awarded = """
             insert into awarded_scholarships
             (id_awarded_scholarship, id_record_book, id_scholarship, start_date, end_date)
             VALUES 
             (%s, %s, %s, %s, %s)
             """

        sql_payments ="""
         insert into scholarship_payments
            (id_scholarship_pay, id_awarded_scholarship, pay_date, status)
         VALUES 
         (%s, %s, %s, %s)
         """
        record_book_ids = [12, 13, 13, 14, 15]
        scholarships_ids = [1, 0, 1, 0, 2, 2]
        start_day = [23, 12, 10, 9, 8]

        id_scholarship_pay = 0

        for _id_awarded_scholarship in range(5):
            id_record_book = record_book_ids[_id_awarded_scholarship]
            id_scholarship = scholarships_ids[_id_awarded_scholarship]
            day = start_day[_id_awarded_scholarship]
            start_date = datetime(day=day, month=1, year=2013)
            end_date = datetime(day=day, month=4, year=2013)
            arr = [_id_awarded_scholarship, id_record_book, id_scholarship, start_date, end_date]
            # cursor.execute(sql_awarded, arr)

            pay_date = start_date

            while pay_date <= end_date:
                status = random.choice(['выплачено',
                                        'не выплачено',
                                        'в обработке'])
                arr = [id_scholarship_pay, _id_awarded_scholarship, pay_date, status]
                # cursor.execute(sql_payments, arr)
                pay_date = add_months(pay_date, 1)
                id_scholarship_pay += 1


def add_months(sourcedate, months):
    month = sourcedate.month - 1 + months
    year = sourcedate.year + month // 12
    month = month % 12 + 1
    day = min(sourcedate.day, calendar.monthrange(year,month)[1])
    return datetime(year, month=month, day=day)





if __name__ == '__main__':
    main()
