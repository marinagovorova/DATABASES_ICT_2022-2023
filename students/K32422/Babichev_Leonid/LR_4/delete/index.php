<?php
namespace App\Service;
use PDO;
$dbuser = 'postgres';
$dbpass = 'dbitmo';
$host = 'localhost';
$dbname = 'car_service';

$db = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);	

if (isset($_GET['garage'])) {
$select=$db->query("SELECT * FROM car_service.garage WHERE car_service.garage.id_garage=$_GET[id_garage]");
while ($row = $select->fetch())
{
echo 'Branch ID (ID филиала): '.$row['id_garage']."<br />";
echo 'Branch Address (Адрес филиала): '.$row['address']."<br />";
echo 'City ID (ID города): '.$row['id_city']."<br />";
}
};
if (isset($_GET['address'])) {
$update=$db->query("DELETE FROM car_service.garage WHERE car_service.garage.id_garage=$_GET[id_garage]");
echo 'Данные успешно удалены!';
};
?>
