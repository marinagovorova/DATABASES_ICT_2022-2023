<?php
namespace App\Service;

use \PDO;

$dbuser = 'postgres';
$dbpass = 'dbitmo';
$host = 'localhost';
$dbname = 'car_service';

$db = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);

if (isset($_GET['submit'])) {
    $idGarage = $_GET['id_garage'];
    $address = $_GET['address'];
    $idCity = $_GET['id_city'];
    $idStaff = $_GET['id_staff'];

    $stmt = $db->prepare('INSERT INTO car_service.garage (id_garage, address, id_city, id_staff) VALUES (?, ?, ?, ?)');
    $stmt->execute([$idGarage, $address, $idCity, $idStaff]);

    echo 'Данные успешно добавлены!';
}
?>