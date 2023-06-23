<?php
  require("db.php");
  $d = $db -> query("select * from coffee")
?>

<table border = "4" align = "center"> 
<tr>
	<th>Coffee sort</th>
	<th>Decaf status</th>
</tr>

<?php
	foreach ($d as $el) 
	{
?>

<tr>
	<td><?php echo $el['coffee_sort']; ?></td>
	<td><?php echo $el['decaf']; ?></td>
</tr>

<?php
}
?>

<a href="index.php">To main page -></a>


