<?php
$dbuser = 'postgres';
$dbpass = '12345';
$host = 'localhost';
$dbname='Hotel';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");

$result = pg_query($db, "SELECT * FROM hotel.hotel");

$rows = pg_num_rows($result);
echo "Всего отелей: " . $rows . ".\n";


?>    