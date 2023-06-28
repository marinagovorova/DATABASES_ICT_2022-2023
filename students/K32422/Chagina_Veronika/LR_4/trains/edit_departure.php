<?php
require_once "config.php";

if (!isset($_GET['departure_id'])) {
    header("Location: view_trains.php");
    exit();
}

$departure_id = $_GET['departure_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $departure_date = $_POST['departure_date'];

    $query = "UPDATE departures SET departure_date = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$departure_date, $departure_id]);

    $train_id = $conn->query("SELECT train_id FROM departures WHERE id = $departure_id")->fetch()['train_id'];
    header("Location: view_details.php?train_id=$train_id");
    exit();
}

$departure = $conn->query("SELECT * FROM departures WHERE id = $departure_id")->fetch();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Редактировать отправление</title>
</head>
<body>
    <h1>Редактировать отправление</h1>
    <form action="edit_departure.php?departure_id=<?= $departure_id ?>" method="post">
        <label for="departure_date">Дата и время отправления:</label>
        <input type="datetime-local" name="departure_date" id="departure_date" value="<?= date('Y-m-d\TH:i', strtotime($departure['departure_date'])) ?>" required>
        <input type="submit" value="Сохранить">
    </form>
</body>
</html>