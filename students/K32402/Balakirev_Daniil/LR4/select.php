<?php
$dbuser = 'postgres';
$dbpass = 'Ballack77';
$host = 'localhost';
$dbname='labb1';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");

$query = "SELECT * FROM public.owner";
$result = pg_query($query);

while ($row = pg_fetch_assoc($result)) {
    echo "Номер водительского удостоверения: " . $row['driver_license_number'] . "<br>";
    echo "Полное имя водителя: " . $row['driver_full_name'] . "<br>";
    echo "Телефон: " . $row['telephone'] . "<br>";
    echo "Адрес: " . $row['address'] . "<br>";
    echo "Статус: " . $row['status'] . "<br><br>";
}
?>
