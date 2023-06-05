from flask import Blueprint, render_template, abort, request, jsonify
import application.db_functions as dbf
import logging

tables_blueprint = Blueprint('tables', __name__, template_folder='templates')


def validate_json_keys(request_json, required_keys):
	if not request_json:
		abort(400, description="Invalid or Missing JSON in request")
	
	if not all(key in request_json for key in required_keys):
		abort(400, description="Missing required key(s) in JSON")


@tables_blueprint.errorhandler(Exception)
def handle_error(e):
	logging.error(f"Error: {e}")
	return jsonify(message=f"An error occurred: {e}"), 500


@tables_blueprint.route('/tables/<name>')
def create(name: str):
	cols, rows = dbf.get_table_data(name)
	return render_template('datatable.jinja2', cols=cols, rows=rows, table_name=name, tables_info=dbf.GENERAL_INFO)


@tables_blueprint.route('/tables/operation/add', methods=['POST'])
def add_entry_to_table():
	request_json = request.json
	validate_json_keys(request_json, ["table_name", "table_data"])
	
	dbf.insert_entry(request_json["table_name"], request_json["table_data"])
	return jsonify(message='Entry was added!'), 200


@tables_blueprint.route('/tables/operation/get', methods=['POST'])
def get_table_entry():
	request_json = request.json
	validate_json_keys(request_json, ["table_name", "entry_id"])
	
	data = dbf.get_entry(request_json["table_name"], request_json["entry_id"])
	return jsonify(data), 200


@tables_blueprint.route('/tables/operation/update', methods=['POST'])
def update_entry_on_table():
	request_json = request.json
	validate_json_keys(request_json, ["table_name", "table_data"])
	
	dbf.update_entry(request_json["table_name"], request_json["table_data"])
	return jsonify(message='Entry was updated!'), 200


@tables_blueprint.route('/tables/operation/delete', methods=['POST'])
def delete_entry_on_table():
	request_json = request.json
	validate_json_keys(request_json, ["table_name", "entry_id"])
	
	dbf.delete_entry(request_json["table_name"], request_json["entry_id"])
	return jsonify(message='Entry was deleted!'), 200
