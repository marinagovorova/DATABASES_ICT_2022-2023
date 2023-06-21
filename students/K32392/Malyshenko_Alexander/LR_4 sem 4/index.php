<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>songs database</title>
    <style>
        label{display: inline-block;width: 170px;}
        form > div{margin-bottom: 5px;}
    </style>
</head>
<table border = '1', width = 100%>
    <tr>
        <td width = 25%, align="center">
            <h2>Команда insert</h2>
            <form action="index_insert.php" method="POST">
                <div>
                    <label for="Title">Название песни*:</label>
                    <input type="text" id="Title" name="song_name" required>
                </div>
                <div>
                    <label for="link">Ссылка на песню*:</label>
                    <input type="text" id="link" name="song_link" required>
                </div>
                <div>
                    <label for="raring">Рейтинг песни:</label>
                    <input type="number" id="rating" name="song_rating">
                </div>
                <div>
                    <label for="views">Кол-во просмотров:</label>
                    <input type="number" id="views" name="song_views">
                </div>
                <input type="submit" value="Отправить в БД">
            </form>
        </td>
        <td width = 25%, align="center">
            <h2>Команда delete</h2>
            <form action="index_delete.php" method="POST">
                <div>
                    <label for="id">ID песни:</label>
                    <input type="text" id="id" name="id">
                </div>
                <div>
                    <label for="Title">Название песни:</label>
                    <input type="text" id="Title" name="song_name">
                </div>
                <input type="submit" value="Удалить из БД">
            </form>
        </td>
        <td width = 25%, align="center">
            <h2>Команда select</h2>
            <form action="index_select.php" method="POST">
                <div>
                    <label for="id">ID песни:</label>
                    <input type="text" id="id" name="id">
                </div>
                <div>
                    <label for="Title">Название песни:</label>
                    <input type="text" id="Title" name="song_name">
                </div>
                <input type="submit" value="Найти и вывести"><br/><br/>
            </form>
            <form action="index_select_all.php" method="POST">
                <input type="submit" value="Вывести все песни"><br/>
            </form>
        </td>
        <td width = 25%, align="center">
            <h2>Команда update</h2>
            <h4>Найти по ID</h4>
            <form action="index_update.php" method="POST">
                <div>
                    <label for="id">ID песни*:</label>
                    <input type="text" id="id" name="id" required>
                </div>
                <h4>Изменить значения</h4>
                <div>
                    <label for="Title">Название песни:</label>
                    <input type="text" id="Title" name="song_name">
                </div>
                <div>
                    <label for="link">Ссылка на песню:</label>
                    <input type="text" id="link" name="song_link">
                </div>
                <div>
                    <label for="raring">Рейтинг песни:</label>
                    <input type="number" id="rating" name="song_rating">
                </div>
                <div>
                    <label for="views">Кол-во просмотров:</label>
                    <input type="number" id="views" name="song_views">
                </div>
                <input type="submit" value="Изменить в БД">
            </form>
        </td>  
    </tr>
</table>
</html>