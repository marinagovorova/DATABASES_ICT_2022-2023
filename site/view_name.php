<?php
require_once 'config.php';

$publisher_id = $_GET['publisher_id'];

$query = "SELECT * FROM publisher WHERE publisher_id = ?";
$stmt = $connection->prepare($query);

if ($stmt) {
    $stmt->bind_param('i', $publisher_id);
    if ($stmt->execute()) {
        $result = $stmt->get_result();
        
        if ($result) {
            $pub = $result->fetch_assoc();
            $result->close();
        } else {
            echo 'Ошибка получения результата: ' . $stmt->error;
        }
    } else {
        echo 'Ошибка выполнения SQL-запроса: ' . $stmt->error;
    }
    $stmt->close();
} else {
    echo 'Ошибка подготовки SQL-запроса: ' . $connection->error;
}

$connection->close();
?>

<!doctype html>
<html lang="en">
<head>
    <title>Издательство</title>
</head>
<body>
<h2>ID: <?= $pub['publisher_id'] ?></h2>
<h4>Название издательства: <?= $pub['publisher_name'] ?></h4>
</body>
</html>
