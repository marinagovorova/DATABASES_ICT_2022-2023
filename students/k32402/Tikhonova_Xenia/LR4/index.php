<?php
	require("db.php");
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <title>Coffee Site</title>
	<style>
        h4 {
            color: grey;
        }
    </style>
</head>
<body>
    <header>
        <div>
            <h1>Product, that makes your day</h1>
            <p>Shop with worlwide coffee variety<p>
        </div>
    </header>

<a style = "cursor: pointer;" href="show_sorts.php"><b> SHOW SORTS </b> in stock</a>
<br>
<br>
<br>
<br>
<h3> If you found the wrong info about the products:</h3>
<a style = "cursor: pointer;" href="update.php">Click here to <b> UPDATE SORT </b> </a>
<br>
<br>
<br>
<h3> For our licensed coffee enjoyers </h3>
<a style = "cursor: pointer;" href="create_sort.php"><b> ADD YOUR FINDING </b> to our waitlist</a>
<br>
<br>
<br>
<br>
<br>
<h4> For our stuff and coffee examination </h4>
<a style = "cursor: pointer;" href="delete_sort.php"><b> DELETE </b> the outdated sorts</a>
<br>


