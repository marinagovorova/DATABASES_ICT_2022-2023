<?php
require_once "config.php";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['pet_id'])) {
    $pet_id = $_POST['pet_id'];
    $feeding_date_time = $_POST['feeding_date_time'];

    $query = "INSERT INTO feedings (pet_id, feeding_date_time) VALUES (?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->execute([$pet_id, $feeding_date_time]);

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
    <title>Добавить кормление</title>
</head>
<body>
    <h1>Добавить кормление</h1>
    <form action="add_feeding.php" method="post">
        <input type="hidden" name="pet_id" value="<?= $_GET['pet_id'] ?>">
        <label for="feeding_date_time">Дата и время кормления:</label>
        <input type="datetime-local" name="feeding_date_time" id="feeding_date_time" required>
        <input type="submit" value="Добавить">
    </form>
</body>
</html>