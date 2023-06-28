<?php
require_once "config.php";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['train_id'])) {
    $train_id = $_POST['train_id'];
    $arrival_point = $_POST['arrival_point'];

    $query = "INSERT INTO arrivals_point (train_id, arrival_point) VALUES (?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->execute([$train_id, $arrival_point]);

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
    <title>Добавить место прибытия</title>
</head>
<body>
    <h1>Добавить место прибытия</h1>
    <form action="add_arrival_point.php" method="post">
        <input type="hidden" name="train_id" value="<?= $_GET['train_id'] ?>">
        <label for="arrival_point">Место прибытия:</label>
        <input type="text" name="arrival_point" id="arrival_point" required>
        <input type="submit" value="Добавить">
    </form>
</body>
</html>