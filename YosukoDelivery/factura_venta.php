<?php
include "common.php";

switch ($_POST["modo"]) { 
	case 0: { //--TRAER SUGERENCIAS DE CLIENTES
		$nombre=$_POST["nombre"];
					
		$res=Consulta("
		SELECT persID, CONCAT(persNombre, ' ', persApellido) AS nya
		FROM personas
		WHERE persTipo=0 AND persActivo=1
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
		persNacimiento, provNombre, locaNombre
		FROM personas
		LEFT JOIN localidades ON localidades.locaID=personas.locaID
		LEFT JOIN provincias ON provincias.provID=localidades.provID
		WHERE persID='$codigo'");
				
		if ($res!="") {
			$res=$res[0];
			echo $res["persID"]."|".$res["persNombre"]." ".$res["persApellido"]."|".$res["persDNI"]."|".$res["persDomicilio"].
			"|".$res["persTelefono"]."|".$res["persNacimiento"]."|".$res["provNombre"]."|".$res["locaNombre"]."|";
		}
	break;}

	case 2: { //--TRAER SUGERENCIAS DE articulos
		$nombre=$_POST["nombre"];
			
		$res=Consulta("
		SELECT artiID, artiNombre
		FROM articulos
		WHERE artiTipo!=2 AND artiActivo=1 AND artiNombre LIKE '%$nombre%'
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
		SELECT artiID, artiNombre, artiPrecio
		FROM articulos
		WHERE artiID='$codigo'");
				
		if ($res!="") {
			$res=$res[0];
			echo $res["artiID"]."|".$res["artiNombre"]."|".$res["artiPrecio"]."|";
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
				VALUES ('$factura', '$fecha', '$cliente', 1)
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
						SELECT artiTipo, artiPrecio
						FROM articulos
						WHERE artiID='$codigo'
						");
						$res=$res[0];
						$tipo=$res["artiTipo"];
						$precio=$res["artiPrecio"];
						
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
						
						//--Movimientos de Stock
						/*
						$res=Consulta("
						SELECT SUM(stockCantidad) AS totalStock
						FROM stock
						WHERE artiID='$codigo'
						");
						$res=$res[0];
						$totalstock=(int)$res["totalStock"];
						*/
						if ($tipo=="1") {
							//--agregar registro en controlstock
							Consulta("
							INSERT INTO controlstock (constockConcepto)
							VALUES (2)
							");
							
							$res=Consulta("
							SELECT MAX(constockID) AS lastID
							FROM controlstock
							");
							$res=$res[0];
							$constock=$res["lastID"];
							
							//--obtener receta
							$res=Consulta("
							SELECT ingrID, ingrCantidad
							FROM producto_ingrediente
							WHERE prodID='$codigo'
							");
							
							foreach ($res as $ingr) {
								$ingr_codigo=$ingr["ingrID"];
								$ingr_cantidad=$ingr["ingrCantidad"];
								$ingr_cantidad=$ingr_cantidad*$cantidad;
								
								Consulta("
								INSERT INTO stock (detaID, artiID, stockCantidad, constockID)
								VALUES ('$detalleid', '$ingr_codigo', -'$ingr_cantidad', '$constock')
								");	
							}
						}
						
						//--descontar stock articulo
						Consulta("
						INSERT INTO stock (detaID, artiID, stockCantidad)
						VALUES ('$detalleid', '$codigo', -'$cantidad')
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
		WHERE factTipo=1 AND factNumero LIKE '%$nombre%'
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
			persNacimiento, provNombre, locaNombre
			FROM personas
			LEFT JOIN localidades ON localidades.locaID=personas.locaID
			LEFT JOIN provincias ON provincias.provID=localidades.provID
			WHERE persID='$cliente'");
			$res=$res[0];
			
			echo $res["persID"]."|".$res["persNombre"]." ".$res["persApellido"]."|".$res["persDNI"]."|".$res["persDomicilio"].
			"|".$res["persTelefono"]."|".$res["persNacimiento"]."|".$res["provNombre"]."|".$res["locaNombre"]."/";
			
			//--Datos del Detalle
			$res=Consulta("
			SELECT a.artiID, artiNombre, detaPrecio, stockCantidad
			FROM detalles AS d
			LEFT JOIN stock AS s ON s.detaID=d.detaID
			LEFT JOIN articulos AS a ON a.artiID=s.artiID
			
			WHERE factID='$facturaid' AND constockID=0
			");
			
			foreach ($res as $det) {
				$cantidad=(int)$det["stockCantidad"];
				$cantidad=abs($cantidad);
				echo $det["artiID"]."|".$det["artiNombre"]."|".$det["detaPrecio"]."|".$cantidad."/";
			}
		}
		else echo "cuack!";
	break;}

	default: {
		echo "ERROR DE MODO";
	break;}
}
?>