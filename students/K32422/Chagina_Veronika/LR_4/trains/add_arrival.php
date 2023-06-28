<?php
require_once "config.php";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['train_id'])) {
    $train_id = $_POST['train_id'];
    $arrival_date = $_POST['arrival_date'];

    $query = "INSERT INTO arrivals (train_id, arrival_date) VALUES (?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->execute([$train_id, $arrival_date]);

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
    <title>Добавить прибытие</title>
</head>
<body>
    <h1>Добавить прибытие</h1>
    <form action="add_arrival.php" method="post">
        <input type="hidden" name="train_id" value="<?= $_GET['train_id'] ?>">
        <label for="arrival_date">Дата и время прибытия:</label>
        <input type="datetime-local" name="arrival_date" id="arrival_date" required>
        <input type="submit" value="Добавить">
    </form>
</body>
</html>