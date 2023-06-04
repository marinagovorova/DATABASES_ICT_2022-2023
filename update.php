<?php
    require("db.php");

    if(isset($_POST ['submit'])){
        $name =$_POST ['nametea'];
        $type = $_POST['typetea'];
        $if_packed =$_POST ['if_packedtea'];

        $db->prepare("UPDATE tea SET type=?, if_packed=? WHERE name=?")->execute([$type, $if_packed, $name]);

        echo "<script>
        alert('Tea information was updated');  
        </script>";
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update tea</title>
</head>
<body>
    <form action="" method="POST">
        <input type="text" name="nametea" required placeholder="Enter tea name">
        <input type="text" name="typetea" required placeholder="enter type of the tea (green, black, etc)">
        <input type="text" name="if_packedtea" placeholder="is the tea packed? (0/1)">
        <br>
        <br>
        <button type="submit" name="submit">Update tea information</button>
    </form>
    <br>
    <a href="index.php">To main page</a>
</body>
</html>