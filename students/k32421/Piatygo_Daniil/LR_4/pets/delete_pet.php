<?php
require_once "config.php";

if (isset($_GET['pet_id'])) {
    $pet_id = $_GET['pet_id'];

    $query = "DELETE FROM pets WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->execute([$pet_id]);
}

header("Location: view_pets.php");
exit();