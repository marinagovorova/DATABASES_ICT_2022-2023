import db_connection


def main():
    with db_connection.ConnectionCursor() as cursor:
        insert_into_record_book = """
         insert into record_book
                        (id_row_record_book,
                        id_group_row, 
                        id_teacher, 
                        id_study_course, 
                        mark, 
                        try_number)
                        VALUES 
                        (%s, %s, %s, %s, %s, %s)
                """

        select_from_record_book = """
            select id_group_row, id_teacher, id_study_course, try_number from record_book where try_number > 1;
        """

        cursor.execute(select_from_record_book)
        rows = cursor.fetchall()
        row_record_book = 400
        for id_group_row, id_teacher, id_study_course, last_try in rows:
            for try_number in range(1, last_try):
                arr = [row_record_book, id_group_row, id_teacher, id_study_course, 2, try_number]
                cursor.execute(insert_into_record_book, arr)
                row_record_book += 1


if __name__ == '__main__':
    main()