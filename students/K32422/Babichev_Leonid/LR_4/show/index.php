<?php
namespace App\Service;
use PDO;
$dbuser = 'postgres';
$dbpass = 'dbitmo';
$host = 'localhost';
$dbname = 'car_service';

$pdo = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);	

$stmt = $pdo->query('SELECT *
FROM car_service.garage, car_service.city
WHERE car_service.garage.id_city = car_service.city.id_city');

while ($row = $stmt->fetch())
{
    echo 'Branch ID (ID филиала): '.$row['id_garage']."<br />";
    echo 'Branch Address (Адрес филиала): '.$row['address']."<br />";
    echo 'City ID (ID города): '.$row['id_city']."<br />";
    echo 'City Name (Название города): '.$row['city_name']."<br />";
    echo 'City Region (Регион): '.$row['region']."<br />";
    echo "<br />";
}

?>
