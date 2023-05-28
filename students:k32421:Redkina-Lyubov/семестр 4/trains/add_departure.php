<?php
require_once "config.php";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['train_id'])) {
    $train_id = $_POST['train_id'];
    $departure_date = $_POST['departure_date'];

    $query = "INSERT INTO departures (train_id, departure_date) VALUES (?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->execute([$train_id, $departure_date]);

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
    <title>Добавить отправление</title>
</head>
<body>
    <h1>Добавить отправление</h1>
    <form action="add_departure.php" method="post">
        <input type="hidden" name="train_id" value="<?= $_GET['train_id'] ?>">
        <label for="departure_date">Дата и время отправления:</label>
        <input type="datetime-local" name="departure_date" id="departure_date" required>
        <input type="submit" value="Добавить">
    </form>
</body>
</html>