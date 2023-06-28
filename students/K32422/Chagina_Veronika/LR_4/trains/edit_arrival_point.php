<?php
require_once "config.php";

if (!isset($_GET['arrival_point_id'])) {
    header("Location: view_trains.php");
    exit();
}

$arrival_point_id = $_GET['arrival_point_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $arrival_point = $_POST['arrival_point'];

    $query = "UPDATE arrivals_point SET arrival_point = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$arrival_point, $arrival_point_id]);

    $train_id = $conn->query("SELECT train_id FROM arrivals_point WHERE id = $arrival_point_id")->fetch()['train_id'];
    header("Location: view_details.php?train_id=$train_id");
    exit();
}

$arrival_point = $conn->query("SELECT * FROM arrivals_point WHERE id = $arrival_point_id")->fetch();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Редактировать место прибытия</title>
</head>
<body>
    <h1>Редактировать место прибытия</h1>
    <form action="edit_arrival_point.php?arrival_point_id=<?= $arrival_point_id ?>" method="post">
        <label for="arrival_point">Место прибытия:</label>
        <textarea name="arrival_point" id="arrival_point" rows="3" required><?= $arrival_point['arrival_point'] ?></textarea>
        <input type="submit" value="Сохранить">
    </form>
</body>
</html>