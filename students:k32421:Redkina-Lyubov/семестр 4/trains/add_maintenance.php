<?php
require_once "config.php";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['train_id'])) {
    $train_id = $_POST['train_id'];
    $maintenance_date = $_POST['maintenance_date'];
    $maintenance_done = $_POST['maintenance_done'];
    $status = $_POST['status'];

    $query = "INSERT INTO maintenances (train_id, maintenance_date, maintenance_done, status) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->execute([$train_id, $maintenance_date, $maintenance_done, $status]);

    header("Location: view_trains.php");
    exit();
}

if (!isset($_GET['train_id'])) {
    header("Location: view_trains.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Добавить техосмотр</title>
</head>
<body>
    <h1>Добавить техосмотр </h1>
    <form action="add_maintenance.php" method="post">
        <input type="hidden" name="train_id" value="<?= $_GET['train_id'] ?>">
        <label for="maintenance_date">Дата техосмотра:</label>
        <input type="date" name="maintenance_date" id="maintenance_date" required>
        <label for="maintenance_done">Проделанная работа:</label>
        <input type="text" name="maintenance_done" id="maintenance_done" required>
        <label for="status">Статус:</label>
        <input type="text" name="status" id="status" required>
        <input type="submit" value="Добавить">
    </form>
</body>
</html>