from flask import Flask, render_template
from flask_wtf import FlaskForm
from wtforms import StringField, SelectMultipleField, SubmitField, SelectField
from wtforms.validators import InputRequired

from db_connection import ConnectionCursor
from db_queries import get_persons_info, get_table_data

app = Flask(__name__)
app.config['SECRET_KEY'] = 'hard to guess string'



class RegisterForm(FlaskForm):
    name = StringField('Name:', validators=[InputRequired()])
    surname = StringField('Surname:', validators=[InputRequired()])
    about = StringField('About:', validators=[InputRequired()])
    education = SelectMultipleField('Educations:')
    job = SelectMultipleField('Job:')
    submit = SubmitField('Submit')

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        with ConnectionCursor() as cursor:
            cursor.execute('select id_education, name from education')
            education_names = cursor.fetchall()
            self.education.choices = education_names

            cursor.execute('select id_job, name from job')
            job_names = cursor.fetchall()
            self.job.choices = job_names





@app.route('/')
def main_page():  # put application's code here
    persons_info = get_persons_info()
    return render_template('main.html', persons_info=persons_info)


@app.route('/register', methods=['GET', 'POST'])
def register_page():
    form = RegisterForm()
    if form.data['submit']:
        name = form.name.data
        surname = form.surname.data
        about = form.about.data
        education_ids = form.education.data
        job_ids = form.job.data

        with ConnectionCursor() as cursor:
            cursor.execute('select max(id_person)+1 from person')
            person_id = cursor.fetchone()[0]

            person_q = '''insert into person(id_person, name, surname, about) 
                        values (%s, %s, %s, %s)
            '''
            cursor.execute(person_q, [person_id, name, surname, about])

            job_q = """
                insert into person_job(id_person, id_job, position) VALUES (%s, %s, %s)
            """
            for job_id in job_ids:
                cursor.execute(job_q, [person_id, job_id, 'junior'])

            education_q = """
                insert into person_education(id_person, id_education, is_finished) 
                VALUES (%s, %s, %s)
            """

            for education_id in education_ids:
                cursor.execute(education_q, [person_id, education_id, True])
    return render_template('register.html', form=form)



class AdminForm(FlaskForm):
    who_deletes = SelectField('Кого удаляем?')
    ids_str = StringField('Перечислите через запятую ID:', validators=[InputRequired()])
    submit = SubmitField('Submit')

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.who_deletes.choices = [('person', 'person'),
                                    ('education', 'education'),
                                    ('job', 'job')]


class DeleteUserForm(FlaskForm):
    delete_ids = SelectMultipleField('Каких пользователей удалим?')
    submit = SubmitField('Submit')

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        with ConnectionCursor() as cursor:
            cursor.execute('select id_person from person')
            ids = cursor.fetchall()
            ids = [i[0] for i in ids]
            self.delete_ids.choices = list(zip(ids, ids))



@app.route('/admin_page', methods=['GET', 'POST'])
def admin_page():
    # формат данных ((column names), [(row1), (row2)])

    form = DeleteUserForm()

    if form.data['submit']:
        with ConnectionCursor() as cursor:
            delete_ids = tuple(form.delete_ids.data)
            query = """delete from person where id_person in %s"""
            cursor.execute(query, [delete_ids])
        # Обновляем форму
        form = DeleteUserForm()

    with ConnectionCursor() as cursor:
        person_data = get_table_data(cursor, 'person')

    return render_template('admin.html',
                           person_data=person_data,
                           form=form)


if __name__ == '__main__':
    app.run()
