<?php
  require("db.php");

  if(isset($_POST ['submit'])){
     $name =$_POST ['nametea'];
     $type = $_POST['typetea'];
     $if_packed =$_POST ['if_packedtea'];

     $db->prepare("INSERT INTO tea (name, type, if_packed) VALUES (?, ?, ?)")->execute([$name, $type, $if_packed]);

     echo "<script>
     alert('Your tea is in our collection now');
     </script>";
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add tea</title>
</head>
<body>
    <form action="" method="POST">
        <input type="text" name="nametea" required placeholder="enter tea name">
        <input type="text" name="typetea" required placeholder="enter type of the tea (green, black, etc)">
        <input type="text" name="if_packedtea" placeholder="is the tea packed? (0/1)">
        <br>
        <br>
        <button type="submit" name="submit">Add your tea to the collection</button>
    </form>
    <br>
    <a href="index.php">To main page</a>
</body>
</html>