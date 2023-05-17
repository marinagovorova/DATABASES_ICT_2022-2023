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

// Обработка формы редактирования и удаления данных
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];
    $brand = $_POST['brand'];
    $model = $_POST['model'];
    $year = $_POST['year'];
    $price = $_POST['price'];

    if (isset($_POST['edit'])) {
        // Редактирование данных в таблице 'auto'
        $sql = "UPDATE auto
                SET brand='$brand', model='$model', year=$year, price=$price
                WHERE id=$id";

        if (mysqli_query($conn, $sql)) {
            echo "Данные успешно отредактированы в таблице 'auto'";
        } else {
            echo "Ошибка при редактировании данных: " . mysqli_error($conn);
        }
    } elseif (isset($_POST['delete'])) {
        // Удаление данных из таблицы 'auto'
        $sql = "DELETE FROM auto WHERE id=$id";

        if (mysqli_query($conn, $sql)) {
            echo "Данные успешно удалены из таблицы 'auto'";
        } else {
            echo "Ошибка при удалении данных: " . mysqli_error($conn);
        }
    }
}

// Вывод таблицы 'auto'
$sql = "SELECT * FROM auto";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    echo "<h2>Таблица 'auto'</h2>";
    echo "<table border='1'>";
    echo "<tr><th>ID</th><th>Бренд</th><th>Модель</th><th>Год</th><th>Цена</th></tr>";
    while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr><td>".$row['id']."</td><td>".$row['brand']."</td><td>".$row['model']."</td><td>".$row['year']."</td><td>".$row['price']."</td></tr>";
    }
    echo "</table>";
} else {
    echo "Таблица 'auto' пуста";
}

// Закрываем соединение
mysqli_close($conn);
?>