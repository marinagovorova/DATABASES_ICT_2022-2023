<?php
$dbuser = 'postgres';
$dbpass = 'Ballack77';
$host = 'localhost';
$dbname='labb1';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");

$query1 = "INSERT INTO public.owner(driver_license_number, driver_full_name, telephone, address, status)
 VALUES('$_POST[driver_license_number]', '$_POST[driver_full_name]', '$_POST[telephone]', '$_POST[address]', '$_POST[status]')";
$result = pg_query($query1);

echo "<script>
        alert('Успешно добавлено!');
        window.history.go(-1);
    </script>";
?>