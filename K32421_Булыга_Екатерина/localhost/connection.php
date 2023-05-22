<?php
    $dbuser = 'postgres';
    $dbpass = 'master';
    $host = 'localhost';
    $dbname = 'bankdatabase';
    $pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);
?> 
