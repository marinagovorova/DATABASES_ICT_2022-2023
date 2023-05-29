<?php
$dbuser = 'postgres';
$dbpass = '12345';
$host = 'localhost';
$dbname='Hotel';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
$query2 = "DELETE FROM hotel.hotel WHERE name = '$_POST[name2]'";
$result = pg_query($query2);

echo "<script>
        alert('Удалено!');
        window.history.go(-1);
    </script>";
?>
