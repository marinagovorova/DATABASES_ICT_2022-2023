<?php
$dbuser = 'postgres';
$dbpass = '12345';
$host = 'localhost';
$dbname='Hotel';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
$query1 = "INSERT INTO hotel.hotel(address, city, name, space_number) VALUES('$_POST[address]', '$_POST[city]', '$_POST[name1]', '$_POST[sp_number]')";
$result = pg_query($query1);

echo "<script>
        alert('Успешно добавлено!');
        window.history.go(-1);
    </script>";
?>