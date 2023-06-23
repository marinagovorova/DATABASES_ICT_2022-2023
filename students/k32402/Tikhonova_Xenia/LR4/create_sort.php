<?php
  require("db.php");

  if(isset($_POST ['submit'])){
    $sort = $_POST['coffee_sort'];
    $decaf = $_POST['decaf'];
	$query = "INSERT INTO coffee (coffee_sort, decaf) VALUES (?, ?)";
	 
	$db->prepare($query)->execute([$sort, $decaf]);
	 
    echo "<script>
    alert('This sort is added to our waitlist');
    </script>";
}

?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add coffee</title>
</head>
<body>
    <form action="" method="POST">
        <input type="text" name="coffee_sort" required placeholder="Enter coffee sort">
        <input type="text" name="decaf" placeholder="Decaf? (0 for no, 1 for yes)">
        <br>
        <br>
        <button type="submit" name="submit">Add coffee to the waitlist</button>
    </form>
    <br>
    <a href="index.php"> To main page -> </a>
</body>
</html>




