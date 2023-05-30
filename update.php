<?php
require("db.php");

 if ($_SERVER['REQUEST_METHOD']=== 'GET') {

    $id = $_GET["id"];
    $product = $db->query("SELECT * FROM products WHERE id =$id")->fetchAll(PDO::FETCH_ASSOC);
        $product = $product[0];
 
 } else if ($_SERVER['REQUEST_METHOD']=== 'POST'){
    $id = $_POST['id'];
    $name = $_POST['nameproduct'];
    $cost = $_POST['costproduct'];
    $photo = $_POST ['imgproduct'];
    $db -> query("UPDATE products SET name= '$name', cost ='$cost', photo = '$photo' WHERE  id= $id");

    echo "<script>
    alert('товар успешно изменена');
    location.href ='index.php';
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
    <title>Изменение данных</title>
</head>
<body>
    <form action="" method="POST">
        <input type="text" name="imgproduct" value="<?php echo $product["photo"] ?>">
        <br>
        <input type="text" name="nameproduct" value="<?php echo $product["name"]?>">
        <br>
        <input type="text" name="costproduct" value="<?php echo $product["cost"] ?>">
        <input type="hidden" name="id" value="<?php echo $product["id"] ?>">
        <br>
        <button type="submit" name="submit">Сохранить</button>
    </form>

    <a href="index.php"> назад</a>
</body>
</html>