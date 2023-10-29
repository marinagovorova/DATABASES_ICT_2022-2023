<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $publisher_id = $_POST['publisher_id'];
    $new_publisher_name = $_POST['new_publisher_name'];

    if (!empty($new_publisher_name) && is_numeric($publisher_id)) {
        $query = "UPDATE publisher SET publisher_name = ? WHERE publisher_id = ?";
        $stmt = $connection->prepare($query);

        if ($stmt) {
            $stmt->bind_param('si', $new_publisher_name, $publisher_id);

            if ($stmt->execute()) {
                echo 'Информация успешно обновлена.';
            } else {
                echo 'Ошибка выполнения SQL-запроса: ' . $stmt->error;
            }

            $stmt->close();
        } else {
            echo 'Ошибка подготовки SQL-запроса: ' . $connection->error;
        }
    } else {
        echo 'Заполните правильно все поля.';
    }
}
$connection->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Обновить информацию</title>
</head>
<body>
<h3>Обновить информацию</h3>
<form action="updatepublisher.php" method="post">
    <p>Введите ID издательства</p>
    <input type="number" name="publisher_id">
    <p>Введите новое имя издательства</p>
    <input type="text" name="new_publisher_name">
    <br> <br>
    <button type="submit">Обновить</button>
</form>
</body>
</html>
