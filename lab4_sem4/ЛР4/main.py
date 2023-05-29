from kivymd.app import MDApp
from kivy.lang import Builder
from kivy.uix.floatlayout import FloatLayout
from kivymd.uix.datatables import MDDataTable
from kivy.metrics import dp
import psycopg2

host = "127.0.0.1"
db_name = "SportClub"

def connect(usr, pwd):
    connection = None
    try:
        connection = psycopg2.connect(
            host=host,
            user=usr,
            password=pwd,
            database=db_name
        )
        cursor = connection.cursor()
        with connection.cursor() as cursor:
            cursor.execute('SELECT Version()')
            print(f"Server version: {cursor.fetchone()}")
    except Exception as _ex:
        return connection
    return connection

def convert_table():
    pass

class MainLayout(FloatLayout):
    pass

class App(MDApp):
    Builder.load_file('data.kv')

    def build(self):
        self.root = MainLayout()
        self.theme_cls.material_style = "M2"
        return self.root

    def Verify(self, lgn, pwd, *args):
        self.connection = connect(lgn, pwd)
        if self.connection is None:
            self.root.ids['error_log'].text = "ERROR: wrong credentials"
        else:
            self.root.ids['scr_manager'].current = 'insert'
            self.data_tables = MDDataTable(
                size_hint=(1 - dp(36) / self.root.width, 1 - (self.root.ids['insert_scroll'].height + dp(36)) / self.root.height),
                pos_hint={'center_x': .5, 'y': dp(18) / self.root.height},
                use_pagination=True,
                column_data=[
                    ("Тип травмы", dp(30)),
                    ("Тяжесть", dp(45)),
                    ("Код МКБ", dp(30)),
                    ("No.", dp(30)),
                ],
                row_data=self.FetchTable(),
            )
            self.root.ids['read'].add_widget(self.data_tables)

    def FetchTable(self):
        with self.connection.cursor() as cursor:
            cursor.execute('SELECT * FROM trauma_test;')
            return cursor.fetchall()

    def FetchId(self, value):
        cnt = 0
        for i in self.data_tables.row_data:
            if i[0] == value:
                return cnt
            cnt += 1
        return False

    def AddRow(self, trauma_type, severity, code):
        temp = (trauma_type, severity, code)
        with self.connection.cursor() as cursor:
            cursor.execute('INSERT INTO trauma_test' + f" VALUES {temp} RETURNING id_trauma;")
            temp_id = len(self.data_tables.row_data) + 1
            temp_id = cursor.fetchall()[0][0]
            print(temp_id)
            self.data_tables.add_row((trauma_type, severity, code, temp_id))
            self.root.ids['insert_log'].text = f"{temp} ожидает внесения"
            return True
        return False

    def Update(self, row_id, trauma_type, severity, code):
        if row_id.isdigit():     
            temp = (trauma_type, severity, code)
            with self.connection.cursor() as cursor:
                cursor.execute('SELECT * FROM trauma_test WHERE id_trauma = ' + f"{row_id};")
                temp_row = cursor.fetchall()
                if temp_row:
                    cursor.execute('UPDATE trauma_test SET (trauma_type, severity, description) =' + f"{temp} WHERE id_trauma = {row_id};")
                    self.root.ids['update_log'].text = f"{temp} ожидает внесения"
                    temp_id = self.FetchId(row_id)
                    self.data_tables.update_row(
                            self.data_tables.row_data[temp_id],
                            (trauma_type, severity, code, row_id)
                        )
                    return True
                else:
                    self.root.ids['update_log'].text = f"Такого id нет"
                    return False
        else:
            self.root.ids['update_log'].text = f"id должен быть числом"
            return False

    def DeleteRow(self, row_id):
        if row_id.isdigit():
            with self.connection.cursor() as cursor:
                cursor.execute('SELECT * FROM trauma_test WHERE id_trauma = ' + f"{row_id};")
                temp_row = cursor.fetchall()
                if temp_row:
                    cursor.execute('DELETE FROM trauma_test WHERE ' + f"id_trauma = {row_id};")
                    self.root.ids['delete_log'].text = f"Удаление строки {temp_row} ожидает внесения"
                    temp_id = self.FetchId(row_id)
                    self.data_tables.remove_row(
                            self.data_tables.row_data[temp_id]
                        )
                else:
                    self.root.ids['delete_log'].text = f"Такого id нет"
                    return False
        else:
            self.root.ids['delete_log'].text = f"id должен быть числом"
            return False

    def Search(self, info, col_name):
        with self.connection.cursor() as cursor:
            cursor.execute(f"SELECT * FROM trauma_test WHERE {col_name} = '{info}'")
            self.data_tables.update_row_data(self.data_tables.row_data, cursor.fetchall())
        pass

if __name__ == '__main__':
    App().run()