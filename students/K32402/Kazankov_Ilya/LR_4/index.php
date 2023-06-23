<?php
$username = 'root';
$password = '';
$dbname = 'train';
$conn = mysqli_connect('localhost', $username, $password, $dbname);
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $number = $_POST['number'];
    $name = $_POST['name'];
    $type_flight = $_POST['type_flight'];
    $type_train = $_POST['type_train'];
    $sql = "INSERT INTO train (name, type_flight, type_train)
            VALUES ('$name', '$type_flight', $type_train)";
mysqli_close($conn);
?>