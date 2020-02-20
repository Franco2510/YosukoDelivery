<?php
include "common.php";

switch ($_POST["modo"]) {
	case 0: { //--TRAER LISTADO DE personas
		$nombre=$_POST["nombre"];
		$orden=$_POST["orden"];
		$ascendente=$_POST["ascendente"];
		$borrados=$_POST["borrados"];
				
		$where="";
		$and="";
				
		//--Filtro por nombre
		if ($nombre!="") {
			$where="WHERE";
			$nombre="persNombre LIKE '%".$nombre."%' OR persApellido LIKE '%".$nombre."%'";
		}
		
		//--Selecciona por que ordenar
		switch ((int)$orden) {
			case 0: {$orden="persID"; break;}
			case 1: {$orden="persNombre"; break;}
			case 2: {$orden="persApellido"; break;}
			case 3: {$orden="persTipo"; break;}
			case 4: {$orden="provNombre, locaNombre"; break;}
			case 5: {$orden="persTipo"; break;}
			case 6: {$orden="persNacimiento"; break;}
			case 7: {$orden="persFechaAlta"; break;}
		}
		
		//--Si es ascendente o descendente el orden
		if ($ascendente=="1") $ascendente="ASC";
		else $ascendente="DESC";
		
		//--Mostrar o no borrados
		if ($borrados=="1") $borrados="";
		else {
			if ($where=="") $where="WHERE";
			else $and="AND";
			$borrados="persActivo=1";
		}
	
		$res=Consulta("
		SELECT persID, persNombre, persApellido, CONCAT(persNombre, ' ', persApellido) as nya,
		persTipo, persDNI, persDomicilio, persTelefono, persNacimiento, persFechaAlta, persActivo,
		locaNombre, provNombre, cargoNombre, proveNombre 
		FROM personas
		LEFT JOIN localidades ON localidades.locaID=personas.locaID
		LEFT JOIN provincias ON provincias.provID=localidades.provID
		LEFT JOIN cargos ON cargos.cargoID=personas.cargoID
		LEFT JOIN proveedores ON proveedores.proveID=personas.proveID
		".$where." ".$borrados." ".$and." ".$nombre."
		ORDER BY ".$orden." ".$ascendente."
		");
								
		if ($res!="") {
			foreach ($res as $per) {
				//--Mostrar Cargo o Empresa dependiendo del tipo
				$cargoempresa="";
				if ($per["persTipo"]==1) $cargoempresa=$per["cargoNombre"];
				elseif ($per["persTipo"]==2) $cargoempresa=$per["proveNombre"];
				
				echo $per["persID"]."|".$per["nya"]."|".$per["persTipo"]."|".$per["persDNI"]."|".$per["persDomicilio"].
				"|".$per["persTelefono"]."|".$per["locaNombre"]."|".$per["provNombre"]."|".$cargoempresa."|".$per["persActivo"].
				"|".$per["persNacimiento"]."|".$per["persFechaAlta"]."/";
			}
		}
		else echo "cuak!";
	break;}
	
	default: {
		echo "ERROR DE MODO";
	break;}
}
?>