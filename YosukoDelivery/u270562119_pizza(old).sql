
-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 20-07-2016 a las 19:36:11
-- Versión del servidor: 10.0.20-MariaDB
-- Versión de PHP: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `u270562119_pizza`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `AppUsuarios`
--

CREATE TABLE IF NOT EXISTS `AppUsuarios` (
  `usuaUsername` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `usuaPassword` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `clieID` int(9) unsigned NOT NULL,
  UNIQUE KEY `clieID` (`clieID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `AppUsuarios`
--

INSERT INTO `AppUsuarios` (`usuaUsername`, `usuaPassword`, `clieID`) VALUES
('franco25', '1234', 1),
('pedrito123', 'pass', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Articulos`
--

CREATE TABLE IF NOT EXISTS `Articulos` (
  `artiID` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `artiNombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `artiTipo` int(1) unsigned NOT NULL,
  `artiMedida` int(1) unsigned NOT NULL,
  `artiCantidad` int(9) unsigned NOT NULL,
  `artiPrecio` decimal(6,0) unsigned NOT NULL,
  `artiCantidadMin` int(9) unsigned DEFAULT '0',
  PRIMARY KEY (`artiID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `Articulos`
--

INSERT INTO `Articulos` (`artiID`, `artiNombre`, `artiTipo`, `artiMedida`, `artiCantidad`, `artiPrecio`, `artiCantidadMin`) VALUES
(1, 'COCA COLA 3L', 0, 0, 12, '35', 10),
(2, 'QUESO MOZZARELLA', 2, 1, 8000, '60', 4000),
(3, 'HARINA LEUDANTE', 2, 1, 10000, '16', 8000),
(4, 'PURE DE TOMATE', 2, 1, 2000, '24', 1000),
(5, 'PIZZA MUZZARELLA', 1, 0, 0, '80', 0),
(6, 'EMPANADA DE CARNE', 1, 0, 0, '15', 0),
(7, 'PRE PIZZA', 2, 0, 30, '20', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Detalles`
--

CREATE TABLE IF NOT EXISTS `Detalles` (
  `detaID` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `factID` int(9) unsigned NOT NULL,
  `artiID` int(9) unsigned NOT NULL,
  `detalPrecio` decimal(6,0) unsigned NOT NULL,
  `detalCantidad` int(6) unsigned NOT NULL,
  PRIMARY KEY (`detaID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Facturas`
--

CREATE TABLE IF NOT EXISTS `Facturas` (
  `factID` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `factNumero` int(16) unsigned NOT NULL,
  `factFecha` date DEFAULT NULL,
  `persID` int(9) unsigned NOT NULL,
  PRIMARY KEY (`factID`),
  UNIQUE KEY `factNumero` (`factNumero`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Personas`
--

CREATE TABLE IF NOT EXISTS `Personas` (
  `persID` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `persNombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `persApellido` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `persDNI` int(9) unsigned NOT NULL,
  `persDomicilio` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `persLocalidad` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `persNacimiento` date NOT NULL,
  `persTelefono` int(10) unsigned DEFAULT NULL,
  `provID` int(9) unsigned DEFAULT NULL,
  `emplCargo` int(2) unsigned DEFAULT NULL,
  PRIMARY KEY (`persID`),
  UNIQUE KEY `persDNI` (`persDNI`,`persTelefono`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `Personas`
--

INSERT INTO `Personas` (`persID`, `persNombre`, `persApellido`, `persDNI`, `persDomicilio`, `persLocalidad`, `persNacimiento`, `persTelefono`, `provID`, `emplCargo`) VALUES
(1, 'Franco', 'Alcaraz', 37156608, 'Villa Cabello', NULL, '1992-10-25', 3764556677, NULL, NULL),
(2, 'Pedro', 'Perez', 12345678, 'Villa Juanita', NULL, '1976-08-06', 3764441122, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Producto-Ingrediente`
--

CREATE TABLE IF NOT EXISTS `Producto-Ingrediente` (
  `prodID` int(9) unsigned NOT NULL,
  `IngrID` int(9) unsigned NOT NULL,
  `ingrCantidad` int(9) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Proveedores`
--

CREATE TABLE IF NOT EXISTS `Proveedores` (
  `provID` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `provNombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`provID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RetirosCaja`
--

CREATE TABLE IF NOT EXISTS `RetirosCaja` (
  `retiID` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `retiNumero` int(16) unsigned NOT NULL,
  `retiFecha` date DEFAULT NULL,
  `retiImporte` decimal(6,0) unsigned NOT NULL,
  PRIMARY KEY (`retiID`),
  UNIQUE KEY `retiNumero` (`retiNumero`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
