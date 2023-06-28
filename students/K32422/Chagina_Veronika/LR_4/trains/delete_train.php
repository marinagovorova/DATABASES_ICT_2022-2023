<?php
require_once "config.php";

if (isset($_GET['train_id'])) {
    $train_id = $_GET['train_id'];

    $query = "DELETE FROM trains WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$train_id]);
}

header("Location: view_trains.php");
exit();