from pprint import pprint
from .db import db_instance
import logging


def get_general_info():
	"""
	Retrieve the general information from the database
	"""
	try:
		with db_instance.get_cursor() as cursor:
			cursor.execute(
				"""
				SELECT tables.table_name,
				       columns.column_name AS primary_key
				FROM information_schema.tables AS tables
				         LEFT JOIN
				     information_schema.table_constraints AS table_constraints
				     ON
				                 table_constraints.table_schema = tables.table_schema
				             AND table_constraints.table_name = tables.table_name
				             AND table_constraints.constraint_type = 'PRIMARY KEY'
				         LEFT JOIN
				     information_schema.key_column_usage AS key_column_usage
				     ON
				                 key_column_usage.table_schema = table_constraints.table_schema
				             AND key_column_usage.table_name = table_constraints.table_name
				             AND key_column_usage.constraint_name = table_constraints.constraint_name
				         LEFT JOIN
				     information_schema.columns AS columns
				     ON
				                 columns.table_schema = key_column_usage.table_schema
				             AND columns.table_name = key_column_usage.table_name
				             AND columns.column_name = key_column_usage.column_name
				WHERE tables.table_schema = %s
				  AND tables.table_type = 'BASE TABLE'
				ORDER BY 1;
				""",
				(db_instance.scheme,)
			)
			fetch = cursor.fetchall()
		return dict(fetch)
	except Exception as e:
		logging.error(f"An error occurred while getting general info: {e}")
		raise


GENERAL_INFO: dict = get_general_info()


def get_table_data(table_name: str):
	"""
	Retrieve table data given a table name
	"""
	try:
		with db_instance.get_cursor() as cursor:
			cursor.execute(
				"SELECT * FROM {}.\"{}\" ORDER BY 1".format(db_instance.scheme, table_name)
			)
			cols = [desc.name for desc in cursor.description]
			rows = cursor.fetchall()
		return cols, rows
	except Exception as e:
		logging.error(f"An error occurred while getting data from table {table_name}: {e}")
		raise


def insert_entry(table_name: str, table_data: dict):
	"""
	Insert data into a table given the table name and the data
	"""
	try:
		columns = ', '.join(table_data.keys())
		placeholders = ', '.join(['%s' for _ in table_data])
		
		with db_instance.get_cursor() as cursor:
			cursor.execute(
				"INSERT INTO {}.\"{}\" ({}) VALUES ({})".format(db_instance.scheme, table_name, columns, placeholders),
				tuple(table_data.values())
			)
		
		db_instance.commit()
	except Exception as e:
		db_instance.rollback()
		logging.error(f"An error occurred while inserting data into table {table_name}: {e}")
		raise


def get_entry(table_name: str, entry_id: int | str):
	"""
	Retrieve entry data given a table name and an entry id
	"""
	try:
		with db_instance.get_cursor() as cursor:
			pk = GENERAL_INFO[table_name]
			cursor.execute(
				"SELECT * FROM {}.\"{}\" WHERE {} = %s".format(db_instance.scheme, table_name, pk),
				(entry_id,)
			)
			cols = [desc.name for desc in cursor.description]
			row = cursor.fetchone()
		
		return dict(zip(cols, row))
	except Exception as e:
		logging.error(f"An error occurred while getting data from {table_name} where entry_id = {entry_id}: {e}")
		raise


def update_entry(table_name: str, table_data: dict):
	"""
	Update entry given the table name and the data
	"""
	try:
		pk = GENERAL_INFO[table_name]
		pk_value = table_data.pop(pk)
		
		columns = ', '.join("\"{}\" = %s".format(col) for col in table_data.keys())
		with db_instance.get_cursor() as cursor:
			cursor.execute(
				"UPDATE {}.\"{}\" SET {} WHERE \"{}\" = %s".format(db_instance.scheme, table_name, columns, pk),
				(*table_data.values(), pk_value)
			)
		db_instance.commit()
	except Exception as e:
		db_instance.rollback()
		entry_id = table_data[GENERAL_INFO[table_name]]
		logging.error(f"An error occurred while updating data from {table_name} where entry_id = {entry_id}: {e}")
		raise


def delete_entry(table_name: str, entry_id: int):
	"""
	Delete entry given the table name and the data
	"""
	try:
		pk = GENERAL_INFO[table_name]
		with db_instance.get_cursor() as cursor:
			cursor.execute(
				"DELETE FROM {}.\"{}\" WHERE \"{}\" = %s".format(db_instance.scheme, table_name, pk),
				(entry_id,)
			)
		db_instance.commit()
	except Exception as e:
		db_instance.rollback()
		entry_id = table_data[GENERAL_INFO[table_name]]
		logging.error(f"An error occurred while deleting entry from {table_name} where entry_id = {entry_id}: {e}")
		raise
