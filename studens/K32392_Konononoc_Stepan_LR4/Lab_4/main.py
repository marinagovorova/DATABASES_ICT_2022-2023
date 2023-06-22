from flask import Flask, render_template, url_for, request, redirect
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:1111@localhost:5432/Lab_1'

db = SQLAlchemy(app)


class Customer(db.Model):
    __tablename__ = 'customer'
    __table_args__ = {'schema': 'projects'}
    id = db.Column(db.Integer, primary_key=True)
    organization_name = db.Column(db.String(80), nullable=False)
    organization_address = db.Column(db.String(200), nullable=False)
    contacts = db.Column(db.String(12), nullable=False)
    full_name = db.Column(db.String(70), nullable=False)

    def __repr__(self):
        return f'<Customer {self.id}>'


@app.route('/')
def index():
    return render_template("index.html")


@app.route('/customers')
def show_customers():
    customers = Customer.query.all()
    return render_template("show_customers.html", customers=customers)


@app.route('/customers/delete/<int:id>')
def delete_customer(id):
    customer = Customer.query.get_or_404(id)

    db.session.delete(customer)
    db.session.commit()
    return redirect('/customers')


@app.route('/customers/<int:id>', methods=['POST', 'GET'])
def edit_customer(id):
    customer = Customer.query.get_or_404(id)
    if request.method == "POST":
        customer.organization_name = request.form['organization_name']
        customer.organization_address = request.form['organization_address']
        customer.contacts = request.form['contacts']
        customer.full_name = request.form['full_name']
        try:
            db.session.commit()
            return redirect('/customers')
        except:
            return "При обновлении заказчика произошла ошибка"
    else:
        return render_template("customer_edit.html", customer=customer)


@app.route('/create_customer', methods=['POST', 'GET'])
def create_customer():
    if request.method == "POST":
        organization_name = request.form['organization_name']
        organization_address = request.form['organization_address']
        contacts = request.form['contacts']
        full_name = request.form['full_name']

        customer = Customer(organization_name=organization_name,
                            organization_address=organization_address,
                            contacts=contacts,
                            full_name=full_name)
        try:
            db.session.add(customer)
            db.session.commit()
            return redirect('/customers')
        except:
            return "При добаление заказчика произошла ошибка"
    else:
        return render_template("create_customer.html")


if __name__ == '__main__':
    app.run(debug=True)
