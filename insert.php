<?php
$dbuser = 'postgres';
$dbpass = '12345';
$host = 'localhost';
$dbname='Hotel';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
$query = "INSERT INTO hotel.hotel(name) VALUES('$_POST[Name]')";
$result = pg_query($query);

echo "<script>
        alert('Успешно добавлено!');
        window.history.go(-1);
    </script>";


?>