import os


class Config(object):
	SOURCE: dict = {
		'host': 'localhost',
		'database': 'auto_repair_shop',
		'user': 'postgres',
		'port': 5432,
		'password': os.environ.get('DB_PASSWORD'),
	}
	SCHEME: str = "auto_repair_shop"
