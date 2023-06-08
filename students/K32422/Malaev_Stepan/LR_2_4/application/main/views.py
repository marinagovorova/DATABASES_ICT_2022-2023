from flask import Blueprint, render_template
import application.db_functions as dbf

main_blueprint = Blueprint('main', __name__, template_folder='templates')


@main_blueprint.route('/')
def index():
	return render_template('index.jinja2', tables_info=dbf.GENERAL_INFO)
