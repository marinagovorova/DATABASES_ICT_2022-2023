<?php
$dbuser = 'postgres';
$dbpass = 'qwerty123';
$host = 'localhost';
$dbname='sports_club';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
$query1 = "INSERT INTO sports_club.coach_category(coach_id, category, date_start, date_end)
 VALUES('$_POST[coach_id]', '$_POST[category]', '$_POST[date_start]', '$_POST[date_end]')";
$result = pg_query($query1);

echo "<script>
        alert('Успешно добавлено!');
        window.history.go(-1);
    </script>";
?>