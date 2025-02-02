CREATE DATABASE  IF NOT EXISTS `pedidovenda` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pedidovenda`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: pedidovenda
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(30) NOT NULL,
  `Cidade` varchar(30) DEFAULT NULL,
  `UF` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `NomeCliente` (`Nome`),
  KEY `CidadeCliente` (`Cidade`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Maria','Governador Valadares','MG'),(2,'Paulo Cesar','Governador Valadares','MG'),(3,'Pedro Henrique','São Paulo','SP'),(4,'Carlos','São Paulo','SP'),(5,'José Maria','Vila Velha','ES'),(6,'Gustavo','São Paulo','SP'),(7,'Marcos','São Paulo','SP'),(8,'Antonio','Vila Velha','ES'),(9,'Ana','Vila Velha','ES'),(10,'Cláudia','Governador Valadares','MG'),(11,'Julia Maria','Governador Valadares','MG'),(12,'Estevão','São Paulo','SP'),(13,'Murílo','São Paulo','SP'),(14,'Maria Aparecida','Vila Velha','ES'),(15,'Sebastião','São Paulo','SP'),(16,'Marcelo','São Paulo','SP'),(17,'Eduarda','Vila Velha','ES'),(18,'Vera','Vila Velha','ES'),(19,'Cristiano','Governador Valadares','MG'),(20,'Wanderson','Governador Valadares','MG'),(21,'Tiago','Governador Valadares','MG'),(22,'Vinicius','Governador Valadares','MG');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `codigocliente` int NOT NULL,
  `DataEmissao` date NOT NULL,
  `ValorTotal` decimal(15,2) NOT NULL,
  `hash` int DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `DataEmissaoPedido` (`DataEmissao`),
  KEY `codigoclientepedidos_idx` (`codigocliente`),
  CONSTRAINT `codigoclientepedidos` FOREIGN KEY (`codigocliente`) REFERENCES `clientes` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (3,1,'2025-02-01',10.00,60121408),(4,1,'2025-02-01',10.00,62611776),(5,1,'2025-02-01',4500.00,136282048),(6,1,'2025-02-01',8000.00,125665216),(7,1,'2025-02-01',8000.00,135757760),(8,1,'2025-02-01',13500.00,134250576),(9,1,'2025-02-01',9000.00,129531984),(10,1,'2025-02-01',8000.00,132415568),(11,1,'2025-02-01',4500.00,121536592);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidosprodutos`
--

DROP TABLE IF EXISTS `pedidosprodutos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidosprodutos` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `codigoPedido` int NOT NULL,
  `codigoProduto` int NOT NULL,
  `quantidade` float NOT NULL DEFAULT '0',
  `ValorUnitario` decimal(15,2) NOT NULL DEFAULT '0.00',
  `ValorTotal` decimal(15,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`codigo`),
  KEY `codigoprodutopedido_idx` (`codigoProduto`),
  KEY `codigopedido_idx` (`codigoPedido`),
  CONSTRAINT `codigopedido` FOREIGN KEY (`codigoPedido`) REFERENCES `pedidos` (`codigo`),
  CONSTRAINT `codigoprodutopedido` FOREIGN KEY (`codigoProduto`) REFERENCES `produtos` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidosprodutos`
--

LOCK TABLES `pedidosprodutos` WRITE;
/*!40000 ALTER TABLE `pedidosprodutos` DISABLE KEYS */;
INSERT INTO `pedidosprodutos` VALUES (1,6,2,1,3500.00,3500.00),(2,6,1,1,4500.00,4500.00),(3,7,2,1,3500.00,3500.00),(4,7,1,1,4500.00,4500.00),(5,8,1,2,4500.00,9000.00),(6,8,1,1,4500.00,4500.00),(7,9,1,2,4500.00,9000.00),(8,10,2,1,3500.00,3500.00),(9,10,1,1,4500.00,4500.00),(10,11,1,1,4500.00,4500.00);
/*!40000 ALTER TABLE `pedidosprodutos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(30) NOT NULL,
  `PrecoVenda` decimal(15,2) NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `DescricaoProduto` (`Descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Notebook Dell Inspiron',4500.00),(2,'Smartphone Samsung Galaxy S21',3500.00),(3,'Smart TV LG 55” 4K',3200.00),(4,'Console PlayStation 5',4600.00),(5,'Mouse Gamer Logitech G502',350.00),(6,'Teclado Mecânico HyperX Alloy',450.00),(7,'Monitor Dell 27” Full HD',1200.00),(8,'Cadeira Gamer DXRacer',1800.00),(9,'Impressora HP LaserJet',900.00),(10,'Tablet Apple iPad 9ª Geração',2800.00),(11,'Fone de Ouvido Bluetooth JBL',500.00),(12,'Roteador Wi-Fi 6 TP-Link',650.00),(13,'HD Externo Seagate 2TB',420.00),(14,'Memória RAM Corsair 16GB DDR4',550.00),(15,'Processador AMD Ryzen 7 5800X',2000.00),(16,'Placa de Vídeo RTX 3060',2800.00),(17,'Fonte Corsair 750W 80 Plus ',700.00),(18,'Gabinete Gamer NZXT',600.00),(19,'SSD NVMe Kingston 1TB',750.00),(20,'Webcam Logitech C920 Full ',400.00),(21,'Microfone Condensador Blue',900.00);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-02 14:29:54
