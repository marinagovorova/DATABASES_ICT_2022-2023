from flask import Flask
from .main.views import main_blueprint
from .tables.views import tables_blueprint


def create_app():
	app = Flask(__name__)
	app.register_blueprint(main_blueprint)
	app.register_blueprint(tables_blueprint)
	
	return app
