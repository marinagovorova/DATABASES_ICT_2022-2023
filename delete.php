<?php

require_once 'config.php';

$id = $_GET['id'];

mysqli_query($connect, "DELETE FROM `products` WHERE `products`.`id` = '$id'");

header('Location: /');