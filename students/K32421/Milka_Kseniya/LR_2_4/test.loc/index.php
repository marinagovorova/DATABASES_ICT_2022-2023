<!DOCTYPE html>
   <head>
<title>Insert data to PostgreSQL with php</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
li {listt-style: none;}
</style>
   </head>
   <body>


<h3>Введите id тренера и категорию, которую вы хотите добавить. Укажите дату начала и окончания действия категории</h3>
<form name="insert_sports_club" action="insert_sports_club.php" method="POST">
id тренера<br>
<input type="int" name="coach_id"/><br>
Категория<br>
<input type="text" name="category"/><br>
Дата начала действия категории<br>
<input type="data" name="date_start"/><br>
Дата окончания действия категории<br>
<input type="data" name="date_end"/><br>
<input type="submit"/>
</form>

<hr>

<h3>Введите id категории тренера, которую вы хотите удалить</h3>
<form name="delete_sports_club" action="delete_sports_club.php" method="POST">
id категории тренера<br>
<input type="int" name="coach_category_id"/>
<br>

<input type="submit"/>
</form>

<hr>


<h3>Обновление категории тренера</h3>
<form name="update_sports_club" action="update_sports_club.php" method="POST">
<br> 

id категории тренера
<br>
<input type="int" name="coach_category_id"/>
<br>
Новая категория тренера
<br>
<input type="text" name="category"/>
<br>
Дата начала действия категории
<br>
<input type="data" name="date_start"/>
<br>

Дата окончания действия категории
<br>
<input type="data" name="date_end"/>
<br>
<input type="submit"/>

</form>

<hr>

<h3>Нажмите, чтобы вывести кол-во всех категорий тренеров</h3>
<form name="select_sports_club" action="select_sports_club.php" method="POST">
<input type="submit"/>
</form>


</body>
</html>