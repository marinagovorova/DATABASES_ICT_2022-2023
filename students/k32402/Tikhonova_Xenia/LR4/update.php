<?php
    require("db.php");

    if(isset($_POST ['submit'])){
        $sort = $_POST ['coffee_sort'];
		$decaf = $_POST ['decaf'];
		$query = "UPDATE coffee SET decaf=? WHERE coffee_sort=?";
		
        $db -> prepare($query) -> execute([$decaf]);

        echo "<script>
        alert('Current coffee sort info was updated');  
        </script>";
}

?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update decaf status</title>
</head>
<body>
    <form action="" method="POST">
        <input type="text" name="coffee_sort" required placeholder="Enter coffee sort">
        <input type="text" name="decaf" placeholder="Decaf? (0/1)">
        <br>
        <br>
        <button type="submit" name="submit">Update decaf information</button>
    </form>
    <br>
    <a href="index.php">To main page -> </a>
</body>
</html>

