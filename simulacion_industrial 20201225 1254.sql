﻿--
-- Script was generated by Devart dbForge Studio 2019 for MySQL, Version 8.2.23.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 25/12/2020 12:54:15 p. m.
-- Server version: 5.5.5-10.4.14-MariaDB
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

DROP DATABASE IF EXISTS simulacion_industrial;

CREATE DATABASE simulacion_industrial
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

--
-- Set default database
--
USE simulacion_industrial;

--
-- Create table `tipodistribucion`
--
CREATE TABLE tipodistribucion (
  idTipoDistribucion int(11) NOT NULL AUTO_INCREMENT,
  descripcion varchar(50) NOT NULL,
  PRIMARY KEY (idTipoDistribucion)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `distribucion`
--
CREATE TABLE distribucion (
  idDistribucion int(11) NOT NULL AUTO_INCREMENT,
  idTipoDistribucion int(11) DEFAULT NULL,
  distribucion varchar(50) NOT NULL,
  PRIMARY KEY (idDistribucion)
)
ENGINE = INNODB,
AUTO_INCREMENT = 9,
AVG_ROW_LENGTH = 2048,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE distribucion
ADD CONSTRAINT FK_distribucion_tipodistribucion_idTipoDistribucion FOREIGN KEY (idTipoDistribucion)
REFERENCES tipodistribucion (idTipoDistribucion) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `evento`
--
CREATE TABLE evento (
  idEvento int(11) NOT NULL AUTO_INCREMENT,
  idFase int(11) NOT NULL,
  idDistribucion int(11) NOT NULL,
  evento varchar(50) NOT NULL,
  descripcion varchar(255) DEFAULT NULL,
  probabilidad float DEFAULT NULL COMMENT 'probabilidad de ocurrencia del evento',
  estado tinyint(1) DEFAULT NULL,
  PRIMARY KEY (idEvento)
)
ENGINE = INNODB,
AUTO_INCREMENT = 21,
AVG_ROW_LENGTH = 1489,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE evento
ADD CONSTRAINT FK_evento_distribucion_idDistribucion FOREIGN KEY (idDistribucion)
REFERENCES distribucion (idDistribucion) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `accioncorrectiva`
--
CREATE TABLE accioncorrectiva (
  idAccionCorrectiva int(11) NOT NULL AUTO_INCREMENT,
  idEvento int(11) NOT NULL,
  Descripcion varchar(50) NOT NULL,
  incremento_t_srevicio float NOT NULL,
  PRIMARY KEY (idAccionCorrectiva)
)
ENGINE = INNODB,
AUTO_INCREMENT = 12,
AVG_ROW_LENGTH = 1489,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE accioncorrectiva
ADD CONSTRAINT FK_accion_correctiva_evento_idEvento FOREIGN KEY (idEvento)
REFERENCES evento (idEvento) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `producto`
--
CREATE TABLE producto (
  idProducto int(11) NOT NULL AUTO_INCREMENT COMMENT 'probabilidad de que se use ese producto',
  producto varchar(50) NOT NULL,
  probabilidad float NOT NULL COMMENT 'Probabilidad de que se use ese producto',
  creado_en timestamp NULL DEFAULT CURRENT_TIMESTAMP(),
  estado bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (idProducto)
)
ENGINE = INNODB,
AUTO_INCREMENT = 10,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create view `producto_v`
--
CREATE
DEFINER = 'root'@'localhost'
VIEW producto_v
AS
SELECT
  `p`.`idProducto` AS `idProducto`,
  `p`.`producto` AS `producto`,
  `p`.`probabilidad` AS `probabilidad`,
  `p`.`creado_en` AS `creado_en`,
  CASE WHEN `p`.`estado` = 1 THEN 'activo' ELSE 'inactivo' END AS `estado`
FROM `producto` `p`;

--
-- Create table `orden`
--
CREATE TABLE orden (
  idOrden int(11) NOT NULL AUTO_INCREMENT,
  idProducto int(11) NOT NULL,
  fechaEntrada datetime NOT NULL,
  fechaSalida datetime NOT NULL,
  fechaPautada datetime NOT NULL,
  PRIMARY KEY (idOrden)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE orden
ADD CONSTRAINT FK_orden_producto_idProducto FOREIGN KEY (idProducto)
REFERENCES producto (idProducto) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `tanda`
--
CREATE TABLE tanda (
  idTanda int(11) NOT NULL AUTO_INCREMENT,
  tanda varchar(50) NOT NULL,
  probabilidad float NOT NULL COMMENT 'porcentaje del tiempo de la tanda',
  tiempoEntreLlegadas float NOT NULL,
  PRIMARY KEY (idTanda)
)
ENGINE = INNODB,
AUTO_INCREMENT = 5,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `producto_tanda`
--
CREATE TABLE producto_tanda (
  idProducto int(11) NOT NULL,
  idTanda int(11) NOT NULL,
  probabilidad float NOT NULL COMMENT 'Probabilidad de elegir un producto en espesifico',
  PRIMARY KEY (idProducto, idTanda)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 819,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE producto_tanda
ADD CONSTRAINT FK_product_tanda_producto_idProducto FOREIGN KEY (idProducto)
REFERENCES producto (idProducto) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE producto_tanda
ADD CONSTRAINT FK_product_tanda_tanda_idTanda FOREIGN KEY (idTanda)
REFERENCES tanda (idTanda) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create view `tiemposervicio_v`
--
CREATE
DEFINER = 'root'@'localhost'
VIEW tiemposervicio_v
AS
SELECT
  `p`.`idProducto` AS `idProducto`,
  `p`.`producto` AS `producto`,
  `t`.`idTanda` AS `idTanda`,
  `t`.`tanda` AS `tanda`,
  `pt`.`probabilidad` AS `probabilidad`,
  `t`.`tiempoEntreLlegadas` AS `llegadas`
FROM ((`producto` `p`
  JOIN `producto_tanda` `pt`
    ON (`pt`.`idProducto` = `p`.`idProducto`))
  JOIN `tanda` `t`
    ON (`pt`.`idTanda` = `t`.`idTanda`));

--
-- Create table `fase`
--
CREATE TABLE fase (
  idFase int(11) NOT NULL AUTO_INCREMENT,
  fase varchar(50) NOT NULL,
  descripcion varchar(255) DEFAULT NULL,
  PRIMARY KEY (idFase)
)
ENGINE = INNODB,
AUTO_INCREMENT = 6,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create view `evento_v`
--
CREATE
DEFINER = 'root'@'localhost'
VIEW evento_v
AS
SELECT
  `e`.`idEvento` AS `idEvento`,
  `e`.`evento` AS `evento`,
  `e`.`idFase` AS `idFase`,
  `f`.`fase` AS `fase`,
  `d`.`distribucion` AS `distribucion`,
  `t`.`descripcion` AS `tipo`,
  `a`.`Descripcion` AS `accionCorrectiva`,
  `a`.`incremento_t_srevicio` AS `t_servicio`,
  `e`.`probabilidad` AS `probabilidad`,
  CASE WHEN `e`.`estado` = 1 THEN 'activo' ELSE 'inactivo' END AS `estado`
FROM ((((`evento` `e`
  JOIN `fase` `f`
    ON (`f`.`idFase` = `e`.`idFase`))
  JOIN `distribucion` `d`
    ON (`d`.`idDistribucion` = `e`.`idDistribucion`))
  JOIN `tipodistribucion` `t`
    ON (`t`.`idTipoDistribucion` = `d`.`idTipoDistribucion`))
  JOIN `accioncorrectiva` `a`
    ON (`e`.`idEvento` = `a`.`idEvento`));

--
-- Create table `fase_tanda`
--
CREATE TABLE fase_tanda (
  idFase int(11) NOT NULL,
  idTanda int(11) NOT NULL COMMENT 'Tiempo de servicio de la fase M',
  probabilidad float DEFAULT NULL,
  tiempoServicio float NOT NULL,
  PRIMARY KEY (idFase, idTanda)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 819,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE fase_tanda
ADD CONSTRAINT FK_fase_tanda_fase_idFase FOREIGN KEY (idFase)
REFERENCES fase (idFase) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE fase_tanda
ADD CONSTRAINT FK_fase_tanda_tanda_idTanda FOREIGN KEY (idTanda)
REFERENCES tanda (idTanda) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create view `tandatiemposervicio_v`
--
CREATE
DEFINER = 'root'@'localhost'
VIEW tandatiemposervicio_v
AS
SELECT
  `f`.`idFase` AS `idFase`,
  `f`.`fase` AS `fase`,
  `t`.`idTanda` AS `idTanda`,
  `t`.`tanda` AS `tanda`,
  `ft`.`probabilidad` AS `probabilidad`,
  `ft`.`tiempoServicio` AS `llegada`
FROM ((`fase` `f`
  JOIN `fase_tanda` `ft`
    ON (`ft`.`idFase` = `f`.`idFase`))
  JOIN `tanda` `t`
    ON (`t`.`idTanda` = `ft`.`idTanda`));

--
-- Create table `fase_evento`
--
CREATE TABLE fase_evento (
  idFase int(11) NOT NULL,
  idEvento int(11) NOT NULL,
  PRIMARY KEY (idFase, idEvento)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE fase_evento
ADD CONSTRAINT FK_fase_evento_evento_idEvento FOREIGN KEY (idEvento)
REFERENCES evento (idEvento) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE fase_evento
ADD CONSTRAINT FK_fase_evento_fase_idFase FOREIGN KEY (idFase)
REFERENCES fase (idFase) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `demanda`
--
CREATE TABLE demanda (
  idDemanda int(11) NOT NULL AUTO_INCREMENT,
  demanda varchar(50) NOT NULL,
  probabilidad float NOT NULL,
  tiempo_entre_llegadas float NOT NULL,
  tiempo_servicio float NOT NULL,
  PRIMARY KEY (idDemanda)
)
ENGINE = INNODB,
AUTO_INCREMENT = 5,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `tiemposervicio`
--
CREATE TABLE tiemposervicio (
  idTiempoServicio varchar(255) NOT NULL,
  idDemanda int(11) NOT NULL,
  idTanda int(11) NOT NULL,
  idProducto int(11) NOT NULL,
  PRIMARY KEY (idTiempoServicio)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE tiemposervicio
ADD CONSTRAINT FK_tiemposervicio_demanda_idDemanda FOREIGN KEY (idDemanda)
REFERENCES demanda (idDemanda) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE tiemposervicio
ADD CONSTRAINT FK_tiemposervicio_producto_idProducto FOREIGN KEY (idProducto)
REFERENCES producto (idProducto) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE tiemposervicio
ADD CONSTRAINT FK_tiemposervicio_tanda_idTanda FOREIGN KEY (idTanda)
REFERENCES tanda (idTanda) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `tiempo_entre_llegadas`
--
CREATE TABLE tiempo_entre_llegadas (
  idDemanda int(11) NOT NULL,
  idTanda int(11) NOT NULL,
  t_entre_llegada float NOT NULL COMMENT 'Tiempo entre llegadas de las ordenes de produccion'
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create foreign key
--
ALTER TABLE tiempo_entre_llegadas
ADD CONSTRAINT FK_tiempo_entre_llegadas_demanda_idDemanda FOREIGN KEY (idDemanda)
REFERENCES demanda (idDemanda) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE tiempo_entre_llegadas
ADD CONSTRAINT FK_tiempo_entre_llegadas_tanda_idTanda FOREIGN KEY (idTanda)
REFERENCES tanda (idTanda) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `usuario`
--
CREATE TABLE usuario (
  idUsuario int(11) NOT NULL AUTO_INCREMENT,
  usuario varchar(50) NOT NULL,
  foto_url varchar(255) NOT NULL,
  nombre varchar(50) NOT NULL,
  correo varchar(50) NOT NULL,
  departamento varchar(50) NOT NULL,
  puestoTrabajo varchar(50) NOT NULL,
  clave varchar(50) NOT NULL,
  ultimoAcceso datetime NOT NULL,
  estado int(11) NOT NULL,
  PRIMARY KEY (idUsuario)
)
ENGINE = INNODB,
AUTO_INCREMENT = 2,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `simulado`
--
CREATE TABLE simulado (
  idSimulado int(11) NOT NULL AUTO_INCREMENT,
  idOrden int(11) NOT NULL,
  idDemanda int(11) NOT NULL,
  idTanda int(11) NOT NULL,
  idProducto int(11) NOT NULL,
  cancelada int(11) NOT NULL,
  cumplida int(11) NOT NULL,
  fechaEntrada datetime NOT NULL,
  fechaSalida datetime NOT NULL,
  fechaPautada datetime NOT NULL,
  PRIMARY KEY (idSimulado)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `reales`
--
CREATE TABLE reales (
  anio varchar(50) NOT NULL,
  mes varchar(50) NOT NULL,
  ordenes int(11) NOT NULL,
  accidentes int(11) NOT NULL,
  cumplimiento int(11) NOT NULL,
  retraso float NOT NULL
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 273,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

-- 
-- Dumping data for table tipodistribucion
--
INSERT INTO tipodistribucion VALUES
(1, 'Distribuciones discretas'),
(2, ' Distribuciones continuas');

-- 
-- Dumping data for table distribucion
--
INSERT INTO distribucion VALUES
(1, 1, 'Distribución binomial'),
(2, 1, 'Distribución Pascal'),
(3, 1, 'Distribución uniforme discreta'),
(4, 2, 'Distribución normal '),
(5, 2, 'Distribución lognormal '),
(6, 2, ' Distribución logística'),
(7, 2, 'Distribución beta'),
(8, 2, 'Distribución exponencial');

-- 
-- Dumping data for table demanda
--
INSERT INTO demanda VALUES
(1, 'MINIMA', 0, 0, 0),
(2, 'PROMEDIO', 0, 0, 0),
(3, 'ALTA', 0, 0, 0),
(4, 'TIEMPO DE CAMPANA', 0, 0, 0);

-- 
-- Dumping data for table producto
--
INSERT INTO producto VALUES
(1, 'Gramaquin', 23.5, '2020-12-12 00:00:00', True),
(2, 'Block de dintel', 32.8, '2020-12-12 13:59:00', True),
(3, 'Block de viga', 15.9, '2020-12-12 00:00:00', True),
(4, 'Bordillo T1', 10, '2020-12-12 00:00:00', True),
(5, 'Paragomas', 17.8, '2020-12-12 00:00:00', True);

-- 
-- Dumping data for table tanda
--
INSERT INTO tanda VALUES
(1, 'MINIMA', 44.15, 5.5),
(2, 'PROMEDIO', 21.14, 3.8),
(3, 'ALTA', 26.96, 2.5),
(4, 'SUPERIOR', 7.75, 1.3);

-- 
-- Dumping data for table fase
--
INSERT INTO fase VALUES
(1, 'Seleccion', NULL),
(2, 'Mesclado', NULL),
(3, 'Moldeado', NULL),
(4, 'Traslado', NULL),
(5, 'Secado', NULL);

-- 
-- Dumping data for table evento
--
INSERT INTO evento VALUES
(1, 1, 1, 'Error en la mesclado', 'Error en la mesclado', 0.5, 1),
(2, 1, 1, 'Problemas de maquinaria', 'Problemas de maquinaria', 1.9, 1),
(3, 1, 1, 'Mescla no cumple con el BOM', 'Mescla no cumple con el BOM', 0.1, 1),
(4, 2, 2, 'Carga inadecuada de block', 'Carga inadecuada de block', 0.4, 1),
(5, 2, 2, 'Fallo electrico', 'Fallo electrico', 0.13, 1),
(6, 3, 2, 'Escaneo incorrecto del codigo', 'Escaneo incorrecto del codigo', 1, 1),
(7, 3, 3, 'Estandar de produccion erroneo', 'Estandar de produccion erroneo', 2.1, 1),
(8, 4, 3, 'Prensa defectuosa', 'Prensa defectuosa', 0.02, 1),
(9, 4, 2, 'Tormenta electrica', 'Tormenta electrica', 0.03, 1),
(10, 5, 3, 'Error de digitacion del estandar', 'Error de digitacion del estandar', 0.4, 1),
(11, 5, 1, 'Accidente laboral', 'Accidente laboral', 0.09, 1);

-- 
-- Dumping data for table usuario
--
INSERT INTO usuario VALUES
(1, 'freilinjb', 'views/assets/img/empleados/064-5687687-6/711.jpg', 'Freilin Jose', 'freilinjb@gmail.com', 'Tecnologia', 'Analista', '1423', '0000-00-00 00:00:00', 1);

-- 
-- Dumping data for table tiempo_entre_llegadas
--
-- Table simulacion_industrial.tiempo_entre_llegadas does not contain any data (it is empty)

-- 
-- Dumping data for table tiemposervicio
--
-- Table simulacion_industrial.tiemposervicio does not contain any data (it is empty)

-- 
-- Dumping data for table simulado
--
-- Table simulacion_industrial.simulado does not contain any data (it is empty)

-- 
-- Dumping data for table reales
--
INSERT INTO reales VALUES
('2019', 'Enero', 13, 1, 7, 67),
('2019', 'Febrero', 35, 1, 24, 93),
('2019', 'Marzo', 1, 2, 22, 68),
('2019', 'Abril', 34, 7, 24, 95),
('2019', 'Mayo', 6, 7, 6, 64),
('2019', 'Junio', 10, 2, 24, 72),
('2019', 'Julio', 36, 0, 8, 78),
('2019', 'Agosto', 44, 7, 10, 74),
('2019', 'Septiembre', 37, 6, 16, 80),
('2019', 'Octubre', 6, 4, 26, 69),
('2019', 'Noviembre', 27, 0, 13, 94),
('2019', 'Diciembre', 16, 6, 11, 91),
('2020', 'Enero', 2, 8, 7, 60),
('2020', 'Febrero', 34, 4, 17, 80),
('2020', 'Marzo', 28, 1, 12, 75),
('2020', 'Abril', 8, 6, 19, 99),
('2020', 'Mayo', 43, 6, 2, 85),
('2020', 'Junio', 4, 7, 8, 85),
('2020', 'Julio', 25, 6, 24, 72),
('2020', 'Agosto', 20, 4, 30, 91),
('2020', 'Septiembre', 24, 4, 25, 92),
('2020', 'Octubre', 13, 1, 3, 73),
('2020', 'Noviembre', 43, 1, 13, 99),
('2020', 'Diciembre', 12, 1, 15, 63),
('2020', 'Enero', 17, 8, 17, 72),
('2020', 'Febrero', 38, 6, 13, 62),
('2020', 'Marzo', 15, 6, 16, 70),
('2020', 'Abril', 1, 4, 7, 60),
('2020', 'Mayo', 22, 3, 6, 65),
('2020', 'Junio', 32, 1, 1, 83),
('2020', 'Julio', 44, 0, 22, 64),
('2020', 'Agosto', 31, 1, 24, 87),
('2020', 'Septiembre', 44, 3, 20, 80),
('2020', 'Octubre', 9, 7, 4, 93),
('2020', 'Noviembre', 12, 6, 9, 62),
('2020', 'Diciembre', 40, 8, 11, 97),
('2020', 'Enero', 21, 8, 23, 75),
('2020', 'Febrero', 16, 3, 16, 79),
('2020', 'Marzo', 35, 1, 12, 88),
('2020', 'Abril', 7, 2, 28, 71),
('2020', 'Mayo', 22, 8, 11, 91),
('2020', 'Junio', 2, 6, 24, 78),
('2020', 'Julio', 41, 7, 10, 77),
('2020', 'Agosto', 35, 4, 25, 72),
('2020', 'Septiembre', 33, 2, 8, 100),
('2020', 'Octubre', 5, 2, 1, 72),
('2020', 'Noviembre', 32, 7, 29, 65),
('2020', 'Diciembre', 15, 1, 14, 75),
('2020', 'Enero', 36, 6, 13, 84),
('2020', 'Febrero', 18, 8, 2, 69),
('2020', 'Marzo', 32, 7, 15, 63),
('2020', 'Abril', 7, 4, 24, 67),
('2020', 'Mayo', 32, 5, 29, 76),
('2020', 'Junio', 15, 5, 25, 90),
('2020', 'Julio', 6, 3, 30, 63),
('2020', 'Agosto', 18, 5, 23, 97),
('2020', 'Septiembre', 25, 3, 18, 60),
('2020', 'Octubre', 25, 5, 11, 70),
('2020', 'Noviembre', 42, 2, 24, 72),
('2020', 'Diciembre', 17, 1, 20, 95);

-- 
-- Dumping data for table producto_tanda
--
INSERT INTO producto_tanda VALUES
(1, 1, 25.9),
(1, 2, 15),
(1, 3, 25.9),
(1, 4, 11.95),
(2, 1, 23.4),
(2, 2, 34.9),
(2, 3, 23.4),
(2, 4, 43.4),
(3, 1, 12),
(3, 2, 16.9),
(3, 3, 12),
(3, 4, 19.5),
(4, 1, 22.7),
(4, 2, 13.1),
(4, 3, 22.7),
(4, 4, 13.15),
(5, 1, 16),
(5, 2, 20.1),
(5, 3, 16),
(5, 4, 12);

-- 
-- Dumping data for table orden
--
-- Table simulacion_industrial.orden does not contain any data (it is empty)

-- 
-- Dumping data for table fase_tanda
--
INSERT INTO fase_tanda VALUES
(1, 1, 23.4, 51),
(1, 2, 23.4, 56),
(1, 3, 5, 53),
(1, 4, 1, 55),
(2, 1, 22, 54),
(2, 2, 22, 58),
(2, 3, 10.6, 50),
(2, 4, 38.6, 50),
(3, 1, 15, 46),
(3, 2, 15, 50),
(3, 3, 13, 50),
(3, 4, 15, 46),
(4, 1, 38.6, 45),
(4, 2, 38.6, 52),
(4, 3, 43, 46),
(4, 4, 22, 57),
(5, 1, 1, 48),
(5, 2, 1, 48),
(5, 3, 28.4, 52),
(5, 4, 23.4, 49);

-- 
-- Dumping data for table fase_evento
--
-- Table simulacion_industrial.fase_evento does not contain any data (it is empty)

-- 
-- Dumping data for table accioncorrectiva
--
INSERT INTO accioncorrectiva VALUES
(1, 1, 'Ajustar la mescla hasta su punto optimo', 5),
(2, 2, 'Realizar inspeccion y mantenimeito', 30),
(3, 3, 'Realizar ajuste de mescla de cumplimiento', 10.5),
(4, 4, 'Inspeccionar maniobra de traslado', 1),
(5, 5, 'Realizar mantenimiento e inspecciones', 5),
(6, 6, 'Ajustar los codigos de los lotes', 0.2),
(7, 7, 'Realizar ajuste de operaciones de produccion', 0.1),
(8, 8, 'Realizar cambio de prensa', 3),
(9, 9, 'Esperar a que la tormente disminuya', 12),
(10, 10, 'Realizar ajuste en el sistema', 0.1),
(11, 11, 'Realizar seguimiento y relevo de personal', 12);

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;