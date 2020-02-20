<?php
include "common.php";

switch ($_POST["modo"]) {
	case 0: { //--TRAER CARGOS Y PROVEEDORES (EMPRESAS)
		//--Cargos
		$res=Consulta("
		SELECT cargoID, cargoNombre
		FROM cargos
		WHERE cargoActivo=1
		");
		foreach ($res as $car) {
			echo $car["cargoID"],"- ",$car["cargoNombre"],"|";
		}
		
		echo "/";
		
		//--Empresas
		$res=Consulta("
		SELECT proveID, proveNombre
		FROM proveedores
		WHERE proveActivo=1
		");
		foreach ($res as $pro) {
			echo $pro["proveID"],"- ",$pro["proveNombre"],"|";
		}		
	break;}
		
	case 1: { //--BUSQUEDA PERSONA
		$codigo=$_POST["codigo"];
		$localidad="";
		
		$res=Consulta("
		SELECT persNombre, persApellido, persTipo, persDNI, persDomicilio, persTelefono,
		persNacimiento, locaID, cargoID, proveID, persActivo
		FROM personas
		WHERE persID='$codigo'");
		if ($res!="") {
			$res=$res[0];
			echo $res["persNombre"]."|".$res["persApellido"]."|".$res["persTipo"]."|".$res["persDNI"]."|".$res["persDomicilio"].
			"|".$res["persTelefono"]."|".$res["persNacimiento"]."|".$res["persActivo"]."|".$res["locaID"]."|";
			
			$tipo=(int)$res["persTipo"];
			$cargo=$res["cargoID"];
			$proveedor=$res["proveID"];
			
			//--Si tiene localidad, enviar provincia
			$localidad=$res["locaID"];
			if ($localidad!="") {
				$res=Consulta("
				SELECT provID
				FROM localidades
				WHERE locaID='$localidad'
				");
				
				$res=$res[0];
				
				echo $res["provID"]."|";
			}
			else
				echo "|";
			
			//--Si es empleado, enviar cargo. Si es proveedor, enviar empresa
			if ($tipo==1) echo $cargo."|";
			elseif ($tipo==2) echo $proveedor."|";
		}
	break;}
	
	case 2: { //--BUSQUEDA ULTIMO ID
		$res=Consulta("
		SELECT MAX(persID) AS persID 
		FROM personas");
		$res=$res[0];
		if ($res!="") echo $res["persID"];
		else echo "0";
	break;}
		
	case 3: { //--GUARDAR PERSONA
			$codigo=$_POST["codigo"];
			$tipo=$_POST["tipo"];
			$nombre=$_POST["nombre"];
			$apellido=$_POST["apellido"];
			$dni=$_POST["dni"];
			$domicilio=$_POST["domicilio"];
			$telefono=$_POST["telefono"];
			$nacimiento=$_POST["nacimiento"];
			$localidad=$_POST["localidad"];
			$cargo=$_POST["cargo"];
			$empresa=$_POST["empresa"];
			
			//--Si los valores son vacios, insertar NULL a cambio
			if ($telefono=="") $telefono="NULL";
			else $telefono="'".$telefono."'";
			
			if ($nacimiento=="") $nacimiento="NULL";
			else $nacimiento="'".$nacimiento."'";
			
			if ($localidad=="") $localidad="NULL";
			else $localidad="'".$localidad."'";
			
			if ($cargo=="") $cargo="NULL";
			else $cargo="'".$cargo."'";
			
			if ($empresa=="") $empresa="NULL";
			else $empresa="'".$empresa."'";
			
			$res=Consulta("SELECT persID FROM personas WHERE persID='$codigo'");
			
			if ($res!="") {
				$res=$res[0];
				if ($codigo==$res["persID"]) { //--Modificacion
					Consulta("
					UPDATE personas
					SET persNombre='$nombre', persApellido='$apellido', persTipo='$tipo', persDNI='$dni',
					persDomicilio='$domicilio', persTelefono=$telefono, persNacimiento=$nacimiento,
					locaID=$localidad, cargoID=$cargo, proveID=$empresa
					WHERE persID='$codigo'");
					
					echo "Persona modificada con exito.";
				}
			}
			else { //--ALTA
				if ($nombre!="") {
					Consulta("
					INSERT INTO personas (persNombre, persApellido, persTipo, persDNI,
					persDomicilio, persTelefono, persNacimiento, locaID, cargoID, proveID)
					VALUES ('$nombre', '$apellido', '$tipo', '$dni',
					'$domicilio', $telefono, $nacimiento, $localidad, $cargo, $empresa)
					");
					
					echo "Persona dada de alta con exito.";
				}
				else
					echo "Ingrese el nombre, apellido y dni de la persona.";		
			}
	break;}
	
	case 4: { //--Borrar/Restaurar Persona
		$codigo=$_POST["codigo"];
		$activo=0;
				
		$res=Consulta("
		SELECT persActivo
		FROM personas
		WHERE persID='$codigo'
		");
						
		if ($res=="")
			echo "Persona no existe.";
		else {
			$res=$res[0];
			if ($res["persActivo"]==1) {
				$activo=0; //--borrar
				echo "0-Persona borrada con exito.";
			}
			else {
				$activo=1;	 //--restaurar
				echo "1-Persona restaurada con exito.";
			}
			
			$res=Consulta("
			UPDATE personas
			SET persActivo='$activo'
			WHERE persID='$codigo'
			");
		}
	break;}
	
	case 5: { //--TRAER LOCALIDADES
		$provincia=$_POST["provincia"];
		$res=Consulta("
		SELECT locaID, locaNombre
		FROM localidades
		WHERE provID='$provincia' AND locaActivo=1
		");
		foreach ($res as $loc) {
			echo $loc["locaID"],"- ",$loc["locaNombre"],"|";
		}
	break;}
	
	case 6: { //--GUARDAR LOCALIDAD NUEVA
		$localidad=$_POST["localidad"];
		$provincia=$_POST["provincia"];
		
		$res=Consulta("
		SELECT locaNombre
		FROM localidades
		WHERE locaNombre='$localidad' AND provID='$provincia' AND locaActivo=1
		");
		
		if ($res=="") {
			Consulta("
			INSERT INTO localidades (locaNombre, provID)
			VALUES ('$localidad',' $provincia')
			");
			
			echo "Localidad agregada a la lista.|OK";
		}
		else
			echo "Localidad ".$localidad." ya existe en la lista de esta provincia|NO";	
	break;}
	
	case 7: { //--GUARDAR ELEMENTO NUEVO (CARGO O PROVEEDOR)
		$nombre=$_POST["nombre"];
		$submodo=$_POST["submodo"];
		$tabla="";
		$elem="";
		$elemento=""; //--cargo o proveedor
		
		switch($submodo) {
			case 2: {
				$tabla="cargos";
				$elem="cargo";
				$elemento="Cargo agregado";
			break;}
			case 3: {
				$tabla="proveedores";
				$elem="prove";
				$elemento="Empresa agregada";
			break;}
		}
				
		$res=Consulta("
		SELECT ".$elem."Nombre
		FROM ".$tabla."
		WHERE ".$elem."Nombre='$nombre' AND ".$elem."Activo=1
		");
		
		if ($res=="") {
			Consulta("
			INSERT INTO ".$tabla." (".$elem."Nombre)
			VALUES ('$nombre')
			");
			
			echo $elemento." a la lista.|OK";
		}
		else
			echo $elemento." $nombre ya existe en la lista de ".$tabla.".|NO";	
	break;}
	
	case 8: { //--Borrar Elemento (localidad, cargo o proveedor)
		$codigo=$_POST["codigo"];
		$submodo=$_POST["submodo"];
		$tabla="";
		$elem="";
		$elemento="";
		
		switch ($submodo) {
			case 1: {
				$tabla="localidades";
				$elem="loca";
				$elemento="Localidad borrada";			
			break;}
			case 2: {
				$tabla="cargos";
				$elem="cargo";
				$elemento="Cargo borrado";
			break;}
			case 3: {
				$tabla="proveedores";
				$elem="prove";
				$elemento="Empresa borrada";
			break;}
		}
				
		Consulta("
		UPDATE ".$tabla."
		SET ".$elem."Activo=0
		WHERE ".$elem."ID='$codigo'
		");
		
		echo $elemento." de la lista.";
	break;}
	
	case 9: { //--TRAER SUGERENCIAS DE personas
		$nombre=$_POST["nombre"];
					
		$res=Consulta("
		SELECT persID, CONCAT(persNombre, ' ', persApellido) AS nya
		FROM personas
		HAVING nya LIKE '%$nombre%'
		ORDER BY nya
		LIMIT 5
		");
				
		if ($res!="") {
			foreach ($res as $art) {
				echo $art["persID"]."-".$art["nya"]."|";
			}
		}
	break;}
	
	default: {
		echo "ERROR DE MODO";
	break;}
}
?>