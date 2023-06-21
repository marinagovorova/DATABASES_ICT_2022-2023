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

    if($id != NULL and $song_name == NULL){
    $song_name=$_POST['song_name'];
        $sql = "DELETE FROM songs WHERE id = '$id'";
    } elseif ($id == NULL and $song_name != NULL) {
        $sql = "DELETE FROM songs WHERE song_name = '$song_name'";
    }else{
        $sql = "DELETE FROM songs WHERE song_name  = '$song_name' AND id = '$id'";
    }

    $database->query($sql);

    echo "Запись успешно удалена!";
}

catch(PDOException $e) {
    echo "Ошибка при удалении записи в базе данных: " . $e->getMessage();
    echo "<br/><br/>";
}

if($id == NULL and $song_name == NULL){
    echo "Данные не были введены<br/>";
}


$database = null;
?>

<!DOCTYPE html>
<html>
<head>
<a href="index.php">Возврат на главную страницу</a>
</html>