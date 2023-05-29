from psycopg2 import connect
from psycopg2.extensions import cursor as CursorClass
from config import Config
from typing import Optional


class ConnectionCursor:

    conn = None
    cursor: Optional[CursorClass]  = None

    def __enter__(self) -> CursorClass:
        try:
            self.conn = connect(
                    host=Config.host,
                    dbname=Config.database,
                    user=Config.username,
                    password=Config.pwd
                )
            self.conn.autocommit = True
            self.cursor = self.conn.cursor()
            return self.cursor
        except Exception as e:
            self.close_connections()
            raise e

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close_connections()

    def close_connections(self):
        if self.conn is not None:
            self.conn.close()
        if self.cursor is not None:
            self.cursor.close()