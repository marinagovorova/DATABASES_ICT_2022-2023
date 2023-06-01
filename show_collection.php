<?php
  require("db.php");
  $d = $db->query("select * from tea")
?>

<table border="3" cellpading="5" cellspacing="5" align="center"> 
<tr>
	<th>Tea name</th>
	<th>Tea type</th>
	<th>Is tea packed</th>
</tr>

<?php
	foreach ($d as $data) 
	{
?>

<tr>
	<td><?php echo $data['name']; ?></td>
	<td><?php echo $data['type']; ?></td>
	<td><?php echo $data['if_packed']; ?></td>
</tr>

<?php
}
?>

<a href="index.php">To main page</a>