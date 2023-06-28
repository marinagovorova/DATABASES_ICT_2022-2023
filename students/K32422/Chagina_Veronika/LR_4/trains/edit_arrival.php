<?php
require_once "config.php";

if (!isset($_GET['arrival_id'])) {
    header("Location: view_trains.php");
    exit();
}

$arrival_id = $_GET['arrival_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $arrival_date = $_POST['arrival_date'];

    $query = "UPDATE arrivals SET arrival_date = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$arrival_date, $arrival_id]);

    $train_id = $conn->query("SELECT train_id FROM arrivals WHERE id = $arrival_id")->fetch()['train_id'];
    header("Location: view_details.php?train_id=$train_id");
    exit();
}

$arrival = $conn->query("SELECT * FROM arrivals WHERE id = $arrival_id")->fetch();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Редактировать отправление</title>
</head>
<body>
    <h1>Редактировать отправление</h1>
    <form action="edit_arrival.php?arrival_id=<?= $arrival_id ?>" method="post">
        <label for="arrival_date">Дата и время отправления:</label>
        <input type="datetime-local" name="arrival_date" id="arrival_date" value="<?= date('Y-m-d\TH:i', strtotime($arrival['arrival_date'])) ?>" required>
        <input type="submit" value="Сохранить">
    </form>
</body>
</html>