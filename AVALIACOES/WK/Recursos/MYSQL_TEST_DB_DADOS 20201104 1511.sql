-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.7.31-log


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema test_db
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ test_db;
USE test_db;

--
-- Table structure for table `test_db`.`tab_pedidos_dados_gerais`
--

DROP TABLE IF EXISTS `tab_pedidos_dados_gerais`;
CREATE TABLE `tab_pedidos_dados_gerais` (
  `tdg_pedido_numero` bigint(20) NOT NULL AUTO_INCREMENT,
  `tdg_data_emissao` datetime DEFAULT NULL,
  `tdg_codigo_cliente` bigint(20) DEFAULT NULL,
  `tdg_valor_total` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`tdg_pedido_numero`),
  KEY `tab_pedidos_dados_gerais_fk1` (`tdg_codigo_cliente`),
  CONSTRAINT `tab_pedidos_dados_gerais_fk1` FOREIGN KEY (`tdg_codigo_cliente`) REFERENCES `tab_vendas_clientes` (`tcl_codigo`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Modulo de Vendas - Pedidos';

--
-- Dumping data for table `test_db`.`tab_pedidos_dados_gerais`
--

/*!40000 ALTER TABLE `tab_pedidos_dados_gerais` DISABLE KEYS */;
INSERT INTO `tab_pedidos_dados_gerais` (`tdg_pedido_numero`,`tdg_data_emissao`,`tdg_codigo_cliente`,`tdg_valor_total`) VALUES 
 (1,'2020-11-04 00:00:00',56394,'127.00'),
 (2,'2020-11-04 00:00:00',56394,'773.50'),
 (3,'2020-11-04 00:00:00',56394,'773.50'),
 (4,'2020-11-04 00:00:00',56394,'56.30'),
 (5,'2020-11-04 00:00:00',56394,'168.90'),
 (6,'2020-11-04 00:00:00',56394,'773.50'),
 (7,'2020-11-04 00:00:00',56394,'375.00'),
 (9,'2020-11-04 00:00:00',45468,'177.10'),
 (10,'2020-11-04 00:00:00',56394,'347.20'),
 (11,'2020-11-04 00:00:00',45468,'100.00'),
 (12,'2020-11-04 00:00:00',56394,'250.00');
/*!40000 ALTER TABLE `tab_pedidos_dados_gerais` ENABLE KEYS */;


--
-- Table structure for table `test_db`.`tab_pedidos_produtos`
--

DROP TABLE IF EXISTS `tab_pedidos_produtos`;
CREATE TABLE `tab_pedidos_produtos` (
  `tpp_regid` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpp_numero_pedido` bigint(20) DEFAULT NULL,
  `tpp_codigo_produto` bigint(20) DEFAULT NULL,
  `tpp_quantidade` int(11) DEFAULT NULL,
  `tpp_valor_unitario` decimal(12,2) DEFAULT NULL,
  `tpp_valor_total` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`tpp_regid`),
  KEY `tab_pedidos_produtos_fk1` (`tpp_numero_pedido`),
  KEY `tab_pedidos_produtos_fk2` (`tpp_codigo_produto`),
  CONSTRAINT `tab_pedidos_produtos_fk1` FOREIGN KEY (`tpp_numero_pedido`) REFERENCES `tab_pedidos_dados_gerais` (`tdg_pedido_numero`) ON UPDATE NO ACTION,
  CONSTRAINT `tab_pedidos_produtos_fk2` FOREIGN KEY (`tpp_codigo_produto`) REFERENCES `tab_vendas_produtos` (`tpd_codigo`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Modulo de Vendas - Itens do Pedido';

--
-- Dumping data for table `test_db`.`tab_pedidos_produtos`
--

/*!40000 ALTER TABLE `tab_pedidos_produtos` DISABLE KEYS */;
INSERT INTO `tab_pedidos_produtos` (`tpp_regid`,`tpp_numero_pedido`,`tpp_codigo_produto`,`tpp_quantidade`,`tpp_valor_unitario`,`tpp_valor_total`) VALUES 
 (1,6,779,2,'55.25','110.50'),
 (2,6,779,4,'55.25','221.00'),
 (3,6,779,8,'55.25','442.00'),
 (8,9,718,5,'25.30','126.50'),
 (9,9,718,2,'25.30','50.60'),
 (10,10,1070,2,'24.80','49.60'),
 (11,10,1070,4,'24.80','99.20'),
 (12,10,1070,8,'24.80','198.40'),
 (13,11,779,1,'50.00','50.00'),
 (14,11,779,1,'50.00','50.00'),
 (15,12,718,5,'50.00','250.00');
/*!40000 ALTER TABLE `tab_pedidos_produtos` ENABLE KEYS */;


--
-- Table structure for table `test_db`.`tab_vendas_clientes`
--

DROP TABLE IF EXISTS `tab_vendas_clientes`;
CREATE TABLE `tab_vendas_clientes` (
  `tcl_regid` bigint(20) NOT NULL AUTO_INCREMENT,
  `tcl_codigo` bigint(20) DEFAULT NULL,
  `tcl_nome` varchar(100) DEFAULT NULL,
  `tcl_cidade` varchar(50) DEFAULT NULL,
  `tcl_uf` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`tcl_regid`),
  KEY `tcl_codigo` (`tcl_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='Modulo de Vendas - Clientes';

--
-- Dumping data for table `test_db`.`tab_vendas_clientes`
--

/*!40000 ALTER TABLE `tab_vendas_clientes` DISABLE KEYS */;
INSERT INTO `tab_vendas_clientes` (`tcl_regid`,`tcl_codigo`,`tcl_nome`,`tcl_cidade`,`tcl_uf`) VALUES 
 (1,365067,'COLEGIO BATISTA','SAO PAULO','SP'),
 (2,593044,'APOTIGAR FERRAMENTAS LTDA','SAO PAULO','SP'),
 (3,690450,'BANCO DO BRASIL S/A','SAO PAULO','SP'),
 (4,45468,'BRASIL TECIDOS LTDA','SAO PAULO','SP'),
 (5,782887,'JACARE HOMECENTER LTDA','SAO PAULO','SP'),
 (6,529937,'REI DOS PARAFUSOS LTDA','SAO PAULO','SP'),
 (7,56394,'SUPERMERCADOS LUSITANA S/A','SAO PAULO','SP'),
 (8,352005,'BOMPREÇO EMPREENDIMENTOS S/A','SAO PAULO','SP'),
 (9,933076,'LITERATO LOJA DE DEPARTAMENTOS LTDA','SAO PAULO','SP'),
 (10,535389,'REFRIMA COMPANHIA DE REFRIGERANTES S/A','SAO PAULO','SP'),
 (11,191156,'AUTOVIARIA MATOS LTDA','SAO PAULO','SP'),
 (12,897751,'MARCOPOLO CARROCERIAS S/A','CURITIBA','PR'),
 (13,501337,'CENTRO ELETRICO COMERCIAL LTDA','CURITIBA','PR'),
 (14,540398,'EXTRAFARMA MEDICAMENTOS S/A','CURITIBA','PR'),
 (15,115054,'OTICAS VEJA LTDA','CURITIBA','PR'),
 (16,503489,'GRUPO UNIÃO AUTOPEÇAS LTDA','CURITIBA','PR'),
 (17,363497,'EMPRESA GONÇALVES LTDA','CURITIBA','PR');
INSERT INTO `tab_vendas_clientes` (`tcl_regid`,`tcl_codigo`,`tcl_nome`,`tcl_cidade`,`tcl_uf`) VALUES 
 (18,212893,'PRONUTRE PRODUTOS NUTRIENTES INDUSTRIAIS LTDA','CURITIBA','PR'),
 (19,257694,'SERASA TECNOLOIGA S/A','CURITIBA','PR'),
 (20,975914,'ENTEC ELETRONICOS LTDA','CURITIBA','PR'),
 (21,813750,'ESCOLA ARVORE DA VIDA LTDA','CURITIBA','PR'),
 (22,651941,'BU 205A TOSHIBA','CURITIBA','PR');
/*!40000 ALTER TABLE `tab_vendas_clientes` ENABLE KEYS */;


--
-- Table structure for table `test_db`.`tab_vendas_produtos`
--

DROP TABLE IF EXISTS `tab_vendas_produtos`;
CREATE TABLE `tab_vendas_produtos` (
  `tpd_regid` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpd_codigo` bigint(20) DEFAULT NULL,
  `tpd_descricao` varchar(100) DEFAULT NULL,
  `tpd_preco_venda` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`tpd_regid`),
  KEY `tpd_codigo` (`tpd_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='Modulo de Vendas - Produtos';

--
-- Dumping data for table `test_db`.`tab_vendas_produtos`
--

/*!40000 ALTER TABLE `tab_vendas_produtos` DISABLE KEYS */;
INSERT INTO `tab_vendas_produtos` (`tpd_regid`,`tpd_codigo`,`tpd_descricao`,`tpd_preco_venda`) VALUES 
 (1,8398,'DIODO 1N4148','8398.00'),
 (2,5737,'BU 205A TOSHIBA','1147.00'),
 (3,8223,'MOLA DIANTEIRA 3A','1644.00'),
 (4,3765,'AMORTECEDOR COFAP','941.00'),
 (5,4010,'RAPARO DA ADMISSAO','802.00'),
 (6,6519,'PARAFUSO INOX 6X8','1303.00'),
 (7,6311,'PARAFUSO INOX 9X4','2103.00'),
 (8,8106,'PROCESSADOR XEON E5-6570 V2','2026.00'),
 (9,1469,'PROCESSADOR I3 2 GERACAO','293.00'),
 (10,718,'PLACA MAE DELL PRECISION T3610 ','359.00'),
 (11,4964,'PLACA DELL PERC 300 RAID','2482.00'),
 (12,8791,'HDD EXTERNO 5.25 16TB','1758.00'),
 (13,4213,'SSD 512GB SCANDISK','2106.00'),
 (14,7761,'FONE DE OUVIDO MOTOROLA R404','3880.00'),
 (15,5867,'MOUSE SEM FIO LOGITECH H12','5867.00'),
 (16,5341,'TECLADO GAMER LASERCHIP G54','1068.00'),
 (17,6844,'CI ZILOG Z80 4.77','2281.00'),
 (18,5836,'INTEL 8080 7.6','1167.00'),
 (19,779,'MICROCOMPUTADOR MSX TURBO R','259.00'),
 (20,438,'TESOURA METAL VERMELHA','146.00'),
 (21,4151,'TINTA SUVINIL EXTERIORES VERMELHA','830.00');
INSERT INTO `tab_vendas_produtos` (`tpd_regid`,`tpd_codigo`,`tpd_descricao`,`tpd_preco_venda`) VALUES 
 (22,8969,'TINTA SUVINIL EXTERIORES BRANCA','4484.00'),
 (23,8779,'TINTA SUVINIL EXTERIORES PRETA','1755.00'),
 (24,1070,'TINTA CORAL INTERIORES AMARELA','267.00');
/*!40000 ALTER TABLE `tab_vendas_produtos` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
