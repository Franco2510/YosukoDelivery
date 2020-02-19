<?php
include "common.php";

$user = $_POST["username"];
$pass = $_POST["password"];
$res=Consulta("SELECT clieID FROM AppUsuarios WHERE usuaUsername='$user' AND usuaPassword='$pass'");
$res=$res[0];

if ($res) {
	$clie=(int)$res["clieID"];
	$res=Consulta("SELECT persNombre, persApellido, persDNI, persDomicilio, persTelefono FROM Personas WHERE persID='$clie'");
	$res=$res[0];
	echo $res["persNombre"]," ",$res["persApellido"],": ",$res["persDomicilio"]," - ",$res["persTelefono"];
}
else echo "Usuario o clave incorrectos.";

?>