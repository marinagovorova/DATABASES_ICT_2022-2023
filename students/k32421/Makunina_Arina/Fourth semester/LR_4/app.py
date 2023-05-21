import psycopg2
from flask import Flask, render_template, request, redirect, flash

app = Flask(__name__)
app.secret_key = 'my_secret_key'

# подключаемся к базе данных
conn = psycopg2.connect(
    host='localhost',
    database='Airport',
    user='postgres',
    password='2512',
    port=5433
)

# определяем курсор
cur = conn.cursor()


# определяем функции для выполнения CRUD-операций

# функция для создания новой записи
def create_passenger(passports_pass, full_name_pass):
    try:
        cur.execute("INSERT INTO airport.passenger(passports_pass, full_name_pass) VALUES (%s, %s)",
                    (passports_pass, full_name_pass))
        conn.commit()
        flash('Passenger added successfully!')
    except psycopg2.Error as e:
        conn.rollback()  # откатываем изменения в БД
        flash(f'Error: {str(e)}')


# функция для чтения данных из таблицы
def read_passenger():
    cur.execute("SELECT * FROM airport.passenger order by passports_pass")
    return cur.fetchall()


# функция для обновления данных в таблице
def update_passenger(passports_pass, new_full_name_pass):
    try:
        # Проверяем, существует ли запись с указанным номером паспорта
        cur.execute("SELECT * FROM airport.passenger WHERE passports_pass = %s", (passports_pass,))
        if existing_passenger := cur.fetchone():
            # Обновляем имя пассажира
            cur.execute("UPDATE airport.passenger SET full_name_pass = %s WHERE passports_pass = %s",
                        (new_full_name_pass, passports_pass))
            conn.commit()
            flash('Passenger updated successfully!')
        else:
            flash('Passenger not found.')
    except psycopg2.Error as e:
        conn.rollback()
        flash(f'Error: {str(e)}')


# функция для удаления записи из таблицы
def delete_passenger(passports_pass):
    try:
        cur.execute("DELETE FROM airport.passenger WHERE passports_pass = %s", (passports_pass,))
        conn.commit()
        flash('Passenger deleted successfully!')
    except psycopg2.Error as e:
        conn.rollback()  # откатываем изменения в БД
        flash(f'Error: {str(e)}')


# определяем маршруты для нашего приложения
@app.route('/')
def index():
    # получаем все записи из таблицы и передаем их в шаблон
    passenger = read_passenger()
    return render_template('index.html', passenger=passenger)


@app.route('/create', methods=['POST'])
def create():
    # получаем данные из формы и создаем новую запись в таблице
    passports_pass = request.form['passports_pass']
    full_name_pass = request.form['full_name_pass']
    create_passenger(passports_pass, full_name_pass)
    return redirect('/')


@app.route('/update', methods=['POST'])
def update():
    try:
        # получаем данные из формы и обновляем запись в таблице
        passports_pass = request.form['passports_pass']
        new_full_name_pass = request.form['new_full_name_pass']
        update_passenger(passports_pass, new_full_name_pass)
        flash('Passenger updated successfully!')
    except Exception:
        flash('Error occurred while updating passenger.')

    return redirect('/')


@app.route('/delete', methods=['POST'])
def delete():
    # получаем данные из формы и удаляем запись из таблицы
    passports_pass = request.form['name']
    delete_passenger(passports_pass)
    return redirect('/')


# запускаем приложение
if __name__ == '__main__':
    app.run(debug=True)
