<?php
$dbuser = 'postgres';
$dbpass = 'bibita177013';
$host = 'localhost';
$dbname = 'library';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
?>