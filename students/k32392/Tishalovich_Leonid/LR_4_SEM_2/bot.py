from aiogram import Bot, Dispatcher, executor, types
from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from config import TOKEN
import sqlite3
import database
import random

MSG = """
Привет, {}! Добро пожаловать в BooX! 💚

Место, где ты можешь получить идеи, что почитать и обсудить прочитанное с другими книголюбами
Добавь свои первые книги!

напиши /add_book , чтобы добавить книгу
"""

PHOTO = open('./img/boox_logo.png', 'rb')

bot = Bot(TOKEN)
dp = Dispatcher(bot)

def search_book(query):
    conn = sqlite3.connect('books.db')
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM books WHERE title LIKE ? OR author LIKE ? OR genre LIKE ?", 
                   ('%{}%'.format(query), '%{}%'.format(query), '%{}%'.format(query)))
    books = cursor.fetchall()
    conn.close()
    return books

@dp.message_handler(commands=['start'])
async def start_handler(message: types.Message):
    user_full_name = message.from_user.full_name
    user_id = message.from_user.id
    database.add_user(user_id, user_full_name)
    await bot.send_photo(user_id, PHOTO, MSG.format(user_full_name))

@dp.message_handler(commands=['add_book'])
async def add_book_handler(message: types.Message):
    user_input = message.text[9:].strip()
    if user_input:
        book = database.find_book(user_input)
        if book:
            keyboard = InlineKeyboardMarkup()
            keyboard.add(InlineKeyboardButton("Добавить", callback_data=f"add_{book[0]}"))
            keyboard.add(InlineKeyboardButton("Отказаться", callback_data="cancel"))
            await message.reply(f"Найдена книга: {book[1]} - {book[2]} ({book[3]})", reply_markup=keyboard)
        else:
            await message.reply("К сожалению, книга не найдена. Попробуйте еще раз!")
    else:
        await message.reply("Введите название книги после команды /add_book")

@dp.callback_query_handler(lambda call: call.data.startswith("add_"))
async def add_book_callback_handler(call: types.CallbackQuery):
    book_id = int(call.data[4:])
    book = database.get_book_by_id(book_id)
    if book:
        database.add_book_to_user(call.from_user.id, book_id)
        
        keyboard = InlineKeyboardMarkup()
        keyboard.add(InlineKeyboardButton("Показать мои книги", callback_data="show_books"))
        keyboard.add(InlineKeyboardButton("Добавить еще книгу", callback_data="add_another"))

        await call.message.reply(f"Книга {book[1]} - {book[2]} ({book[3]}) добавлена!", reply_markup=keyboard)
    else:
        await call.answer(text="Произошла ошибка, попробуйте еще раз.")

@dp.callback_query_handler(lambda call: call.data == "show_books")
async def show_books_callback_handler(call: types.CallbackQuery):
    books = database.get_user_books(call.from_user.id)
    if books:
        response = "Ваши книги:\n\n"
        for book in books:
            response += f"{book[1]} - {book[2]} ({book[3]})\n"
        await call.message.reply(response)
    else:
        await call.message.reply("У вас пока нет добавленных книг.")

@dp.callback_query_handler(lambda call: call.data == "add_another")
async def add_another_callback_handler(call: types.CallbackQuery):
    await call.message.reply("Введите название книги после команды /add_book")


@dp.message_handler(commands=['recommend'])
async def recommend_handler(message: types.Message):
    user_id = message.from_user.id
    user_books = database.get_user_books(user_id)
    if user_books:
        recommended_books = []
        for book in user_books:
            genre_books = database.get_books_by_genre(user_id, book[3])
            recommended_books.extend(genre_books)

        if recommended_books:
            book = random.choice(recommended_books)

            keyboard = InlineKeyboardMarkup()
            keyboard.add(InlineKeyboardButton("Добавить", callback_data=f"add_{book[0]}"))
            keyboard.add(InlineKeyboardButton("Отказаться", callback_data="cancel"))

            response = "Рекомендованная книга:\n\n"
            response += f"{book[1]} - {book[2]} ({book[3]})"
            await message.reply(response, reply_markup=keyboard)
        else:
            await message.reply("К сожалению, нет новых рекомендаций по вашим жанрам. Попробуйте добавить больше книг!")
    else:
        await message.reply("Вы пока не добавили ни одной книги. Добавьте хотя бы одну, чтобы получить рекомендации.")

@dp.message_handler(commands=['delete'])
async def delete_handler(message: types.Message):
    user_id = message.from_user.id
    database.delete_user(user_id)
    await message.reply("Ваша информация была удалена.")

@dp.message_handler(commands=['delete_book'])
async def delete_book_handler(message: types.Message):
    user_input = message.text[12:].strip()
    user_id = message.from_user.id
    if user_input:
        if database.check_book_added(user_id, user_input):
            database.delete_book_from_user(user_id, user_input)
            await message.reply(f"Книга '{user_input}' была удалена из вашего списка.")
        else:
            await message.reply("Такой книги у вас нет.")
    else:
        await message.reply("Введите название книги после команды /delete_book")

@dp.message_handler(commands=['show_books'])
async def show_books_handler(message: types.Message):
    user_id = message.from_user.id
    books = database.get_user_books(user_id)
    if books:
        response = "Ваши книги:\n\n"
        for book in books:
            response += f"{book[1]} - {book[2]} ({book[3]})\n"
        await message.reply(response)
    else:
        await message.reply("Вы ещё не добавили ни одной книги.")

if __name__ == '__main__':
    executor.start_polling(dp)