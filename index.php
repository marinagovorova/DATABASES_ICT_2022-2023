<?php
	require("db.php");
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <title>Tea collection</title>
</head>
<body>
    <header>
        <div>
            <h1>Greatest tea collection</h1>
            <p>Collecting best tea from all over the world since 2023<p>
        </div>
    </header>

<a style = "cursor: pointer;" href="show_collection.php">Enjoy our collection</a>
<br>
<br>
<br>
<h4> Found a tasty tea? Add it to our collection </h4>
<a style = "cursor: pointer;" href="create.php">Add your tea</a>
<br>
<br>
<h4> The tea from our collection is not tasty? </h4>
<a style = "cursor: pointer;" href="delete.php">Get rid of untasty tea</a>
<br>
<br>
<h4> Found wrong information in our collection? </h4>
<a style = "cursor: pointer;" href="update.php">Correct the mistake</a>