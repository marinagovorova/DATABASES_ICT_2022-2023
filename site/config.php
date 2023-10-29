<?php

$host = 'localhost'; 
$username = 'root'; 
$password = ''; 
$database = 'postgres'; 


$connection = mysqli_connect($host, $username, $password, $database);


if ($connection->connect_error) {
    die('Ошибка подключения: ' . $connection->connect_error);
} 
?>

