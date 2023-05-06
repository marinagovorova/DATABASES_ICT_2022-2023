<?php
require_once "config.php";

if (!isset($_GET['walk_id'])) {
    header("Location: view_pets.php");
    exit();
}

$walk_id = $_GET['walk_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $walk_date_time = $_POST['walk_date_time'];

    $query = "UPDATE walks SET walk_date_time = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$walk_date_time, $walk_id]);

    $pet_id = $conn->query("SELECT pet_id FROM walks WHERE id = $walk_id")->fetch()['pet_id'];
    header("Location: view_details.php?pet_id=$pet_id");
    exit();
}

$walk = $conn->query("SELECT * FROM walks WHERE id = $walk_id")->fetch();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Редактировать выгул</title>
</head>
<body>
    <h1>Редактировать выгул</h1>
    <form action="edit_walk.php?walk_id=<?= $walk_id ?>" method="post">
        <label for="walk_date_time">Дата и время выгула:</label>
        <input type="datetime-local" name="walk_date_time" id="walk_date_time" value="<?= date('Y-m-d\TH:i', strtotime($walk['walk_date_time'])) ?>" required>
        <input type="submit" value="Сохранить">
    </form>
</body>
</html>