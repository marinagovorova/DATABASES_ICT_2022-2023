<?php
$dbuser = 'postgres';
$dbpass = 'qwerty123';
$host = 'localhost';
$dbname='sports_club';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
$query3 = "UPDATE sports_club.coach_category SET category = '$_POST[category]', 
 date_start = '$_POST[date_start]', date_end = '$_POST[date_end]' 
            WHERE coach_category_id = '$_POST[coach_category_id]'";
$result = pg_query($query3);

echo "<script>
        alert('Успешно обновлено!');
        window.history.go(-1);
    </script>";
?>