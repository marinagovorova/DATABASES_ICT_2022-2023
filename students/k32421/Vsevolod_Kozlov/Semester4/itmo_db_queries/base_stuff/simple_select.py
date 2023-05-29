import db_connection

if __name__ == '__main__':
    with db_connection.ConnectionCursor() as cursor:
        cursor.execute('select * from public.subdivisions')
        print(cursor.fetchall())

