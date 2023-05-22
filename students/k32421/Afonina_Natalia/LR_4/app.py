import os
import psycopg2
from flask import Flask, render_template, request, url_for, redirect, flash

app = Flask(__name__)
app.secret_key = 'mysecretkey'


def get_db_connection():
    conn = psycopg2.connect(
        host='localhost',
        database='Bank_Database',
        user='postgres',
        password='qwerty',
        port=5433
    )
    return conn


@app.route('/')
def index():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT * FROM "Bank_schema".job ORDER BY id_job;')
    jobs = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('index.html', jobs=jobs)


@app.route('/create/', methods=('GET', 'POST'))
def create():
    if request.method == 'POST':
        id = request.form['id']
        name = request.form['name']
        salary = request.form['salary']
        responsibilities = request.form['responsibilities']

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('INSERT INTO "Bank_schema".job (id_job, name_job, salary, responsibilities)'
                    'VALUES (%s, %s, %s, %s);',
                    (int(id), name, float(salary), responsibilities))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('index'))

    return render_template('create.html')


def get_job_by_id(job_id):
    conn = get_db_connection()
    cur = conn.cursor()
    try:
        cur.execute('SELECT * FROM "Bank_schema".job WHERE id_job = %s;', (int(job_id),))
        job = cur.fetchone()
        cur.close()
        conn.close()
        return job
    except psycopg2.Error as e:
        cur.close()
        conn.close()
        return None


def update_job(job_id, name, salary, responsibilities):
    job = get_job_by_id(job_id)
    if not job:
        return f"Job with id = {job_id} does not exist"

    conn = get_db_connection()
    cur = conn.cursor()

    try:
        cur.execute(
            'UPDATE "Bank_schema".job SET name_job = %s, salary = %s, responsibilities = %s WHERE id_job = %s;',
            (name, float(salary), responsibilities, int(job_id)))
        conn.commit()
        cur.close()
        conn.close()
        return "Job updated successfully!"
    except psycopg2.Error as e:
        cur.close()
        conn.close()
        return f"Error updating job: {e}"


@app.route('/update', methods=['GET', 'POST'])
def update():
    if request.method == 'POST':
        job_id = int(request.form['job_id'])
        job = get_job_by_id(job_id)
        if job:
            return redirect(url_for('updatejobinfo', job_id=job_id))
        else:
            flash(f"Job with ID {job_id} does not exist", 'error')


    return render_template('update.html')


@app.route('/update/<int:job_id>', methods=['GET', 'POST'])
def updatejobinfo(job_id):
    if request.method == 'POST':
        name = request.form['name']
        salary = request.form['salary']
        responsibilities = request.form['responsibilities']

        result = update_job(job_id, name, salary, responsibilities)
        if result is None:
            flash(result, 'error')
            return redirect(url_for('updatejobinfo', job_id=job_id))

        flash(result, 'success')
        return redirect(url_for('index'))

    job = get_job_by_id(job_id)
    return render_template('updatejobinfo.html', job_id=job_id, job=job)


@app.route('/delete', methods=['POST'])
def delete():
    job_id = int(request.form['id'])

    conn = get_db_connection()
    cur = conn.cursor()
    try:
        cur.execute('DELETE FROM "Bank_schema".job WHERE id_job = %s;', (int(job_id),))
        conn.commit()
        cur.close()
        conn.close()
        flash('Job deleted successfully!', 'success')
    except psycopg2.Error as e:
        cur.close()
        conn.close()
        flash(f"Error deleting job: {e}", 'error')

    return redirect(url_for('index'))


@app.errorhandler(Exception)
def handle_error(e):
    app.logger.error(e)
    if isinstance(e, psycopg2.errors.UniqueViolation):
        message = 'Error: job with such ID already exists!'
    elif isinstance(e, ValueError):
        message = 'Error: incorrect data type!'
    else:
        message = 'Internal Server Error'

    return render_template('error.html', message=message), 500


if __name__ == '__main__':
    app.run(debug=True)
