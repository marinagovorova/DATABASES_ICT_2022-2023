<?php

$username = 'postgres';
$password = '20012001S';
$host = 'localhost';
$dbname='lab4_sem4';
try{
    $database = new PDO("pgsql:host=$host;port=5432;dbname=$dbname;", $username, $password);
    $database -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $song_name=$_POST['song_name'];
    $song_link=$_POST['song_link'];
    $song_rating=$_POST['song_rating'];
    $song_views=$_POST['song_views'];

    $data = array(
        'title' => "$song_name",
        'link' => "$song_link",
        'rating' => "$song_rating",
        'views' => "$song_views",
    );

    if($song_rating > 0){
        $sql = "INSERT INTO songs(song_name, song_link, song_rating, song_views)".
    " VALUES(:title, :link, :rating, :views)";
    } else {
        $sql = "INSERT INTO songs(song_name, song_link, song_rating, song_views)".
        " VALUES(:title, :link, :0, :views)";
    }

    $statement = $database->prepare($sql);
    $statement->execute($data);

    echo "Запись успешно создана!<br/>";
}

catch(PDOException $e) {
echo "Ошибка при создании записи в базе данных: " . $e->getMessage();
echo "<br/><br/>";
}

$database = null;
?>

<!DOCTYPE html>
<html>
<head>
<a href="index.php">Возврат на главную страницу</a>
</html>