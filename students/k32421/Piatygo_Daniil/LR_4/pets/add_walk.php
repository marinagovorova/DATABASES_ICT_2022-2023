<?php
require_once "config.php";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['pet_id'])) {
    $pet_id = $_POST['pet_id'];
    $walk_date_time = $_POST['walk_date_time'];

    $query = "INSERT INTO walks (pet_id, walk_date_time) VALUES (?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->execute([$pet_id, $walk_date_time]);

    header("Location: view_pets.php");
    exit();
}

if (!isset($_GET['pet_id'])) {
    header("Location: view_pets.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Добавить выгул</title>
</head>
<body>
    <h1>Добавить выгул</h1>
    <form action="add_walk.php" method="post">
        <input type="hidden" name="pet_id" value="<?= $_GET['pet_id'] ?>">
        <label for="walk_date_time">Дата и время выгула:</label>
        <input type="datetime-local" name="walk_date_time" id="walk_date_time" required>
        <input type="submit" value="Добавить">
    </form>
</body>
</html>