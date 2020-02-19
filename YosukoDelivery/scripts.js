//--MENUS-------------------------------------------------------------
function EsconderMenus() {
	document.getElementById("menu_abms").style.display="none";
	document.getElementById("menu_listas").style.display="none";
	document.getElementById("menu_facturas").style.display="none";
	document.getElementById("menu_ajustes").style.display="none";
	document.getElementById("menu_informes").style.display="none";
}
function MostrarMenus(menuID) {
	EsconderMenus();
	document.getElementById(menuID).style.display="inline";
}

//--AJAX--------------------------------------------------------------
function objetoAjax(){
        var xmlhttp=false;
        try {
                xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
                try {
                   xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (E) {
                        xmlhttp = false;
                }
        }
 
         if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
               xmlhttp = new XMLHttpRequest();
        }        
        return xmlhttp;
}

function ComprobarSesion() {
	ajax=objetoAjax();
	ajax.open("GET", "validating.php");
	ajax.onreadystatechange=function() {
    	if (ajax.readyState==4 && ajax.status==200) {
			if (ajax.responseText!="OK") {
				window.location.href="login.html";
			}
			else Comenzar();
		}
	};
	ajax.send();
}

//--VALIDACIONES----------------------------------------------------
function ValidarTexto(campo) {
	var texto = document.getElementById(campo).value;
	document.getElementById(campo).value=texto.toUpperCase();
}
function ValidarEntero(campo) {
	if (isNaN(document.getElementById(campo).value) || document.getElementById(campo).value<0
	|| document.getElementById(campo).value=="")
		document.getElementById(campo).value=document.getElementById(campo).defaultValue;
	else
		document.getElementById(campo).value=parseInt(document.getElementById(campo).value, 10);
}
function ValidarDecimal(campo) {
	if (isNaN(document.getElementById(campo).value) || document.getElementById(campo).value<0
	|| document.getElementById(campo).value=="")
		document.getElementById(campo).value=document.getElementById(campo).defaultValue;
	else
		document.getElementById(campo).value=parseFloat(document.getElementById(campo).value, 10);
}

//--OTROS-----------------------------------------------------------
function CargarPagina(pagina) {
	window.location.href=pagina;
}