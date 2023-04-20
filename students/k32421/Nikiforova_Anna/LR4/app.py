from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.exc import IntegrityError
from datetime import date, datetime, timedelta

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///octobot.sqlite'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
app.app_context().push()


class MyDate(db.TypeDecorator):
    impl = db.Date

    def process_bind_param(self, value, dialect):
        if type(value) is str:
            return datetime.strptime(value, '%Y-%m-%d')
        return value


class Instructor(db.Model):
    __tablename__ = 'instructor'

    def __init__(self, name, isu=None, email=None, telegram=None):
        self.name = name
        self.isu = isu
        self.email = email
        self.telegram = telegram

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(250), nullable=False)
    isu = db.Column(db.String(300))
    email = db.Column(db.String(250))
    telegram = db.Column(db.String(50))
    subjects = db.relationship(
        'Subject',
        back_populates='instructor',
        cascade='save-update, merge, delete'
    )

    def __repr__(self):
        return f"Instructor({self.id}, {self.name}, {self.isu}, {self.email}, {self.telegram})"


class Subject(db.Model):
    __tablename__ = 'subject'

    def __init__(self, instructor_id, name, assessment_table=None):
        self.instructor_id = instructor_id
        self.name = name
        self.assessment_table = assessment_table

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    instructor_id = db.Column(db.Integer, db.ForeignKey('instructor.id', ondelete='CASCADE'))
    instructor = db.relationship("Instructor", back_populates='subjects')
    name = db.Column(db.String(250), nullable=False)
    assessment_table = db.Column(db.String(300))
    tasks = db.relationship(
        'Task',
        back_populates='subject',
        cascade='save-update, merge, delete'
    )

    def __repr__(self):
        return f"Subject({self.id}, {self.instructor_id}, {self.name}, {self.assessment_table})"


class Task(db.Model):
    __tablename__ = 'task'

    def __init__(self, subject_id, name, deadline=(date.today() + timedelta(days=14)),
                 description=None, status="not started",
                 note=None):
        self.subject_id = subject_id
        self.name = name
        self.deadline = deadline
        self.description = description
        assert (status in ["not started", "in progress", "done"])
        self.status = status
        self.note = note

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    subject_id = db.Column(db.Integer, db.ForeignKey('subject.id', ondelete='CASCADE'))
    subject = db.relationship("Subject", back_populates='tasks')
    name = db.Column(db.String(250), nullable=False)
    deadline = db.Column(MyDate, default=(date.today() + timedelta(days=14)))
    description = db.Column(db.String(500))
    status = db.Column(db.String(12), nullable=False, default="not started")
    note = db.Column(db.String(500))

    def __repr__(self):
        return f"Task({self.id}, {self.subject_id}, {self.name}, {self.deadline}, {self.description}, {self.status}, " \
               f"{self.note})"


def initial_inserts():
    instructors_list = [
        ["Чернышева Анастасия Вадимовна",
         "https://isu.ifmo.ru/pls/apex/f?p=2143:PERSON:108214562555001::NO:RP:PID:182049",
         "avchernysheva@itmo.ru", "@avchernysheva"],
        ["Милованович Екатерина Воиславовна",
         "https://isu.ifmo.ru/pls/apex/f?p=2143:PERSON:108214562555001::NO:RP:PID:106026",
         "evmilovanovich@itmo.ru", None],
        ["Дмитракова Янина Александровна", None, "iadmitrakova@itmo.ru", None],
    ]
    for instructor in instructors_list:
        db.session.add(Instructor(*instructor))

    subjects_list = [
        [1, "Методы визуализации данных",
         "https://docs.google.com/spreadsheets/d/1QrV8MHMRSDXMxDKDLmsR9u_Ewyjljo6LsP4iN5pJfAU/edit#gid=0"],
        [2, "Теория вероятностей", None],
        [2, "Дискретная математика", None],
        [3, "Экология", None],
    ]
    for subject in subjects_list:
        db.session.add(Subject(*subject))

    tasks_list = [
        [1, "Разведочный анализ данных", date(2023, 4, 19), None, "done",
         "У субботней группы дедлайн в ближайшую субботу"],
        [1, "Проверка гипотез", date(2023, 5, 3), None, "not started", None],
        [3, "Типовик", None, None, "in progress", "Задания по вариантам из ИСУ"],
        [4, "Практика 5", date(2023, 4, 23), "Оценка рисков", "done", None]
    ]
    for task in tasks_list:
        db.session.add(Task(*task))

    db.session.commit()

###

def value_check(value: str):
    return None if value == '-' else value

###

@app.route("/instructors")
def instructors():
    instructors_list = Instructor.query.all()
    return render_template("instructors.html", instructors_list=instructors_list)


@app.route('/instructors/<int:instructor_id>')
def instructor_page(instructor_id):
    instructor = Instructor.query.get(instructor_id)
    return render_template('instructor.html', instructor=instructor)


@app.route('/instructors/<int:instructor_id>/delete', methods=['POST'])
def delete_instructor(instructor_id):
    instructor = Instructor.query.get(instructor_id)
    db.session.delete(instructor)
    db.session.commit()
    return redirect(url_for('instructors'))


@app.route('/instructors/<int:instructor_id>/edit', methods=['GET', 'POST'])
def edit_instructor(instructor_id):
    instructor = Instructor.query.get(instructor_id)
    if request.method == 'POST':
        instructor.name = value_check(request.form['name'])
        instructor.isu = value_check(request.form['isu'])
        instructor.email = value_check(request.form['email'])
        instructor.telegram = value_check(request.form['telegram'])
        db.session.commit()
        return redirect(url_for('instructor_page', instructor_id=instructor.id))
    return render_template('edit_instructor.html', instructor=instructor)


@app.route('/instructors/add', methods=['GET', 'POST'])
def add_instructor():
    if request.method == 'POST':
        try:
            instructor = Instructor(value_check(request.form['name']),
                                    value_check(request.form['isu']),
                                    value_check(request.form['email']),
                                    value_check(request.form['telegram']))
            db.session.add(instructor)
            db.session.commit()
        except IntegrityError:
            pass
        return redirect(url_for('instructors'))
    return render_template('edit_instructor.html', instructor=None)

###

@app.route("/subjects")
def subjects():
    subjects_list = Subject.query.all()
    return render_template("subjects.html", subjects_list=subjects_list)


@app.route("/subjects/<int:subject_id>")
def subject_page(subject_id):
    subject = Subject.query.get(subject_id)
    instructor = Instructor.query.get(subject.instructor_id)
    return render_template('subject.html', subject=subject, instructor=instructor)


@app.route('/subjects/<int:subject_id>/delete', methods=['POST'])
def delete_subject(subject_id):
    subject = Subject.query.get(subject_id)
    db.session.delete(subject)
    db.session.commit()
    return redirect(url_for('subjects'))


@app.route('/subjects/<int:subject_id>/edit', methods=['GET', 'POST'])
def edit_subject(subject_id):
    subject = Subject.query.get(subject_id)
    instructors_list = Instructor.query.all()
    if request.method == 'POST':
        subject.name = value_check(request.form['name'])
        subject.instructor_id = request.form['instructor_id']
        subject.assessment_table = value_check(request.form['assessment_table'])
        db.session.commit()
        return redirect(url_for('subject_page', subject_id=subject.id))
    return render_template('edit_subject.html', subject=subject, instructors_list=instructors_list)


@app.route('/subjects/add', methods=['GET', 'POST'])
def add_subject():
    instructors_list = Instructor.query.all()
    if request.method == 'POST':
        try:
            subject = Subject(request.form['instructor_id'],
                                    value_check(request.form['name']),
                                    value_check(request.form['assessment_table']))
            db.session.add(subject)
            db.session.commit()
        except IntegrityError:
            pass
        return redirect(url_for('subjects'))
    return render_template('edit_subject.html', subject=None, instructors_list=instructors_list)

###

@app.route("/tasks")
def tasks():
    tasks_list = Task.query.all()
    subjects_list = [Subject.query.get(task.subject_id) for task in tasks_list]
    return render_template("tasks.html", tasks_list=tasks_list, subjects_list=subjects_list)


@app.route("/tasks/<int:task_id>")
def task_page(task_id):
    task = Task.query.get(task_id)
    subject = Subject.query.get(task.subject_id)
    return render_template('task.html', task=task, subject=subject)


@app.route('/tasks/<int:task_id>/delete', methods=['POST'])
def delete_task(task_id):
    task = Task.query.get(task_id)
    db.session.delete(task)
    db.session.commit()
    return redirect(url_for('tasks'))


@app.route('/tasks/<int:task_id>/edit', methods=['GET', 'POST'])
def edit_task(task_id):
    task = Task.query.get(task_id)
    subjects_list = Subject.query.all()
    if request.method == 'POST':
        task.subject_id = request.form['subject_id']
        task.name = request.form['name']
        task.deadline = request.form['deadline']
        task.description = value_check(request.form['description'])
        task.status = request.form['status']
        task.note = value_check(request.form['note'])
        db.session.commit()
        return redirect(url_for('task_page', task_id=task.id))
    return render_template('edit_task.html', task=task, subjects_list=subjects_list)


@app.route('/tasks/add', methods=['GET', 'POST'])
def add_task():
    subjects_list = Subject.query.all()
    if request.method == 'POST':
        try:
            task = Task(request.form['subject_id'], request.form['name'],
                        request.form['deadline'], value_check(request.form['description']),
                        request.form['status'], value_check(request.form['note']))
            db.session.add(task)
            db.session.commit()
        except IntegrityError:
            pass
        return redirect(url_for('tasks'))
    return render_template('edit_task.html', task=None, subjects_list=subjects_list)


if __name__ == "__main__":
    db.create_all()
    #initial_inserts()
    app.run(debug=True)
