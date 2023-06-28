<?php
$dbuser = 'postgres';
$dbpass = '12345';
$host = 'localhost';
$dbname='Hotel';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
$query3 = "UPDATE hotel.hotel SET address = '$_POST[address]'
            WHERE hotel_code = '$_POST[hotel_code]'";
$result = pg_query($query3);

echo "<script>
        alert('Успешно обновлено!');
        window.history.go(-1);
    </script>";
?>