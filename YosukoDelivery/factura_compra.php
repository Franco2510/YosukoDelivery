<?php
include "common.php";

switch ($_POST["modo"]) { 
	case 0: { //--TRAER SUGERENCIAS DE PROVEEDORES
		$nombre=$_POST["nombre"];
					
		$res=Consulta("
		SELECT persID, CONCAT(persNombre, ' ', persApellido) AS nya
		FROM Personas
		WHERE persTipo=2 AND persActivo=1
		HAVING nya LIKE '%$nombre%'
		ORDER BY nya
		LIMIT 5
		");
				
		if ($res!="") {
			foreach ($res as $cli) {
				echo $cli["persID"]."-".$cli["nya"]."|";
			}
		}
	break;}
	
	case 1: { //--TRAER DATOS CLIENTE
		$codigo=$_POST["codigo"];
		
		$res=Consulta("
		SELECT persID, persNombre, persApellido, persDNI, persDomicilio, persTelefono,
		persNacimiento, provNombre, locaNombre, proveNombre
		FROM Personas
		LEFT JOIN localidades ON localidades.locaID=Personas.locaID
		LEFT JOIN provincias ON provincias.provID=localidades.provID
		LEFT JOIN proveedores ON proveedores.proveID=Personas.proveID
		WHERE persID='$codigo'");
				
		if ($res!="") {
			$res=$res[0];
			echo $res["persID"]."|".$res["persNombre"]." ".$res["persApellido"]."|".$res["persDNI"]."|".$res["persDomicilio"].
			"|".$res["persTelefono"]."|".$res["persNacimiento"]."|".$res["provNombre"]."|".$res["locaNombre"]."|".$res["proveNombre"]."|";
		}
	break;}

	case 2: { //--TRAER SUGERENCIAS DE ARTICULOS
		$nombre=$_POST["nombre"];
			
		$res=Consulta("
		SELECT artiID, artiNombre
		FROM Articulos
		WHERE artiTipo!=1 AND artiActivo=1 AND artiNombre LIKE '%$nombre%'
		ORDER BY artiNombre
		LIMIT 5
		");
		
		if ($res!="") {
			foreach ($res as $art) {
				echo $art["artiID"]."-".$art["artiNombre"]."|";
			}
		}
	break;}
	
	case 3: { //--TRAER DATOS ARTICULO
		$codigo=$_POST["codigo"];
		
		$res=Consulta("
		SELECT artiID, artiNombre, artiCosto, artiMedida
		FROM Articulos
		WHERE artiID='$codigo'");
				
		if ($res!="") {
			$res=$res[0];
			echo $res["artiID"]."|".$res["artiNombre"]."|".$res["artiCosto"]."|".$res["artiMedida"]."|";
		}
	break;}
	
	case 4: { //--GRABAR FACTURA
			$factura=$_POST["factura"];
			$fecha=$_POST["fecha"];
			$cliente=$_POST["cliente"];
			$detalles=explode("|", $_POST["detalles"]);
			
			$res=Consulta("SELECT factNumero FROM facturas WHERE factNumero='$factura'");
			if ($res=="") {
				//--Cabecera
				Consulta("
				INSERT INTO facturas (factNumero, factFecha, clieprovID, factTipo)
				VALUES ('$factura', '$fecha', '$cliente', 0)
				");
				
				$res=$res=Consulta("SELECT MAX(factID) AS lastID FROM facturas");
				$res=$res[0];
				$facturaid=$res["lastID"];
				
				foreach ($detalles as $det) {
					$det=explode("-",$det);
					$codigo=$det[0];
					$cantidad=(int)$det[1];
					if ($cantidad!="0") {						
						$res=Consulta("
						SELECT artiTipo, artiCosto
						FROM articulos
						WHERE artiID='$codigo'
						");
						$res=$res[0];
						$tipo=$res["artiTipo"];
						$precio=$res["artiCosto"];
						
						//--Detalle
						Consulta("
						INSERT INTO detalles (factID, detaPrecio)
						VALUES ('$facturaid', '$precio')
						");
						
						$res=$res=Consulta("
						SELECT MAX(detaID) AS lastID
						FROM detalles
						");
						$res=$res[0];
						$detalleid=$res["lastID"];
												
						//--descontar stock articulo
						Consulta("
						INSERT INTO stock (detaID, artiID, stockCantidad)
						VALUES ('$detalleid', '$codigo', '$cantidad')
						");						
					}
					
				}
				
				echo "Factura grabada exitosamente.|OK";
			}
			else {
				echo "El numero de factura ya existe.|NO.";		
			}
	break;}
	
	case 5: { //--TRAER SUGERENCIAS DE FACTURAS
		$nombre=$_POST["nombre"];
					
		$res=Consulta("
		SELECT factNumero
		FROM facturas
		WHERE factTipo=0 AND factNumero LIKE '%$nombre%'
		ORDER BY factNumero
		LIMIT 5
		");
				
		if ($res!="") {
			foreach ($res as $fac) {
				echo "N°".$fac["factNumero"]."|";
			}
		}
	break;}
	
	case 6: { //--TRAER FACTURA
		$numero=$_POST["numero"];
		
		$res=Consulta("
		SELECT factID, factFecha, clieprovID
		FROM facturas
		WHERE factNumero='$numero'
		");
		
		if ($res!="") {
			//--Datos de Factura
			$res=$res[0];		
			$facturaid=$res["factID"];
			$fecha=$res["factFecha"];
			$cliente=$res["clieprovID"];
			
			echo $fecha."/";
			
			//--Datos del Cliente
			$res=Consulta("
			SELECT persID, persNombre, persApellido, persDNI, persDomicilio, persTelefono,
			persNacimiento, provNombre, locaNombre, proveNombre
			FROM Personas
			LEFT JOIN localidades ON localidades.locaID=Personas.locaID
			LEFT JOIN provincias ON provincias.provID=localidades.provID
			LEFT JOIN proveedores ON proveedores.proveID=Personas.proveID
			WHERE persID='$cliente'");
			$res=$res[0];
			
			echo $res["persID"]."|".$res["persNombre"]." ".$res["persApellido"]."|".$res["persDNI"]."|".$res["persDomicilio"].
			"|".$res["persTelefono"]."|".$res["persNacimiento"]."|".$res["provNombre"]."|".$res["locaNombre"]."|".$res["proveNombre"]."/";
			
			//--Datos del Detalle
			$res=Consulta("
			SELECT a.artiID, artiNombre, detaPrecio, stockCantidad, artiMedida
			FROM detalles AS d
			LEFT JOIN stock AS s ON s.detaID=d.detaID
			LEFT JOIN articulos AS a ON a.artiID=s.artiID
			
			WHERE factID='$facturaid' AND constockID=0
			");
			
			foreach ($res as $det) {
				$cantidad=(int)$det["stockCantidad"];
				$cantidad=abs($cantidad);
				
				if ($det["artiMedida"]==1) $medida="g";
				else $medida="u";
				
				echo $det["artiID"]."|".$det["artiNombre"]."|".$det["detaPrecio"]."|".$cantidad."|".$medida."/";
			}
		}
		else echo "cuack!";
	break;}

	default: {
		echo "ERROR DE MODO";
	break;}
}
?>