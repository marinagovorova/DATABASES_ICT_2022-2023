<?php
require_once "config.php";

if (!isset($_GET['feeding_id'])) {
    header("Location: view_pets.php");
    exit();
}

$feeding_id = $_GET['feeding_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $feeding_date_time = $_POST['feeding_date_time'];

    $query = "UPDATE feedings SET feeding_date_time = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$feeding_date_time, $feeding_id]);

    $pet_id = $conn->query("SELECT pet_id FROM feedings WHERE id = $feeding_id")->fetch()['pet_id'];
    header("Location: view_details.php?pet_id=$pet_id");
    exit();
}

$feeding = $conn->query("SELECT * FROM feedings WHERE id = $feeding_id")->fetch();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Редактировать кормление</title>
</head>
<body>
    <h1>Редактировать кормление</h1>
    <form action="edit_feeding.php?feeding_id=<?= $feeding_id ?>" method="post">
        <label for="feeding_date_time">Дата и время кормления:</label>
        <input type="datetime-local" name="feeding_date_time" id="feeding_date_time" value="<?= date('Y-m-d\TH:i', strtotime($feeding['feeding_date_time'])) ?>" required>
        <input type="submit" value="Сохранить">
    </form>
</body>
</html>