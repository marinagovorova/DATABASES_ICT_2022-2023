<?php
require_once "config.php";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['pet_id'])) {
    $pet_id = $_POST['pet_id'];
    $visit_date = $_POST['visit_date'];
    $diagnosis = $_POST['diagnosis'];
    $treatment = $_POST['treatment'];

    $query = "INSERT INTO vet_visits (pet_id, visit_date, diagnosis, treatment) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->execute([$pet_id, $visit_date, $diagnosis, $treatment]);

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
    <title>Добавить визит к ветеринару</title>
</head>
<body>
    <h1>Добавить визит к ветеринару</h1>
    <form action="add_vet_visit.php" method="post">
        <input type="hidden" name="pet_id" value="<?= $_GET['pet_id'] ?>">
        <label for="visit_date">Дата визита:</label>
        <input type="date" name="visit_date" id="visit_date" required>
        <label for="diagnosis">Диагноз:</label>
        <input type="text" name="diagnosis" id="diagnosis" required>
        <label for="treatment">Лечение:</label>
        <input type="text" name="treatment" id="treatment" required>
        <input type="submit" value="Добавить">
    </form>
</body>
</html>