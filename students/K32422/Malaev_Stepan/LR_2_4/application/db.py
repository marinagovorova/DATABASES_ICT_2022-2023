import psycopg2
import logging
from config import Config


class Database:
	_instance = None
	
	def __new__(cls):
		if cls._instance is None:
			cls._instance = super(Database, cls).__new__(cls)
		return cls._instance
	
	def __init__(self):
		self.scheme = Config.SCHEME
		self._connection = self.connect_to_database()
	
	def connect_to_database(self):
		"""
		Connects to the database using the parameters from Config.
		"""
		return psycopg2.connect(**Config.SOURCE)
	
	def get_cursor(self):
		"""
		Returns a cursor from the database connection.
		"""
		try:
			return self._connection.cursor()
		except Exception as e:
			logging.error(f"An error occurred while getting cursor: {e}")
			raise
	
	def commit(self):
		"""
		Commits the current transaction.
		"""
		try:
			self._connection.commit()
		except Exception as e:
			logging.error(f"An error occurred while committing: {e}")
			raise
	
	def rollback(self):
		"""
		Rolls back the current transaction.
		"""
		try:
			self._connection.rollback()
		except Exception as e:
			logging.error(f"An error occurred while rolling back: {e}")
			raise


# Singleton
db_instance = Database()
