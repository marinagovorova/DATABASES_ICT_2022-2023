<?php
require_once "config.php";

if (!isset($_GET['maintenance_id'])) {
    header("Location: view_trains.php");
    exit();
}

$maintenance_id = $_GET['maintenance_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $maintenance_date = $_POST['maintenance_date'];
    $maintenance_done = $_POST['maintenance_done'];
    $status = $_POST['status'];

    $query = "UPDATE maintenances SET maintenance_date = ?, maintenance_done = ?, status = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$maintenance_date, $maintenance_done, $status, $maintenance_id]);

    $train_id = $conn->query("SELECT train_id FROM maintenances WHERE id = $maintenance_id")->fetch()['train_id'];
    header("Location: view_details.php?train_id=$train_id");
    exit();
}

$maintenance = $conn->query("SELECT * FROM maintenances WHERE id = $maintenance_id")->fetch();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Редактировать техосмотр</title>
</head>
<body>
    <h1>Редактировать техосмотр</h1>
    <form action="edit_maintenance.php?maintenance_id=<?= $maintenance_id ?>" method="post">
        <label for="maintenance_date">Дата техосмотра:</label>
        <input type="date" name="maintenance_date" id="maintenance_date" value="<?= date('Y-m-d', strtotime($maintenance['maintenance_date'])) ?>" required>
        <label for="maintenance_done">Выполненные работы:</label>
        <textarea name="maintenance_done" id="maintenance_done" rows="3" required><?= $maintenance['maintenance_done'] ?></textarea>
        <label for="status">Статус:</label>
        <textarea name="status" id="status" rows="3" required><?= $maintenance['status'] ?></textarea>
        <input type="submit" value="Сохранить">
    </form>
</body>
</html>