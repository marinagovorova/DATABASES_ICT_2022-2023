<?php
$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'trains';
$conn = mysqli_connect($host, $username, $password, $dbname);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];
    $type = $_POST['type'];
    $model = $_POST['model'];
    $manufacturer  = $_POST['manufacturer'];
    $number_of_seats  = $_POST['number_of_seats'];

    if (isset($_POST['edit'])) {
        $sql = "UPDATE vagons
                SET brand='$brand', model='$model', year=$year, price=$price
                WHERE id=$id";
        if (mysqli_query($conn, $sql)) {
            echo "true";
        } else {
            echo "false " . mysqli_error($conn);
        }
    } elseif (isset($_POST['delete'])) {
        $sql = "DELETE FROM vagons WHERE id=$id";
        if (mysqli_query($conn, $sql)) {
            echo "true";
        } else {
            echo "false" . mysqli_error($conn);
        }
    }
}

$sql = "SELECT * FROM vagons";
$result = mysqli_query($conn, $sql);
if (mysqli_num_rows($result) > 0) {
    echo "<h2>Таблица 'vagons'</h2>";
    echo "<table border='1'>";
    echo "<tr><th>ID</th><th>Type</th><th>model</th><th>manufacturer</th><th>number_of_seats</th></tr>";
    while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr><td>".$row['id']."</td><td>".$row['type']."</td><td>".$row['model']."</td><td>".$row['manufacturer']."</td><td>".$row['number_of_seats']."</td></tr>";
    }
    echo "</table>";
} else {
    echo "Таблица пуста";
}

mysqli_close($conn);
?>