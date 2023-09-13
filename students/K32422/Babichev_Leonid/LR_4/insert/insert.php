<! DOCTYPE html>
<head>
<title>Insert data</title>
<meta http-equiv="Content-Type" content="text/html;
charset=utf-8" />
<style>
li {list-style: none;}
</style>
</head>
<body>
<h2>Добавление нового филиала</h2>
<ul>
<form name="insert" action="index.php" method="GET" >
<li>Введите ID филиала:</li><li><input type="text" name="id_garage" /></li>
<li>Введите адрес филиала в формате 'Улица ..., дом ...':</li><li><input type="text" name="address" /></li>
<li>Введите ID города (от 1 до 3):</li><li><input type="text" name="id_city" /></li>
<li>Введите работника:</li><li><input type="text" name="id_staff" /></li>
<li><input type="submit" name="submit" /></li>
</form>
</ul>
</body>
</html>
