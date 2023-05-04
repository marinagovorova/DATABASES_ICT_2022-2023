import sqlite3
from bottle import route, run, debug, template, request, static_file, error

# only needed when you run Bottle on mod_wsgi
from bottle import default_app


@route('/readers')
def readers_list():
    conn = sqlite3.connect('todo.db')
    c = conn.cursor()
    c.execute("SELECT id, name, surname, birthday FROM readers")
    result = c.fetchall()
    c.close()

    output = template('make_readers', rows=result)
    return output


@route('/books')
def books_list():
    conn = sqlite3.connect('todo.db')
    c = conn.cursor()
    c.execute("SELECT * FROM books")
    result = c.fetchall()
    c.close()

    output = template('make_books', rows=result)
    return output


@route('/take')
def take_list():
    conn = sqlite3.connect('todo.db')
    c = conn.cursor()
    c.execute("SELECT * FROM take1")
    result = c.fetchall()
    c.close()

    output = template('make_take', rows=result)
    return output


@route('/newreader', method='GET')
def new_reader():

    if request.GET.save:

        new1 = request.GET.name.strip()
        new2 = request.GET.surname.strip()
        new3 = request.GET.birthday.strip()

        conn = sqlite3.connect('todo.db')
        c = conn.cursor()

        c.execute("INSERT INTO readers (name, surname, birthday) VALUES (?,?,?)", (new1, new2, new3))
        new_id = c.lastrowid

        conn.commit()
        c.close()
        return '<p>The new reader was inserted into the database, the ID is %s</p>' % new_id
    else:
        return template('new_reader.tpl')


@route('/newbook', method='GET')
def new_book():

    if request.GET.save:

        new1 = request.GET.name.strip()
        new2 = request.GET.author_name.strip()

        conn = sqlite3.connect('todo.db')
        c = conn.cursor()

        c.execute("INSERT INTO books (name, author_name) VALUES (?,?)", (new1, new2))
        new_id = c.lastrowid

        conn.commit()
        c.close()
        return '<p>The new book was inserted into the database, the ID is %s</p>' % new_id
    else:
        return template('new_book.tpl')


@route('/newtake', method='GET')
def new_take():

    if request.GET.save:

        new1 = request.GET.reader_id.strip()
        new2 = request.GET.book_id.strip()
        new3 = request.GET.date.strip()

        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        check1 = c.execute("SELECT id FROM books WHERE id = ?", new2)
        ch1 = check1.fetchall()
        if ch1:
            check2 = c.execute("SELECT id FROM readers WHERE id = ?", new1)
            ch2 = check2.fetchall()
            if ch2:
                c.execute("INSERT INTO take1 (reader_id, book_id, date) VALUES (?,?,?)", (new1, new2, new3))
                new_id = c.lastrowid
                conn.commit()
                c.close()
                return '<p>The new take was inserted into the database, the ID is %s</p>' % new_id
            else:
                c.close()
                return 'No such id in readers'
        else:
            c.close()
            return 'No such id in books'

    else:
        return template('new_take.tpl')


@route('/updatereader/<no:int>', method='GET')
def update_reader(no):
    if request.GET.save:

        update_name = request.GET.name.strip()
        update_surname = request.GET.surname.strip()
        update_birthday = request.GET.birthday.strip()

        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("UPDATE readers SET name = ?, surname = ?, birthday = ? WHERE id LIKE ?", (update_name, update_surname, update_birthday, no))
        conn.commit()

        return '<p>The item number %s was successfully updated</p>' % no
    else:
        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("SELECT name, surname, birthday FROM readers WHERE id LIKE ?", (str(no)))
        cur_data = c.fetchone()
        return template('update_reader', old=cur_data, no=no)


@route('/updatebook/<no:int>', method='GET')
def update_book(no):
    if request.GET.save:

        update_name = request.GET.name.strip()
        update_author = request.GET.author_name.strip()

        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("UPDATE books SET name = ?, author_name = ? WHERE id LIKE ?", (update_name, update_author, no))
        conn.commit()

        return '<p>The item number %s was successfully updated</p>' % no
    else:
        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("SELECT name, author_name FROM books WHERE id LIKE ?", (str(no)))
        cur_data = c.fetchone()

        return template('update_book', old=cur_data, no=no)


@route('/updatetake/<no:int>', method='GET')
def update_take(no):
    if request.GET.save:

        update_reader = request.GET.reader_id.strip()
        update_book = request.GET.book_id.strip()
        update_date = request.GET.date.strip()

        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        check1 = c.execute("SELECT id FROM books WHERE id = ?", update_book)
        ch1 = check1.fetchall()
        if ch1:
            check2 = c.execute("SELECT id FROM readers WHERE id = ?", update_reader)
            ch2 = check2.fetchall()
            if ch2:
                c.execute("UPDATE take1 SET reader_id = ?, book_id = ?, date = ? WHERE id LIKE ?", (update_reader, update_book, update_date, no))
                conn.commit()
                c.close()
                return '<p>The item number %s was successfully updated</p>' % no
            else:
                c.close()
                return 'No such id in readers'
        else:
            c.close()
            return 'No such id in books'

    else:
        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("SELECT reader_id, book_id, date FROM take1 WHERE id LIKE ?", (str(no)))
        cur_data = c.fetchone()

        return template('update_take', old=cur_data, no=no)


@route('/deletereader/<no:int>', method='GET')
def delete_reader(no):
    if request.GET.save:
        delete = request.GET.delete.strip()
        print(delete)
        if delete == 'yes':
            conn = sqlite3.connect('todo.db')
            c = conn.cursor()
            ch = c.execute("SELECT id FROM take1 WHERE reader_id=(?)", (no,))
            n = ch.fetchone()
            if n:
                c.execute("DELETE FROM take1 WHERE reader_id=(?)", (no,))
            c.execute("DELETE FROM readers WHERE id=(?)", (no,))
            conn.commit()
            return '<p>The reader %s was successfully deleted</p>' % no
        else:
            return 'Nothing was deleted'
    else:
        #conn = sqlite3.connect('todo.db')
        #c = conn.cursor()
        #c.execute("SELECT id FROM take1 WHERE id LIKE ?", (str(no)))
        #n = c.fetchone()
        #print(no, n)
        return template('delete_reader', no=no)


@route('/deletebook/<no:int>', method='GET')
def delete_book(no):
    if request.GET.save:
        delete = request.GET.delete.strip()
        print(delete)
        if delete == 'yes':
            conn = sqlite3.connect('todo.db')
            c = conn.cursor()
            ch = c.execute("SELECT id FROM take1 WHERE book_id=(?)", (no,))
            n = ch.fetchone()
            if n:
                c.execute("DELETE FROM take1 WHERE book_id=(?)", (no,))
            c.execute("DELETE FROM books WHERE id=(?)", (no,))
            conn.commit()
            return '<p>The book %s was successfully deleted</p>' % no
        else:
            return 'Nothing was deleted'
    else:
        return template('delete_book', no=no)


@route('/deletetake/<no:int>', method='GET')
def delete_take(no):
    if request.GET.save:
        delete = request.GET.delete.strip()
        print(delete)
        if delete == 'yes':
            conn = sqlite3.connect('todo.db')
            c = conn.cursor()
            c.execute("DELETE FROM take1 WHERE id=(?)", (no,))
            conn.commit()
            return '<p>The taking %s was successfully deleted</p>' % no
        else:
            return 'Nothing was deleted'
    else:
        return template('delete_take', no=no)


@route('/help')
def help():
    static_file('help.html', root='.')
    

@route('/json<json:re:[0-9]+>')
def show_json(json):
    conn = sqlite3.connect('todo.db')
    c = conn.cursor()
    c.execute("SELECT task FROM todo WHERE id LIKE ?", (json,))
    result = c.fetchall()
    c.close()

    if not result:
        return {'task': 'This item number does not exist!'}
    else:
        return {'task': result[0]}


@error(403)
def mistake403(code):
    return 'There is a mistake in your url!'


@error(404)
def mistake404(code):
    return 'Sorry, that page does not exist!'

#debug(True)
run(reloader=True)