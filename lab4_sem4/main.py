import sqlite3
import streamlit as st
import pandas as pd

# database connection
conn = sqlite3.connect("auto.db")
c = conn.cursor()

# create cars table
c.execute("CREATE TABLE IF NOT EXISTS cars (id INTEGER PRIMARY KEY, model TEXT, rating DECIMAL(4,2))")


# Streamlit app
def car_app():
    # Title
    st.title("АВТО БД")

    # Sidebar menu
    menu = ["Добавить машину", "Найти машину", "Изменить машину", "Удалить машину", "Просмотр БД"]
    choice = st.sidebar.radio("Выберите операцию", menu)



    # Add car
    if choice == "Добавить машину":
        st.subheader("Добавить машину")

        model = st.text_input("Модель")
        rating = st.slider("Рейтинг", 0.0, 10.0, 5.0, 0.1)

        if st.button("Добавить отметку"):
            if len(model) > 0:
                c.execute("INSERT INTO cars (model, rating) VALUES (?, ?)", (model, rating))
                conn.commit()
                st.success("Отметка добавлена!")
            else:
                st.warning('Заполните название модели')



    # Find car
    elif choice == "Найти машину":
        st.subheader(":green[_Только проверенные автомобили!_]")
        st.header("Найти машину")

        id = st.number_input("ID", min_value=1)

        if st.button("Поиск"):
            c.execute("SELECT * FROM cars WHERE id=?", (id,))
            car = c.fetchone()

            if car:
                st.write("Модель:", car[1])
                st.write("Рейтинг:", car[2])
            else:
                st.warning("Авто не найдено")

    # Update car
    elif choice == "Изменить машину":
        st.header("Изменить машину")

        id = st.number_input("ID", min_value=1)
        model = st.text_input("Модель")
        rating = st.slider("Рейтинг", 0.0, 10.0, 5.0, 0.1)


        if st.button("Обновить"):
            c.execute("SELECT * FROM cars WHERE id=?", (id,))
            car = c.fetchone()
            if car:
                if len(model) > 0:
                        c.execute("UPDATE cars SET model=?, rating=? WHERE id=?", (model, rating, id))
                        conn.commit()
                        st.success("Отметка обновлена")
                else:
                    st.warning('Заполните название модели')
            else:
                st.warning("Авто не найдено")


    # Delete car
    elif choice == "Удалить машину":
        st.header("Удалить машину")

        id = st.number_input("ID", min_value=1)

        if st.button("Удалить"):
            c.execute("SELECT * FROM cars WHERE id=?", (id,))
            car = c.fetchone()

            if car:
                c.execute("DELETE FROM cars WHERE id=?", (id,))
                conn.commit()
                st.success("Запись удалена")
            else:
                st.warning("Авто не найдено")
    elif choice == "Просмотр БД":
        st.header("Просмотр БД")
        sql_query = pd.read_sql_query('''
                                       SELECT
                                       *
                                       FROM cars
                                       ''', conn)
        df = pd.DataFrame(sql_query)
        st.dataframe(df, hide_index=True,)

    # Closing db connection
    c.close()
    conn.close()


if __name__ == "__main__":
    car_app()
