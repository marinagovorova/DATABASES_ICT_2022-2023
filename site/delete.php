<?php
require_once 'config.php';

$publisher_id = $_GET['publisher_id'];

$query = "DELETE FROM publisher WHERE publisher_id = ?";
$stmt = $connection->prepare($query);

if ($stmt) {
    $stmt->bind_param('i', $publisher_id);
    if ($stmt->execute()) {
        header('Location: /');
    } else {
        echo 'Ошибка выполнения SQL-запроса: ' . $stmt->error;
    }
    $stmt->close();
} else {
    echo 'Ошибка подготовки SQL-запроса: ' . $connection->error;
}
$connection->close();
?>
