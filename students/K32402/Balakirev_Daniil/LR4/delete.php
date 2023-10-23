<?php
$dbuser = 'postgres';
$dbpass = 'Ballack77';
$host = 'localhost';
$dbname='labb1';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
$query2 = "DELETE FROM public.owner WHERE driver_license_number = 
'$_POST[driver_license_number]'";
$result = pg_query($query2);

echo "<script>
        alert('Удалено!');
        window.history.go(-1);
    </script>";
?>