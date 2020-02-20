<?php
session_start();
	if ($_POST["user"]=="admin" && $_POST["pass"]=="1234") {
		$_SESSION["validated"]=true;
		header("Location: menu.html");
	}
	else {
		echo "<p align='center'> Usuario o Contraseña Inválidas. </p>";
		$_SESSION["validated"]=false;
		session_unset();
		session_destroy();
		header("Refresh: 2; url=login.html");
	}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>LOGIN</title>
</head>

<body>

</body>
</html>