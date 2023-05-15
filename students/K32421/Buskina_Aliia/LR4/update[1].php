<?php
    require_once'../config/connect.php';
    $title=$_POST['title'];
    $description=$_POST['description'];
    $price=$_POST['price'];
    $id=$_POST['id'];
    mysqli_query($connect, "UPDATE `goods` SET `title` = '$title', `description` = '$description', `price` = '$price' WHERE `goods`.`id` = '$id'");

    header('Location: /');