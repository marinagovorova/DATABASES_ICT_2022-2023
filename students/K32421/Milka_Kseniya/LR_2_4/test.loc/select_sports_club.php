<?php
$dbuser = 'postgres';
$dbpass = 'qwerty123';
$host = 'localhost';
$dbname='sports_club';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");

$result = pg_query($db, "SELECT * FROM sports_club.coach_category");

$rows = pg_num_rows($result);
echo "Все категории тренеров: " . $rows . ".\n";


?>    