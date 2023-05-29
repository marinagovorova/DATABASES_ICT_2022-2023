from db_connection import ConnectionCursor


def main():
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
            person_dict['jobs'] = jobs_info
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


if __name__ == '__main__':
    print(main())