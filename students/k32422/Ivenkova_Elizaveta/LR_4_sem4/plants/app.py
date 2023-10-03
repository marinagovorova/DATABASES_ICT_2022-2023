from flask import Flask, render_template, redirect, url_for
from dataclasses import dataclass
from db_connection import ConnectionCursor
import db_queries
import forms

app = Flask(__name__)
app.config['SECRET_KEY'] = 'Come with me if you want to live'

@dataclass()
class SubmitMsgs():
    add_watering: str = ''
    change_watering: str = ''
    delete_watering: str = ''

submit_msgs = SubmitMsgs()


@app.route('/watering_info', methods=['GET'])
def watering_info():
    with ConnectionCursor() as cursor:
        cursor.execute('select * from watering_schedule order by watering_id')
        schedule_data = cursor.fetchall()
        watering_info = []
        for watering_id, user_plant_id, watering_time in schedule_data:
            name, surname, plant_name = db_queries.get_owner_and_plant_name(cursor, user_plant_id)
            watering_row = {}
            watering_row['watering_id'] = watering_id
            watering_row['user_plant_id'] = user_plant_id
            watering_row['name'] = name
            watering_row['surname'] = surname
            watering_row['plant_name'] = plant_name
            watering_row['watering_time'] = watering_time.strftime('%Y-%m-%d %H:%M:%S')

            watering_info.append(watering_row)

        return render_template('watering_info.html', watering_info=watering_info)


@app.route('/add_watering', methods=['GET', 'POST'])
def add_watering():
    form = forms.AddWateringForm()
    if form.is_submitted():
        if form.validate():
            with ConnectionCursor() as cursor:
                cursor.execute('select max(watering_id)+1 from watering_schedule')
                new_id = cursor.fetchone()[0]
                user_plant_id = form.user_plant_id.data
                watering_dt = form.watering_time.data
                cursor.execute('insert into watering_schedule(watering_id, user_plant_id, watering_time) values (%s, %s, %s)',
                               [new_id, user_plant_id, watering_dt])
                submit_msgs.add_watering = 'Запись добавлена'
        elif not form.watering_time.validate(form):
            submit_msgs.add_watering = 'Неверный формат даты. Попробуйте заново'
        return redirect(url_for('add_watering'))

    return render_template('add_watering.html',
                           form=form,
                           submit_msg=submit_msgs.add_watering)


@app.route('/delete_watering', methods=['POST', 'GET'])
def delete_watering():
    form = forms.DeleteWateringForm()
    if form.validate_on_submit():
        with ConnectionCursor() as cursor:
            delete_id = form.delete_id.data
            cursor.execute('delete from watering_schedule where watering_id=%s', [delete_id])
        submit_msgs.delete_watering = 'Запись удалена'
        return redirect(url_for('delete_watering'))
    return render_template('delete_watering.html',
                           form=form,
                           submit_msg=submit_msgs.delete_watering)


@app.route('/change_watering', methods=['POST', 'GET'])
def change_watering():
    form = forms.ChangeWateringForm()
    if form.is_submitted():
        if form.validate_on_submit():
            with ConnectionCursor() as cursor:
                change_id = form.watering_id.data
                new_date = form.new_date.data
                cursor.execute('update watering_schedule set watering_time=%s where watering_id=%s',
                               [new_date, change_id])
            submit_msgs.change_watering = 'Запись изменена'
        elif not form.new_date.validate(form):
            submit_msgs.change_watering = 'Неверный формат даты. Попробуйте заново'
        return redirect(url_for('change_watering'))

    return render_template('change_watering.html',
                           form=form,
                           submit_msg=submit_msgs.change_watering)


if __name__ == '__main__':
    app.run()
