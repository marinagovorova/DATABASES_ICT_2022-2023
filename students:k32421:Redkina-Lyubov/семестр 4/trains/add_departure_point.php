<?php
require_once "config.php";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['train_id'])) {
    $train_id = $_POST['train_id'];
    $departure_point = $_POST['departure_point'];

    $query = "INSERT INTO departures_point (train_id, departure_point) VALUES (?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->execute([$train_id, $departure_point]);

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
    <title>Добавить место отправления</title>
</head>
<body>
    <h1>Добавить отправление</h1>
    <form action="add_departure_point.php" method="post">
        <input type="hidden" name="train_id" value="<?= $_GET['train_id'] ?>">
        <label for="departure_date">Место отправления:</label>
        <input type="text" name="departure_point" id="departure_point" required>
        <input type="submit" value="Добавить">
    </form>
</body>
</html>