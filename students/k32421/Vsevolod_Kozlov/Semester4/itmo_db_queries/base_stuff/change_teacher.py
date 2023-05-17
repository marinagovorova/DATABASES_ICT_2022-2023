import db_connection


def main():
    with db_connection.ConnectionCursor() as cursor:
        subdivisions = """
                update teachers set
                 name = %s, 
                 surname = %s,
                 patronymic = %s
                 where id_teacher = %s;
                """

        for _id in range(40):
            name = f'teacher_name{_id}'
            surname = f'teacher_surname{_id}'
            patronymic = f'teacher_patronimic{_id}'
            cursor.execute(subdivisions, [name, surname, patronymic, _id])


if __name__ == '__main__':
    main()