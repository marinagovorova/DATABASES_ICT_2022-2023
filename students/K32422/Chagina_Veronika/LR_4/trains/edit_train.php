<?php
require_once "config.php";

if (!isset($_GET['train_id'])) {
    header("Location: view_trains.php");
    exit();
}

$train_id = $_GET['train_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $type = $_POST['type'];
    $name = $_POST['name'];

    $query = "UPDATE trains SET type = ?, name = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$type, $name, $train_id]);

    header("Location: view_details.php?train_id=$train_id");
    exit();
}

$train = $conn->query("SELECT * FROM trains WHERE id = $train_id")->fetch();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Редактировать информацию о поезде</title>
</head>
<body>
    <h1>Редактировать информацию о поезде</h1>
    <form action="edit_train.php?train_id=<?= $train_id ?>" method="post">
        <label for="type">Тип поезда:</label>
        <input type="text" name="type" id="type" value="<?= $train['type'] ?>" required>
        <label for="name">Имя поезда:</label>
        <input type="text" name="name" id="name" value="<?= $train['name'] ?>" required>
        <input type="submit" value="Сохранить">
    </form>
</body>
</html>