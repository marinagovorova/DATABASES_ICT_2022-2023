<?php
require_once "config.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $type = $_POST['type'];
    $name = $_POST['name'];

    $query = "INSERT INTO trains (type, name) VALUES (?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->execute([$type, $name]);

}

header("Location: index.php");
exit();