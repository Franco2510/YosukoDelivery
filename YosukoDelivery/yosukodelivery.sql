-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-06-2017 a las 02:34:48
-- Versión del servidor: 5.7.11
-- Versión de PHP: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `yosukodelivery`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `appusuarios`
--

CREATE TABLE `appusuarios` (
  `usuaUsername` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `usuaPassword` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `clieID` int(9) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `appusuarios`
--

INSERT INTO `appusuarios` (`usuaUsername`, `usuaPassword`, `clieID`) VALUES
('franco25', '1234', 1),
('pedrito123', 'pass', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `artiID` int(9) UNSIGNED NOT NULL,
  `artiNombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `artiTipo` int(1) UNSIGNED NOT NULL,
  `artiMedida` int(1) UNSIGNED NOT NULL,
  `artiCosto` decimal(6,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `artiPrecio` decimal(6,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `artiCantidadMin` int(9) UNSIGNED DEFAULT '0',
  `artiActivo` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`artiID`, `artiNombre`, `artiTipo`, `artiMedida`, `artiCosto`, `artiPrecio`, `artiCantidadMin`, `artiActivo`) VALUES
(1, 'COCA COLA 3L Y CAJONES', 0, 0, '52.00', '72.00', 10, 1),
(2, 'QUESO MOZZARELLA', 2, 1, '60.00', '0.00', 4000, 1),
(3, 'HARINA LEUDANTE', 2, 1, '16.00', '0.00', 8000, 0),
(4, 'PURE DE TOMATE', 2, 1, '24.00', '0.00', 1000, 1),
(5, 'SALAME', 2, 1, '140.00', '0.00', 3000, 1),
(6, 'EMPANADA DE CARNE', 1, 0, '0.00', '15.00', 0, 0),
(7, 'PRE PIZZA', 2, 0, '20.00', '0.00', 10, 1),
(8, 'SPRITE 3L', 0, 0, '24.00', '32.00', 6, 1),
(9, 'FANTA 3L', 0, 0, '28.00', '35.00', 6, 1),
(10, 'PEPSI 1L', 0, 0, '16.00', '23.00', 10, 0),
(11, 'LAYS', 0, 0, '16.00', '22.00', 10, 1),
(12, 'PORORO', 0, 0, '4.50', '12.00', 4, 1),
(13, 'PIZZA MUZARELLA', 1, 0, '0.00', '120.00', 2, 1),
(14, 'CARNE MOLIDA', 2, 1, '60.00', '0.00', 5000, 1),
(15, 'ACEITUNAS', 2, 1, '100.00', '0.00', 1000, 1),
(16, 'ANCHOAS', 2, 1, '250.00', '0.00', 500, 0),
(17, 'OREGANO', 2, 1, '60.00', '0.00', 500, 1),
(18, 'PIZZA CALABRESA', 1, 0, '0.00', '140.00', 5, 1),
(19, 'SIDRA 1L', 0, 0, '36.00', '52.00', 10, 1),
(20, 'DORITOS', 0, 0, '22.00', '35.00', 5, 1),
(21, 'CHOCOLATE BARRA', 0, 0, '8.75', '14.25', 8, 1),
(22, 'MANTECA', 2, 1, '80.00', '0.00', 2000, 1),
(23, 'PALITO SALADO', 0, 0, '1.25', '3.50', 4, 1),
(24, 'COCA COLA LATA', 0, 0, '16.00', '24.00', 8, 1),
(25, 'AGUA MINERAL SIN GAS', 0, 0, '25.00', '30.00', 60, 1),
(26, 'EMPANADAS DE JAMÃ“N Y QUESO', 1, 0, '0.00', '15.00', 60, 1),
(27, 'JAMÃ“N COCIDO', 2, 1, '80.00', '0.00', 40000, 1),
(28, 'TAPAS DE EMPANADAS', 2, 0, '1.25', '0.00', 600, 1),
(29, 'SEVEN UP 1L', 0, 0, '10.00', '17.00', 8, 1),
(30, 'GAYTORADE', 0, 0, '6.50', '12.00', 0, 1),
(31, 'ARROZ CON LECHE', 0, 0, '2.25', '6.50', 0, 1),
(32, 'FACTURAS DULCE DE LECHE', 0, 0, '3.00', '5.00', 5, 1),
(33, 'PUFLITO', 0, 0, '5.00', '7.25', 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja`
--

CREATE TABLE `caja` (
  `cajaID` int(9) UNSIGNED NOT NULL,
  `cajaMonto` decimal(9,2) NOT NULL,
  `empleID` int(9) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargos`
--

CREATE TABLE `cargos` (
  `cargoID` int(2) NOT NULL,
  `cargoNombre` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `cargoActivo` tinyint(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cargos`
--

INSERT INTO `cargos` (`cargoID`, `cargoNombre`, `cargoActivo`) VALUES
(1, 'COCINERO', 1),
(2, 'VENDEDOR', 1),
(3, 'PUNTERO', 0),
(4, 'MOTOQUERO', 0),
(5, 'MOZO', 1),
(6, 'PELMAZO', 0),
(7, 'SACERDOTE', 0),
(8, 'MOTOCHORRO', 0),
(9, 'MAESTRO', 0),
(10, 'MOTOMANDADO', 1),
(11, 'LIMPIEZA', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `controlcaja`
--

CREATE TABLE `controlcaja` (
  `concajaID` int(9) UNSIGNED NOT NULL,
  `concajaNumero` int(16) UNSIGNED NOT NULL,
  `concajaFecha` date DEFAULT NULL,
  `concajaMonto` decimal(9,2) NOT NULL,
  `empleID` int(9) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `controlstock`
--

CREATE TABLE `controlstock` (
  `constockID` int(9) UNSIGNED NOT NULL,
  `constockConcepto` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `constockFecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `controlstock`
--

INSERT INTO `controlstock` (`constockID`, `constockConcepto`, `constockFecha`) VALUES
(1, 2, '2017-03-17 16:33:20'),
(2, 2, '2017-03-17 16:35:23'),
(3, 2, '2017-03-17 16:35:23'),
(4, 2, '2017-03-17 16:35:23'),
(5, 2, '2017-03-17 17:35:05'),
(6, 2, '2017-03-17 17:35:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles`
--

CREATE TABLE `detalles` (
  `detaID` int(9) UNSIGNED NOT NULL,
  `factID` int(9) UNSIGNED NOT NULL,
  `detaPrecio` decimal(6,2) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `detalles`
--

INSERT INTO `detalles` (`detaID`, `factID`, `detaPrecio`) VALUES
(1, 1, '120.00'),
(2, 1, '35.00'),
(3, 2, '140.00'),
(4, 2, '120.00'),
(5, 2, '15.00'),
(6, 2, '32.00'),
(7, 3, '120.00'),
(8, 3, '32.00'),
(9, 3, '15.00'),
(10, 3, '35.00'),
(11, 4, '30.00'),
(12, 4, '6.50'),
(13, 5, '12.00'),
(14, 5, '35.00'),
(15, 5, '3.50'),
(16, 6, '140.00'),
(17, 6, '25.00'),
(18, 7, '60.00'),
(19, 7, '20.00'),
(20, 8, '60.00'),
(21, 8, '60.00'),
(22, 8, '80.00'),
(23, 8, '100.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `factID` int(9) UNSIGNED NOT NULL,
  `factNumero` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `factFecha` date DEFAULT NULL,
  `factTipo` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `clieprovID` int(9) UNSIGNED NOT NULL,
  `factEstado` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`factID`, `factNumero`, `factFecha`, `factTipo`, `clieprovID`, `factEstado`) VALUES
(1, '111', '2017-03-17', 1, 13, 0),
(2, '222', '2017-03-17', 1, 9, 0),
(3, '333', '2017-03-17', 1, 1, 0),
(4, '444', '2017-03-17', 1, 14, 0),
(5, '555', '2017-03-17', 1, 14, 0),
(6, 'C111', '2017-03-26', 0, 6, 0),
(7, 'C222', '2017-03-26', 0, 4, 0),
(8, 'C333', '2017-03-28', 0, 6, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidades`
--

CREATE TABLE `localidades` (
  `locaID` int(2) UNSIGNED NOT NULL,
  `locaNombre` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `provID` int(2) UNSIGNED NOT NULL,
  `locaActivo` tinyint(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `localidades`
--

INSERT INTO `localidades` (`locaID`, `locaNombre`, `provID`, `locaActivo`) VALUES
(1, 'POSADAS', 1, 1),
(2, 'LA PLATA', 4, 1),
(3, 'IGUAZU', 1, 1),
(4, 'CORRIENTES', 2, 1),
(5, 'WARAWARA', 19, 0),
(6, 'YAPEYU', 2, 1),
(7, 'CANDELARIA', 1, 1),
(8, 'OBERA', 1, 1),
(9, 'APOSTOLES', 1, 1),
(10, 'ITUZAINGO', 2, 1),
(11, 'ENTRE RIOS', 3, 1),
(12, 'ROSARIO', 5, 1),
(13, 'ASDASD', 14, 0),
(14, 'CAPITAL FEDERAL', 4, 1),
(15, 'DADADAD', 4, 0),
(16, 'SHALALASD', 1, 0),
(17, 'LOCAS LOCAS', 9, 0),
(18, 'PATATAS', 13, 0),
(19, 'FORMOSA', 7, 1),
(20, 'ELDORADO', 1, 1),
(21, 'CLORINDA', 7, 1),
(22, 'GARUPA', 1, 1),
(23, 'BAHIA BLANCA', 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `persID` int(9) UNSIGNED NOT NULL,
  `persNombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `persApellido` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `persTipo` tinyint(1) NOT NULL,
  `persDNI` int(9) UNSIGNED NOT NULL,
  `persDomicilio` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locaID` int(4) UNSIGNED DEFAULT NULL,
  `persTelefono` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `persNacimiento` date DEFAULT NULL,
  `cargoID` int(2) UNSIGNED DEFAULT NULL,
  `proveID` int(9) UNSIGNED DEFAULT NULL,
  `persFechaAlta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `persActivo` tinyint(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`persID`, `persNombre`, `persApellido`, `persTipo`, `persDNI`, `persDomicilio`, `locaID`, `persTelefono`, `persNacimiento`, `cargoID`, `proveID`, `persFechaAlta`, `persActivo`) VALUES
(1, 'FRANCO', 'ALCARAZ', 0, 37156608, 'VILLA CABELLO', 1, '3764334455', '1992-10-25', NULL, NULL, '2017-02-13 16:21:03', 1),
(2, 'PEDRO', 'PEREZ', 0, 12345678, 'VILLA JUANITA', 19, '3764335577', '1976-08-06', NULL, NULL, '2017-02-13 16:21:03', 0),
(3, 'CARLOS', 'GUTIERREZ', 1, 45222333, 'SAN LUIS 2235', 1, '3377558877', '1986-10-30', 1, NULL, '2017-02-27 13:29:31', 1),
(4, 'JUAN', 'GONZALES', 2, 11555444, 'SAN MARTIN 442 DEPTO G6 PISO 7', 3, '9922115544', '1978-05-12', NULL, 3, '2017-02-27 13:29:31', 1),
(5, 'FERNANDO', 'LOPEZ', 2, 55444666, 'BARRIO JUANITAS MANZANA 8', 10, '8877232323', '1991-04-09', NULL, 8, '2017-02-27 17:05:06', 1),
(6, 'MARCOS', 'FERRARI', 2, 11222555, '', 1, NULL, NULL, NULL, 6, '2017-02-27 22:39:23', 1),
(7, 'MARTA', 'GONZALES', 1, 33555888, '', 4, '6666442211', NULL, 2, NULL, '2017-02-28 03:33:01', 1),
(8, 'JUALIAN', 'PERON', 0, 11333666, '', NULL, NULL, NULL, NULL, NULL, '2017-02-28 03:47:47', 0),
(9, 'ESTEBAN', 'SUAREZ', 0, 27888456, 'SAN MARTIN 445', 20, '376458471', '1984-02-02', NULL, NULL, '2017-02-28 21:29:21', 1),
(10, 'JOSE', 'LOPEZ', 2, 35784631, 'CORDOBA 763', 21, '376574361', '1983-12-25', NULL, 9, '2017-02-28 21:31:47', 1),
(11, 'JUAN', 'FERNANDEZ', 1, 42145869, 'BOLIVAR 721', 22, '376487451', '1999-08-12', 11, NULL, '2017-02-28 21:33:38', 1),
(12, 'SEBASTIAN', 'ZORRO', 0, 66888444, 'AV PERON 436 CASA 4', 23, NULL, NULL, NULL, NULL, '2017-03-12 16:28:06', 1),
(13, 'SANDRA', 'ALCARAZ', 0, 23456789, 'VILLA CABELLO', 1, '3764554477', '1973-07-20', NULL, NULL, '2017-03-14 21:05:08', 1),
(14, 'MARIA', 'LOPEZ', 0, 44999555, '', NULL, NULL, NULL, NULL, NULL, '2017-03-14 23:44:17', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_ingrediente`
--

CREATE TABLE `producto_ingrediente` (
  `prodID` int(9) UNSIGNED NOT NULL,
  `ingrID` int(9) UNSIGNED NOT NULL,
  `ingrCantidad` int(9) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `producto_ingrediente`
--

INSERT INTO `producto_ingrediente` (`prodID`, `ingrID`, `ingrCantidad`) VALUES
(5, 7, 1),
(5, 4, 60),
(5, 2, 200),
(13, 17, 5),
(13, 7, 1),
(13, 4, 50),
(13, 2, 200),
(13, 15, 40),
(18, 2, 200),
(18, 3, 250),
(18, 4, 60),
(18, 5, 100),
(18, 15, 40),
(18, 17, 20),
(6, 14, 60),
(6, 3, 20),
(26, 2, 25),
(26, 27, 25),
(26, 28, 1),
(6, 28, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `proveID` int(9) UNSIGNED NOT NULL,
  `proveNombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `proveActivo` tinyint(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`proveID`, `proveNombre`, `proveActivo`) VALUES
(1, 'CALIFORNIA', 1),
(2, 'MAXICONSUMO', 1),
(3, 'DIARCO', 1),
(4, 'FABRICA DE CAJAS', 0),
(5, 'COSA NOSTRA', 0),
(6, 'VITAL', 1),
(7, 'LOS Z', 0),
(8, 'MAKRO', 1),
(9, 'YAGUAR', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincias`
--

CREATE TABLE `provincias` (
  `provID` int(2) UNSIGNED NOT NULL,
  `provNombre` varchar(30) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `provincias`
--

INSERT INTO `provincias` (`provID`, `provNombre`) VALUES
(1, 'MISIONES'),
(2, 'CORRIENTES'),
(3, 'ENTRE RIOS'),
(4, 'BUENOS AIRES'),
(5, 'SANTA FE'),
(6, 'CHACO'),
(7, 'FORMOSA'),
(8, 'SANTIAGO DEL ESTERO'),
(9, 'TUCUMAN'),
(10, 'SALTA'),
(11, 'JUJUY'),
(12, 'CATAMARCA'),
(13, 'LA RIOJA'),
(14, 'SAN JUAN'),
(15, 'MENDOZA'),
(16, 'SAN LUIS'),
(17, 'CORDOBA'),
(18, 'LA PAMPA'),
(19, 'NEUQUEN'),
(20, 'RIO NEGRO'),
(21, 'CHUBUT'),
(22, 'SANTA CRUZ'),
(23, 'TIERRA DEL FUEGO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock`
--

CREATE TABLE `stock` (
  `stockID` int(9) UNSIGNED NOT NULL,
  `detaID` int(9) UNSIGNED DEFAULT '0',
  `constockID` int(9) UNSIGNED NOT NULL DEFAULT '0',
  `artiID` int(9) UNSIGNED NOT NULL,
  `stockCantidad` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `stock`
--

INSERT INTO `stock` (`stockID`, `detaID`, `constockID`, `artiID`, `stockCantidad`) VALUES
(1, 1, 1, 17, -5),
(2, 1, 1, 7, -1),
(3, 1, 1, 4, -50),
(4, 1, 1, 2, -200),
(5, 1, 1, 15, -40),
(6, 1, 0, 13, -1),
(7, 2, 0, 9, -1),
(8, 3, 2, 2, -200),
(9, 3, 2, 3, -250),
(10, 3, 2, 4, -60),
(11, 3, 2, 5, -100),
(12, 3, 2, 15, -40),
(13, 3, 2, 17, -20),
(14, 3, 0, 18, -1),
(15, 4, 3, 17, -10),
(16, 4, 3, 7, -2),
(17, 4, 3, 4, -100),
(18, 4, 3, 2, -400),
(19, 4, 3, 15, -80),
(20, 4, 0, 13, -2),
(21, 5, 4, 2, -300),
(22, 5, 4, 27, -300),
(23, 5, 4, 28, -12),
(24, 5, 0, 26, -12),
(25, 6, 0, 8, -1),
(26, 7, 5, 17, -10),
(27, 7, 5, 7, -2),
(28, 7, 5, 4, -100),
(29, 7, 5, 2, -400),
(30, 7, 5, 15, -80),
(31, 7, 0, 13, -2),
(32, 8, 0, 8, -1),
(33, 9, 6, 2, -150),
(34, 9, 6, 27, -150),
(35, 9, 6, 28, -6),
(36, 9, 0, 26, -6),
(37, 10, 0, 20, -1),
(38, 11, 0, 25, -1),
(39, 12, 0, 31, -1),
(40, 13, 0, 30, -2),
(41, 14, 0, 20, -1),
(42, 15, 0, 23, -1),
(43, 16, 0, 5, 2000),
(44, 17, 0, 25, 6),
(45, 18, 0, 2, 6000),
(46, 19, 0, 7, 20),
(47, 20, 0, 14, 6000),
(48, 21, 0, 2, 4000),
(49, 22, 0, 27, 5000),
(50, 23, 0, 15, 1000);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `appusuarios`
--
ALTER TABLE `appusuarios`
  ADD UNIQUE KEY `clieID` (`clieID`);

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`artiID`);

--
-- Indices de la tabla `caja`
--
ALTER TABLE `caja`
  ADD PRIMARY KEY (`cajaID`);

--
-- Indices de la tabla `cargos`
--
ALTER TABLE `cargos`
  ADD PRIMARY KEY (`cargoID`);

--
-- Indices de la tabla `controlcaja`
--
ALTER TABLE `controlcaja`
  ADD PRIMARY KEY (`concajaID`),
  ADD UNIQUE KEY `retiNumero` (`concajaNumero`);

--
-- Indices de la tabla `controlstock`
--
ALTER TABLE `controlstock`
  ADD PRIMARY KEY (`constockID`);

--
-- Indices de la tabla `detalles`
--
ALTER TABLE `detalles`
  ADD PRIMARY KEY (`detaID`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`factID`),
  ADD UNIQUE KEY `factNumero` (`factNumero`);

--
-- Indices de la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD PRIMARY KEY (`locaID`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`persID`),
  ADD UNIQUE KEY `persDNI` (`persDNI`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`proveID`);

--
-- Indices de la tabla `provincias`
--
ALTER TABLE `provincias`
  ADD PRIMARY KEY (`provID`);

--
-- Indices de la tabla `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`stockID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `artiID` int(9) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT de la tabla `caja`
--
ALTER TABLE `caja`
  MODIFY `cajaID` int(9) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `cargos`
--
ALTER TABLE `cargos`
  MODIFY `cargoID` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `controlcaja`
--
ALTER TABLE `controlcaja`
  MODIFY `concajaID` int(9) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `controlstock`
--
ALTER TABLE `controlstock`
  MODIFY `constockID` int(9) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `detalles`
--
ALTER TABLE `detalles`
  MODIFY `detaID` int(9) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `factID` int(9) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `localidades`
--
ALTER TABLE `localidades`
  MODIFY `locaID` int(2) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `persID` int(9) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `proveID` int(9) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `provincias`
--
ALTER TABLE `provincias`
  MODIFY `provID` int(2) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT de la tabla `stock`
--
ALTER TABLE `stock`
  MODIFY `stockID` int(9) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
