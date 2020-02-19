<?php
include "common.php";

switch ($_POST["modo"]) {
	case 0: { //--TRAER INGREDEINTES
		$res=Consulta("
		SELECT artiID, artiNombre, artiMedida
		FROM Articulos 
		WHERE artiTipo=2 AND artiActivo=1");
		foreach ($res as $art) {
			if ((int)$art["artiMedida"]==1)
				echo $art["artiID"],"- ",$art["artiNombre"]," -g|";
			else
				echo $art["artiID"],"- ",$art["artiNombre"]," -u|";
			}
	break;}
		
	case 1: { //--BUSQUEDA ARTICULO
		$codigo=$_POST["codigo"];
		$res=Consulta("
		SELECT artiNombre, artiPrecio, artiTipo, artiMedida, artiCantidad, artiCantidadMin, artiActivo 
		FROM Articulos 
		WHERE artiID='$codigo'");
		if ($res!="") {
			$res=$res[0];
			echo $res["artiNombre"]."|".$res["artiPrecio"]."|".$res["artiTipo"].
			"|".$res["artiMedida"]."|".$res["artiCantidad"]."|".$res["artiCantidadMin"]."|".$res["artiActivo"]."|";
			//--Si es un Producto, trae sus ingredientes.
			if ($res["artiTipo"]==1) {
				$res=Consulta("
				SELECT prodID, ingrID, artiNombre, ingrCantidad, artiMedida
				FROM producto_ingrediente
				JOIN Articulos ON producto_ingrediente.ingrID=Articulos.artiID
				WHERE prodID='$codigo'
				");
				if ($res!="") {
					foreach ($res as $ingr) {
						echo $ingr["ingrID"]."-".$ingr["artiNombre"]."-".$ingr["ingrCantidad"]."-";
						if  ($ingr["artiMedida"]==0)
							echo "u"."/";
						else
							echo "g"."/";
					}
				}
			}
		}
	break;}
	
	case 2: { //--BUSQUEDA ULTIMO ID
		$res=Consulta("
		SELECT MAX(artiID) AS artiID 
		FROM Articulos");
		$res=$res[0];
		if ($res!="") echo $res["artiID"];
		else echo "0";
	break;}
		
	case 3: { //--GUARDAR ARTICULO
			$codigo=$_POST["codigo"];
			$tipo=$_POST["tipo"];
			$nombre=$_POST["nombre"];
			$precio=$_POST["precio"];
			$medida=$_POST["medida"];
			$cantidad=$_POST["cantidad"];
			$cantidadminima=$_POST["cantidadminima"];
			$ingredientes=explode("|", $_POST["ingredientes"]);
			
			$res=Consulta("SELECT artiID FROM Articulos WHERE artiID='$codigo'");
			if ($res!="") {
				$res=$res[0];
				if ($codigo==$res["artiID"]) { //--Modificacion
					Consulta("
					UPDATE Articulos 
					SET artiNombre='$nombre', artiPrecio='$precio', artiTipo='$tipo',
					artiMedida='$medida', artiCantidad='$cantidad', artiCantidadMin='$cantidadminima'
					WHERE artiID='$codigo'");
				
					echo "Articulo modificado con exito";
				}
			}
			else { //--ALTA
				if ($nombre!="") {
					Consulta("
					INSERT INTO Articulos (artiNombre, artiPrecio, artiTipo,
					artiMedida, artiCantidad, artiCantidadMin)
					VALUES ('$nombre', '$precio', '$tipo',
					'$medida', '$cantidad', '$cantidadminima')
					");
					
					echo "Articulo dado de alta con exito.";
				}
				else
					echo "Ingrese un nombre al articulo.";		
			}
			
			//--Si es un producto con ingredientes...
			if ((int)$tipo==1 && $ingredientes[0]!="NINGUNO") {
				//--Borrar todos sus ingredientes
				$res=Consulta("
				DELETE FROM producto_ingrediente
				WHERE prodID='$codigo'
				");
				
				//--Agregar ingredientes actuales
				foreach ($ingredientes as $ingr) {
					if ($ingr!="") {
						$ingr=explode("-",$ingr);
						$ingr_cod=$ingr[0];
						$ingr_cant=substr($ingr[2],0,-1);
						//echo $codigo, $ingr_cod, $ingr_cant;
						$res=Consulta("
						INSERT INTO producto_ingrediente (prodID, ingrID, ingrCantidad)
						VALUES ('$codigo', '$ingr_cod', '$ingr_cant')
						");
					}
				}	
			}
	break;}
	
	case 4: { //--Borrar/Restaurar Articulo
		$codigo=$_POST["codigo"];
		$activo=0;
				
		$res=Consulta("
		SELECT artiActivo
		FROM Articulos
		WHERE artiID='$codigo'
		");
						
		if ($res=="")
			echo "Articulo no existe.";
		else {
			$res=$res[0];
			if ($res["artiActivo"]==1) {
				$activo=0; //--borrar
				echo "0-Articulo borrado con exito.";
			}
			else {
				$activo=1;	 //--restaurar
				echo "1-Articulo restaurado con exito.";
			}
			
			$res=Consulta("
			UPDATE Articulos
			SET artiActivo='$activo'
			WHERE artiID='$codigo'
			");
		}
	break;}
	
	default: {
		echo "ERROR DE MODO";
	break;}
}
?>