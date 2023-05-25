<?php
require_once "config.php";

if (!isset($_GET['departure_point_id'])) {
    header("Location: view_trains.php");
    exit();
}

$departure_point_id = $_GET['departure_point_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $departure_point = $_POST['departure_point'];

    $query = "UPDATE departures_point SET departure_point = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$departure_point, $departure_point_id]);

    $train_id = $conn->query("SELECT train_id FROM departures_point WHERE id = $departure_point_id")->fetch()['train_id'];
    header("Location: view_details.php?train_id=$train_id");
    exit();
}

$departure_point = $conn->query("SELECT * FROM departures_point WHERE id = $departure_point_id")->fetch();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Редактировать место отправления</title>
</head>
<body>
    <h1>Редактировать место отправления</h1>
    <form action="edit_departure_point.php?departure_point_id=<?= $departure_point_id ?>" method="post">
        <label for="departure_point">Место отправления:</label>
        <textarea name="departure_point" id="departure_point" rows="3" required><?= $departure_point['departure_point'] ?></textarea>
        <input type="submit" value="Сохранить">
    </form>
</body>
</html>