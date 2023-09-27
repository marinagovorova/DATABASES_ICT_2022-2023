import psycopg2
from flask import Flask, render_template, request, redirect, flash

app = Flask(__name__)
app.secret_key = 'my_secret_key'

conn = psycopg2.connect(
    host='localhost',
    database='client',
    user='postgres',
    password='password',
    port=5432
)


cur = conn.cursor()


def create_client(passportnumber, fullname, phonenumber, emailaddress):
    try:
        cur.execute(
            "INSERT INTO client(passportnumber, fullname, phonenumber, emailaddress) VALUES (%s, %s, %s, %s)",
            (passportnumber, fullname, phonenumber, emailaddress))
        conn.commit()
    except psycopg2.Error as e:
        conn.rollback()  # откатываем изменения в БД
        flash(f'Error: {str(e)}')


# функция для чтения данных из таблицы
def read_client():
    cur.execute("SELECT * FROM client order by passportnumber")
    return cur.fetchall()


# функция для обновления данных в таблице
def update_client(passportnumber, new_fullname, new_phonenumber, new_emailaddress):
    try:
        # Проверяем, существует ли запись с указанным номером паспорта
        cur.execute("SELECT * FROM client WHERE passportnumber = %s", (passportnumber,))
        if existing_client := cur.fetchone():
            # Обновляем имя пассажира
            cur.execute("UPDATE client SET fullname = %s, phonenumber = %s, emailaddress = %s WHERE passportnumber = %s",
                        (new_fullname, new_phonenumber, new_emailaddress, passportnumber))
            conn.commit()
        else:
    except psycopg2.Error as e:
        conn.rollback()
        flash(f'Error: {str(e)}')


# функция для удаления записи из таблицы
def delete_client(passportnumber):
    try:
        cur.execute("DELETE FROM client WHERE passportnumber = %s", (passportnumber,))
        conn.commit()
    except psycopg2.Error as e:
        conn.rollback()  # откатываем изменения в БД
        flash(f'Error: {str(e)}')


# определяем маршруты для нашего приложения
@app.route('/')
def index():
    # получаем все записи из таблицы и передаем их в шаблон
    client = read_client()
    return render_template('index.html', client=client)


@app.route('/create', methods=['POST'])
def create():
    # получаем данные из формы и создаем новую запись в таблице
    passportnumber = request.form['passportnumber']
    fullname = request.form['fullname']
    phonenumber = request.form['phonenumber']
    emailaddress = request.form['emailaddress']
    create_client(passportnumber, fullname, phonenumber, emailaddress)
    return redirect('/')


@app.route('/update', methods=['POST'])
def update():
    try:
        # получаем данные из формы и обновляем запись в таблице
        passportnumber = request.form['passportnumber']
        new_fullname = request.form['new_fullname']
        new_phonenumber = request.form['new_phonenumber']
        new_emailaddress = request.form['new_emailaddress']
        update_client(passportnumber, new_fullname, new_phonenumber, new_emailaddress)
    except Exception:
        flash('Error occurred while updating client.')

    return redirect('/')


@app.route('/delete', methods=['POST'])
def delete():
    # получаем данные из формы и удаляем запись из таблицы
    passportnumber = request.form['passportnumber']
    delete_client(passportnumber)
    return redirect('/')


# запускаем приложение
if __name__ == '__main__':
    app.run(debug=True)