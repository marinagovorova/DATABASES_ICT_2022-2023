<?php
require("db.php");

if(isset($_POST ['submit'])){
   $name =$_POST ['nameproduct'];
   $cost = $_POST['costproduct'];
   $photo =$_POST ['imgproduct'];

   $db->query("INSERT INTO products (name, cost, photo) VALUES ('$name', '$cost', '$photo')");

   echo "<script>
   alert('товар успешно создан');
   </script>";
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Document</title>
</head>
<body>
    <form action="" method="POST">
        <input type="text" name="imgproduct" placeholder="введите url цветка">
        <br>
        <input type="text" name="nameproduct" required placeholder="введите название цветка">
        <br>
        <input type="text" name="costproduct" required placeholder="введите стоимость цветка">
        <br>
        <button type="submit" name="submit">Создать</button>
    </form>

    <a href="index.php">Назад</a>
</body>
</html>