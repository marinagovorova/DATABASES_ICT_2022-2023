<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $publisher_name = $_POST['publisher_name'];
    $country_of_pub = $_POST['country_of_pub'];
    $city_of_pub = $_POST['city_of_pub'];
    $publisher_id = $_POST['publisher_id'];

    $query = "INSERT INTO publisher (publisher_name, country_of_pub, city_of_pub, publisher_id) VALUES (?, ?, ?, ?)";
 
    $stmt = $connection->prepare($query);

    if ($stmt) {
        $stmt->bind_param('sssi', $publisher_name, $country_of_pub, $city_of_pub, $publisher_id);
        if ($stmt->execute()) {
            header('Location: /');
        } else {
            echo 'Ошибка выполнения SQL-запроса: ' . $stmt->error;
        }
        $stmt->close();
    } else {
        echo 'Ошибка подготовки SQL-запроса: ' . $connection->error;
    }
}

$query = "SELECT * FROM publisher";
$result = $connection->query($query);

?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Publisher</title>
</head>
<style>
    th, td {
        padding: 10px;
    }

    th {
        background: #606060;
        color: #fff;
    }

    td {
        background: #b5b5b5;
    }
</style>
<body>
<table>
    <tr>
        <th>ID</th>
        <th>Название издательства</th>
        <th>Страна издательства</th>
        <th>Город издательства</th>
    </tr>

    <?php
    if ($result) {
        while ($pub = $result->fetch_assoc()) {
            ?>
            <tr>
                <td><?= $pub['publisher_id'] ?></td>
                <td><?= $pub['publisher_name'] ?></td>
                <td><?= $pub['country_of_pub'] ?></td>
                <td><?= $pub['city_of_pub'] ?></td>
                <td><a href="view_name.php?publisher_id=<?= $pub['publisher_id'] ?>">View</a></td>
                <td><a href="updatepublisher.php?publisher_id=<?= $pub['publisher_id'] ?>">Update</a></td>
                <td><a style="color: red;" href="delete.php?publisher_id=<?= $pub['publisher_id'] ?>">Delete</a></td>
            </tr>
            <?php
        }
        $result->free();
    } else {
        echo 'Ошибка выполнения SQL-запроса: ' . $connection->error;
    }
    $connection->close();
    ?>
</table>

<h3>Добавление нового издательства</h3>
<form action="index.php" method="POST">
    <p>Название издательства</p>
    <input type="text" name="publisher_name">
    <p>Страна издательства</p>
    <input type="text" name="country_of_pub">
    <p>Город издательства</p>
    <input type="text" name="city_of_pub">
    <p>ID издательства</p>
    <input type="number" name="publisher_id"> <br> <br>
    <button type="submit">Добавить</button>
</form>
</body>
</html>
