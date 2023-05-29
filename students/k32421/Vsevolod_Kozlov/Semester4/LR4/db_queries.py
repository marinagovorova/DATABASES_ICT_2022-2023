from db_connection import ConnectionCursor
from psycopg2 import sql


def get_table_data(cursor, table_name):
    cols = get_table_columns(cursor, table_name)
    rows = get_table_rows(cursor, table_name)
    table_data = [cols, rows]
    return table_data


def get_table_columns(cursor, table_name):
    query = """select column_name from information_schema.columns where table_name=%s"""
    cursor.execute(query, [table_name])
    columns_one_by_one = cursor.fetchall()
    columns_normal = [i[0] for i in columns_one_by_one]
    return columns_normal


def get_table_rows(cursor, table_name):
    query = sql.SQL('select * from {table_name}').format(table_name=sql.Identifier(table_name))

    cursor.execute(query)
    table = cursor.fetchall()
    return table


def get_persons_info():
    with ConnectionCursor() as cursor:
        cursor.execute('select * from person')
        persons_raw = cursor.fetchall()
        persons_info = []
        for _id, name, surname, about in persons_raw:
            person_dict = {}
            # adding ready data
            person_dict['name'] = name
            person_dict['surname'] = surname
            person_dict['about'] = about
            # getting jobs
            jobs_info = get_jobs_info(cursor, _id)
            person_dict['job'] = jobs_info
            # getting educations
            educations_info = get_education_info(cursor, _id)
            person_dict['education'] = educations_info
            # add to list of persons
            persons_info.append(person_dict)
    return persons_info


def get_jobs_info(cursor, id_person):
    cursor.execute('select * from person_job where id_person=%s', (id_person,))
    jobs_raw = cursor.fetchall()
    jobs_info = []

    for _, _, id_job, position in jobs_raw:
        job_dict = {}
        cursor.execute('select * from job where id_job=%s', (id_job,))
        _, job_name, job_description = cursor.fetchone()
        job_dict['name'] = job_name
        job_dict['description'] = job_description
        job_dict['position'] = position
        jobs_info.append(job_dict)

    return jobs_info


def get_education_info(cursor, id_person):
    cursor.execute('select * from person_education where id_person=%s', (id_person,))
    educations_raw = cursor.fetchall()
    educations_info = []

    for _, _, id_education, is_finished in educations_raw:
        education_dict = {}
        cursor.execute('select * from education where id_education=%s', (id_education,))
        _, education_name, education_description = cursor.fetchone()
        education_dict['name'] = education_name
        education_dict['description'] = education_description
        education_dict['is_finished'] = is_finished
        educations_info.append(education_dict)

    return educations_info