<?php
$dbuser = 'postgres';
$dbpass = 'Ballack77';
$host = 'localhost';
$dbname='labb1';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
$query3 = "UPDATE public.owner SET driver_full_name = '$_POST[driver_full_name]', 
 telephone = '$_POST[telephone]', address = '$_POST[address]', status = '$_POST[status]' 
            WHERE driver_license_number = '$_POST[driver_license_number]'";
$result = pg_query($query3);

echo "<script>
        alert('Успешно обновлено!');
        window.history.go(-1);
    </script>";
?>