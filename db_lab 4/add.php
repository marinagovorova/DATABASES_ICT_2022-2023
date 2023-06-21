<?php 
$dbuser = 'postgres';
$dbpass = '315510';
$host = 'localhost';
$dbname='postgres';
$dbconnect = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");

$query = "SELECT * FROM vendors2;";
$result = pg_query($dbconnect, $query);
$vendors = pg_fetch_all($result); 
array_multisort($vendors);
$lastVendor = end($vendors);
$lastVendorId = $lastVendor['id'];

$vendorName = $_POST['vendorName'];
$newVendorId = $lastVendorId + 1;
if($vendorName !=""){
    $query = "INSERT INTO vendors2 VALUES($newVendorId, '$vendorName')";
    $result = pg_query($dbconnect, $query);
}

header("Location: http://localhost?message=Запрос выполнен!");
?>