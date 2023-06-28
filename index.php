<!DOCTYPE html>
   <head>
<title>Insert data to PostgreSQL with php</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
li {listt-style: none;}
</style>
   </head>
   <body>


<h3>Введите название отеля, который вы хотите добавить, и город, в котором он находится</h3>
<form name="insert" action="insert_hotel.php" method="POST">
Название отеля<br>
<input type="text" name="name1"/><br>
Город<br>
<input type="text" name="city"/><br>
Адресс<br>
<input type="text" name="address"/><br>
Количество номеров<br>
<input type="text" name="sp_number"/><br>
<input type="submit"/>
</form>

<hr>

<h3>Введите отель, который вы хотите удалить</h3>
<form name="delete_hotel" action="delete_hotel.php" method="POST">
Название отеля<br>
<input type="text" name="name2"/>
<br>
<input type="submit"/>
</form>

<hr>


<h3>Обновить адрес отеля</h3>
<form name="update_hotel" action="update_hotel.php" method="POST">
<br> 
Введите код отеля
<br>
<input type="text" name="hotel_code"/>
<br>
Ввведите новый адресс
<br>
<input type="text" name="address"/>
<br>
<input type="submit"/>
</form>

<hr>

<h3>Нажмите, чтобы вывести кол-во всех отелей в сети</h3>
<form name="select_hotel" action="select_hotel.php" method="POST">
<input type="submit"/>
</form>


</body>
</html>