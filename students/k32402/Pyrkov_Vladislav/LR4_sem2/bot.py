from aiogram import Bot, Dispatcher, executor, types
from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from config import TOKEN
import sqlite3
import database
import random

MSG = """
Привет, {}! Добро пожаловать в Фильмобот! 💚

Место, где ты можешь получить идеи, что посмотреть в свободное время
Добавь свои первые фильмы!

Доступные команды:
/add_film - добавить фильм, принимает: название фильма
/recommend - получить рекомендацию
/show_films - показать ваши фильмы
/update_director - обновить режиссёра фильма, принимает: название фильма, новое имя режиссёра
/delete - удалить всю вашу информацию
/delete_film - удалить фильм из вашего списка
"""

PHOTO = open("./img/film.jpg", "rb")

bot = Bot(TOKEN)
dp = Dispatcher(bot)


def search_film(query):
    conn = sqlite3.connect("films.db")
    cursor = conn.cursor()
    cursor.execute(
        "SELECT * FROM films WHERE title LIKE ? OR director LIKE ? OR genre LIKE ?",
        ("%{}%".format(query), "%{}%".format(query), "%{}%".format(query)),
    )
    films = cursor.fetchall()
    conn.close()
    return films


@dp.message_handler(commands=["start"])
async def start_handler(message: types.Message):
    user_full_name = message.from_user.full_name
    user_id = message.from_user.id
    database.add_user(user_id, user_full_name)
    await bot.send_photo(user_id, PHOTO, MSG.format(user_full_name))


@dp.message_handler(commands=["add_film"])
async def add_film_handler(message: types.Message):
    user_input = message.text[9:].strip()
    if user_input:
        film = database.find_film(user_input)
        if film:
            keyboard = InlineKeyboardMarkup()
            keyboard.add(
                InlineKeyboardButton("Добавить", callback_data=f"add_{film[0]}")
            )
            keyboard.add(InlineKeyboardButton("Отказаться", callback_data="cancel"))
            await message.reply(
                f"Найден фильм: {film[1]} - {film[2]} ({film[3]})",
                reply_markup=keyboard,
            )
        else:
            await message.reply("К сожалению, фильм не найден. Попробуйте еще раз!")
    else:
        await message.reply("Введите название фильма после команды /add_film")


@dp.callback_query_handler(lambda call: call.data.startswith("add_"))
async def add_film_callback_handler(call: types.CallbackQuery):
    film_id = int(call.data[4:])
    film = database.get_film_by_id(film_id)
    if film:
        database.add_film_to_user(call.from_user.id, film_id)

        keyboard = InlineKeyboardMarkup()
        keyboard.add(
            InlineKeyboardButton("Показать мои фильмы", callback_data="show_films")
        )
        keyboard.add(
            InlineKeyboardButton("Добавить еще фильм", callback_data="add_another")
        )

        await call.message.reply(
            f"Фильм {film[1]} - {film[2]} ({film[3]}) добавлен!", reply_markup=keyboard
        )
    else:
        await call.answer(text="Произошла ошибка, попробуйте еще раз.")


@dp.callback_query_handler(lambda call: call.data == "show_films")
async def show_films_callback_handler(call: types.CallbackQuery):
    films = database.get_user_films(call.from_user.id)
    if films:
        response = "Ваши фильмы:\n\n"
        for film in films:
            response += f"{film[1]} - {film[2]} ({film[3]})\n"
        await call.message.reply(response)
    else:
        await call.message.reply("У вас пока нет добавленных фильмов.")


@dp.callback_query_handler(lambda call: call.data == "add_another")
async def add_another_callback_handler(call: types.CallbackQuery):
    await call.message.reply("Введите название фильма после команды /add_film")


@dp.message_handler(commands=["recommend"])
async def recommend_handler(message: types.Message):
    user_id = message.from_user.id
    user_films = database.get_user_films(user_id)
    if user_films:
        recommended_films = []
        for film in user_films:
            genre_films = database.get_films_by_genre(user_id, film[3])
            recommended_films.extend(genre_films)

        if recommended_films:
            film = random.choice(recommended_films)

            keyboard = InlineKeyboardMarkup()
            keyboard.add(
                InlineKeyboardButton("Добавить", callback_data=f"add_{film[0]}")
            )
            keyboard.add(InlineKeyboardButton("Отказаться", callback_data="cancel"))

            response = "Рекомендованный фильм:\n\n"
            response += f"{film[1]} - {film[2]} ({film[3]})"
            await message.reply(response, reply_markup=keyboard)
        else:
            await message.reply(
                "К сожалению, нет новых рекомендаций по вашим жанрам. Попробуйте добавить больше фильмов!"
            )
    else:
        await message.reply(
            "Вы пока не добавили ни одного фильма. Добавьте хотя бы один, чтобы получить рекомендации."
        )


@dp.message_handler(commands=["delete"])
async def delete_handler(message: types.Message):
    user_id = message.from_user.id
    database.delete_user(user_id)
    await message.reply("Ваша информация была удалена.")


@dp.message_handler(commands=["delete_film"])
async def delete_film_handler(message: types.Message):
    user_input = message.text[12:].strip()
    user_id = message.from_user.id
    if user_input:
        if database.check_film_added(user_id, user_input):
            database.delete_film_from_user(user_id, user_input)
            await message.reply(f"Фильм '{user_input}' была удалена из вашего списка.")
        else:
            await message.reply("Такого фильма у вас нет.")
    else:
        await message.reply("Введите название фильма после команды /delete_film")


@dp.message_handler(commands=["show_films"])
async def show_films_handler(message: types.Message):
    user_id = message.from_user.id
    films = database.get_user_films(user_id)
    if films:
        response = "Ваши фильмы:\n\n"
        for film in films:
            response += f"{film[1]} - {film[2]} ({film[3]})\n"
        await message.reply(response)
    else:
        await message.reply("Вы ещё не добавили ни одного фильма.")


@dp.message_handler(commands=["update_director"])
async def update_director_handler(message: types.Message):
    user_input = message.text[16:]
    print(user_input)
    if user_input:
        film = database.find_film(user_input.split()[0])
        if film:
            database.update_film_director(film[1], user_input.split()[1])
            await message.reply(
                "Теперь у фильма "
                + film[1]
                + " режиссёр "
                + user_input.split()[1]
                + " !"
            )


if __name__ == "__main__":
    executor.start_polling(dp)
