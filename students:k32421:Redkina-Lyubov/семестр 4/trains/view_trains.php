<?php
require_once "config.php";

$query = "SELECT * FROM trains";
$result = $conn->query($query);
$trains = $result->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Просмотр поездов</title>
</head>
<body>
    <h1>Просмотр поездов</h1>
    <nav>
        <ul>
            <li><a href="index.php">Главная</a></li>
            <li><a href="view_trains.php">Просмотр поездов</a></li>
        </ul>
    </nav>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Тип</th>
                <th>Название</th>
                <th>Действия</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($trains as $train): ?>
            <tr>
                <td><?= $train['id'] ?></td>
                <td><?= $train['type'] ?></td>
                <td><?= $train['name'] ?></td>
                <td>
                    <a href="add_departure.php?train_id=<?= $train['id'] ?>">Добавить отправление</a> |
                    <a href="add_departure_point.php?train_id=<?= $train['id'] ?>">Добавить место отправления</a> |
                    <a href="add_arrival.php?train_id=<?= $train['id'] ?>">Добавить прибытие</a> |
                    <a href="add_arrival_point.php?train_id=<?= $train['id'] ?>">Добавить место прибытия</a> |
                    <a href="add_maintenance.php?train_id=<?= $train['id'] ?>">Добавить техосмотр</a> |
                    <a href="view_details.php?train_id=<?= $train['id'] ?>">Просмотреть детали</a> |
                    <a href="delete_train.php?train_id=<?= $train['id'] ?>">Удалить поезд</a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>