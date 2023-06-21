<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>songs database</title>
</head>
<body>

<?php
$username = 'postgres';
$password = '20012001S';
$host = 'localhost';
$dbname='lab4_sem4';
try{
    $database = new PDO("pgsql:host=$host;port=5432;dbname=$dbname;", $username, $password);
    $database -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $id=$_POST['id'];
    $song_name=$_POST['song_name'];
    $song_link=$_POST['song_link'];
    $song_rating=$_POST['song_rating'];
    $song_views=$_POST['song_views'];

    if($song_name != NULL){
        $database->query("UPDATE songs SET song_name='$song_name' WHERE id='$id'");
    }
    if($song_link != NULL){
        $database->query("UPDATE songs SET song_link='$song_link' WHERE id='$id'");
    }
    if($song_rating != NULL){
        $database->query("UPDATE songs SET song_rating='$song_rating' WHERE id='$id'");
    }
    if($song_views != NULL){
        $database->query("UPDATE songs SET song_views='$song_views' WHERE id='$id'");
    }

    echo "Запись успешно изменена!<br/>";
}

catch(PDOException $e) {
    echo "Ошибка при изменении записей из базы данных: " . $e->getMessage();
    echo "<br/><br/>";
}


$database = null;  
?>

<!DOCTYPE html>
<html>
<head>
<a href="index.php">Возврат на главную страницу</a>
</html>