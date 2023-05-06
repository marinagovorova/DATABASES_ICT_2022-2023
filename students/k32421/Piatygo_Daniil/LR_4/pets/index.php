<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Управление питомцами</title>
</head>
<body>
    <h1>Управление питомцами</h1>
    <nav>
        <ul>
            <li><a href="index.php">Главная</a></li>
            <li><a href="view_pets.php">Просмотр питомцев</a></li>
        </ul>
    </nav>

    <h2>Добавить питомца</h2>
    <form action="add_pet.php" method="post">
        <label for="type">Тип:</label>
        <input type="text" name="type" id="type" required>
        <label for="name">Кличка:</label>
        <input type="text" name="name" id="name" required>
        <input type="submit" value="Добавить">
    </form>
</body>
</html>