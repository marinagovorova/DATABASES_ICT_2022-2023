<?php
	require("db.php");

	if(isset($_POST ['submit'])){
	   $name =$_POST ['nametea'];

	   $db->prepare("DELETE FROM tea WHERE name=?")->execute([$name]);

	   echo "<script>
	   alert('Untasty tea was deleted');
	   </script>";
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete tea</title>
</head>
<body>
    <form action="" method="POST">
        <input type="text" name="nametea" required placeholder="Enter tea name">
        <br>
        <br>
        <button type="submit" name="submit">Delete untasty tea</button>
    </form>
    <br>
    <a href="index.php">To main page</a>
</body>
</html>