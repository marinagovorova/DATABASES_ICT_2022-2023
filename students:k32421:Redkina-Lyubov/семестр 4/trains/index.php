<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Управление поездами</title>
</head>
<body>
    <h1>Управление поездами</h1>
    <nav>
        <ul>
            <li><a href="index.php">Главная</a></li>
            <li><a href="view_trains.php">Просмотр поездов</a></li>
        </ul>
    </nav>

    <h2>Добавить поезд</h2>
    <form action="add_train.php" method="post">
        <label for="type">Тип:</label>
        <input type="text" name="type" id="type" required>
        <label for="name">Название:</label>
        <input type="text" name="name" id="name" required>
        <input type="submit" value="Добавить">
    </form>
</body>
</html>