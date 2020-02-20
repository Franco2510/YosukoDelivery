<?php
include "common.php";

switch ($_POST["modo"]) {
	case 0: { //--TRAER LISTADO DE articulos
		$nombre=$_POST["nombre"];
		$orden=$_POST["orden"];
		$ascendente=$_POST["ascendente"];
		$borrados=$_POST["borrados"];
				
		$where="";
		$and="";
				
		//--Filtro por nombre
		if ($nombre!="") {
			$where="WHERE";
			$nombre="artiNombre LIKE '%".$nombre."%'";
		}
		
		//--Selecciona por que ordenar
		switch ((int)$orden) {
			case 0: {$orden="artiID"; break;}
			case 1: {$orden="artiNombre"; break;}
			case 2: {$orden="artiTipo"; break;}
			case 3: {$orden="artiCosto"; break;}
			case 4: {$orden="artiPrecio"; break;}
		}
		
		//--Si es ascendente o descendente el orden
		if ($ascendente=="1") $ascendente="ASC";
		else $ascendente="DESC";
		
		//--Mostrar o no borrados
		if ($borrados=="1") $borrados="";
		else {
			if ($where=="") $where="WHERE";
			else $and="AND";
			$borrados="artiActivo=1";
		}
	
		$res=Consulta("
		SELECT artiID, artiNombre, artiTipo, artiCosto, artiPrecio, artiCantidadMin, artiMedida, artiActivo
		FROM articulos
		".$where." ".$borrados." ".$and." ".$nombre."
		ORDER BY ".$orden." ".$ascendente."
		");
		
		if ($res!="") {
			foreach ($res as $art) {
				echo $art["artiID"]."|".$art["artiNombre"]."|".$art["artiTipo"]."|".$art["artiCosto"]."|".$art["artiPrecio"].
				"|".$art["artiCantidadMin"]."|".$art["artiMedida"]."|".$art["artiActivo"]."/";
			}
		}
	break;}
	
	case 1: {//--Mostrar Receta
		$codigo=$_POST["codigo"];
	
		$res=Consulta("
		SELECT prodID, ingrID, artiNombre, ingrCantidad, artiMedida
		FROM producto_ingrediente
		JOIN articulos ON producto_ingrediente.ingrID=articulos.artiID
		WHERE prodID='$codigo'
		");
		if ($res!="") {
			foreach ($res as $ingr) {
				echo $ingr["artiNombre"]." ".$ingr["ingrCantidad"]." ";
				if  ($ingr["artiMedida"]==0)
					if ($ingr["ingrCantidad"]=="1")
						echo "unidad\n";
					else
						echo "unidades\n";
				else
					echo "gramos\n";
			}
		}
	}
	break;
	
	default: {
		echo "ERROR DE MODO";
	break;}
}
?>