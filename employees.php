<?php
$dbuser = 'postgres';
$dbpass = '12345';
$host = 'localhost';
$dbname='Hotel';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
$query5 = "INSERT INTO hotel.employees(hotel_id, post, fio) VALUES('$_POST[hotel_id]', '$_POST[post]', '$_POST[fio]')";
$result = pg_query($query5);

echo "<script>
        alert('Сотрудник успешно добавлен!');
        window.history.go(-1);
    </script>";


?>