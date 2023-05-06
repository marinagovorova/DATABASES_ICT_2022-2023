<?php
require_once "config.php";

$query = "SELECT * FROM pets";
$result = $conn->query($query);
$pets = $result->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Просмотр питомцев</title>
</head>
<body>
    <h1>Просмотр питомцев</h1>
    <nav>
        <ul>
            <li><a href="index.php">Главная</a></li>
            <li><a href="view_pets.php">Просмотр питомцев</a></li>
        </ul>
    </nav>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Тип</th>
                <th>Кличка</th>
                <th>Действия</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($pets as $pet): ?>
            <tr>
                <td><?= $pet['id'] ?></td>
                <td><?= $pet['type'] ?></td>
                <td><?= $pet['name'] ?></td>
                <td>
                    <a href="add_feeding.php?pet_id=<?= $pet['id'] ?>">Добавить кормление</a> |
                    <a href="add_walk.php?pet_id=<?= $pet['id'] ?>">Добавить выгул</a> |
                    <a href="add_vet_visit.php?pet_id=<?= $pet['id'] ?>">Добавить визит к ветеринару</a> |
                    <a href="view_details.php?pet_id=<?= $pet['id'] ?>">Просмотреть детали</a> |
                    <a href="delete_pet.php?pet_id=<?= $pet['id'] ?>">Удалить питомца</a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>