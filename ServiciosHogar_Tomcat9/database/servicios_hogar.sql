-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-10-2026 a las 05:20:27
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `servicios_hogar`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(5, 'Carpinteria'),
(1, 'Electricidad'),
(2, 'Gasfiteria'),
(6, 'Mantenimiento general'),
(4, 'Pintura'),
(3, 'Reparacion de electrodomesticos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id` bigint(20) NOT NULL,
  `solicitud_id` bigint(20) NOT NULL,
  `remitente_id` bigint(20) NOT NULL,
  `contenido` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `mensaje` varchar(255) NOT NULL,
  `leida` tinyint(1) NOT NULL DEFAULT 0,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` bigint(20) NOT NULL,
  `solicitud_id` bigint(20) NOT NULL,
  `comprador_id` bigint(20) NOT NULL,
  `importe` decimal(10,2) NOT NULL,
  `metodo` varchar(40) NOT NULL DEFAULT 'SIMULADO',
  `estado` enum('PENDIENTE','APROBADO','RECHAZADO','REEMBOLSADO') NOT NULL DEFAULT 'PENDIENTE',
  `referencia` varchar(100) DEFAULT NULL,
  `fecha_pago` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfiles_proveedor`
--

CREATE TABLE `perfiles_proveedor` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `foto_url` varchar(500) DEFAULT NULL,
  `experiencia_anios` int(11) NOT NULL DEFAULT 0,
  `tarifa_referencial` decimal(10,2) DEFAULT 0.00,
  `verificacion` enum('PENDIENTE','APROBADO','RECHAZADO') NOT NULL DEFAULT 'PENDIENTE',
  `disponibilidad` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `perfiles_proveedor`
--

INSERT INTO `perfiles_proveedor` (`id`, `usuario_id`, `descripcion`, `foto_url`, `experiencia_anios`, `tarifa_referencial`, `verificacion`, `disponibilidad`) VALUES
(1, 4, NULL, NULL, 0, 0.00, 'PENDIENTE', 1),
(2, 5, 'Electricista con 3 años de experiencia. Realiza instalaciones eléctricas, reparación de tomacorrientes, iluminación, cableado y mantenimiento eléctrico para el hogar.', '/img/proveedores/electricidad_01.jpg', 3, 48.00, 'APROBADO', 1),
(3, 6, 'Gasfitero con 3 años de experiencia en reparación de fugas, tuberías, grifos, lavaderos, baños y sistemas de agua para viviendas.', '/img/proveedores/gasfiteria.jpg', 3, 43.00, 'APROBADO', 1),
(4, 7, 'Técnico especializado con 3 años de experiencia reparando electrodomésticos. Diagnóstico y mantenimiento de equipos del hogar.', '/img/proveedores/electrodomesticos.jpg', 3, 54.00, 'APROBADO', 1),
(5, 8, 'Pintor profesional con 3 años de experiencia en pintura de interiores y exteriores, acabados, preparación de paredes y renovación de ambientes.', '/img/proveedores/pintura.jpg', 3, 38.00, 'APROBADO', 1),
(6, 9, 'Carpintero con 3 años de experiencia en fabricación y reparación de muebles, puertas, mesas, estantes y trabajos personalizados en madera.', '/img/proveedores/carpinteria.jpg', 3, 59.00, 'APROBADO', 1),
(7, 10, 'Especialista en mantenimiento general con 3 años de experiencia realizando reparaciones, instalaciones y mantenimiento preventivo dentro del hogar.', '/img/proveedores/mantenimiento.jpg', 3, 43.00, 'APROBADO', 1),
(8, 11, 'Electricista con 4 años de experiencia. Realiza instalaciones eléctricas, reparación de tomacorrientes, iluminación, cableado y mantenimiento eléctrico para el hogar.', '/img/proveedores/electricidad_02.jpg', 4, 51.00, 'APROBADO', 1),
(9, 12, 'Gasfitero con 4 años de experiencia en reparación de fugas, tuberías, grifos, lavaderos, baños y sistemas de agua para viviendas.', '/img/proveedores/gasfiteria.jpg', 4, 46.00, 'APROBADO', 1),
(10, 13, 'Técnico especializado con 4 años de experiencia reparando electrodomésticos. Diagnóstico y mantenimiento de equipos del hogar.', '/img/proveedores/electrodomesticos.jpg', 4, 58.00, 'APROBADO', 1),
(11, 14, 'Pintor profesional con 4 años de experiencia en pintura de interiores y exteriores, acabados, preparación de paredes y renovación de ambientes.', '/img/proveedores/pintura.jpg', 4, 41.00, 'APROBADO', 1),
(12, 15, 'Carpintero con 4 años de experiencia en fabricación y reparación de muebles, puertas, mesas, estantes y trabajos personalizados en madera.', '/img/proveedores/carpinteria.jpg', 4, 63.00, 'APROBADO', 1),
(13, 16, 'Especialista en mantenimiento general con 4 años de experiencia realizando reparaciones, instalaciones y mantenimiento preventivo dentro del hogar.', '/img/proveedores/mantenimiento.jpg', 4, 46.00, 'APROBADO', 1),
(14, 17, 'Electricista con 5 años de experiencia. Realiza instalaciones eléctricas, reparación de tomacorrientes, iluminación, cableado y mantenimiento eléctrico para el hogar.', '/img/proveedores/electricidad_03.jpg', 5, 54.00, 'APROBADO', 1),
(15, 18, 'Gasfitero con 5 años de experiencia en reparación de fugas, tuberías, grifos, lavaderos, baños y sistemas de agua para viviendas.', '/img/proveedores/gasfiteria.jpg', 5, 49.00, 'APROBADO', 1),
(16, 19, 'Técnico especializado con 5 años de experiencia reparando electrodomésticos. Diagnóstico y mantenimiento de equipos del hogar.', '/img/proveedores/electrodomesticos.jpg', 5, 62.00, 'APROBADO', 1),
(17, 20, 'Pintor profesional con 5 años de experiencia en pintura de interiores y exteriores, acabados, preparación de paredes y renovación de ambientes.', '/img/proveedores/pintura.jpg', 5, 44.00, 'APROBADO', 1),
(18, 21, 'Carpintero con 5 años de experiencia en fabricación y reparación de muebles, puertas, mesas, estantes y trabajos personalizados en madera.', '/img/proveedores/carpinteria.jpg', 5, 67.00, 'APROBADO', 1),
(19, 22, 'Especialista en mantenimiento general con 5 años de experiencia realizando reparaciones, instalaciones y mantenimiento preventivo dentro del hogar.', '/img/proveedores/mantenimiento.jpg', 5, 49.00, 'APROBADO', 1),
(20, 23, 'Electricista con 6 años de experiencia. Realiza instalaciones eléctricas, reparación de tomacorrientes, iluminación, cableado y mantenimiento eléctrico para el hogar.', '/img/proveedores/electricidad_01.jpg', 6, 57.00, 'APROBADO', 1),
(21, 24, 'Gasfitero con 6 años de experiencia en reparación de fugas, tuberías, grifos, lavaderos, baños y sistemas de agua para viviendas.', '/img/proveedores/gasfiteria.jpg', 6, 52.00, 'APROBADO', 1),
(22, 25, 'Técnico especializado con 6 años de experiencia reparando electrodomésticos. Diagnóstico y mantenimiento de equipos del hogar.', '/img/proveedores/electrodomesticos.jpg', 6, 66.00, 'APROBADO', 1),
(23, 26, 'Pintor profesional con 6 años de experiencia en pintura de interiores y exteriores, acabados, preparación de paredes y renovación de ambientes.', '/img/proveedores/pintura.jpg', 6, 47.00, 'APROBADO', 1),
(24, 27, 'Carpintero con 6 años de experiencia en fabricación y reparación de muebles, puertas, mesas, estantes y trabajos personalizados en madera.', '/img/proveedores/carpinteria.jpg', 6, 71.00, 'APROBADO', 1),
(25, 28, 'Especialista en mantenimiento general con 6 años de experiencia realizando reparaciones, instalaciones y mantenimiento preventivo dentro del hogar.', '/img/proveedores/mantenimiento.jpg', 6, 52.00, 'APROBADO', 1),
(26, 29, 'Electricista con 7 años de experiencia. Realiza instalaciones eléctricas, reparación de tomacorrientes, iluminación, cableado y mantenimiento eléctrico para el hogar.', '/img/proveedores/electricidad_02.jpg', 7, 60.00, 'APROBADO', 1),
(27, 30, 'Gasfitero con 7 años de experiencia en reparación de fugas, tuberías, grifos, lavaderos, baños y sistemas de agua para viviendas.', '/img/proveedores/gasfiteria.jpg', 7, 55.00, 'APROBADO', 1),
(28, 31, 'Técnico especializado con 7 años de experiencia reparando electrodomésticos. Diagnóstico y mantenimiento de equipos del hogar.', '/img/proveedores/electrodomesticos.jpg', 7, 70.00, 'APROBADO', 1),
(29, 32, 'Pintor profesional con 7 años de experiencia en pintura de interiores y exteriores, acabados, preparación de paredes y renovación de ambientes.', '/img/proveedores/pintura.jpg', 7, 50.00, 'APROBADO', 1),
(30, 33, 'Carpintero con 7 años de experiencia en fabricación y reparación de muebles, puertas, mesas, estantes y trabajos personalizados en madera.', '/img/proveedores/carpinteria.jpg', 7, 75.00, 'APROBADO', 1),
(31, 34, 'Especialista en mantenimiento general con 7 años de experiencia realizando reparaciones, instalaciones y mantenimiento preventivo dentro del hogar.', '/img/proveedores/mantenimiento.jpg', 7, 55.00, 'APROBADO', 1),
(32, 35, 'Electricista con 8 años de experiencia. Realiza instalaciones eléctricas, reparación de tomacorrientes, iluminación, cableado y mantenimiento eléctrico para el hogar.', '/img/proveedores/electricidad_03.jpg', 8, 63.00, 'APROBADO', 1),
(33, 36, 'Gasfitero con 8 años de experiencia en reparación de fugas, tuberías, grifos, lavaderos, baños y sistemas de agua para viviendas.', '/img/proveedores/gasfiteria.jpg', 8, 58.00, 'APROBADO', 1),
(34, 37, 'Técnico especializado con 8 años de experiencia reparando electrodomésticos. Diagnóstico y mantenimiento de equipos del hogar.', '/img/proveedores/electrodomesticos.jpg', 8, 74.00, 'APROBADO', 1),
(35, 38, 'Pintor profesional con 8 años de experiencia en pintura de interiores y exteriores, acabados, preparación de paredes y renovación de ambientes.', '/img/proveedores/pintura.jpg', 8, 53.00, 'APROBADO', 1),
(36, 39, 'Carpintero con 8 años de experiencia en fabricación y reparación de muebles, puertas, mesas, estantes y trabajos personalizados en madera.', '/img/proveedores/carpinteria.jpg', 8, 79.00, 'APROBADO', 1),
(37, 40, 'Especialista en mantenimiento general con 8 años de experiencia realizando reparaciones, instalaciones y mantenimiento preventivo dentro del hogar.', '/img/proveedores/mantenimiento.jpg', 8, 58.00, 'APROBADO', 1),
(38, 41, 'Electricista con 9 años de experiencia. Realiza instalaciones eléctricas, reparación de tomacorrientes, iluminación, cableado y mantenimiento eléctrico para el hogar.', '/img/proveedores/electricidad_01.jpg', 9, 66.00, 'APROBADO', 1),
(39, 42, 'Gasfitero con 9 años de experiencia en reparación de fugas, tuberías, grifos, lavaderos, baños y sistemas de agua para viviendas.', '/img/proveedores/gasfiteria.jpg', 9, 61.00, 'APROBADO', 1),
(40, 43, 'Técnico especializado con 9 años de experiencia reparando electrodomésticos. Diagnóstico y mantenimiento de equipos del hogar.', '/img/proveedores/electrodomesticos.jpg', 9, 78.00, 'APROBADO', 1),
(41, 44, 'Pintor profesional con 9 años de experiencia en pintura de interiores y exteriores, acabados, preparación de paredes y renovación de ambientes.', '/img/proveedores/pintura.jpg', 9, 56.00, 'APROBADO', 1),
(42, 45, 'Carpintero con 9 años de experiencia en fabricación y reparación de muebles, puertas, mesas, estantes y trabajos personalizados en madera.', '/img/proveedores/carpinteria.jpg', 9, 83.00, 'APROBADO', 1),
(43, 46, 'Especialista en mantenimiento general con 9 años de experiencia realizando reparaciones, instalaciones y mantenimiento preventivo dentro del hogar.', '/img/proveedores/mantenimiento.jpg', 9, 61.00, 'APROBADO', 1),
(44, 47, 'Electricista con 2 años de experiencia. Realiza instalaciones eléctricas, reparación de tomacorrientes, iluminación, cableado y mantenimiento eléctrico para el hogar.', '/img/proveedores/electricidad_02.jpg', 2, 69.00, 'APROBADO', 1),
(45, 48, 'Gasfitero con 2 años de experiencia en reparación de fugas, tuberías, grifos, lavaderos, baños y sistemas de agua para viviendas.', '/img/proveedores/gasfiteria.jpg', 2, 64.00, 'APROBADO', 1),
(46, 49, 'Técnico especializado con 2 años de experiencia reparando electrodomésticos. Diagnóstico y mantenimiento de equipos del hogar.', '/img/proveedores/electrodomesticos.jpg', 2, 82.00, 'APROBADO', 1),
(47, 50, 'Pintor profesional con 2 años de experiencia en pintura de interiores y exteriores, acabados, preparación de paredes y renovación de ambientes.', '/img/proveedores/pintura.jpg', 2, 59.00, 'APROBADO', 1),
(48, 51, 'Carpintero con 2 años de experiencia en fabricación y reparación de muebles, puertas, mesas, estantes y trabajos personalizados en madera.', '/img/proveedores/carpinteria.jpg', 2, 87.00, 'APROBADO', 1),
(49, 52, 'Especialista en mantenimiento general con 2 años de experiencia realizando reparaciones, instalaciones y mantenimiento preventivo dentro del hogar.', '/img/proveedores/mantenimiento.jpg', 2, 64.00, 'APROBADO', 1),
(50, 53, 'Electricista con 3 años de experiencia. Realiza instalaciones eléctricas, reparación de tomacorrientes, iluminación, cableado y mantenimiento eléctrico para el hogar.', '/img/proveedores/electricidad_03.jpg', 3, 72.00, 'APROBADO', 1),
(51, 54, 'Gasfitero con 3 años de experiencia en reparación de fugas, tuberías, grifos, lavaderos, baños y sistemas de agua para viviendas.', '/img/proveedores/gasfiteria.jpg', 3, 67.00, 'APROBADO', 1),
(52, 55, 'Técnico especializado con 3 años de experiencia reparando electrodomésticos. Diagnóstico y mantenimiento de equipos del hogar.', '/img/proveedores/electrodomesticos.jpg', 3, 86.00, 'APROBADO', 1),
(53, 56, 'Pintor profesional con 3 años de experiencia en pintura de interiores y exteriores, acabados, preparación de paredes y renovación de ambientes.', '/img/proveedores/pintura.jpg', 3, 62.00, 'APROBADO', 1),
(54, 57, 'Carpintero con 3 años de experiencia en fabricación y reparación de muebles, puertas, mesas, estantes y trabajos personalizados en madera.', '/img/proveedores/carpinteria.jpg', 3, 91.00, 'APROBADO', 1),
(55, 58, 'Especialista en mantenimiento general con 3 años de experiencia realizando reparaciones, instalaciones y mantenimiento preventivo dentro del hogar.', '/img/proveedores/mantenimiento.jpg', 3, 67.00, 'APROBADO', 1),
(56, 59, 'Electricista con 4 años de experiencia. Realiza instalaciones eléctricas, reparación de tomacorrientes, iluminación, cableado y mantenimiento eléctrico para el hogar.', '/img/proveedores/electricidad_01.jpg', 4, 75.00, 'APROBADO', 1),
(57, 60, 'Gasfitero con 4 años de experiencia en reparación de fugas, tuberías, grifos, lavaderos, baños y sistemas de agua para viviendas.', '/img/proveedores/gasfiteria.jpg', 4, 70.00, 'APROBADO', 1),
(58, 61, 'Técnico especializado con 4 años de experiencia reparando electrodomésticos. Diagnóstico y mantenimiento de equipos del hogar.', '/img/proveedores/electrodomesticos.jpg', 4, 90.00, 'APROBADO', 1),
(59, 62, 'Pintor profesional con 4 años de experiencia en pintura de interiores y exteriores, acabados, preparación de paredes y renovación de ambientes.', '/img/proveedores/pintura.jpg', 4, 65.00, 'APROBADO', 1),
(60, 63, 'Carpintero con 4 años de experiencia en fabricación y reparación de muebles, puertas, mesas, estantes y trabajos personalizados en madera.', '/img/proveedores/carpinteria.jpg', 4, 95.00, 'APROBADO', 1),
(61, 64, 'Especialista en mantenimiento general con 4 años de experiencia realizando reparaciones, instalaciones y mantenimiento preventivo dentro del hogar.', '/img/proveedores/mantenimiento.jpg', 4, 70.00, 'APROBADO', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `portafolio`
--

CREATE TABLE `portafolio` (
  `id` bigint(20) NOT NULL,
  `proveedor_id` bigint(20) NOT NULL,
  `titulo` varchar(120) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen_url` varchar(500) NOT NULL,
  `fecha_publicacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resenas`
--

CREATE TABLE `resenas` (
  `id` bigint(20) NOT NULL,
  `solicitud_id` bigint(20) NOT NULL,
  `comprador_id` bigint(20) NOT NULL,
  `proveedor_id` bigint(20) NOT NULL,
  `puntuacion` tinyint(4) NOT NULL,
  `comentario` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` bigint(20) NOT NULL,
  `proveedor_id` bigint(20) NOT NULL,
  `categoria_id` bigint(20) NOT NULL,
  `titulo` varchar(120) NOT NULL,
  `descripcion` text NOT NULL,
  `imagen_url` varchar(500) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id`, `proveedor_id`, `categoria_id`, `titulo`, `descripcion`, `imagen_url`, `precio`, `activo`, `fecha_creacion`) VALUES
(1, 2, 1, 'Servicio de electricidad #01', 'Instalaciones, reparaciones y mantenimiento eléctrico para viviendas.', '/img/servicios/electricidad.jpg', 53.00, 1, '2026-10-27 11:43:30'),
(2, 3, 2, 'Servicio de gasfitería #01', 'Reparación de fugas, tuberías, grifos, lavaderos y servicios de gasfitería.', '/img/servicios/gasfiteria.jpg', 48.00, 1, '2026-10-27 11:43:30'),
(3, 4, 3, 'Reparación de electrodomésticos #01', 'Diagnóstico, reparación y mantenimiento de electrodomésticos del hogar.', '/img/servicios/electrodomesticos.jpg', 59.00, 1, '2026-10-27 11:43:30'),
(4, 5, 4, 'Servicio de pintura #01', 'Pintura de interiores y exteriores con preparación y acabado de superficies.', '/img/servicios/pintura.jpg', 43.00, 1, '2026-10-27 11:43:30'),
(5, 6, 5, 'Servicio de carpintería #01', 'Fabricación, reparación y mantenimiento de muebles y estructuras de madera.', '/img/servicios/carpinteria.jpg', 64.00, 1, '2026-10-27 11:43:30'),
(6, 7, 6, 'Mantenimiento del hogar #01', 'Mantenimiento general y pequeñas reparaciones para viviendas.', '/img/servicios/mantenimiento.jpg', 48.00, 1, '2026-10-27 11:43:30'),
(7, 8, 1, 'Servicio de electricidad #02', 'Instalaciones, reparaciones y mantenimiento eléctrico para viviendas.', '/img/servicios/electricidad.jpg', 56.00, 1, '2026-10-27 11:43:30'),
(8, 9, 2, 'Servicio de gasfitería #02', 'Reparación de fugas, tuberías, grifos, lavaderos y servicios de gasfitería.', '/img/servicios/gasfiteria.jpg', 51.00, 1, '2026-10-27 11:43:30'),
(9, 10, 3, 'Reparación de electrodomésticos #02', 'Diagnóstico, reparación y mantenimiento de electrodomésticos del hogar.', '/img/servicios/electrodomesticos.jpg', 63.00, 1, '2026-10-27 11:43:30'),
(10, 11, 4, 'Servicio de pintura #02', 'Pintura de interiores y exteriores con preparación y acabado de superficies.', '/img/servicios/pintura.jpg', 46.00, 1, '2026-10-27 11:43:30'),
(11, 12, 5, 'Servicio de carpintería #02', 'Fabricación, reparación y mantenimiento de muebles y estructuras de madera.', '/img/servicios/carpinteria.jpg', 68.00, 1, '2026-10-27 11:43:30'),
(12, 13, 6, 'Mantenimiento del hogar #02', 'Mantenimiento general y pequeñas reparaciones para viviendas.', '/img/servicios/mantenimiento.jpg', 51.00, 1, '2026-10-27 11:43:30'),
(13, 14, 1, 'Servicio de electricidad #03', 'Instalaciones, reparaciones y mantenimiento eléctrico para viviendas.', '/img/servicios/electricidad.jpg', 59.00, 1, '2026-10-27 11:43:30'),
(14, 15, 2, 'Servicio de gasfitería #03', 'Reparación de fugas, tuberías, grifos, lavaderos y servicios de gasfitería.', '/img/servicios/gasfiteria.jpg', 54.00, 1, '2026-10-27 11:43:30'),
(15, 16, 3, 'Reparación de electrodomésticos #03', 'Diagnóstico, reparación y mantenimiento de electrodomésticos del hogar.', '/img/servicios/electrodomesticos.jpg', 67.00, 1, '2026-10-27 11:43:30'),
(16, 17, 4, 'Servicio de pintura #03', 'Pintura de interiores y exteriores con preparación y acabado de superficies.', '/img/servicios/pintura.jpg', 49.00, 1, '2026-10-27 11:43:30'),
(17, 18, 5, 'Servicio de carpintería #03', 'Fabricación, reparación y mantenimiento de muebles y estructuras de madera.', '/img/servicios/carpinteria.jpg', 72.00, 1, '2026-10-27 11:43:30'),
(18, 19, 6, 'Mantenimiento del hogar #03', 'Mantenimiento general y pequeñas reparaciones para viviendas.', '/img/servicios/mantenimiento.jpg', 54.00, 1, '2026-10-27 11:43:30'),
(19, 20, 1, 'Servicio de electricidad #04', 'Instalaciones, reparaciones y mantenimiento eléctrico para viviendas.', '/img/servicios/electricidad.jpg', 62.00, 1, '2026-10-27 11:43:30'),
(20, 21, 2, 'Servicio de gasfitería #04', 'Reparación de fugas, tuberías, grifos, lavaderos y servicios de gasfitería.', '/img/servicios/gasfiteria.jpg', 57.00, 1, '2026-10-27 11:43:30'),
(21, 22, 3, 'Reparación de electrodomésticos #04', 'Diagnóstico, reparación y mantenimiento de electrodomésticos del hogar.', '/img/servicios/electrodomesticos.jpg', 71.00, 1, '2026-10-27 11:43:30'),
(22, 23, 4, 'Servicio de pintura #04', 'Pintura de interiores y exteriores con preparación y acabado de superficies.', '/img/servicios/pintura.jpg', 52.00, 1, '2026-10-27 11:43:30'),
(23, 24, 5, 'Servicio de carpintería #04', 'Fabricación, reparación y mantenimiento de muebles y estructuras de madera.', '/img/servicios/carpinteria.jpg', 76.00, 1, '2026-10-27 11:43:30'),
(24, 25, 6, 'Mantenimiento del hogar #04', 'Mantenimiento general y pequeñas reparaciones para viviendas.', '/img/servicios/mantenimiento.jpg', 57.00, 1, '2026-10-27 11:43:30'),
(25, 26, 1, 'Servicio de electricidad #05', 'Instalaciones, reparaciones y mantenimiento eléctrico para viviendas.', '/img/servicios/electricidad.jpg', 65.00, 1, '2026-10-27 11:43:30'),
(26, 27, 2, 'Servicio de gasfitería #05', 'Reparación de fugas, tuberías, grifos, lavaderos y servicios de gasfitería.', '/img/servicios/gasfiteria.jpg', 60.00, 1, '2026-10-27 11:43:30'),
(27, 28, 3, 'Reparación de electrodomésticos #05', 'Diagnóstico, reparación y mantenimiento de electrodomésticos del hogar.', '/img/servicios/electrodomesticos.jpg', 75.00, 1, '2026-10-27 11:43:30'),
(28, 29, 4, 'Servicio de pintura #05', 'Pintura de interiores y exteriores con preparación y acabado de superficies.', '/img/servicios/pintura.jpg', 55.00, 1, '2026-10-27 11:43:30'),
(29, 30, 5, 'Servicio de carpintería #05', 'Fabricación, reparación y mantenimiento de muebles y estructuras de madera.', '/img/servicios/carpinteria.jpg', 80.00, 1, '2026-10-27 11:43:30'),
(30, 31, 6, 'Mantenimiento del hogar #05', 'Mantenimiento general y pequeñas reparaciones para viviendas.', '/img/servicios/mantenimiento.jpg', 60.00, 1, '2026-10-27 11:43:30'),
(31, 32, 1, 'Servicio de electricidad #06', 'Instalaciones, reparaciones y mantenimiento eléctrico para viviendas.', '/img/servicios/electricidad.jpg', 68.00, 1, '2026-10-27 11:43:30'),
(32, 33, 2, 'Servicio de gasfitería #06', 'Reparación de fugas, tuberías, grifos, lavaderos y servicios de gasfitería.', '/img/servicios/gasfiteria.jpg', 63.00, 1, '2026-10-27 11:43:30'),
(33, 34, 3, 'Reparación de electrodomésticos #06', 'Diagnóstico, reparación y mantenimiento de electrodomésticos del hogar.', '/img/servicios/electrodomesticos.jpg', 79.00, 1, '2026-10-27 11:43:30'),
(34, 35, 4, 'Servicio de pintura #06', 'Pintura de interiores y exteriores con preparación y acabado de superficies.', '/img/servicios/pintura.jpg', 58.00, 1, '2026-10-27 11:43:30'),
(35, 36, 5, 'Servicio de carpintería #06', 'Fabricación, reparación y mantenimiento de muebles y estructuras de madera.', '/img/servicios/carpinteria.jpg', 84.00, 1, '2026-10-27 11:43:30'),
(36, 37, 6, 'Mantenimiento del hogar #06', 'Mantenimiento general y pequeñas reparaciones para viviendas.', '/img/servicios/mantenimiento.jpg', 63.00, 1, '2026-10-27 11:43:30'),
(37, 38, 1, 'Servicio de electricidad #07', 'Instalaciones, reparaciones y mantenimiento eléctrico para viviendas.', '/img/servicios/electricidad.jpg', 71.00, 1, '2026-10-27 11:43:30'),
(38, 39, 2, 'Servicio de gasfitería #07', 'Reparación de fugas, tuberías, grifos, lavaderos y servicios de gasfitería.', '/img/servicios/gasfiteria.jpg', 66.00, 1, '2026-10-27 11:43:30'),
(39, 40, 3, 'Reparación de electrodomésticos #07', 'Diagnóstico, reparación y mantenimiento de electrodomésticos del hogar.', '/img/servicios/electrodomesticos.jpg', 83.00, 1, '2026-10-27 11:43:30'),
(40, 41, 4, 'Servicio de pintura #07', 'Pintura de interiores y exteriores con preparación y acabado de superficies.', '/img/servicios/pintura.jpg', 61.00, 1, '2026-10-27 11:43:30'),
(41, 42, 5, 'Servicio de carpintería #07', 'Fabricación, reparación y mantenimiento de muebles y estructuras de madera.', '/img/servicios/carpinteria.jpg', 88.00, 1, '2026-10-27 11:43:30'),
(42, 43, 6, 'Mantenimiento del hogar #07', 'Mantenimiento general y pequeñas reparaciones para viviendas.', '/img/servicios/mantenimiento.jpg', 66.00, 1, '2026-10-27 11:43:30'),
(43, 44, 1, 'Servicio de electricidad #08', 'Instalaciones, reparaciones y mantenimiento eléctrico para viviendas.', '/img/servicios/electricidad.jpg', 74.00, 1, '2026-10-27 11:43:30'),
(44, 45, 2, 'Servicio de gasfitería #08', 'Reparación de fugas, tuberías, grifos, lavaderos y servicios de gasfitería.', '/img/servicios/gasfiteria.jpg', 69.00, 1, '2026-10-27 11:43:30'),
(45, 46, 3, 'Reparación de electrodomésticos #08', 'Diagnóstico, reparación y mantenimiento de electrodomésticos del hogar.', '/img/servicios/electrodomesticos.jpg', 87.00, 1, '2026-10-27 11:43:30'),
(46, 47, 4, 'Servicio de pintura #08', 'Pintura de interiores y exteriores con preparación y acabado de superficies.', '/img/servicios/pintura.jpg', 64.00, 1, '2026-10-27 11:43:30'),
(47, 48, 5, 'Servicio de carpintería #08', 'Fabricación, reparación y mantenimiento de muebles y estructuras de madera.', '/img/servicios/carpinteria.jpg', 92.00, 1, '2026-10-27 11:43:30'),
(48, 49, 6, 'Mantenimiento del hogar #08', 'Mantenimiento general y pequeñas reparaciones para viviendas.', '/img/servicios/mantenimiento.jpg', 69.00, 1, '2026-10-27 11:43:30'),
(49, 50, 1, 'Servicio de electricidad #09', 'Instalaciones, reparaciones y mantenimiento eléctrico para viviendas.', '/img/servicios/electricidad.jpg', 77.00, 1, '2026-10-27 11:43:30'),
(50, 51, 2, 'Servicio de gasfitería #09', 'Reparación de fugas, tuberías, grifos, lavaderos y servicios de gasfitería.', '/img/servicios/gasfiteria.jpg', 72.00, 1, '2026-10-27 11:43:30'),
(51, 52, 3, 'Reparación de electrodomésticos #09', 'Diagnóstico, reparación y mantenimiento de electrodomésticos del hogar.', '/img/servicios/electrodomesticos.jpg', 91.00, 1, '2026-10-27 11:43:30'),
(52, 53, 4, 'Servicio de pintura #09', 'Pintura de interiores y exteriores con preparación y acabado de superficies.', '/img/servicios/pintura.jpg', 67.00, 1, '2026-10-27 11:43:30'),
(53, 54, 5, 'Servicio de carpintería #09', 'Fabricación, reparación y mantenimiento de muebles y estructuras de madera.', '/img/servicios/carpinteria.jpg', 96.00, 1, '2026-10-27 11:43:30'),
(54, 55, 6, 'Mantenimiento del hogar #09', 'Mantenimiento general y pequeñas reparaciones para viviendas.', '/img/servicios/mantenimiento.jpg', 72.00, 1, '2026-10-27 11:43:30'),
(55, 56, 1, 'Servicio de electricidad #10', 'Instalaciones, reparaciones y mantenimiento eléctrico para viviendas.', '/img/servicios/electricidad.jpg', 80.00, 1, '2026-10-27 11:43:30'),
(56, 57, 2, 'Servicio de gasfitería #10', 'Reparación de fugas, tuberías, grifos, lavaderos y servicios de gasfitería.', '/img/servicios/gasfiteria.jpg', 75.00, 1, '2026-10-27 11:43:30'),
(57, 58, 3, 'Reparación de electrodomésticos #10', 'Diagnóstico, reparación y mantenimiento de electrodomésticos del hogar.', '/img/servicios/electrodomesticos.jpg', 95.00, 1, '2026-10-27 11:43:30'),
(58, 59, 4, 'Servicio de pintura #10', 'Pintura de interiores y exteriores con preparación y acabado de superficies.', '/img/servicios/pintura.jpg', 70.00, 1, '2026-10-27 11:43:30'),
(59, 60, 5, 'Servicio de carpintería #10', 'Fabricación, reparación y mantenimiento de muebles y estructuras de madera.', '/img/servicios/carpinteria.jpg', 100.00, 1, '2026-10-27 11:43:30'),
(60, 61, 6, 'Mantenimiento del hogar #10', 'Mantenimiento general y pequeñas reparaciones para viviendas.', '/img/servicios/mantenimiento.jpg', 75.00, 1, '2026-10-27 11:43:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes`
--

CREATE TABLE `solicitudes` (
  `id` bigint(20) NOT NULL,
  `comprador_id` bigint(20) NOT NULL,
  `servicio_id` bigint(20) NOT NULL,
  `descripcion_problema` text NOT NULL,
  `direccion` varchar(250) NOT NULL,
  `fecha_solicitada` datetime NOT NULL,
  `estado` enum('PENDIENTE','ACEPTADA','RECHAZADA','EN_PROCESO','FINALIZADA','CANCELADA') NOT NULL DEFAULT 'PENDIENTE',
  `precio_acordado` decimal(10,2) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `password_hash` varchar(100) NOT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `rol` enum('COMPRADOR','PROVEEDOR','ADMIN') NOT NULL DEFAULT 'COMPRADOR',
  `estado` enum('ACTIVO','BLOQUEADO') NOT NULL DEFAULT 'ACTIVO',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `password_hash`, `telefono`, `rol`, `estado`, `fecha_registro`) VALUES
(2, 'Sebastian Alexander Clavijo pinedo', 'sebas123456@gmail.com', '$2a$12$jZof7dqHJI/WMBmiETrK9OaxT2srkSaEUQInLMY5VmKcRs/vFENKO', '96325874', 'COMPRADOR', 'ACTIVO', '2026-10-27 10:14:44'),
(4, 'Sebastian Alexander Clavijo pinedo', 'sebas1234567@gmail.com', '$2a$12$esxlxF8k0NhfeM7dFT7Y2eY1YXsN9v.d.tHoJP7/MyfMt.OuK53WO', '96325874', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:33:15'),
(5, 'Electricista 01', 'demo.electricidad01@servicioshogar.local', 'CUENTA_DEMOSTRACION', '901000001', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(6, 'Gasfitero 01', 'demo.gasfiteria01@servicioshogar.local', 'CUENTA_DEMOSTRACION', '902000001', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(7, 'Técnico en electrodomésticos 01', 'demo.electrodomesticos01@servicioshogar.local', 'CUENTA_DEMOSTRACION', '903000001', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(8, 'Pintor profesional 01', 'demo.pintura01@servicioshogar.local', 'CUENTA_DEMOSTRACION', '904000001', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(9, 'Carpintero 01', 'demo.carpinteria01@servicioshogar.local', 'CUENTA_DEMOSTRACION', '905000001', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(10, 'Técnico de mantenimiento 01', 'demo.mantenimiento01@servicioshogar.local', 'CUENTA_DEMOSTRACION', '906000001', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(11, 'Electricista 02', 'demo.electricidad02@servicioshogar.local', 'CUENTA_DEMOSTRACION', '901000002', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(12, 'Gasfitero 02', 'demo.gasfiteria02@servicioshogar.local', 'CUENTA_DEMOSTRACION', '902000002', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(13, 'Técnico en electrodomésticos 02', 'demo.electrodomesticos02@servicioshogar.local', 'CUENTA_DEMOSTRACION', '903000002', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(14, 'Pintor profesional 02', 'demo.pintura02@servicioshogar.local', 'CUENTA_DEMOSTRACION', '904000002', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(15, 'Carpintero 02', 'demo.carpinteria02@servicioshogar.local', 'CUENTA_DEMOSTRACION', '905000002', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(16, 'Técnico de mantenimiento 02', 'demo.mantenimiento02@servicioshogar.local', 'CUENTA_DEMOSTRACION', '906000002', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(17, 'Electricista 03', 'demo.electricidad03@servicioshogar.local', 'CUENTA_DEMOSTRACION', '901000003', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(18, 'Gasfitero 03', 'demo.gasfiteria03@servicioshogar.local', 'CUENTA_DEMOSTRACION', '902000003', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(19, 'Técnico en electrodomésticos 03', 'demo.electrodomesticos03@servicioshogar.local', 'CUENTA_DEMOSTRACION', '903000003', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(20, 'Pintor profesional 03', 'demo.pintura03@servicioshogar.local', 'CUENTA_DEMOSTRACION', '904000003', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(21, 'Carpintero 03', 'demo.carpinteria03@servicioshogar.local', 'CUENTA_DEMOSTRACION', '905000003', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(22, 'Técnico de mantenimiento 03', 'demo.mantenimiento03@servicioshogar.local', 'CUENTA_DEMOSTRACION', '906000003', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(23, 'Electricista 04', 'demo.electricidad04@servicioshogar.local', 'CUENTA_DEMOSTRACION', '901000004', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(24, 'Gasfitero 04', 'demo.gasfiteria04@servicioshogar.local', 'CUENTA_DEMOSTRACION', '902000004', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(25, 'Técnico en electrodomésticos 04', 'demo.electrodomesticos04@servicioshogar.local', 'CUENTA_DEMOSTRACION', '903000004', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(26, 'Pintor profesional 04', 'demo.pintura04@servicioshogar.local', 'CUENTA_DEMOSTRACION', '904000004', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(27, 'Carpintero 04', 'demo.carpinteria04@servicioshogar.local', 'CUENTA_DEMOSTRACION', '905000004', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(28, 'Técnico de mantenimiento 04', 'demo.mantenimiento04@servicioshogar.local', 'CUENTA_DEMOSTRACION', '906000004', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(29, 'Electricista 05', 'demo.electricidad05@servicioshogar.local', 'CUENTA_DEMOSTRACION', '901000005', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(30, 'Gasfitero 05', 'demo.gasfiteria05@servicioshogar.local', 'CUENTA_DEMOSTRACION', '902000005', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(31, 'Técnico en electrodomésticos 05', 'demo.electrodomesticos05@servicioshogar.local', 'CUENTA_DEMOSTRACION', '903000005', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(32, 'Pintor profesional 05', 'demo.pintura05@servicioshogar.local', 'CUENTA_DEMOSTRACION', '904000005', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(33, 'Carpintero 05', 'demo.carpinteria05@servicioshogar.local', 'CUENTA_DEMOSTRACION', '905000005', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(34, 'Técnico de mantenimiento 05', 'demo.mantenimiento05@servicioshogar.local', 'CUENTA_DEMOSTRACION', '906000005', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(35, 'Electricista 06', 'demo.electricidad06@servicioshogar.local', 'CUENTA_DEMOSTRACION', '901000006', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(36, 'Gasfitero 06', 'demo.gasfiteria06@servicioshogar.local', 'CUENTA_DEMOSTRACION', '902000006', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(37, 'Técnico en electrodomésticos 06', 'demo.electrodomesticos06@servicioshogar.local', 'CUENTA_DEMOSTRACION', '903000006', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(38, 'Pintor profesional 06', 'demo.pintura06@servicioshogar.local', 'CUENTA_DEMOSTRACION', '904000006', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(39, 'Carpintero 06', 'demo.carpinteria06@servicioshogar.local', 'CUENTA_DEMOSTRACION', '905000006', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(40, 'Técnico de mantenimiento 06', 'demo.mantenimiento06@servicioshogar.local', 'CUENTA_DEMOSTRACION', '906000006', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(41, 'Electricista 07', 'demo.electricidad07@servicioshogar.local', 'CUENTA_DEMOSTRACION', '901000007', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(42, 'Gasfitero 07', 'demo.gasfiteria07@servicioshogar.local', 'CUENTA_DEMOSTRACION', '902000007', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(43, 'Técnico en electrodomésticos 07', 'demo.electrodomesticos07@servicioshogar.local', 'CUENTA_DEMOSTRACION', '903000007', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(44, 'Pintor profesional 07', 'demo.pintura07@servicioshogar.local', 'CUENTA_DEMOSTRACION', '904000007', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(45, 'Carpintero 07', 'demo.carpinteria07@servicioshogar.local', 'CUENTA_DEMOSTRACION', '905000007', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(46, 'Técnico de mantenimiento 07', 'demo.mantenimiento07@servicioshogar.local', 'CUENTA_DEMOSTRACION', '906000007', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(47, 'Electricista 08', 'demo.electricidad08@servicioshogar.local', 'CUENTA_DEMOSTRACION', '901000008', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(48, 'Gasfitero 08', 'demo.gasfiteria08@servicioshogar.local', 'CUENTA_DEMOSTRACION', '902000008', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(49, 'Técnico en electrodomésticos 08', 'demo.electrodomesticos08@servicioshogar.local', 'CUENTA_DEMOSTRACION', '903000008', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(50, 'Pintor profesional 08', 'demo.pintura08@servicioshogar.local', 'CUENTA_DEMOSTRACION', '904000008', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(51, 'Carpintero 08', 'demo.carpinteria08@servicioshogar.local', 'CUENTA_DEMOSTRACION', '905000008', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(52, 'Técnico de mantenimiento 08', 'demo.mantenimiento08@servicioshogar.local', 'CUENTA_DEMOSTRACION', '906000008', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(53, 'Electricista 09', 'demo.electricidad09@servicioshogar.local', 'CUENTA_DEMOSTRACION', '901000009', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(54, 'Gasfitero 09', 'demo.gasfiteria09@servicioshogar.local', 'CUENTA_DEMOSTRACION', '902000009', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(55, 'Técnico en electrodomésticos 09', 'demo.electrodomesticos09@servicioshogar.local', 'CUENTA_DEMOSTRACION', '903000009', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(56, 'Pintor profesional 09', 'demo.pintura09@servicioshogar.local', 'CUENTA_DEMOSTRACION', '904000009', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(57, 'Carpintero 09', 'demo.carpinteria09@servicioshogar.local', 'CUENTA_DEMOSTRACION', '905000009', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(58, 'Técnico de mantenimiento 09', 'demo.mantenimiento09@servicioshogar.local', 'CUENTA_DEMOSTRACION', '906000009', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(59, 'Electricista 10', 'demo.electricidad10@servicioshogar.local', 'CUENTA_DEMOSTRACION', '901000010', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(60, 'Gasfitero 10', 'demo.gasfiteria10@servicioshogar.local', 'CUENTA_DEMOSTRACION', '902000010', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(61, 'Técnico en electrodomésticos 10', 'demo.electrodomesticos10@servicioshogar.local', 'CUENTA_DEMOSTRACION', '903000010', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(62, 'Pintor profesional 10', 'demo.pintura10@servicioshogar.local', 'CUENTA_DEMOSTRACION', '904000010', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(63, 'Carpintero 10', 'demo.carpinteria10@servicioshogar.local', 'CUENTA_DEMOSTRACION', '905000010', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30'),
(64, 'Técnico de mantenimiento 10', 'demo.mantenimiento10@servicioshogar.local', 'CUENTA_DEMOSTRACION', '906000010', 'PROVEEDOR', 'ACTIVO', '2026-10-27 11:43:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoraciones`
--

CREATE TABLE `valoraciones` (
  `id` bigint(20) NOT NULL,
  `proveedor_id` bigint(20) NOT NULL,
  `comprador_id` bigint(20) NOT NULL,
  `puntuacion` tinyint(4) NOT NULL,
  `comentario` varchar(500) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `solicitud_id` (`solicitud_id`),
  ADD KEY `remitente_id` (`remitente_id`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `referencia` (`referencia`),
  ADD KEY `solicitud_id` (`solicitud_id`),
  ADD KEY `comprador_id` (`comprador_id`);

--
-- Indices de la tabla `perfiles_proveedor`
--
ALTER TABLE `perfiles_proveedor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `portafolio`
--
ALTER TABLE `portafolio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proveedor_id` (`proveedor_id`);

--
-- Indices de la tabla `resenas`
--
ALTER TABLE `resenas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `solicitud_id` (`solicitud_id`),
  ADD KEY `comprador_id` (`comprador_id`),
  ADD KEY `proveedor_id` (`proveedor_id`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proveedor_id` (`proveedor_id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comprador_id` (`comprador_id`),
  ADD KEY `servicio_id` (`servicio_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_valoracion_proveedor` (`proveedor_id`),
  ADD KEY `fk_valoracion_comprador` (`comprador_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `perfiles_proveedor`
--
ALTER TABLE `perfiles_proveedor`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `portafolio`
--
ALTER TABLE `portafolio`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resenas`
--
ALTER TABLE `resenas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`solicitud_id`) REFERENCES `solicitudes` (`id`),
  ADD CONSTRAINT `mensajes_ibfk_2` FOREIGN KEY (`remitente_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`solicitud_id`) REFERENCES `solicitudes` (`id`),
  ADD CONSTRAINT `pagos_ibfk_2` FOREIGN KEY (`comprador_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `perfiles_proveedor`
--
ALTER TABLE `perfiles_proveedor`
  ADD CONSTRAINT `perfiles_proveedor_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `portafolio`
--
ALTER TABLE `portafolio`
  ADD CONSTRAINT `portafolio_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `perfiles_proveedor` (`id`);

--
-- Filtros para la tabla `resenas`
--
ALTER TABLE `resenas`
  ADD CONSTRAINT `resenas_ibfk_1` FOREIGN KEY (`solicitud_id`) REFERENCES `solicitudes` (`id`),
  ADD CONSTRAINT `resenas_ibfk_2` FOREIGN KEY (`comprador_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `resenas_ibfk_3` FOREIGN KEY (`proveedor_id`) REFERENCES `perfiles_proveedor` (`id`);

--
-- Filtros para la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD CONSTRAINT `servicios_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `perfiles_proveedor` (`id`),
  ADD CONSTRAINT `servicios_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);

--
-- Filtros para la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD CONSTRAINT `solicitudes_ibfk_1` FOREIGN KEY (`comprador_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `solicitudes_ibfk_2` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`);

--
-- Filtros para la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  ADD CONSTRAINT `fk_valoracion_comprador` FOREIGN KEY (`comprador_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `fk_valoracion_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `perfiles_proveedor` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
