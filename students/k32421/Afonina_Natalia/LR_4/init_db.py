import psycopg2
from flask import Flask, render_template, request, redirect

app = Flask(__name__)

# подключаемся к базе данных
conn = psycopg2.connect(
    host='localhost',
    database='Bank_Database',
    user='postgres',
    password='qwerty',
    port = 5433
)

# определяем курсор
cur = conn.cursor()

cur.execute('INSERT INTO "Bank_schema".client (id_client, id_information_client, name_client, email_client, address_client, phonenumber_client)'
            'VALUES (%s, %s, %s, %s, %s, %s)',
            ('4022345667',
             'Russia, St-Petersburg, 2002-08-08',
             'Ivan Ivanov',
             'ivan@gmail.com',
             'St-Petersburg',
             '+79110027426')
            )

conn.commit()

cur.close()
conn.close()