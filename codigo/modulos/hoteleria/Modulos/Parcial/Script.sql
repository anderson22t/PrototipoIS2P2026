/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- =============================================================
--  MÓDULO MRP
--  Catálogos, inventario, producción e integración logística
-- =============================================================

-- =============================================================
--  Bd_Mrp  |  Script final  v3
--  Inventario unificado + integración API con logística
--  v4: Tbl_Colaborador eliminada (usa tbl_empleado de seguridad)
--       Tbl_Producto + Tbl_Materiales unificadas en Tbl_Materiales
--       Tbl_Tipo_Producto renombrada a Tbl_Tipo_Material
-- =============================================================

CREATE DATABASE IF NOT EXISTS Bd_Mrp;
USE Bd_Mrp;

-- =============================================================
--  MÓDULO HOTELERÍA (Seguridad)
--  Empleados, usuarios, perfiles y permisos
-- =============================================================

DROP TABLE IF EXISTS `tbl_aplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_aplicacion` (
  `Pk_Id_Aplicacion` int NOT NULL,
  `Fk_Id_Reporte_Aplicacion` int DEFAULT NULL,
  `Cmp_Nombre_Aplicacion` varchar(50) DEFAULT NULL,
  `Cmp_Descripcion_Aplicacion` varchar(50) DEFAULT NULL,
  `Cmp_Estado_Aplicacion` bit(1) NOT NULL,
  PRIMARY KEY (`Pk_Id_Aplicacion`),
  KEY `Fk_Aplicacion_Reporte` (`Fk_Id_Reporte_Aplicacion`),
  CONSTRAINT `Fk_Aplicacion_Reporte` FOREIGN KEY (`Fk_Id_Reporte_Aplicacion`) REFERENCES `tbl_reportes` (`Pk_Id_Reporte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_aplicacion`
--

LOCK TABLES `tbl_aplicacion` WRITE;
/*!40000 ALTER TABLE `tbl_aplicacion` DISABLE KEYS */;
INSERT INTO `tbl_aplicacion` VALUES (1,1,'Gestion de empleado','Se gestionan los empleados del hotel',_binary ''),(301,5,'Empleados','Control de empleados de la hoteleria',_binary ''),(302,NULL,'Usuarios','Control de usuarios de empleados',_binary ''),(303,3,'Perfiles','Perfiles que se asignan a usuarios',_binary ''),(304,NULL,'Modulos','Mantenimiento de modulos',_binary ''),(305,NULL,'Aplicacion','Mantenimiento de aplicaciones',_binary ''),(306,NULL,'Asig Aplicacion Usuario','Asigna permisos a usuarios',_binary ''),(307,NULL,'Asig aplicacion Perfil','Asigna permisos a perfiles',_binary ''),(308,NULL,'Asig Perfiles','Asigna los perfiles a usuarios',_binary ''),(309,NULL,'Bitacora','Da acceso a bitacora',_binary '');
/*!40000 ALTER TABLE `tbl_aplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_asignacion_modulo_aplicacion`
--

DROP TABLE IF EXISTS `tbl_asignacion_modulo_aplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_asignacion_modulo_aplicacion` (
  `Fk_Id_Modulo` int NOT NULL,
  `Fk_Id_Aplicacion` int NOT NULL,
  PRIMARY KEY (`Fk_Id_Modulo`,`Fk_Id_Aplicacion`),
  KEY `Fk_AsigAplicacion` (`Fk_Id_Aplicacion`),
  CONSTRAINT `Fk_AsigAplicacion` FOREIGN KEY (`Fk_Id_Aplicacion`) REFERENCES `tbl_aplicacion` (`Pk_Id_Aplicacion`),
  CONSTRAINT `Fk_AsigModulo` FOREIGN KEY (`Fk_Id_Modulo`) REFERENCES `tbl_modulo` (`Pk_Id_Modulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_asignacion_modulo_aplicacion`
--

LOCK TABLES `tbl_asignacion_modulo_aplicacion` WRITE;
/*!40000 ALTER TABLE `tbl_asignacion_modulo_aplicacion` DISABLE KEYS */;
INSERT INTO `tbl_asignacion_modulo_aplicacion` VALUES (4,301),(4,302),(4,303),(4,304),(4,305),(4,306),(4,307),(4,308),(4,309);
/*!40000 ALTER TABLE `tbl_asignacion_modulo_aplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_bitacora`
--

DROP TABLE IF EXISTS `tbl_bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_bitacora` (
  `Pk_Id_Bitacora` int NOT NULL AUTO_INCREMENT,
  `Fk_Id_Usuario` int DEFAULT NULL,
  `Fk_Id_Aplicacion` int DEFAULT NULL,
  `Cmp_Fecha` datetime DEFAULT NULL,
  `Cmp_Accion` varchar(255) DEFAULT NULL,
  `Cmp_Ip` varchar(50) DEFAULT NULL,
  `Cmp_Nombre_Pc` varchar(50) DEFAULT NULL,
  `Cmp_Login_Estado` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Pk_Id_Bitacora`),
  KEY `Fk_Bitacora_Usuario` (`Fk_Id_Usuario`),
  KEY `Fk_Bitacora_Aplicacion` (`Fk_Id_Aplicacion`),
  CONSTRAINT `Fk_Bitacora_Aplicacion` FOREIGN KEY (`Fk_Id_Aplicacion`) REFERENCES `tbl_aplicacion` (`Pk_Id_Aplicacion`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Fk_Bitacora_Usuario` FOREIGN KEY (`Fk_Id_Usuario`) REFERENCES `tbl_usuario` (`Pk_Id_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4583 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_bitacora`
--

LOCK TABLES `tbl_bitacora` WRITE;
/*!40000 ALTER TABLE `tbl_bitacora` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_bloqueo_usuario`
--

DROP TABLE IF EXISTS `tbl_bloqueo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_bloqueo_usuario` (
  `Pk_Id_Bloqueo` int NOT NULL AUTO_INCREMENT,
  `Fk_Id_Usuario` int DEFAULT NULL,
  `Fk_Id_Bitacora` int DEFAULT NULL,
  `Cmp_Fecha_Inicio_Bloqueo_Usuario` datetime DEFAULT NULL,
  `Cmp_Fecha_Fin_Bloqueo_Usuario` datetime DEFAULT NULL,
  `Cmp_Motivo__Bloqueo_Usuario` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Pk_Id_Bloqueo`),
  KEY `Fk_Bloqueo_Usuario` (`Fk_Id_Usuario`),
  KEY `Fk_Bloqueo_Bitacora` (`Fk_Id_Bitacora`),
  CONSTRAINT `Fk_Bloqueo_Bitacora` FOREIGN KEY (`Fk_Id_Bitacora`) REFERENCES `tbl_bitacora` (`Pk_Id_Bitacora`),
  CONSTRAINT `Fk_Bloqueo_Usuario` FOREIGN KEY (`Fk_Id_Usuario`) REFERENCES `tbl_usuario` (`Pk_Id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_bloqueo_usuario`
--

LOCK TABLES `tbl_bloqueo_usuario` WRITE;
/*!40000 ALTER TABLE `tbl_bloqueo_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_bloqueo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_empleado`
--

DROP TABLE IF EXISTS `tbl_empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_empleado` (
  `Pk_Id_Empleado` int NOT NULL AUTO_INCREMENT,
  `Cmp_Nombres_Empleado` varchar(50) DEFAULT NULL,
  `Cmp_Apellidos_Empleado` varchar(50) DEFAULT NULL,
  `Cmp_Dpi_Empleado` bigint DEFAULT NULL,
  `Cmp_Nit_Empleado` bigint DEFAULT NULL,
  `Cmp_Correo_Empleado` varchar(50) DEFAULT NULL,
  `Cmp_Telefono_Empleado` varchar(15) DEFAULT NULL,
  `Cmp_Genero_Empleado` varchar(10) DEFAULT NULL,
  `Cmp_Fecha_Nacimiento_Empleado` date DEFAULT NULL,
  `Cmp_Fecha_Contratacion__Empleado` date DEFAULT NULL,
  PRIMARY KEY (`Pk_Id_Empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=10008 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_empleado`
--

LOCK TABLES `tbl_empleado` WRITE;
/*!40000 ALTER TABLE `tbl_empleado` DISABLE KEYS */;
INSERT INTO `tbl_empleado` VALUES (2,'Juan','Pérez López',1234567890101,9876542,'juan.perez@example.com','5555-1234','Masculino','1995-08-20','2025-09-21'),(3,'Juan','pruebas',1234,123,'@pruebas','1234','Masculino','2025-09-26','2025-09-26');
/*!40000 ALTER TABLE `tbl_empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_modulo`
--

DROP TABLE IF EXISTS `tbl_modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_modulo` (
  `Pk_Id_Modulo` int NOT NULL,
  `Cmp_Nombre_Modulo` varchar(50) DEFAULT NULL,
  `Cmp_Descripcion_Modulo` varchar(50) DEFAULT NULL,
  `Cmp_Estado_Modulo` bit(1) NOT NULL,
  PRIMARY KEY (`Pk_Id_Modulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_modulo`
--

LOCK TABLES `tbl_modulo` WRITE;
/*!40000 ALTER TABLE `tbl_modulo` DISABLE KEYS */;
INSERT INTO `tbl_modulo` VALUES (2,'Navegador','Módulo de navegador',_binary ''),(4,'Seguridad','Modulo de seguridad de la hoteleria',_binary '');
/*!40000 ALTER TABLE `tbl_modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_perfil`
--

DROP TABLE IF EXISTS `tbl_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_perfil` (
  `Pk_Id_Perfil` int NOT NULL AUTO_INCREMENT,
  `Cmp_Puesto_Perfil` varchar(50) DEFAULT NULL,
  `Cmp_Descripcion_Perfil` varchar(50) DEFAULT NULL,
  `Cmp_Estado_Perfil` bit(1) NOT NULL,
  `Cmp_Tipo_Perfil` int DEFAULT NULL,
  PRIMARY KEY (`Pk_Id_Perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_perfil`
--

LOCK TABLES `tbl_perfil` WRITE;
/*!40000 ALTER TABLE `tbl_perfil` DISABLE KEYS */;
INSERT INTO `tbl_perfil` VALUES (1,'Administrador','Perfil con todos los permisos',_binary '',1);
/*!40000 ALTER TABLE `tbl_perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_permiso_perfil_aplicacion`
--

DROP TABLE IF EXISTS `tbl_permiso_perfil_aplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_permiso_perfil_aplicacion` (
  `Fk_Id_Perfil` int NOT NULL,
  `Fk_Id_Modulo` int NOT NULL,
  `Fk_Id_Aplicacion` int NOT NULL,
  `Cmp_Ingresar_Permisos_Aplicacion_Perfil` bit(1) DEFAULT NULL,
  `Cmp_Consultar_Permisos_Aplicacion_Perfil` bit(1) DEFAULT NULL,
  `Cmp_Modificar_Permisos_Aplicacion_Perfil` bit(1) DEFAULT NULL,
  `Cmp_Eliminar_Permisos_Aplicacion_Perfil` bit(1) DEFAULT NULL,
  `Cmp_Imprimir_Permisos_Aplicacion_Perfil` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Fk_Id_Perfil`,`Fk_Id_Modulo`,`Fk_Id_Aplicacion`),
  KEY `Fk_PermisoPerfil_ModuloAplicacion` (`Fk_Id_Modulo`,`Fk_Id_Aplicacion`),
  CONSTRAINT `Fk_PermisoPerfil` FOREIGN KEY (`Fk_Id_Perfil`) REFERENCES `tbl_perfil` (`Pk_Id_Perfil`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_PermisoPerfil_ModuloAplicacion` FOREIGN KEY (`Fk_Id_Modulo`, `Fk_Id_Aplicacion`) REFERENCES `tbl_asignacion_modulo_aplicacion` (`Fk_Id_Modulo`, `Fk_Id_Aplicacion`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_permiso_perfil_aplicacion`
--

LOCK TABLES `tbl_permiso_perfil_aplicacion` WRITE;
/*!40000 ALTER TABLE `tbl_permiso_perfil_aplicacion` DISABLE KEYS */;
INSERT INTO `tbl_permiso_perfil_aplicacion` VALUES (1,4,301,_binary '',_binary '',_binary '',_binary '',_binary ''),(1,4,305,_binary '',_binary '',_binary '',_binary '',_binary ''),(1,4,306,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0'),(1,4,309,_binary '',_binary '',_binary '',_binary '',_binary '');
/*!40000 ALTER TABLE `tbl_permiso_perfil_aplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_permiso_usuario_aplicacion`
--

DROP TABLE IF EXISTS `tbl_permiso_usuario_aplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_permiso_usuario_aplicacion` (
  `Fk_Id_Usuario` int NOT NULL,
  `Fk_Id_Modulo` int NOT NULL,
  `Fk_Id_Aplicacion` int NOT NULL,
  `Cmp_Ingresar_Permiso_Aplicacion_Usuario` bit(1) DEFAULT NULL,
  `Cmp_Consultar_Permiso_Aplicacion_Usuario` bit(1) DEFAULT NULL,
  `Cmp_Modificar_Permiso_Aplicacion_Usuario` bit(1) DEFAULT NULL,
  `Cmp_Eliminar_Permiso_Aplicacion_Usuario` bit(1) DEFAULT NULL,
  `Cmp_Imprimir_Permiso_Aplicacion_Usuario` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Fk_Id_Usuario`,`Fk_Id_Modulo`,`Fk_Id_Aplicacion`),
  KEY `Fk_Permiso_Modulo_Aplicacion` (`Fk_Id_Modulo`,`Fk_Id_Aplicacion`),
  CONSTRAINT `Fk_Permiso_Modulo_Aplicacion` FOREIGN KEY (`Fk_Id_Modulo`, `Fk_Id_Aplicacion`) REFERENCES `tbl_asignacion_modulo_aplicacion` (`Fk_Id_Modulo`, `Fk_Id_Aplicacion`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_Permiso_Usuario` FOREIGN KEY (`Fk_Id_Usuario`) REFERENCES `tbl_usuario` (`Pk_Id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_permiso_usuario_aplicacion`
--

LOCK TABLES `tbl_permiso_usuario_aplicacion` WRITE;
/*!40000 ALTER TABLE `tbl_permiso_usuario_aplicacion` DISABLE KEYS */;
INSERT INTO `tbl_permiso_usuario_aplicacion` VALUES (4,4,301,_binary '',_binary '',_binary '',_binary '',_binary ''),(4,4,302,_binary '',_binary '',_binary '',_binary '',_binary ''),(4,4,303,_binary '',_binary '',_binary '',_binary '',_binary ''),(4,4,304,_binary '',_binary '',_binary '',_binary '',_binary ''),(4,4,305,_binary '',_binary '',_binary '',_binary '',_binary ''),(4,4,306,_binary '',_binary '',_binary '',_binary '',_binary ''),(4,4,307,_binary '',_binary '',_binary '',_binary '',_binary ''),(4,4,308,_binary '',_binary '',_binary '',_binary '',_binary ''),(23,4,301,_binary '',_binary '',_binary '',_binary '',_binary ''),(23,4,302,_binary '',_binary '',_binary '',_binary '',_binary ''),(23,4,303,_binary '',_binary '',_binary '',_binary '',_binary ''),(23,4,304,_binary '',_binary '',_binary '',_binary '',_binary ''),(23,4,305,_binary '',_binary '',_binary '',_binary '',_binary ''),(23,4,306,_binary '',_binary '',_binary '',_binary '',_binary ''),(23,4,307,_binary '',_binary '',_binary '',_binary '',_binary ''),(23,4,308,_binary '',_binary '',_binary '',_binary '',_binary ''),(23,4,309,_binary '',_binary '',_binary '',_binary '',_binary '');
/*!40000 ALTER TABLE `tbl_permiso_usuario_aplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_reportes`
--

DROP TABLE IF EXISTS `tbl_reportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_reportes` (
  `Pk_Id_Reporte` int NOT NULL AUTO_INCREMENT,
  `Cmp_Titulo_Reporte` varchar(50) DEFAULT NULL,
  `Cmp_Ruta_Reporte` varchar(500) DEFAULT NULL,
  `Cmp_Fecha_Reporte` date DEFAULT NULL,
  PRIMARY KEY (`Pk_Id_Reporte`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_reportes`
--

LOCK TABLES `tbl_reportes` WRITE;
/*!40000 ALTER TABLE `tbl_reportes` DISABLE KEYS */;
INSERT INTO `tbl_reportes` VALUES (1,'Reporte final','C:\\Users\\lopez\\OneDrive\\Escritorio\\navegador\\asis2k25p2\\codigo\\componentes\\reporteador\\Base de Datos y Reporte Generado\\ReporteEmpleadosHSC.rpt','2025-01-01'),(2,'Reporte_Prueba','C:\\Users\\lopez\\OneDrive\\Escritorio\\navegador\\asis2k25p2\\codigo\\componentes\\reporteador\\Base de Datos y Reporte Generado\\ReporteEmpleadosHSC.rpt','2025-01-01'),(3,'Perfiles Reporte','C:\\is2k26pf\\codigo\\componentes\\seguridad\\SeguridadMVC\\SeguridadMVC\\CapaVista\\Reporte_perfiles.rpt','2026-02-03'),(5,'Empleados reporte','C:\\is2k26pf\\codigo\\componentes\\seguridad\\SeguridadMVC\\SeguridadMVC\\CapaVista\\Reporte_empleado.rpt','2026-02-05');
/*!40000 ALTER TABLE `tbl_reportes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_token_restaurarcontrasena`
--

DROP TABLE IF EXISTS `tbl_token_restaurarcontrasena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_token_restaurarcontrasena` (
  `Pk_Id_Token` int NOT NULL AUTO_INCREMENT,
  `Fk_Id_Usuario` int DEFAULT NULL,
  `Cmp_Token` varchar(50) DEFAULT NULL,
  `Cmp_Fecha_Creacion_Restaurar_Contrasenea` datetime DEFAULT NULL,
  `Cmp_Expiracion_Restaurar_Contrasenea` datetime DEFAULT NULL,
  `Cmp_Utilizado_Restaurar_Contrasenea` bit(1) DEFAULT NULL,
  `Cmp_Fecha_Uso_Restaurar_Contrasenea` datetime DEFAULT NULL,
  PRIMARY KEY (`Pk_Id_Token`),
  KEY `Fk_Token_Usuario` (`Fk_Id_Usuario`),
  CONSTRAINT `Fk_Token_Usuario` FOREIGN KEY (`Fk_Id_Usuario`) REFERENCES `tbl_usuario` (`Pk_Id_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_token_restaurarcontrasena`
--

LOCK TABLES `tbl_token_restaurarcontrasena` WRITE;
/*!40000 ALTER TABLE `tbl_token_restaurarcontrasena` DISABLE KEYS */;
INSERT INTO `tbl_token_restaurarcontrasena` VALUES (1,2,'C43C63DA','2025-09-21 18:24:01','2025-09-21 18:29:01',_binary '','2025-09-21 18:24:38'),(2,1,'901DA0A1','2025-09-21 18:31:36','2025-09-21 18:36:36',_binary '','2025-09-21 18:32:15'),(3,1,'990DD530','2025-09-22 10:05:46','2025-09-22 10:10:46',_binary '\0',NULL),(4,1,'39C03B58','2025-09-24 20:53:40','2025-09-24 20:58:40',_binary '','2025-09-24 20:54:05'),(5,1,'21BE635F','2025-09-25 08:36:46','2025-09-25 08:41:46',_binary '','2025-09-25 08:37:06'),(6,7,'28F08413','2025-09-26 19:21:51','2025-09-26 19:26:51',_binary '\0',NULL),(7,24,'314418EF','2025-09-27 10:09:06','2025-09-27 10:14:06',_binary '','2025-09-27 10:09:27'),(8,7,'C30808F1','2025-09-27 12:22:20','2025-09-27 12:27:20',_binary '','2025-09-27 12:22:29'),(9,7,'B1AE042A','2025-09-27 12:22:53','2025-09-27 12:27:53',_binary '','2025-09-27 12:23:00'),(10,7,'183E762C','2025-09-27 12:30:45','2025-09-27 12:35:45',_binary '','2025-09-27 12:31:30'),(11,7,'AB7B8C02','2025-09-27 12:34:27','2025-09-27 12:39:27',_binary '','2025-09-27 12:34:54'),(12,7,'76A7D51E','2025-09-27 17:50:00','2025-09-27 17:55:00',_binary '\0',NULL),(13,7,'F8C4776A','2025-09-27 23:49:38','2025-09-27 23:54:38',_binary '','2025-09-27 23:49:52'),(14,1,'DE59E51C','2025-10-06 22:27:35','2025-10-06 22:32:35',_binary '','2025-10-06 22:27:56'),(15,29,'C577F481','2025-10-08 13:30:21','2025-10-08 13:35:21',_binary '','2025-10-08 13:31:09'),(16,12,'F7A08D82','2025-10-12 08:03:14','2025-10-12 08:08:14',_binary '','2025-10-12 08:03:29'),(17,12,'B1B0EC64','2025-10-12 08:05:58','2025-10-12 08:10:58',_binary '','2025-10-12 08:06:12'),(18,7,'A8806F00','2025-10-12 14:48:07','2025-10-12 14:53:07',_binary '\0',NULL),(19,7,'A02EE0D6','2025-10-12 14:57:40','2025-10-12 15:02:40',_binary '','2025-10-12 14:58:16'),(20,47,'C319527A','2025-10-13 17:23:42','2025-10-13 17:28:42',_binary '','2025-10-13 17:24:22'),(21,53,'18AE161D','2025-10-14 18:31:41','2025-10-14 18:36:41',_binary '','2025-10-14 18:32:04'),(22,2,'F1E15FAE','2025-10-18 11:49:09','2025-10-18 11:54:09',_binary '','2025-10-18 11:50:16'),(23,4,'B07EF449','2025-10-18 12:07:34','2025-10-18 12:12:34',_binary '','2025-10-18 12:08:27'),(24,4,'0C76A696','2025-10-18 17:08:53','2025-10-18 17:13:53',_binary '','2025-10-18 17:09:11'),(25,2,'9BAAF4CB','2025-10-21 13:44:20','2025-10-21 13:49:20',_binary '','2025-10-21 13:44:51'),(26,7,'46B0AC97','2025-10-25 14:48:38','2025-10-25 14:53:38',_binary '','2025-10-25 14:48:59');
/*!40000 ALTER TABLE `tbl_token_restaurarcontrasena` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_usuario`
--

DROP TABLE IF EXISTS `tbl_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_usuario` (
  `Pk_Id_Usuario` int NOT NULL AUTO_INCREMENT,
  `Fk_Id_Empleado` int DEFAULT NULL,
  `Cmp_Nombre_Usuario` varchar(50) DEFAULT NULL,
  `Cmp_Contrasena_Usuario` varchar(65) DEFAULT NULL,
  `Cmp_Intentos_Fallidos_Usuario` int DEFAULT NULL,
  `Cmp_Estado_Usuario` bit(1) DEFAULT NULL,
  `Cmp_FechaCreacion_Usuario` datetime DEFAULT NULL,
  `Cmp_Ultimo_Cambio_Contrasenea` datetime DEFAULT NULL,
  `Cmp_Pidio_Cambio_Contrasenea` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Pk_Id_Usuario`),
  KEY `Fk_Usuario_Empleado` (`Fk_Id_Empleado`),
  CONSTRAINT `Fk_Usuario_Empleado` FOREIGN KEY (`Fk_Id_Empleado`) REFERENCES `tbl_empleado` (`Pk_Id_Empleado`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_usuario`
--

LOCK TABLES `tbl_usuario` WRITE;
/*!40000 ALTER TABLE `tbl_usuario` DISABLE KEYS */;
INSERT INTO `tbl_usuario` VALUES (4,2,'brandon','45297c633d331e6ac35169ebaaf75bc7fafd206ebb59ba4efd80566936e46eb0',0,_binary '','2025-09-21 20:49:54','2025-10-18 17:09:11',_binary '\0'),(23,3,'admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',0,_binary '','2025-09-26 20:45:53','2025-09-26 20:45:53',_binary '\0');
/*!40000 ALTER TABLE `tbl_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_usuario_perfil`
--

DROP TABLE IF EXISTS `tbl_usuario_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_usuario_perfil` (
  `Fk_Id_Usuario` int NOT NULL,
  `Fk_Id_Perfil` int NOT NULL,
  PRIMARY KEY (`Fk_Id_Usuario`,`Fk_Id_Perfil`),
  KEY `Fk_UsuarioPerfil_Perfil` (`Fk_Id_Perfil`),
  CONSTRAINT `Fk_UsuarioPerfil_Perfil` FOREIGN KEY (`Fk_Id_Perfil`) REFERENCES `tbl_perfil` (`Pk_Id_Perfil`),
  CONSTRAINT `Fk_UsuarioPerfil_Usuario` FOREIGN KEY (`Fk_Id_Usuario`) REFERENCES `tbl_usuario` (`Pk_Id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_usuario_perfil`
--

LOCK TABLES `tbl_usuario_perfil` WRITE;
/*!40000 ALTER TABLE `tbl_usuario_perfil` DISABLE KEYS */;
INSERT INTO `tbl_usuario_perfil` VALUES (4,1);
/*!40000 ALTER TABLE `tbl_usuario_perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_listado_cierres`
--

DROP TABLE IF EXISTS `vw_listado_cierres`;
/*!50001 DROP VIEW IF EXISTS `vw_listado_cierres`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_listado_cierres` AS SELECT 
 1 AS `id`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_listado_cierres`
--

/*!50001 DROP VIEW IF EXISTS `vw_listado_cierres`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_listado_cierres` AS select 1 AS `id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;


-- =============================================================
--  Restaurar configuración de sesión
-- =============================================================
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


-- =============================================================
--  MÓDULO MRP
--  Catálogos, inventario, producción e integración logística
-- =============================================================

-- =========================
-- CATÁLOGOS BASE
-- =========================

CREATE TABLE Tbl_Tipo_Material (
    Pk_Id_Tipo_Material  INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Tipo_Material VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB; -- Materia Prima, Producto Terminado

CREATE TABLE Tbl_Categoria_Material (
    Pk_Id_Categoria_Material  INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Categoria_Material VARCHAR(100) NOT NULL UNIQUE,
    Fk_Tipo_Material          INT NOT NULL,
    CONSTRAINT fk_categoria_tipo_material
        FOREIGN KEY (Fk_Tipo_Material)
        REFERENCES Tbl_Tipo_Material(Pk_Id_Tipo_Material)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB; -- Maderas, Muebles, Electrónicos, Plásticos...

CREATE TABLE Tbl_Unidad_Medida (
    Pk_Id_Unidad_Medida       INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Unidad_Medida      VARCHAR(100) NOT NULL,
    Abreviatura_Unidad_Medida VARCHAR(20)  NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE Tbl_Almacen (
    Pk_Id_Almacen     INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Almacen    VARCHAR(100) NOT NULL,
    Ubicacion_Almacen VARCHAR(150) NOT NULL,
    Tipo_Almacen      VARCHAR(50)  NOT NULL,
    Estado_Almacen    BOOLEAN      NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE Tbl_Materiales (
    Pk_Id_Materiales          INT AUTO_INCREMENT PRIMARY KEY,
    Codigo_Material           VARCHAR(50)   NOT NULL UNIQUE,
    Nombre_Material           VARCHAR(150)  NOT NULL,
    Descripcion_Material      VARCHAR(255),
    Fk_Id_Categoria           INT NOT NULL,
    Fk_Id_Unidad_Medida       INT NOT NULL,
    Stock_Minimo              DECIMAL(12,4) NOT NULL DEFAULT 0,
    Stock_Seguridad           DECIMAL(12,4) NOT NULL DEFAULT 0,
    Lote_Minimo_Compra        DECIMAL(12,4) NOT NULL DEFAULT 1,
    Lead_Time_Produccion_Dias INT           DEFAULT 0,
    Activo                    BOOLEAN       NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_materiales_categoria
        FOREIGN KEY (Fk_Id_Categoria)
        REFERENCES Tbl_Categoria_Material(Pk_Id_Categoria_Material)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_materiales_unidad_medida
        FOREIGN KEY (Fk_Id_Unidad_Medida)
        REFERENCES Tbl_Unidad_Medida(Pk_Id_Unidad_Medida)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;


-- =========================
-- CATÁLOGOS DE ESTADOS
-- =========================

CREATE TABLE Tbl_Estado_Produccion (
    Pk_Id_Estado_Produccion       INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Estado_Produccion      VARCHAR(100) NOT NULL UNIQUE,
    Descripcion_Estado_Produccion VARCHAR(255)
    -- Valores: 'En Proceso', 'Pausado', 'Terminado', 'Rechazado'
) ENGINE=InnoDB;

CREATE TABLE Tbl_Tipo_Movimiento_Inventario (
    Pk_Id_Tipo_Movimiento_Inventario  INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Tipo_Movimiento_Inventario VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB; -- Entrada, Salida

CREATE TABLE Tbl_Estado_BOM (
    Pk_Id_Estado_BOM       INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Estado_BOM      VARCHAR(100) NOT NULL UNIQUE,
    Descripcion_Estado_BOM VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE Tbl_Estado_Plan_Produccion (
    Pk_Id_Estado_Plan_Produccion       INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Estado_Plan_Produccion      VARCHAR(100) NOT NULL UNIQUE,
    Descripcion_Estado_Plan_Produccion VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE Tbl_Estado_Orden_Produccion (
    Pk_Id_Estado_Orden_Produccion       INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Estado_Orden_Produccion      VARCHAR(100) NOT NULL UNIQUE,
    Descripcion_Estado_Orden_Produccion VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE Tbl_Estado_Orden_Recibida (
    Pk_Id_Estado_Orden_Recibida       INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Estado_Orden_Recibida      VARCHAR(100) NOT NULL UNIQUE,
    Descripcion_Estado_Orden_Recibida VARCHAR(255)
    -- Valores: 'Pendiente', 'En Produccion', 'Entregada', 'Cancelada'
) ENGINE=InnoDB;

CREATE TABLE Tbl_Estado_Recepcion_Material (
    Pk_Id_Estado_Recepcion_Material       INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Estado_Recepcion_Material      VARCHAR(100) NOT NULL UNIQUE,
    Descripcion_Estado_Recepcion_Material VARCHAR(255)
    -- Valores: 'Pendiente', 'Recibido', 'Rechazado'
) ENGINE=InnoDB;

CREATE TABLE Tbl_Estado_Fase_Produccion (
    Pk_Id_Estado_Fase       INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Estado_Fase      VARCHAR(50)  NOT NULL,
    Descripcion_Estado_Fase VARCHAR(255)
) ENGINE=InnoDB;


-- =========================
-- INVENTARIO UNIFICADO
-- =========================

CREATE TABLE Tbl_Tipo_Inventario (
    Pk_Id_Tipo_Inventario  INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Tipo_Inventario VARCHAR(50) NOT NULL UNIQUE
    -- Valores: 'En Almacen', 'En Produccion', 'Producto Final'
) ENGINE=InnoDB;

-- NOTA: La FK a Tbl_Orden_Produccion se agrega con ALTER TABLE al final del script.
CREATE TABLE Tbl_Inventario (
    Pk_Id_Inventario        INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Tipo_Inventario   INT NOT NULL,
    Fk_Id_Material          INT NOT NULL,
    Fk_Id_Almacen           INT NULL,
    Fk_Id_Orden_Produccion  INT NULL,
    Fk_Id_Estado_Produccion INT NULL,
    Cantidad_Disponible     DECIMAL(12,4) NOT NULL DEFAULT 0,
    Costo_Unitario          DECIMAL(12,4) NOT NULL DEFAULT 0,
    Fecha_Actualizacion     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
                            ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uq_inventario UNIQUE (
        Fk_Id_Tipo_Inventario,
        Fk_Id_Material,
        Fk_Id_Almacen,
        Fk_Id_Orden_Produccion
    ),
    CONSTRAINT fk_inventario_tipo
        FOREIGN KEY (Fk_Id_Tipo_Inventario)
        REFERENCES Tbl_Tipo_Inventario(Pk_Id_Tipo_Inventario)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_inventario_material
        FOREIGN KEY (Fk_Id_Material)
        REFERENCES Tbl_Materiales(Pk_Id_Materiales)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_inventario_almacen
        FOREIGN KEY (Fk_Id_Almacen)
        REFERENCES Tbl_Almacen(Pk_Id_Almacen)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_inventario_estado_produccion
        FOREIGN KEY (Fk_Id_Estado_Produccion)
        REFERENCES Tbl_Estado_Produccion(Pk_Id_Estado_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;


-- =========================
-- INTEGRACIÓN CON LOGÍSTICA
-- =========================

-- Punto de entrada para órdenes recibidas vía POST /api/mrp/ordenes.
-- Id_Externo_Logistica: ID del sistema logística; garantiza idempotencia (UNIQUE).
-- Fecha_Requerida:      fecha límite solicitada por logística; se compara contra
--                       Lead_Time_Produccion_Dias para evaluar factibilidad.
-- Fk_Id_Plan_Produccion: se asigna al procesar la orden y generar el plan interno.
-- FK a Tbl_Plan_Produccion se agrega con ALTER TABLE al final del script.
CREATE TABLE Tbl_Orden_Recibida (
    Pk_Id_Orden_Recibida        INT AUTO_INCREMENT PRIMARY KEY,
    Id_Externo_Logistica        VARCHAR(100)  NOT NULL UNIQUE,
    Fk_Id_Material              INT NOT NULL,
    Fk_Id_Estado_Orden_Recibida INT NOT NULL,
    Cantidad_Solicitada         DECIMAL(12,4) NOT NULL,
    Fecha_Recepcion             TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Fecha_Requerida             DATE          NOT NULL,
    Observacion                 VARCHAR(255),
    CONSTRAINT fk_orden_recibida_producto
        FOREIGN KEY (Fk_Id_Material)
        REFERENCES Tbl_Materiales(Pk_Id_Materiales)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_orden_recibida_estado
        FOREIGN KEY (Fk_Id_Estado_Orden_Recibida)
        REFERENCES Tbl_Estado_Orden_Recibida(Pk_Id_Estado_Orden_Recibida)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE Tbl_Recepcion_Material (
    Pk_Id_Recepcion_Material        INT AUTO_INCREMENT PRIMARY KEY,
    Id_Externo_Logistica            VARCHAR(100)  NOT NULL UNIQUE,
    Fk_Id_Material                  INT NOT NULL,
    Fk_Id_Almacen_Destino           INT NOT NULL,
    Fk_Id_Estado_Recepcion_Material INT NOT NULL,
    Cantidad_Recibida               DECIMAL(12,4) NOT NULL,
    Costo_Unitario_Recibido         DECIMAL(12,4) NOT NULL DEFAULT 0,
    Fecha_Notificacion              TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Fecha_Ingreso_Almacen           TIMESTAMP     NULL,
    Observacion                     VARCHAR(255),
    CONSTRAINT fk_recepcion_material_material
        FOREIGN KEY (Fk_Id_Material)
        REFERENCES Tbl_Materiales(Pk_Id_Materiales)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_recepcion_material_almacen
        FOREIGN KEY (Fk_Id_Almacen_Destino)
        REFERENCES Tbl_Almacen(Pk_Id_Almacen)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_recepcion_material_estado
        FOREIGN KEY (Fk_Id_Estado_Recepcion_Material)
        REFERENCES Tbl_Estado_Recepcion_Material(Pk_Id_Estado_Recepcion_Material)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;


-- =========================
-- PRODUCCIÓN  —  BOM
-- =========================

CREATE TABLE Tbl_BOM (
    Pk_Id_BOM          INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Material     INT NOT NULL,
    Fk_Id_Estado_BOM   INT NOT NULL,
    Version_BOM        VARCHAR(20)  NOT NULL,
    Descripcion_BOM    VARCHAR(255) NOT NULL,
    Fecha_Creacion_BOM TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_bom_material_version UNIQUE (Fk_Id_Material, Version_BOM),
    CONSTRAINT fk_bom_material
        FOREIGN KEY (Fk_Id_Material)
        REFERENCES Tbl_Materiales(Pk_Id_Materiales)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_bom_estado
        FOREIGN KEY (Fk_Id_Estado_BOM)
        REFERENCES Tbl_Estado_BOM(Pk_Id_Estado_BOM)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE Tbl_BOM_Detalle (
    Pk_Id_BOM_Detalle              INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_BOM                      INT NOT NULL,
    Fk_Id_Materiales               INT NOT NULL,
    Fk_Id_Unidad_Medida            INT NOT NULL,
    Cantidad_Requerida_BOM_Detalle DECIMAL(12,4) NOT NULL,
    Porcentaje_Merma_BOM_Detalle   DECIMAL(5,2)  NOT NULL DEFAULT 0,
    CONSTRAINT uq_bom_material UNIQUE (Fk_Id_BOM, Fk_Id_Materiales),
    CONSTRAINT fk_bom_detalle_bom
        FOREIGN KEY (Fk_Id_BOM)
        REFERENCES Tbl_BOM(Pk_Id_BOM)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_bom_detalle_material
        FOREIGN KEY (Fk_Id_Materiales)
        REFERENCES Tbl_Materiales(Pk_Id_Materiales)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_bom_detalle_unidad
        FOREIGN KEY (Fk_Id_Unidad_Medida)
        REFERENCES Tbl_Unidad_Medida(Pk_Id_Unidad_Medida)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;


-- =========================
-- PRODUCCIÓN  —  PLANES Y ÓRDENES
-- =========================

CREATE TABLE Tbl_Plan_Produccion (
    Pk_Id_Plan_Produccion        INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Orden_Recibida         INT NOT NULL,
    Fk_Id_Estado_Plan_Produccion INT NOT NULL,
    Fecha_Plan_Produccion        DATE         NOT NULL,
    Descripcion_Plan_Produccion  VARCHAR(255) NOT NULL,
    CONSTRAINT fk_orden_recibida
        FOREIGN KEY (Fk_Id_Orden_Recibida)
        REFERENCES Tbl_Orden_Recibida(Pk_Id_Orden_Recibida)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_plan_estado
        FOREIGN KEY (Fk_Id_Estado_Plan_Produccion)
        REFERENCES Tbl_Estado_Plan_Produccion(Pk_Id_Estado_Plan_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE Tbl_Orden_Produccion (
    Pk_Id_Orden_Produccion               INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Plan_Produccion                INT NOT NULL,
    Fk_Id_Material                       INT NOT NULL,
    Fk_Id_Estado_Orden_Produccion        INT NOT NULL,
    Cantidad_Programada_Orden_Produccion DECIMAL(12,4) NOT NULL,
    Cantidad_Producida_Orden_Produccion  DECIMAL(12,4) NOT NULL DEFAULT 0,
    Fecha_Inicio_Orden_Produccion        DATE NOT NULL,
    Fecha_Fin_Orden_Produccion           DATE NOT NULL,
    CONSTRAINT fk_orden_plan
        FOREIGN KEY (Fk_Id_Plan_Produccion)
        REFERENCES Tbl_Plan_Produccion(Pk_Id_Plan_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_orden_material
        FOREIGN KEY (Fk_Id_Material)
        -- CORRECCIÓN: nombre de columna era Pk_Id_Material; el correcto es Pk_Id_Materiales
        REFERENCES Tbl_Materiales(Pk_Id_Materiales)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_orden_estado
        FOREIGN KEY (Fk_Id_Estado_Orden_Produccion)
        REFERENCES Tbl_Estado_Orden_Produccion(Pk_Id_Estado_Orden_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE Tbl_Fases_Produccion (
    Pk_Id_Fase_Producto         INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Material              INT          NOT NULL,
    Nombre_Fase_Produccion      VARCHAR(100) NOT NULL,
    Descripcion_Fase_Produccion TEXT         NOT NULL,
    CONSTRAINT fk_fase_producto
        FOREIGN KEY (Fk_Id_Material)
        -- CORRECCIÓN: nombre de columna era Pk_Id_Material; el correcto es Pk_Id_Materiales
        REFERENCES Tbl_Materiales(Pk_Id_Materiales)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE Tbl_Cronograma_Fases_Produccion (
    Pk_Id_Cronograma_Fase  INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Orden_Produccion INT  NOT NULL,
    Fk_Id_Fase_Producto    INT  NOT NULL,
    Fecha_Inicio_Fase      DATE NOT NULL,
    Fecha_Fin_Fase         DATE NOT NULL,
    Horas_Hombres          INT  NOT NULL,
    Fk_Id_Encargado        INT  NOT NULL,
    Fk_Id_Estado_Fase      INT  NOT NULL,
    CONSTRAINT Fk_Orden_Produccion
        FOREIGN KEY (Fk_Id_Orden_Produccion)
        REFERENCES Tbl_Orden_Produccion(Pk_Id_Orden_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT Fk_Id_Fase_Producto
        FOREIGN KEY (Fk_Id_Fase_Producto)
        REFERENCES Tbl_Fases_Produccion(Pk_Id_Fase_Producto)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT Fk_Id_Encargado
        FOREIGN KEY (Fk_Id_Encargado)
        REFERENCES tbl_empleado(Pk_Id_Empleado)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_cronograma_estado_fase
        FOREIGN KEY (Fk_Id_Estado_Fase)
        REFERENCES Tbl_Estado_Fase_Produccion(Pk_Id_Estado_Fase)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;


-- =========================
-- ALTER TABLE diferidos
-- (FKs circulares resueltas aquí)
-- =========================

ALTER TABLE Tbl_Inventario
    ADD CONSTRAINT fk_inventario_orden_produccion
        FOREIGN KEY (Fk_Id_Orden_Produccion)
        REFERENCES Tbl_Orden_Produccion(Pk_Id_Orden_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION;


-- =========================
-- PRODUCCIÓN  —  MOVIMIENTOS
-- =========================

-- Fk_Id_Recepcion_Material: trazabilidad de movimientos originados por una recepción.
CREATE TABLE Tbl_Movimiento_Inventarios (
    Pk_Id_Movimiento_Inventarios           INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Tipo_Movimiento                     INT NOT NULL,
    Fk_Id_Material                         INT NOT NULL,
    Cantidad_Movida_Movimiento_Inventarios  DECIMAL(12,4) NOT NULL,
    Fk_Id_Almacen_Origen                   INT NOT NULL,
    Fk_Id_Almacen_Destino                  INT NOT NULL,
    Fk_Orden_Produccion                    INT NULL,
    Fk_Id_Recepcion_Material               INT NULL,
    Fecha_Movimiento_Inventarios           TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Observacion_Movimiento_Inventarios     VARCHAR(255) NOT NULL,
    CONSTRAINT fk_movimiento_tipo
        FOREIGN KEY (Fk_Tipo_Movimiento)
        REFERENCES Tbl_Tipo_Movimiento_Inventario(Pk_Id_Tipo_Movimiento_Inventario)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_movimiento_material
        FOREIGN KEY (Fk_Id_Material)
        REFERENCES Tbl_Materiales(Pk_Id_Materiales)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_movimiento_almacen_origen
        FOREIGN KEY (Fk_Id_Almacen_Origen)
        REFERENCES Tbl_Almacen(Pk_Id_Almacen)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_movimiento_almacen_destino
        FOREIGN KEY (Fk_Id_Almacen_Destino)
        REFERENCES Tbl_Almacen(Pk_Id_Almacen)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_movimiento_orden
        FOREIGN KEY (Fk_Orden_Produccion)
        REFERENCES Tbl_Orden_Produccion(Pk_Id_Orden_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_movimiento_recepcion
        FOREIGN KEY (Fk_Id_Recepcion_Material)
        REFERENCES Tbl_Recepcion_Material(Pk_Id_Recepcion_Material)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;


-- =========================
-- PRODUCCIÓN  —  MATERIALES, MANO DE OBRA Y COSTOS
-- =========================

CREATE TABLE Tbl_Orden_Material (
    Pk_Id_Orden_Material              INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Orden_Produccion            INT NOT NULL,
    Fk_Id_Materiales                  INT NOT NULL,
    Cantidad_Necesaria_Orden_Material DECIMAL(12,4) NOT NULL,
    Cantidad_Consumida_Orden_Material DECIMAL(12,4) NOT NULL DEFAULT 0,
    Cantidad_Restante_Orden_Material  DECIMAL(12,4) NOT NULL DEFAULT 0,
    CONSTRAINT uq_orden_material UNIQUE (Fk_Id_Orden_Produccion, Fk_Id_Materiales),
    CONSTRAINT fk_orden_material_orden
        FOREIGN KEY (Fk_Id_Orden_Produccion)
        REFERENCES Tbl_Orden_Produccion(Pk_Id_Orden_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_orden_material_material
        FOREIGN KEY (Fk_Id_Materiales)
        REFERENCES Tbl_Materiales(Pk_Id_Materiales)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE Tbl_Mano_Obra (
    Pk_Id_Mano_Obra          INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Orden_Produccion   INT NOT NULL,
    Fk_Id_Empleado           INT NOT NULL,
    Hora_Trabajada_Mano_Obra DECIMAL(10,2) NOT NULL,
    Costo_Hora_Mano_Obra     DECIMAL(12,4) NOT NULL,
    Subtotal_Mano_Obra       DECIMAL(12,4) NOT NULL,
    CONSTRAINT fk_mano_obra_orden
        FOREIGN KEY (Fk_Id_Orden_Produccion)
        REFERENCES Tbl_Orden_Produccion(Pk_Id_Orden_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_mano_obra_empleado
        FOREIGN KEY (Fk_Id_Empleado)
        REFERENCES tbl_empleado(Pk_Id_Empleado)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE Tbl_Costo_Indirecto_Produccion (
    Pk_Id_Costo_Indirecto_Produccion       INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Orden_Produccion                 INT NOT NULL,
    Concepto_Costo_Indirecto_Produccion    VARCHAR(100) NOT NULL,
    Monto_Costo_Indirecto_Produccion       DECIMAL(12,4) NOT NULL,
    Descripcion_Costo_Indirecto_Produccion VARCHAR(255),
    CONSTRAINT fk_costo_indirecto_orden
        FOREIGN KEY (Fk_Id_Orden_Produccion)
        REFERENCES Tbl_Orden_Produccion(Pk_Id_Orden_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE Tbl_Costo_Produccion (
    Pk_Id_Costo_Produccion           INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Orden_Produccion           INT NOT NULL UNIQUE,
    Costo_Material_Costo_Produccion  DECIMAL(12,4) NOT NULL,
    Costo_Mano_Obra_Costo_Produccion DECIMAL(12,4) NOT NULL,
    Costo_Indirecto_Costo_Produccion DECIMAL(12,4) NOT NULL,
    Costo_Total_Costo_Produccion     DECIMAL(12,4) NOT NULL,
    Costo_Unitario_Costo_Produccion  DECIMAL(12,4) NOT NULL,
    CONSTRAINT fk_costo_produccion_orden
        FOREIGN KEY (Fk_Id_Orden_Produccion)
        REFERENCES Tbl_Orden_Produccion(Pk_Id_Orden_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;


-- =========================
-- MERMAS
-- =========================

CREATE TABLE Tbl_Tipo_Merma (
    Pk_Id_Tipo_Merma       INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Tipo_Merma      VARCHAR(100) NOT NULL UNIQUE,
    Descripcion_Tipo_Merma VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE Tbl_Merma (
    Pk_Id_Merma            INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Orden_Produccion INT NOT NULL,
    Fk_Id_Materiales       INT NOT NULL,
    Fk_Tipo_Merma          INT NOT NULL,
    Cantidad_Merma         DECIMAL(12,4) NOT NULL,
    Motivo_Merma           VARCHAR(255)  NOT NULL,
    Fecha                  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_merma_orden
        FOREIGN KEY (Fk_Id_Orden_Produccion)
        REFERENCES Tbl_Orden_Produccion(Pk_Id_Orden_Produccion)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_merma_material
        FOREIGN KEY (Fk_Id_Materiales)
        REFERENCES Tbl_Materiales(Pk_Id_Materiales)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_merma_tipo
        FOREIGN KEY (Fk_Tipo_Merma)
        REFERENCES Tbl_Tipo_Merma(Pk_Id_Tipo_Merma)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;


-- =========================
-- GARANTÍA
-- =========================

CREATE TABLE Tbl_Garantia (
    Pk_Id_Garantia                 INT AUTO_INCREMENT PRIMARY KEY,
    Fk_Id_Material                 INT NOT NULL,
    Tiempo_Garantia_Dias_Garantia  INT NOT NULL,
    Descripcion_Cobertura_Garantia VARCHAR(255) NOT NULL,
    Fecha_Inicio_Vigencia_Garantia DATE NOT NULL,
    Fecha_Fin_Vigencia_Garantia    DATE NOT NULL,
    CONSTRAINT fk_garantia_material
        FOREIGN KEY (Fk_Id_Material)
        REFERENCES Tbl_Materiales(Pk_Id_Materiales)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;


-- =============================================================
--  VISTAS
-- =============================================================

DROP VIEW IF EXISTS `vw_listado_cierres`;
CREATE ALGORITHM=UNDEFINED
    DEFINER=`root`@`localhost`
    SQL SECURITY DEFINER
    VIEW `vw_listado_cierres` AS
        SELECT 1 AS `id`;


-- =============================================================
--  Restaurar configuración de sesión
-- =============================================================
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;



-- =========================== INSERTS DE PERMISOS SEGURIDAD ========================================
INSERT INTO tbl_modulo 
(Pk_Id_Modulo, Cmp_Nombre_Modulo, Cmp_Descripcion_Modulo, Cmp_Estado_Modulo)
VALUES
(5, 'MRP', 'Planificación de requerimientos de materiales', 1);

INSERT INTO tbl_aplicacion 
(Pk_Id_Aplicacion, Fk_Id_Reporte_Aplicacion, Cmp_Nombre_Aplicacion, Cmp_Descripcion_Aplicacion, Cmp_Estado_Aplicacion)
VALUES
(700, NULL, 'Tipo Material', 'Define tipos generales de material', 1),
(701, NULL, 'Categoría Material', 'Clasifica los materiales', 1),
(702, NULL, 'Unidad de Medida', 'Define unidades de medida', 1),
(703, NULL, 'Almacén', 'Registra almacenes', 1),
(704, NULL, 'Materiales', 'Información de materiales o productos', 1),
(705, NULL, 'Estado Producción', 'Estados de producción', 1),
(706, NULL, 'Tipo Movimiento Inventario', 'Tipos de movimiento', 1),
(707, NULL, 'Estado BOM', 'Estado de lista de materiales', 1),
(708, NULL, 'Estado Plan Producción', 'Estado de planes de producción', 1),
(709, NULL, 'Estado Orden Producción', 'Estado de órdenes de producción', 1),
(710, NULL, 'Estado Orden Recibida', 'Estado de órdenes recibidas', 1),
(711, NULL, 'Estado Recepción Material', 'Estado de recepción de material', 1),
(712, NULL, 'Tipo Inventario', 'Tipos de inventario', 1),
(713, NULL, 'Inventario', 'Control de inventario', 1),
(714, NULL, 'Orden Recibida', 'Pedidos recibidos', 1),
(715, NULL, 'Recepción Material', 'Materiales recibidos', 1),
(716, NULL, 'BOM', 'Estructura de materiales', 1),
(717, NULL, 'Detalle BOM', 'Detalle de materiales del BOM', 1),
(718, NULL, 'Plan Producción', 'Planificación de producción', 1),
(719, NULL, 'Orden Producción', 'Órdenes de producción', 1),
(720, NULL, 'Estado Fase Producción', 'Estado de fases', 1),
(721, NULL, 'Movimiento Inventarios', 'Movimientos de inventario', 1),
(722, NULL, 'Orden Material', 'Materiales por orden', 1),
(723, NULL, 'Costo Indirecto Producción', 'Costos indirectos', 1),
(724, NULL, 'Costo Producción', 'Costo total de producción', 1),
(725, NULL, 'Tipo Merma', 'Tipos de merma', 1),
(726, NULL, 'Merma', 'Registro de merma', 1),
(727, NULL, 'Garantía', 'Garantías de productos', 1),
(728, NULL, 'Mano de Obra', 'Trabajo humano en producción', 1),
(729, NULL, 'Fases Producción', 'Fases del proceso productivo', 1),
(730, NULL, 'Cronograma Fases Producción', 'Cronograma de fases', 1);

INSERT INTO tbl_asignacion_modulo_aplicacion (Fk_Id_Modulo, Fk_Id_Aplicacion)
VALUES
(5,700),(5,701),(5,702),(5,703),(5,704),
(5,705),(5,706),(5,707),(5,708),(5,709),
(5,710),(5,711),(5,712),(5,713),(5,714),
(5,715),(5,716),(5,717),(5,718),(5,719),
(5,720),(5,721),(5,722),(5,723),(5,724),
(5,725),(5,726),(5,727),(5,728),(5,729),
(5,730);

INSERT INTO tbl_permiso_usuario_aplicacion
(Fk_Id_Usuario, Fk_Id_Modulo, Fk_Id_Aplicacion,
Cmp_Ingresar_Permiso_Aplicacion_Usuario,
Cmp_Consultar_Permiso_Aplicacion_Usuario,
Cmp_Modificar_Permiso_Aplicacion_Usuario,
Cmp_Eliminar_Permiso_Aplicacion_Usuario,
Cmp_Imprimir_Permiso_Aplicacion_Usuario)
VALUES
-- Usuario 4
(4,5,700,1,1,1,1,1),(4,5,701,1,1,1,1,1),
(4,5,702,1,1,1,1,1),(4,5,703,1,1,1,1,1),
(4,5,704,1,1,1,1,1),(4,5,705,1,1,1,1,1),
(4,5,706,1,1,1,1,1),(4,5,707,1,1,1,1,1),
(4,5,708,1,1,1,1,1),(4,5,709,1,1,1,1,1),
(4,5,710,1,1,1,1,1),(4,5,711,1,1,1,1,1),
(4,5,712,1,1,1,1,1),(4,5,713,1,1,1,1,1),
(4,5,714,1,1,1,1,1),(4,5,715,1,1,1,1,1),
(4,5,716,1,1,1,1,1),(4,5,717,1,1,1,1,1),
(4,5,718,1,1,1,1,1),(4,5,719,1,1,1,1,1),
(4,5,720,1,1,1,1,1),(4,5,721,1,1,1,1,1),
(4,5,722,1,1,1,1,1),(4,5,723,1,1,1,1,1),
(4,5,724,1,1,1,1,1),(4,5,725,1,1,1,1,1),
(4,5,726,1,1,1,1,1),(4,5,727,1,1,1,1,1),
(4,5,728,1,1,1,1,1),(4,5,729,1,1,1,1,1),
(4,5,730,1,1,1,1,1),

-- Usuario 23
(23,5,700,1,1,1,1,1),(23,5,701,1,1,1,1,1),
(23,5,702,1,1,1,1,1),(23,5,703,1,1,1,1,1),
(23,5,704,1,1,1,1,1),(23,5,705,1,1,1,1,1),
(23,5,706,1,1,1,1,1),(23,5,707,1,1,1,1,1),
(23,5,708,1,1,1,1,1),(23,5,709,1,1,1,1,1),
(23,5,710,1,1,1,1,1),(23,5,711,1,1,1,1,1),
(23,5,712,1,1,1,1,1),(23,5,713,1,1,1,1,1),
(23,5,714,1,1,1,1,1),(23,5,715,1,1,1,1,1),
(23,5,716,1,1,1,1,1),(23,5,717,1,1,1,1,1),
(23,5,718,1,1,1,1,1),(23,5,719,1,1,1,1,1),
(23,5,720,1,1,1,1,1),(23,5,721,1,1,1,1,1),
(23,5,722,1,1,1,1,1),(23,5,723,1,1,1,1,1),
(23,5,724,1,1,1,1,1),(23,5,725,1,1,1,1,1),
(23,5,726,1,1,1,1,1),(23,5,727,1,1,1,1,1),
(23,5,728,1,1,1,1,1),(23,5,729,1,1,1,1,1),
(23,5,730,1,1,1,1,1);



ALTER TABLE Tbl_Tipo_Material
ADD Estado_Tipo_Material TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1=Activo, 0=Inactivo';

INSERT INTO tbl_tipo_material (Nombre_Tipo_Material, Estado_Tipo_Material) VALUES
('Materia Prima', 1),
('Producto Terminado', 1),
('Material Defectuoso', 0);



use bd_mrp;
-- Creacion de tabla para mantenimiento --
CREATE TABLE Tipo_Jugador (
	ID_TIPO_JUGADOR INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE_POSICION varchar(60)
);


