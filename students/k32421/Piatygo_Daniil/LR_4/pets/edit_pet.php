<?php
require_once "config.php";

if (!isset($_GET['pet_id'])) {
    header("Location: view_pets.php");
    exit();
}

$pet_id = $_GET['pet_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $type = $_POST['type'];
    $name = $_POST['name'];

    $query = "UPDATE pets SET type = ?, name = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$type, $name, $pet_id]);

    header("Location: view_details.php?pet_id=$pet_id");
    exit();
}

$pet = $conn->query("SELECT * FROM pets WHERE id = $pet_id")->fetch();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Редактировать информацию о питомце</title>
</head>
<body>
    <h1>Редактировать информацию о питомце</h1>
    <form action="edit_pet.php?pet_id=<?= $pet_id ?>" method="post">
        <label for="type">Тип питомца:</label>
        <input type="text" name="type" id="type" value="<?= $pet['type'] ?>" required>
        <label for="name">Кличка питомца:</label>
        <input type="text" name="name" id="name" value="<?= $pet['name'] ?>" required>
        <input type="submit" value="Сохранить">
    </form>
</body>
</html>