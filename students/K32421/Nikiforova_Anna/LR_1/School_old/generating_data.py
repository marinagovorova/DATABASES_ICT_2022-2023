from mimesis import Person, Address
from mimesis.locales import Locale
from mimesis.enums import Gender
import random
from marshmallow import Schema, fields
from dataclasses import dataclass
import typing as tp
from datetime import datetime, date, time


def generate_students(n=1):
    # (student_code, full_name, birth_date, address, phone_number, email)
    deck = list(range(1, 2147))
    random.shuffle(deck)
    student_code = [deck[i] for i in range(n)]
    full_name = []
    phone_number = []
    email = []
    for _ in range(n):
        person = Person(Locale.RU)
        full_name.append(person.full_name(gender=Gender.FEMALE if random.randint(0, 1) else Gender.MALE, reverse=True))

        phone_number.append(person.telephone(mask="+7##########") if random.randint(0, 1) else None)
        email.append(person.email() if random.randint(0, 1) else None)
    birth_date = [date(random.choice(list(range(2005, 2013))), random.choice(list(range(1, 13))),
                       random.choice(list(range(1, 29)))) for _ in range(n)]
    address = [f"Россия, Ивановская область, Иваново, {Address(locale=Locale.RU).address()}" if random.randint(0, 1)
               else None for _ in range(n)]
    l = [student_code, full_name, birth_date, address, phone_number, email]
    return list(map(list, zip(*l)))


def generate_teachers(n=1):
    # (teacher_personnel_number, full_name, birth_date, address, phone_number, email, passport_number)
    deck = list(range(1, 2147))
    random.shuffle(deck)
    teacher_personnel_number = [deck[i] for i in range(n)]
    full_name = []
    phone_number = []
    email = []
    for _ in range(n):
        person = Person(Locale.RU)
        full_name.append(person.full_name(gender=Gender.FEMALE if random.randint(0, 1) else Gender.MALE, reverse=True))

        phone_number.append(person.telephone(mask="+7##########") if random.randint(0, 1) else None)
        email.append(person.email() if random.randint(0, 1) else None)
    birth_date = [date(random.choice(list(range(1960, 2000))), random.choice(list(range(1, 13))),
                       random.choice(list(range(1, 29)))) for _ in range(n)]
    address = [f"Россия, Ивановская область, Иваново, {Address(locale=Locale.RU).address()}" if random.randint(0, 1)
               else None for _ in range(n)]
    passport_number = [f"{random.choice(list(range(1000, 9999)))} {random.choice(list(range(100000, 999999)))}"
                       for _ in range(n)]
    l = [teacher_personnel_number, full_name, birth_date, address, phone_number, email, passport_number]
    return list(map(list, zip(*l)))


def generate_classes(n=1):
    # (class_id: auto, class_name, status)
    all_classes = [f"{a}{b}" for b in 'АБВ' for a in range(5, 12)]
    class_name = [random.choice(all_classes) for _ in range(n)]
    status = [random.choice(['Действует', 'Формируется', 'Расформирован']) for _ in range(n)]
    l = [class_name, status]
    return list(set((map(tuple, zip(*l)))))


def generate_classrooms(n=1):
    # (classroom_number, classroom_specialization: nope, having_projector, number_of_seats)
    nums = list(range(1, 50))
    random.shuffle(nums)
    classroom_number = nums[:n]
    having_projector = [random.choice([True, False]) for _ in range(n)]
    number_of_seats = [random.choice([30, 32]) for _ in range(n)]
    l = [classroom_number, having_projector, number_of_seats]
    return list(set((map(tuple, zip(*l)))))


if __name__ == "__main__":
    l = generate_classes(5)
    print(l)

