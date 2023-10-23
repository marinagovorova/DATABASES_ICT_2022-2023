<!DOCTYPE html>
   <head>
<title>-_-</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
li {listt-style: none;}
</style>
   </head>
   <body>


<h3>Введите данные:</h3>
<form name="insert" action="insert.php" method="POST">
Номер водительского удостоверения<br>
<input type="int" name="driver_license_number"/><br>
ФИО<br>
<input type="text" name="driver_full_name"/><br>
Телефон<br>
<input type="int" name="telephone"/><br>
Адрес<br>
<input type="text" name="address"/><br>
Статус<br>
<input type="tetxt" name="status"/><br>
<input type="submit"/>
</form>

<hr>

<h3>Введите номер водительского удостоверения, который вы хотите удалить:</h3>
<form name="delete" action="delete.php" method="POST">
Номер водительского удостоверения<br>
<input type="int" name="driver_license_number"/>
<br>

<input type="submit"/>
</form>

<hr>


<h3>Обновление данных:</h3>
<form name="update" action="update.php" method="POST">
<br> 

Введите номер ВУ
<br>
<input type="int" name="driver_license_number"/>
<br>
Новое ФИО
<br>
<input type="text" name="driver_full_name"/>
<br>
Новый номер телефона
<br>
<input type="text" name="telephone"/>
<br>
Новый адрес
<br>
<input type="text" name="address"/>
<br>
Новый статус
<input type="text" name="status"/>
<br>
<input type="submit"/>

</form>

<hr>

<h3>Показать все данные:</h3>
<form name="select" action="select.php" method="POST">
<input type="submit"/>
</form>


</body>
</html>

