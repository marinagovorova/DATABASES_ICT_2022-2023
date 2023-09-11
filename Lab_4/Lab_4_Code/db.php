<?php
define('HOST', 'localhost');
define('USER', 'root');
define('PASSWORD', '0000');
define('DATABASE', 'registration');

$connect = mysqli_connect(HOST, USER, PASSWORD, DATABASE);

if (!$connect) {
    echo 'Не могу соединиться с БД. Код ошибки: ' . mysqli_connect_errno() . ', ошибка: ' . mysqli_connect_error();
    exit;
  }
?>