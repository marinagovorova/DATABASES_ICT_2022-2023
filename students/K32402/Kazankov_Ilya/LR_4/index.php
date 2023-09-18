<!DOCTYPE html>
<html>
<head>
    <title>Таблица значений</title>
    <style>
        table {
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
        }
    </style>
</head>
<body>

<?php
$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'trains';
$conn = mysqli_connect($host, $username, $password, $dbname);
if (!$conn) {
    die('Ошибка подключения: ' . mysqli_connect_error());
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $type = $_POST['type'];
    $model = $_POST['model'];
    $manufacturer  = $_POST['manufacturer'];
    $number_of_seats  = $_POST['number_of_seats'];
    $sql = "INSERT INTO vagons (type, model, manufacturer, number_of_seats)
            VALUES ('$type', '$model', '$manufacturer', $number_of_seats)";

    if (mysqli_query($conn, $sql)) {
        echo "Данные успешно добавлены в таблицу";
    } else {
        echo "Ошибка при добавлении данных: " . mysqli_error($conn);
    }
}
$sql = "SELECT * FROM vagons";
$result = mysqli_query($conn, $sql);
if (mysqli_num_rows($result) > 0) {
    echo "<h2>Таблица значений:</h2>";
    echo "<table>";
    echo "<tr><th>ID</th><th>Type</th><th>model</th><th>manufacturer</th><th>number_of_seats</th></tr>";
    while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr><td>".$row['id']."</td><td>".$row['type']."</td><td>".$row['model']."</td><td>".$row['manufacturer']."</td><td>".$row['number_of_seats']."</td></tr>";
    }
    echo "</table>";
} else {
    echo "Таблица 'auto' пуста";
}

mysqli_close($conn);
?>