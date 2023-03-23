import random

import db_connect
from datetime import datetime, timedelta
import calendar


def empty_db(cursor, db_name):
    cursor.execute(f'delete from {db_name}')


def main():
    with db_connect.ConnectionCursor() as cursor:

        airports = """
        insert into Аэропорт.airport 
        (city, name)
        VALUES 
        (%s, %s)
        """

        airports_ids = list(range(10))
        for id in airports_ids:
            name = f'name {id}'
            city = 'Москва' if id < 5 else 'Саратов'
            arr = (city, name)
            cursor.execute(airports, arr)

if __name__ == '__main__':
    main()