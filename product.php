<?php

    require_once 'config.php';

    $product_id = $_GET['id'];

    $product = mysqli_query($connect, "SELECT * FROM `products` WHERE `id` = '$product_id'");

    $product = mysqli_fetch_assoc($product);

?>

<!doctype html>
<html lang="en">
<head>
    <title>Product</title>
</head>
<body>
    <h2>Title: <?= $product['title'] ?></h2>
    <h4>Price: <?= $product['price'] ?></h4>
    <p>Description: <?= $product['description'] ?></p>
</body>
</html>