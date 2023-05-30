import psycopg2
import random
import datetime


worker_positions = [
    ["Водитель", 20_000],
    ["Старший водитель", 50_000]
]

workers = [
    ["Имя", "Фамилия", "Отчество", "+79107439027", "1234567890"],
    ["123", "444", "4124", "+79107439952", "0987654321"],
    ["421", "Bruh", "Last_name", "+79105259427", "0666644447"],
    ["Крутое имя", "Нереальная фамилия", "Бомбезное отчество", "+79109999027", "4214892184"]
]

shifts = [
    [datetime.datetime(2023, 3, 15, 9, 0, 0), datetime.datetime(2023, 3, 15, 17, 0, 0)]
]

rates = [
    ["Эконом", 1.2],
    ["Комфорт", 2.5],
    ["Бизнес", 5.0],
    ["Детский", 2.2]
]

car_types = [
    ["Logan", "Renault", datetime.date(2000, 12, 12), "Russia", "Седан", 50],
    ["miDo", "Datsun", datetime.date(2010, 1, 2), "Russia", "Седан", 40],
    ["a180", "Mercedes Benz", datetime.date(2021, 10, 10), "Germany", "Long", 80]
]

cars = [
    ["М842НК", 2_000_000, 3_000, "Вася Пупкин", datetime.date(2023, 1, 10)],
    ["А018АА", 20_000_000, 500, "Бандит", datetime.date(2022, 12, 15)],
    ["Х228АМ", 200_000_000, 5_000, "Бандит", datetime.date(2022, 12, 17)],
]

worker_shifts = [
    [datetime.datetime(2023, 3, 15, 9, 15, 0), "Опоздал"]
]

users = [
    ['Вася', 'Пупкин'],
    ['123421', '412421'],
    ['Alexey', '4124']
]

orders = [
    [datetime.datetime(2023, 3, 14, 9, 5), "Addr from", "Addr to", "По карте", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
    [datetime.datetime(2023, 3, 14, 9, 5), "Ул Пушкина, дом Колотушкина", "ИТМО Гривцова", "По карте", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
    [datetime.datetime(2023, 3, 14, 9, 5), "Example", "Example to", "Наличные", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
    [datetime.datetime(2023, 3, 14, 9, 5), "412421", "42141241", "СБП", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
    [datetime.datetime(2023, 3, 14, 9, 5), "214", "251521", "По карте", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
    [datetime.datetime(2023, 3, 14, 9, 5), "521521", "5215215", "По карте", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
    [datetime.datetime(2023, 3, 14, 9, 5), "Hello", "Hello to", "По карте", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
    [datetime.datetime(2023, 3, 14, 9, 5), "Я не знаю какой адрес написать)", "Ооооооочень длинный адрес", "По карте", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
    [datetime.datetime(2023, 3, 14, 9, 5), "Привет)", "Придумывать адреса - сложно", "Наличными", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
    [datetime.datetime(2023, 3, 14, 9, 5), "124", "МСГ", "По карте", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
    [datetime.datetime(2023, 3, 14, 9, 5), "Биржа", "Домой в кроватку", "По карте", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
    [datetime.datetime(2023, 3, 14, 9, 5), "СПБ", "Москва", "По карте", 1.14, datetime.datetime(2023, 3, 14, 9, 10), datetime.datetime(2023, 3, 14, 9, 20)],
]


def __execute_query(connection, query: str, data) -> int:
    cursor = connection.cursor()
    cursor.execute(query, data)
    id = cursor.fetchone()[0]
    connection.commit()
    return id


def create_tables(connection) -> None:
    with open('create_tables.sql', 'r') as file:
        cursor = connection.cursor()
        transaction = file.read()
        cursor.execute(transaction)
        connection.commit()


def create_worker_position(connection, data) -> int:
    query = """
        INSERT INTO worker_position (category, salary) VALUES (%s, %s) RETURNING id
    """
    return __execute_query(connection, query, data)


def create_worker(connection, data, position_id) -> int:
    query = """
        INSERT INTO worker (last_name, first_name, middle_name, phone_number, passport_number, position_id)
            VALUES (%s, %s, %s, %s, %s, %s) RETURNING id
    """
    return __execute_query(connection, query, data + [position_id])


def create_shift(connection, data) -> int:
    query = """
        INSERT INTO shift (time_from, time_to) VALUES (%s, %s) RETURNING id
    """
    return __execute_query(connection, query, data)


def create_rate(connection, data) -> int:
    query = """
        INSERT INTO rate (name, price_per_km) VALUES (%s, %s) RETURNING id
    """
    return __execute_query(connection, query, data)


def create_car_type(connection, data, rate_id) -> int:
    query = """
        INSERT INTO car_type (model, brand, construction_date, manufacturer_country, body, displacement, rate_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s) RETURNING id
    """

    return __execute_query(connection, query, data + [rate_id])


def create_car(connection, data, type_id) -> int:
    query = """
        INSERT INTO car (government_number, market_price, mileage, owner, maintenance_date, type_id)
            VALUES (%s, %s, %s, %s, %s, %s) RETURNING id
    """
    return __execute_query(connection, query, data + [type_id])


def create_worker_shift(connection, worker_id, shift_id, car_id, data) -> int:
    query = """
        INSERT INTO worker_shift (worker_id, shift_id, car_id, start_time, status) 
            VALUES (%s, %s, %s, %s, %s) RETURNING id
    """
    return __execute_query(connection, query, [worker_id, shift_id, car_id] + data)


def create_user(connection, data) -> int:
    query = """
        INSERT INTO usr (first_name, last_name) VALUES (%s, %s) RETURNING id
    """
    return __execute_query(connection, query, data)


def create_order(connection, user_id, worker_id, car_id, data) -> int:
    query = """
        INSERT INTO ordr (usr_id, worker_id, car_id, time_start_plan, address_from, 
        address_to, payment_format, distance_km, time_start_fact, time_end)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING id
    """
    return __execute_query(connection, query, [user_id, worker_id, car_id] + data)


if __name__ == "__main__":
    connection = psycopg2.connect(user='root',
                                  password='root',
                                  host='localhost',
                                  port='5432',
                                  database='taxi')

    # create tables if needed
    # create_tables(connection)
    worker_position_ids = [create_worker_position(connection, data) for data in worker_positions]
    worker_ids = [create_worker(connection, data, random.choice(worker_position_ids)) for data in workers]
    shift_ids = [create_shift(connection, data) for data in shifts]
    rate_ids = [create_rate(connection, data) for data in rates]
    car_type_ids = [create_car_type(connection, data, random.choice(rate_ids)) for data in car_types]
    car_ids = [create_car(connection, data, random.choice(car_type_ids)) for data in cars]
    worker_shift_ids = [create_worker_shift(connection, random.choice(worker_ids), random.choice(shift_ids),
                                            random.choice(car_ids), data) for data in worker_shifts]
    user_ids = [create_user(connection, data) for data in users]

    for _ in range(250):
        user_id = random.choice(user_ids)
        worker_id = random.choice(worker_ids)
        car_id = random.choice(car_ids)
        data = random.choice(orders)
        create_order(connection, user_id, worker_id, car_id, data)




