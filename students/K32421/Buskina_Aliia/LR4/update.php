<?php
    require_once'config/connect.php';
    $goods_id = $_GET['id'];
    $good = mysqli_query($connect, "SELECT * FROM `goods` WHERE `id`='$goods_id'");
    $good = mysqli_fetch_assoc($good);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>Обновить товар</title>
</head>
<body>

<h2>Обновить товар</h2>
    <form action="vendor/update.php" method="post">
        <input type="hidden" name="id" value="<?=$goods_id ?>">
        <p>Название</p>
        <input type="text" name="title" value="<?=$good['title']?>">
        <p>Описание</p>
        <textarea name="description"><?=$good['description']?></textarea>
        <p>Цена</p>
        <input type="number" name="price" value="<?=$good['price']?>">
        <button type="submit">Обновить</button>
    </form>

</body>
</html>