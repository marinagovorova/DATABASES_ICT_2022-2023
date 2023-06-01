import random
from faker import Faker
from datetime import timedelta

fake = Faker()

def write_to_file(filename, content):
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(content)

providers_count = 10
managers_count = 5
products_count = 20
shipments_count = 100
clients_count = 20
purchases_count = 50

Faker.seed(0)
random.seed(0)

# Providers
providers = "INSERT INTO provider (name_of_company, full_name, address) VALUES\n"
for i in range(providers_count):
    name_of_company = fake.company()
    full_name = fake.name()
    address = fake.address().replace('\n', ', ')
    providers += f"('{name_of_company}', '{full_name}', '{address}'){',' if i < providers_count - 1 else ';'}\n"
write_to_file("providers.sql", providers)

# Managers
managers = "INSERT INTO manager (full_name, position, contact_information) VALUES\n"
positions = ['Manager', 'Assistant Manager', 'Sales Manager', 'Marketing Manager', 'Operations Manager']
for i in range(managers_count):
    full_name = fake.name()
    position = random.choice(positions)
    contact_information = fake.phone_number()
    managers += f"('{full_name}', '{position}', '{contact_information}'){',' if i < managers_count - 1 else ';'}\n"
write_to_file("managers.sql", managers)

# Unit of measurements
unit_of_measurements = ['pcs', 'kg', 'g', 'l', 'ml', 'm']
unit_of_measurement = "INSERT INTO unit_of_measurement (name) VALUES\n"
for i, unit in enumerate(unit_of_measurements):
    unit_of_measurement += f"('{unit}'){',' if i < len(unit_of_measurements) - 1 else ';'}\n"
write_to_file("unit_of_measurement.sql", unit_of_measurement)

# Products
products = "INSERT INTO product (product_type, product_name, unit_of_measurement_id) VALUES\n"
product_types = ['Electronics', 'Grocery', 'Clothing', 'Toys', 'Furniture', 'Automotive']
for i in range(products_count):
    product_type = random.choice(product_types)
    product_name = fake.word().capitalize()
    unit_of_measurement_id = random.randint(1, len(unit_of_measurements))
    products += f"('{product_type}', '{product_name}', {unit_of_measurement_id}){',' if i < products_count - 1 else ';'}\n"
write_to_file("products.sql", products)

# Shipments, shipment_invoice, and shipment_content
shipments = "INSERT INTO shipment (provider_id, manager_id, invoice_creation_date, invoice_fulfillment_date, status) VALUES\n"
shipment_invoice = "INSERT INTO shipment_invoice (shipment_id, invoice_number, invoice_date, payment_date) VALUES\n"
shipment_content = "INSERT INTO shipment_content (shipment_id, product_id, remains, amount_of_goods, expiration_date, price) VALUES\n"

for i in range(shipments_count):
    provider_id = random.randint(1, providers_count)
    manager_id = random.randint(1, managers_count)
    invoice_creation_date = fake.date_between(start_date='-2y', end_date='today')
    invoice_fulfillment_date = fake.date_between(start_date=invoice_creation_date, end_date='today')
    status = random.choice(['completed', 'not completed'])
    shipments += f"({provider_id}, {manager_id}, '{invoice_creation_date}', '{invoice_fulfillment_date}', '{status}'){',' if i < shipments_count - 1 else ';'}\n"

    invoice_number = i + 1
    invoice_date = invoice_creation_date
    payment_date = fake.date_between(start_date=invoice_date + timedelta(days=1), end_date='today')
    shipment_invoice += f"({i + 1}, {invoice_number}, '{invoice_date}', '{payment_date}'){',' if i < shipments_count - 1 else ';'}\n"

    product_id = random.randint(1, products_count)
    remains = random.randint(1, 100)
    amount_of_goods = random.randint(1, 100)
    expiration_date = fake.date_between(start_date='today', end_date='+1y')
    price = random.randint(1, 1000)
    shipment_content += f"({i + 1}, {product_id}, {remains}, {amount_of_goods}, '{expiration_date}', {price}){',' if i < shipments_count - 1 else ';'}\n"

    write_to_file("shipments.sql", shipments)
write_to_file("shipment_invoice.sql", shipment_invoice)
write_to_file("shipment_content.sql", shipment_content)

# Clients
clients = "INSERT INTO client (full_name, organization_name, address) VALUES\n"
for i in range(clients_count):
    full_name = fake.name()
    organization_name = fake.company()
    address = fake.address().replace('\n', ', ')
    clients += f"('{full_name}', '{organization_name}', '{address}'){',' if i < clients_count - 1 else ';'}\n"
write_to_file("clients.sql", clients)

# Purchases, purchase_invoice, and purchase_content
purchases = "INSERT INTO purchase (client_id, manager_id, invoice_creation_date, invoice_fulfillment_date, status) VALUES\n"
purchase_invoice = "INSERT INTO purchase_invoice (purchase_id, invoice_number, invoice_date, payment_date) VALUES\n"
purchase_content = "INSERT INTO purchase_content (purchase_id, product_id, amount_of_goods, expiration_date, price) VALUES\n"

for i in range(purchases_count):
    client_id = random.randint(1, clients_count)
    manager_id = random.randint(1, managers_count)
    invoice_creation_date = fake.date_between(start_date='-2y', end_date='today')
    invoice_fulfillment_date = fake.date_between(start_date=invoice_creation_date, end_date='today')
    status = random.choice(['completed', 'not completed'])
    purchases += f"({client_id}, {manager_id}, '{invoice_creation_date}', '{invoice_fulfillment_date}', '{status}'){',' if i < purchases_count - 1 else ';'}\n"

    invoice_number = i + 1
    invoice_date = invoice_creation_date
    payment_date = fake.date_between(start_date=invoice_date + timedelta(days=1), end_date='today')
    purchase_invoice += f"({i + 1}, {invoice_number}, '{invoice_date}', '{payment_date}'){',' if i < purchases_count - 1 else ';'}\n"
    product_id = random.randint(1, products_count)
    amount_of_goods = random.randint(1, 100)
    expiration_date = fake.date_between(start_date='today', end_date='+1y')
    price = random.randint(1, 1000)
    purchase_content += f"({i + 1}, {product_id}, {amount_of_goods}, '{expiration_date}', {price}){',' if i < purchases_count - 1 else ';'}\n"

write_to_file("purchases.sql", purchases)
write_to_file("purchase_invoice.sql", purchase_invoice)
write_to_file("purchase_content.sql", purchase_content)
