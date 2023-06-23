<?php
	require("db.php");

	if(isset($_POST ['submit'])){
	   $sort = $_POST ['coffee_sort'];
	   $query = "DELETE FROM coffee WHERE coffee_sort=?";
	   
	   $db -> prepare($query) -> execute([$sort]);

	   echo "<script> alert('Coffee sort $sort was deleted'); </script>";
}

?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete tea</title>
</head>
<body>
    <form method="POST">
        <input type="text" name="coffee_sort" required placeholder="Enter coffee sort">
        <br>
        <br>
        <button type="submit" name="submit">Delete this sort of coffee</button>
    </form>
    <br>
    <a href="index.php">To main page -> </a>
</body>
</html>

