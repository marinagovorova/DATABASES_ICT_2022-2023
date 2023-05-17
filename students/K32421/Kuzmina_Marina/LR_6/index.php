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
// Подключаемся к серверу MySQL
$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'auto';

$conn = mysqli_connect($host, $username, $password, $dbname);

// Проверяем соединение
if (!$conn) {
    die('Ошибка подключения: ' . mysqli_connect_error());
}

// Обработка формы вставки данных
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $brand = $_POST['brand'];
    $model = $_POST['model'];
    $year = $_POST['year'];
    $price = $_POST['price'];

    // Вставка данных в таблицу 'auto'
    $sql = "INSERT INTO auto (brand, model, year, price)
            VALUES ('$brand', '$model', $year, $price)";

    if (mysqli_query($conn, $sql)) {
        echo "Данные успешно добавлены в таблицу 'auto'";
    } else {
        echo "Ошибка при добавлении данных: " . mysqli_error($conn);
    }
}

// Выводим таблицу значений
$sql = "SELECT * FROM auto";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    echo "<h2>Таблица значений:</h2>";
    echo "<table>";
    echo "<tr><th>ID</th><th>Бренд</th><th>Модель</th><th>Год</th><th>Цена</th></tr>";

    while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr>";
        echo "<td>".$row['id']."</td>";
        echo "<td>".$row['brand']."</td>";
        echo "<td>".$row['model']."</td>";
        echo "<td>".$row['year']."</td>";
        echo "<td>".$row['price']."</td>";
        echo "</tr>";
    }

    echo "</table>";
} else {
    echo "Таблица 'auto' пуста";
}

// Закрываем соединение
mysqli_close($conn);
?>
