<?php
session_start();
if (!isset($_SESSION["validated"]) || $_SESSION["validated"]==false) {
	echo "<h3 align='center'>Acceso Denegado</h3>";
	session_unset();
	session_destroy();
}
else {
	echo "OK";
}
?>