<?php
require_once "config.php";

if (!isset($_GET['train_id'])) {
    header("Location: view_trains.php");
    exit();
}

$train_id = $_GET['train_id'];
$train = $conn->query("SELECT * FROM trains WHERE id = $train_id")->fetch();
$departures = $conn->query("SELECT * FROM departures WHERE train_id = $train_id")->fetchAll();
$departures_point = $conn->query("SELECT * FROM departures_point WHERE train_id = $train_id")->fetchAll();
$arrivals = $conn->query("SELECT * FROM arrivals WHERE train_id = $train_id")->fetchAll();
$arrivals_point = $conn->query("SELECT * FROM arrivals_point WHERE train_id = $train_id")->fetchAll();
$maintenances = $conn->query("SELECT * FROM maintenances WHERE train_id = $train_id")->fetchAll();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Информация о поезде</title>
</head>
<body>
    <h1>Информация о поезде</h1>
    <p>Тип: <?= $train['type'] ?></p>
    <p>Название: <?= $train['name'] ?></p>
    <p><a href="edit_train.php?train_id=<?= $train_id ?>">Редактировать информацию о поезде</a></p>
    <a href="index.php">На главную</a>
    <h2>Отправления</h2>
    <table border="1">
        <tr>
            <th>Дата и время отправления</th>
            <th>Действия</th>
        </tr>
        <?php foreach ($departures as $departure): ?>
        <tr>
            <td><?= $departure['departure_date'] ?></td>
            <td>
                <a href="edit_departure.php?departure_id=<?= $departure['id'] ?>">Редактировать</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </table>
    <h2>Места отправления</h2>
    <table border="1">
        <tr>
            <th>Место отправления</th>
            <th>Действия</th>
        </tr>
        <?php foreach ($departures_point as $departure_point): ?>
        <tr>
            <td><?= $departure_point['departure_point'] ?></td>
            <td>
                <a href="edit_departure_point.php?departure_point_id=<?= $departure_point['id'] ?>">Редактировать</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </table>
    <h2>Прибытия</h2>
    <table border="1">
        <tr>
            <th>Дата и время прибытия</th>
            <th>Действия</th>
        </tr>
        <?php foreach ($arrivals as $arrival): ?>
        <tr>
            <td><?= $arrival['arrival_date'] ?></td>
            <td>
                <a href="edit_arrival.php?arrival_id=<?= $arrival['id'] ?>">Редактировать</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </table>
    <h2>Места прибытия</h2>
    <table border="1">
        <tr>
            <th>Место прибытия</th>
            <th>Действия</th>
        </tr>
        <?php foreach ($arrivals_point as $arrival_point): ?>
        <tr>
            <td><?= $arrival_point['arrival_point'] ?></td>
            <td>
                <a href="edit_arrival_point.php?arrival_point_id=<?= $arrival_point['id'] ?>">Редактировать</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </table>
    <h2>Техосмотры</h2>
    <table border="1">
        <tr>
            <th>Дата техосмотра</th>
            <th>Проделанная работа</th>
            <th>Статус</th>
            <th>Действия</th>
        </tr>
        <?php foreach ($maintenances as $maintenance): ?>
        <tr>
            <td><?= $maintenance['maintenance_date'] ?></td>
            <td><?= $maintenance['maintenance_done'] ?></td>
            <td><?= $maintenance['status'] ?></td>
            <td>
                <a href="edit_maintenance.php?maintenance_id=<?= $maintenance['id'] ?>">Редактировать</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>