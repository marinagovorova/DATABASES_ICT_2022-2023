from flask_wtf import FlaskForm
from wtforms import SubmitField, SelectField, DateTimeField
from wtforms.validators import InputRequired, DataRequired

from db_connection import ConnectionCursor
import db_queries



class AddWateringForm(FlaskForm):
    user_plant_id = SelectField('Выберите цветок пользователя',
                                validators=[InputRequired()])
    watering_time = DateTimeField('Время полива в формате %Y-%m-%d %H:%M:%S',
                                  validators=[InputRequired()],
                                  format='%Y-%m-%d %H:%M:%S')
    submit = SubmitField('Добавить')

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        with ConnectionCursor() as cursor:
            cursor.execute('select user_plant_id from user_plant')
            # todo понять, что отвечает за визуальное отображение, а что за значение
            plant_ids = cursor.fetchall()
            plant_ids = [i[0] for i in plant_ids]
            labels = []
            for plant_id in plant_ids:
                name, surname, plant_name = db_queries.get_owner_and_plant_name(cursor, plant_id)
                label = f'{name} {surname} {plant_name}'
                labels.append(label)
            self.user_plant_id.choices = list(zip(plant_ids, labels))


class DeleteWateringForm(FlaskForm):
    delete_id = SelectField('Выберите id полива для удаления:', validators=[InputRequired()])
    submit = SubmitField('Удалить', validators=[InputRequired()])

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        with ConnectionCursor() as cursor:
            cursor.execute('select watering_id from watering_schedule')
            id_tuples = cursor.fetchall()
            ids = [i[0] for i in id_tuples]
            self.delete_id.choices = list(zip(ids, ids))



class ChangeWateringForm(FlaskForm):
    watering_id = SelectField('Выберите id полива для изменения:',
                              validators=[InputRequired()])
    new_date = DateTimeField('Выберите новую дату полива:',
                             validators=[InputRequired()],
                             format='%Y-%m-%d %H:%M:%S')
    submit = SubmitField('Изменить')
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        with ConnectionCursor() as cursor:
            cursor.execute('select watering_id from watering_schedule')
            id_tuples = cursor.fetchall()
            ids = [i[0] for i in id_tuples]
            self.watering_id.choices = list(zip(ids, ids))