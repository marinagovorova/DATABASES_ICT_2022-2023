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

    if($id != NULL and $song_name == NULL){
        $sql = "SELECT * FROM songs WHERE id='$id'";
    }elseif($id == NULL and $song_name != NULL){
        $sql = "SELECT * FROM songs WHERE song_name='$song_name'";
    }elseif($id == NULL and $song_name == NULL){
        $sql = "SELECT * FROM songs";        
    }
    $result = $database->query($sql)->fetchAll(PDO::FETCH_ASSOC);
}
catch(PDOException $e) {
    echo "Ошибка при выводе записей из базе данных: " . $e->getMessage();
    echo "<br/><br/>";
}

if($id == NULL and $song_name == NULL){
    echo "Данные не были введены<br/>";
}
$database = null;  
?>
    <table border = "1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Название песни</th>
                <th>Ссылка</th>
                <th>Рейтинг песни</th>
                <th>Кол-во просмотров</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($result as $row): ?>
            <tr>
                <td><?php echo $row['id']; ?></td>
                <td><?php echo $row['song_name']; ?></td>
                <td><?php echo '<a href = "'.$row['song_link'].'">ссылка</a>'?></td>
                <td><?php echo $row['song_rating']; ?></td>
                <td><?php echo $row['song_views']; ?></td>
            </tr>
            <?php endforeach; ?>    
        </tbody>
    </table>
    <br/><a href="index.php">Вернуться на главную</a><br/><br/>
</body>
</html>
