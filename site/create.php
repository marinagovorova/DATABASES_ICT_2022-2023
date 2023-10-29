<?php
require_once 'config.php';

$publisher_name = $_GET['publisher_name'];
$country_of_pub = $_GET['country_of_pub'];
$city_of_pub = $_GET['city_of_pub'];
$publisher_id = $_GET['publisher_id'];

$query = "INSERT INTO publisher (publisher_name, country_of_pub, city_of_pub, publisher_id) VALUES (?, ?, ?, ?);";

$stmt = $connection->prepare($query);

if ($stmt) {
    $stmt->bind_param('ssdi', $publisher_name, $country_of_pub, $city_of_pub, $publisher_id);
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
