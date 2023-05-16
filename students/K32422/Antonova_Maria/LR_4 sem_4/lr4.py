# # создание файла с данными
# import sqlite3
# conn = sqlite3.connect('students.db') # Warning: This file is created in the current directory
# conn.execute("CREATE TABLE students (id INTEGER PRIMARY KEY, student char(100) NOT NULL, status bool NOT NULL)")
# conn.execute("INSERT INTO students (student,status) VALUES ('Антонов Николай',0)")
# conn.execute("INSERT INTO students (student,status) VALUES ('Петров Иван',1)")
# conn.execute("INSERT INTO students (student,status) VALUES ('Иванов Дмитрий',1)")
# conn.execute("INSERT INTO students (student,status) VALUES ('Денисов Артем',0)")
# conn.commit()

import sqlite3
from bottle import run, route, debug, template,request, static_file,error

#создание таблицы со списком
@route('/students')
@route('/student_list')
def student_list():
    conn = sqlite3.connect('students.db')
    c = conn.cursor()
    c.execute("SELECT id, student FROM students WHERE status LIKE '1'") #вывод строк, где статус равен единице
    result = c.fetchall()
    c.close()
    output = template('make_table', rows=result)
    return output

#добавление новых задач
@route('/new', method='GET')
def new_item():

    if request.GET.save:

        new = request.GET.student.strip()
        conn = sqlite3.connect('students.db')
        c = conn.cursor()

        c.execute("INSERT INTO students (student,status) VALUES (?,?)", (new,1))
        new_id = c.lastrowid

        conn.commit()
        c.close()

        return '<p>The new student was inserted into the database, the ID is %s</p>' % new_id
    else:
        return template('new_student.tpl')

# изменение задач
@route('/edit/<no:int>', method='GET')
def edit_item(no):

    if request.GET.save:
        edit = request.GET.student.strip()
        status = request.GET.status.strip()

        if status == 'currently studying':
            status = 1
        else:
            status = 0

        conn = sqlite3.connect('students.db')
        c = conn.cursor()
        c.execute("UPDATE students SET student = ?, status = ? WHERE id LIKE ?", (edit, status, no))
        conn.commit()

        return '<p>The student number %s was successfully updated</p>' % no
    else:
        conn = sqlite3.connect('students.db')
        c = conn.cursor()
        c.execute("SELECT student FROM students WHERE id LIKE ?", (str(no),))
        cur_data = c.fetchone()

        return template('edit_student', old=cur_data, no=no)

#показывать определенную задачу
@route('/item<item:re:[0-9]+>')
def show_item(item):
    conn = sqlite3.connect('students.db')
    c = conn.cursor()
    c.execute("SELECT student FROM students WHERE id LIKE ?", (item,))
    result = c.fetchall()
    c.close()
    if not result:
        return 'This student number does not exist!'
    else:
        return 'Student: %s' % result[0]


@route('/delete/<no:int>', method='GET')
def delete_student(no):
    if request.GET.save:
        delete = request.GET.delete.strip()
        print(delete)
        if delete == 'yes':
            conn = sqlite3.connect('students.db')
            c = conn.cursor()
            c.execute("DELETE FROM students WHERE id=(?)", (no,))
            conn.commit()
            return '<p>The student %s was successfully deleted</p>' % no
        else:
            return 'Nothing was deleted'
    else:
        return template('delete_student', no=no)

#справка пользователей
@route('/help')
def help():
    return static_file('help.html', root='.') #находиться в текущей папке

#возврат данных в формате json для дальшейншего пользования в других программах
@route('/json<json:re:[0-9]+>')
def show_json(json):
    conn = sqlite3.connect('students.db')
    c = conn.cursor()
    c.execute("SELECT student FROM students WHERE id LIKE ?", (json,))
    result = c.fetchall()
    c.close()

    if not result:
        return {'student': 'This student number does not exist!'}
    else:
        return {'student': result[0]}

#в случае ошибки (403) вывод определенной фразы
@error(403)
def mistake403(code):
    return 'The parameter you passed has the wrong format!'

@error(404)
def mistake404(code):
    return 'Sorry, this page does not exist!'

@error(500)
def mistake500(code):
    return 'broken application'


debug(True)
run(port=8081)