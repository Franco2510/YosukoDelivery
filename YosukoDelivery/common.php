<?php
date_default_timezone_set("America/Argentina/Buenos_Aires");

function Conectarse() {
	if (!($conexion=mysqli_connect("localhost","id12645781_root","password","id12645781_yosukodelivery"))) return 0;
	else return $conexion;
}

function Consulta($pedido) {
	$conexion = Conectarse();
	if (!$conexion)
		return "Error de Conexion |";
	else {
		$consulta = mysqli_query($conexion, $pedido);
		if (!$consulta)
			return "Error de Consulta: ".mysqli_error($conexion)."|";
		else {
			if ($consulta===true)
				return "Modificacion Exitosa |"; //--UPDATE, DELETE...
			else {
				$respuestas=[];
				while ($respuesta=mysqli_fetch_assoc($consulta)) {
					$respuestas[]=$respuesta;
				}
				mysqli_free_result($consulta);
				mysqli_close($conexion);
				return $respuestas;
			}
		}
			
			//--Retorna siempre un array, si el resultado es una sola fila, esta en indice 0
			//--usar como indice los nombres de campo para tomar datos de la fila
	}
}
?>