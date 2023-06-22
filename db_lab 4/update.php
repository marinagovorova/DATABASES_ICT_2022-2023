<?php 
$dbuser = 'postgres';
$dbpass = '315510';
$host = 'localhost';
$dbname='postgres';
$dbconnect = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");

$vendorId = $_POST['vendorId'];
$vendorName = $_POST['vendorName'];

if ($vendorId != '') {
    $query = "UPDATE vendors2 SET name='$vendorName' WHERE id = $vendorId;";
    $result = pg_query($dbconnect, $query);
}

$result = pg_query($dbconnect, $query);
header("Location: http://localhost?message=Запрос выполнен!");
?>