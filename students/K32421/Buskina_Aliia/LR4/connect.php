<?php
    $connect = mysqli_connect('localhost', 'root','', 'crud2');
    if (!$connect){
        die('ошибка подключения к бд!');
    }
