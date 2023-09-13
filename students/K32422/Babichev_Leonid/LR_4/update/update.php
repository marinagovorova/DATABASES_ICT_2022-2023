<!DOCTYPE html>
<head>
<title>Update data</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
li {list-style: none;}
</style>
</head>
<body>
<h2>Просмотр информации о филиале, адрес которого мы хотим поменять.</h2>
<ul>
<form name="display" action="index.php" method="GET" >
<li>Введите id филиала:</li><li><input type="text" name="id_garage" /></li>
<li><input type="submit" name="garage" /></li>
</form>
</ul>
<h2>Изменение адреса выбранного филиала</h2>
<ul>
<form name="update" action="index.php" method="GET" >
<li>Введите id филиала:</li><li><input type="text" name="id_garage" /></li>
<li>Введите новый адрес филиала в формате 'Улица ..., дом ...':</li><li><input type="text" name="address"/></li>
<li><input type="submit" name="update_address" value="Обновить адрес" /></li>
</form>
<ul>
</body>
</html>