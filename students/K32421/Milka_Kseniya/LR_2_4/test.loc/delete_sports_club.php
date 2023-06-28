<?php
$dbuser = 'postgres';
$dbpass = 'qwerty123';
$host = 'localhost';
$dbname='sports_club';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
$query2 = "DELETE FROM sports_club.coach_category WHERE coach_category_id = 
'$_POST[coach_category_id]'";
$result = pg_query($query2);

echo "<script>
        alert('Удалено!');
        window.history.go(-1);
    </script>";
?>
