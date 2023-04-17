import random

import db_connect
import calendar
import random
from datetime import date, timedelta, time


def empty_db(cursor, db_name):
    cursor.execute(f'delete from {db_name}')

start_date = date(2020, 1, 1)
end_date = date(2021, 12, 31)
random_days = random.randint(0, (end_date - start_date).days)

def main():
    with db_connect.ConnectionCursor() as cursor:

        # airports = """
        # insert into Аэропорт.airport 
        # (city, name)
        # VALUES 
        # (%s, %s)
        # """

        # airports_ids = list(range(10))
        # for id in airports_ids:
        #     name = f'name {id}'
        #     city = 'Москва' if id < 5 else 'Саратов'
        #     arr = (city, name)
        #     cursor.execute(airports, arr)

        transit = """
        insert into Аэропорт.transit 
        (id, id_airport, fly_time)
        VALUES 
        (%s, %s, %s)
        """

        transit_ids = list(range(10))
        for id in transit_ids:
            id = id
            id_airport = id + 1
            fly_time = time(hour=12, minute=30)
            arr = (id, id_airport, fly_time)
            cursor.execute(transit, arr)

        flight = """
        insert into Аэропорт.flight 
        (id, date, variant, id_transit)
        VALUES 
        (%s, %s, %s, %s)
        """

        flight_ids = list(range(10))
        for id in flight_ids:
            id = f'{id}'
            date = start_date + timedelta(days=random_days)
            variant = 'home'
            id_transit = f'{id}'
            arr = (id, date, variant, id_transit)
            cursor.execute(flight, arr)


        crew = """
        insert into Аэропорт.crew 
        (id, passport, id_flight, health_check, access, health_check_date)
        VALUES 
        (%s, %s, %s, %s, %s, %s)
        """
        crew_ids = list(range(10))
        for id in crew_ids:
            id = id
            passport = f'{id * 23223113}'
            id_flight = f'{id}'
            health_check = True if id % 2 == 1 else False
            access = True if id % 2 == 1 else False
            health_check_date = start_date + timedelta(days=random_days)
            arr = (id, passport, id_flight, health_check, access, health_check_date)
            cursor.execute(crew, arr)

    

    

if __name__ == '__main__':
    main()