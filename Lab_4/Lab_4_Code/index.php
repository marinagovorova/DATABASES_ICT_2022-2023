<!DOCTYPE html>
<html>
<head>
	<title>SIGN UP</title>
	<link rel="stylesheet" type="text/css" href="slide navbar style.css">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
	<div class="main">  	
		<input type="checkbox" id="chk" aria-hidden="true">

			<div class="signup">
				<form name='insert' action='index.php' method='POST'>
					<label for="chk" aria-hidden="true">Sign up</label>
					<input type="text" name="reg_user_name" placeholder="User name" required="">
					<input type="email" name="reg_email" placeholder="Email" required="">
					<input type="password" name="reg_pswd" placeholder="Password" required="">
					<div class="btn-group">
						<button type="submit" name="reg_create">Create</button>
						<button type="submit" name="reg_update">Update</button>
						<button type="submit" name="reg_delete">Delete</button>
					</div>
				</form>
			</div>

			<div class="login">
				<form>
					<label for="chk" aria-hidden="true">Login</label>
					<input type="email" name="email" placeholder="Email" required="">
					<input type="password" name="pswd" placeholder="Password" required="">
					<button class="button">Login</button>
				</form>
			</div>
	</div>
</body>
</html>

<?php
require("db.php");

$name = $_POST['reg_user_name'];
$mail = $_POST['reg_email'];
$pswd = $_POST['reg_pswd'];

if(isset($_POST['reg_create'])){

	$sql = mysqli_query($connect, "SELECT * FROM `user_reg` WHERE `user_reg`.`mail` = '$mail'");
	$sql = mysqli_fetch_assoc($sql);
	$Checker = $sql['mail'];

	if  ($Checker != null) {
		echo "<script>
			alert('Пользователь с почтой $mail уже существует');
			</script>";

	} else {
    	
		$sql = mysqli_query($connect,"INSERT INTO `user_reg` (`name`, `mail`, `password`) VALUES ('$name', '$mail', '$pswd')");

		if ($sql) {
			echo "<script>
			alert('Вы успешно зарегестрированы');
			</script>";
		  } else {
			echo "<script>
			alert('Произошла ошибка, попробуйте снова');
			</script>";
		  }
	}
}

if(isset($_POST['reg_update'])){

	$sql = mysqli_query($connect, "SELECT * FROM `user_reg` WHERE `user_reg`.`name` = '$name' AND `user_reg`.`mail` = '$mail'");
	$sql = mysqli_fetch_assoc($sql);
	$Checker = $sql['mail'];

	if  ($Checker != null) {
    	
		$sql = mysqli_query($connect, "UPDATE `user_reg` SET `password` = '$pswd' WHERE `user_reg`.`name` = '$name' AND `user_reg`.`mail` = '$mail'");

		if ($sql) {
			echo "<script>
			alert('Вы успешно обновили пароль');
			</script>";
		  } else {
			echo "<script>
			alert('Произошла ошибка, попробуйте снова');
			</script>";
		  }

	} else {
    	echo "<script>
			alert('Произошла ошибка, попробуйте снова');
			</script>";
	}
}

if(isset($_POST['reg_delete'])){

	$sql = mysqli_query($connect, "SELECT * FROM `user_reg`  WHERE `user_reg`.`name` = '$name' AND `user_reg`.`mail` = '$mail' AND `user_reg`.`password` = '$pswd'");
	$sql = mysqli_fetch_assoc($sql);
	$Checker = $sql['mail'];

	if  ($Checker != null) {
    	
		$sql = mysqli_query($connect, "DELETE FROM `user_reg` WHERE `user_reg`.`name` = '$name' AND `user_reg`.`mail` = '$mail' AND `user_reg`.`password` = '$pswd'");

		if ($sql) {
		echo "<script>
		alert('Вы успешно удалили аккаунт пользователя $name');
		</script>";
	  } else {
		echo "<script>
		alert('Произошла ошибка, попробуйте снова');
		</script>";
	  }

	} else {
    	echo "<script>
			alert('Произошла ошибка, попробуйте снова');
			</script>";
	}
}
?>