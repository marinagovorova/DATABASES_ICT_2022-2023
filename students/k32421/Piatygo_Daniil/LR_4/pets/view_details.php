<?php
require_once "config.php";

if (!isset($_GET['pet_id'])) {
    header("Location: view_pets.php");
    exit();
}

$pet_id = $_GET['pet_id'];
$pet = $conn->query("SELECT * FROM pets WHERE id = $pet_id")->fetch();
$feedings = $conn->query("SELECT * FROM feedings WHERE pet_id = $pet_id")->fetchAll();
$walks = $conn->query("SELECT * FROM walks WHERE pet_id = $pet_id")->fetchAll();
$vet_visits = $conn->query("SELECT * FROM vet_visits WHERE pet_id = $pet_id")->fetchAll();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Информация о питомце</title>
</head>
<body>
    <h1>Информация о питомце</h1>
    <p>Тип: <?= $pet['type'] ?></p>
    <p>Кличка: <?= $pet['name'] ?></p>
    <p><a href="edit_pet.php?pet_id=<?= $pet_id ?>">Редактировать информацию о питомце</a></p>
    <a href="index.php">На главную</a>
    <h2>Кормления</h2>
    <table border="1">
        <tr>
            <th>Дата и время кормления</th>
            <th>Действия</th>
        </tr>
        <?php foreach ($feedings as $feeding): ?>
        <tr>
            <td><?= $feeding['feeding_date_time'] ?></td>
            <td>
                <a href="edit_feeding.php?feeding_id=<?= $feeding['id'] ?>">Редактировать</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </table>
    <h2>Выгулы</h2>
    <table border="1">
        <tr>
            <th>Дата и время выгула</th>
            <th>Действия</th>
        </tr>
        <?php foreach ($walks as $walk): ?>
        <tr>
            <td><?= $walk['walk_date_time'] ?></td>
            <td>
                <a href="edit_walk.php?walk_id=<?= $walk['id'] ?>">Редактировать</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </table>
    <h2>Визиты к ветеринару</h2>
    <table border="1">
        <tr>
            <th>Дата визита</th>
            <th>Диагноз</th>
            <th>Лечение</th>
            <th>Действия</th>
        </tr>
        <?php foreach ($vet_visits as $vet_visit): ?>
        <tr>
            <td><?= $vet_visit['visit_date'] ?></td>
            <td><?= $vet_visit['diagnosis'] ?></td>
            <td><?= $vet_visit['treatment'] ?></td>
            <td>
                <a href="edit_vet_visit.php?vet_visit_id=<?= $vet_visit['id'] ?>">Редактировать</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>