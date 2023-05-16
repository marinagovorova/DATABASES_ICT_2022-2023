<?php
require_once "config.php";

if (!isset($_GET['vet_visit_id'])) {
    header("Location: view_pets.php");
    exit();
}

$vet_visit_id = $_GET['vet_visit_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $visit_date = $_POST['visit_date'];
    $diagnosis = $_POST['diagnosis'];
    $treatment = $_POST['treatment'];

    $query = "UPDATE vet_visits SET visit_date = ?, diagnosis = ?, treatment = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$visit_date, $diagnosis, $treatment, $vet_visit_id]);

    $pet_id = $conn->query("SELECT pet_id FROM vet_visits WHERE id = $vet_visit_id")->fetch()['pet_id'];
    header("Location: view_details.php?pet_id=$pet_id");
    exit();
}

$vet_visit = $conn->query("SELECT * FROM vet_visits WHERE id = $vet_visit_id")->fetch();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Редактировать визит к ветеринару</title>
</head>
<body>
    <h1>Редактировать визит к ветеринару</h1>
    <form action="edit_vet_visit.php?vet_visit_id=<?= $vet_visit_id ?>" method="post">
        <label for="visit_date">Дата визита:</label>
        <input type="date" name="visit_date" id="visit_date" value="<?= date('Y-m-d', strtotime($vet_visit['visit_date'])) ?>" required>
        <label for="diagnosis">Диагноз:</label>
        <textarea name="diagnosis" id="diagnosis" rows="3" required><?= $vet_visit['diagnosis'] ?></textarea>
        <label for="treatment">Лечение:</label>
        <textarea name="treatment" id="treatment" rows="3" required><?= $vet_visit['treatment'] ?></textarea>
        <input type="submit" value="Сохранить">
    </form>
</body>
</html>