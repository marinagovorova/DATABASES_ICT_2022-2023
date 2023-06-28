
<!DOCTYPE html>
   <head>
<title>Insert data to PostgreSQL with php - creating a simple web         application</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
li {listt-style: none;}
</style>
   </head>
   <body>
<h2>Данные о госте</h2>
<ul>
<form name="insert" action="insert.php" method="POST" >
<li>Паспортные данные:</li><li><input type="text" name="passport_id" /></li>
<li>ФИО:</li><li><input type="text" name="resident_fio" /></li>
<li><input type="submit" name="submit"/></li>
</form>
</ul>
</body>
</html>
<?php
$dbuser = 'postgres';
$dbpass = '12345';
$host = 'localhost';
$dbname = 'Hotel';
$db = pg_connect("host=$host dbname=$dbname user=$dbuser password=$dbpass");
if (isset($_POST['submit'])) {
		
	$query = "INSERT INTO hotel.resident VALUES ('$_POST[passport_id]', '$_POST[resident_fio]')";
	$result = pg_query($query);
	pg_close($db); 
	if (!$result)
	{
		echo "Update failed!!";
	} else
		{
			echo "Update successfull;";
		}
	}
?> 

