-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 18, 2024 at 10:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mentevida`
--
CREATE DATABASE IF NOT EXISTS `mentevida` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `mentevida`;

-- --------------------------------------------------------

--
-- Table structure for table `agendamento`
--

CREATE TABLE `agendamento` (
  `id_agendamento` int(11) NOT NULL,
  `data_agendamento` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `paciente_id_paciente` int(11) NOT NULL,
  `medico_id_medico` int(11) NOT NULL,
  `funcionario_id_funcionario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `agendamento`
--

INSERT INTO `agendamento` (`id_agendamento`, `data_agendamento`, `status`, `paciente_id_paciente`, `medico_id_medico`, `funcionario_id_funcionario`) VALUES
(2, '2024-05-12 00:00:00', 0, 2, 1, 1),
(5, '2024-11-12 12:00:00', 1, 5, 2, 1),
(6, '2024-11-16 13:30:00', 1, 13, 2, 2),
(7, '2000-12-25 00:00:00', 0, 12, 2, 1),
(8, '2024-05-12 00:00:00', 1, 2, 1, 1),
(9, '2024-11-12 12:00:00', 0, 5, 2, 1),
(10, '2024-11-12 12:00:00', 0, 5, 2, 1),
(11, '2024-11-12 12:00:00', 0, 5, 2, 2),
(12, '2024-11-12 12:00:00', 1, 7, 2, 2),
(13, '2024-11-12 12:00:00', 1, 13, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `consulta`
--

CREATE TABLE `consulta` (
  `id_consulta` int(11) NOT NULL,
  `duracao` int(11) NOT NULL,
  `valor` double DEFAULT NULL,
  `id_paciente` int(11) DEFAULT NULL,
  `id_medico` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `consulta`
--

INSERT INTO `consulta` (`id_consulta`, `duracao`, `valor`, `id_paciente`, `id_medico`) VALUES
(2, 40, 225, 5, 2),
(3, 60, 275, 6, 2),
(4, 40, 200, 12, 4);

-- --------------------------------------------------------

--
-- Table structure for table `funcionario`
--

CREATE TABLE `funcionario` (
  `id_funcionario` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `cargo` varchar(100) DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `funcionario`
--

INSERT INTO `funcionario` (`id_funcionario`, `nome`, `telefone`, `email`, `cargo`, `idUsuario`) VALUES
(1, 'Bianca Almeida', '8521597531', 'biancaal@hotmail.com', 'Recepcionista', NULL),
(2, 'Mariana Almeida', '12345678995', 'mariana@email.com', 'Gerente', 7),
(3, 'Usuario Funcionario', '99988856452', 'usuario@email', 'Funcionario', 10),
(4, 'Satoru Gojo', '61999551212', 'teste@email.com', 'Analista de Dados', 12),
(14, 'Funcionario', '11111111111', 'funcionario@email', 'Atendente', 14);

--
-- Triggers `funcionario`
--
DELIMITER $$
CREATE TRIGGER `after_funcionario_delete` AFTER DELETE ON `funcionario` FOR EACH ROW BEGIN
    DELETE FROM UsuarioAssociacao WHERE idUsuario = OLD.idUsuario AND Cargo = 'Funcionario';
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_funcionario_insert` BEFORE INSERT ON `funcionario` FOR EACH ROW BEGIN
    IF NEW.idUsuario IS NOT NULL THEN
        INSERT INTO UsuarioAssociacao (idUsuario, Cargo)
        VALUES (NEW.idUsuario, 'Funcionario')
        ON DUPLICATE KEY UPDATE Cargo = 'Funcionario';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_funcionario_update` BEFORE UPDATE ON `funcionario` FOR EACH ROW BEGIN
    IF NEW.idUsuario IS NOT NULL THEN
        INSERT INTO UsuarioAssociacao (idUsuario, Cargo)
        VALUES (NEW.idUsuario, 'Funcionario')
        ON DUPLICATE KEY UPDATE Cargo = 'Funcionario';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `medico`
--

CREATE TABLE `medico` (
  `id_medico` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `especialidade` varchar(100) NOT NULL,
  `telefone` varchar(14) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medico`
--

INSERT INTO `medico` (`id_medico`, `nome`, `especialidade`, `telefone`, `email`, `idUsuario`) VALUES
(1, 'DEDEDE', 'Psicologia', '999999999', '12EEEE@email', 4),
(2, 'Rafael Mendes', 'Psiquiatria', '1546582145', 'faelmendes@gmail.com', NULL),
(3, 'Medico Administrador', 'Psiquiatria', '11111111111', 'asdklasjd@email.com', 9),
(4, 'Gabriel Andre dos Santos', 'Psicologia', '61999995555', 'gabriel@email', 11),
(9, 'Medico', 'Psiquiatria', '9999999999', 'email@gmail', 15);

--
-- Triggers `medico`
--
DELIMITER $$
CREATE TRIGGER `after_medico_delete` AFTER DELETE ON `medico` FOR EACH ROW BEGIN
    DELETE FROM UsuarioAssociacao WHERE idUsuario = OLD.idUsuario AND Cargo = 'Medico';
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_medico_insert` BEFORE INSERT ON `medico` FOR EACH ROW BEGIN
    IF NEW.idUsuario IS NOT NULL THEN
        INSERT INTO UsuarioAssociacao (idUsuario, Cargo)
        VALUES (NEW.idUsuario, 'Medico')
        ON DUPLICATE KEY UPDATE Cargo = 'Medico';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_medico_update` BEFORE UPDATE ON `medico` FOR EACH ROW BEGIN
    IF NEW.idUsuario IS NOT NULL THEN
        INSERT INTO UsuarioAssociacao (idUsuario, Cargo)
        VALUES (NEW.idUsuario, 'Medico')
        ON DUPLICATE KEY UPDATE Cargo = 'Medico';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `paciente`
--

CREATE TABLE `paciente` (
  `id_paciente` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `data_nascimento` date NOT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `historico_medico` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `paciente`
--

INSERT INTO `paciente` (`id_paciente`, `nome`, `data_nascimento`, `telefone`, `email`, `historico_medico`) VALUES
(2, 'Evil Neuro', '2020-01-01', '999999999', 'vedal987@email', '/Pacientes/historico2EvilNeuro.pdf'),
(5, 'vedal', '1998-01-12', '9854123541', 'vedal@email', 'C:\\historico\\historico2.pdf'),
(6, 'lucas', '2008-05-21', '8541254615', 'lucas@email', 'C:\\historico\\historico2.pdf'),
(7, 'John Kennedy II', '2024-11-21', '854123645', 'asdasdsadsadsa@dsakdjsakdsadsa', '/Pacientes/historico7JohnKennedy.pdf'),
(8, 'Roberto Amaral', '2003-12-11', '856214638', 'robertoaldsakd@email.com', '/home/kuroneko/Dev/Uploads/Pacientes/historico8'),
(9, 'Murilo Couto', '1986-06-27', '7778895462', '785214569lkjhg@email.com', '/home/kuroneko/Dev/Uploads/Pacientes/historico9'),
(11, 'Roberto Carlos', '1998-08-12', '7854123654', 'email@email.com', '/Pacientes/historico11RobertoCarlos'),
(12, 'Luciano Hulk', '2000-02-05', '958623145698', 'caldeiraodohulkpobre@gmai.com', '/Pacientes/historico12LucianoHulk'),
(13, 'Miguel O\'Hara', '1999-12-25', '12345678912', 'miguelsaikyou@hotmail.com', '/Pacientes/historico13MiguelO\'Hara.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `prescricao`
--

CREATE TABLE `prescricao` (
  `id_prescricao` int(11) NOT NULL,
  `data_prescricao` date NOT NULL,
  `medicamentos` varchar(200) DEFAULT NULL,
  `dosagem` varchar(200) DEFAULT NULL,
  `comentario` varchar(500) DEFAULT NULL,
  `id_consulta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prescricao`
--

INSERT INTO `prescricao` (`id_prescricao`, `data_prescricao`, `medicamentos`, `dosagem`, `comentario`, `id_consulta`) VALUES
(2, '2024-12-11', 'medicamento 2, medicamento 3, medicamento 4', 'dosagem A e B', '888888', 3),
(3, '2024-12-20', 'medicamento 4, medicamento 6, medicamento 4', 'dosagem F e D', 'Isto é mais um comentário', 2),
(4, '2024-11-22', 'Medicamento X Sdklsal', '1 2e 3', 'Tomar sempre', 3),
(6, '2024-12-12', 'medicamento1111', 'dosagem1111', 'instrucoes1111', 2),
(7, '2024-12-12', 'medicamento1111222', 'dosagem1111222', 'aaaaaaaaaa', 2);

-- --------------------------------------------------------

--
-- Table structure for table `relatorio`
--

CREATE TABLE `relatorio` (
  `id_relatorio` int(11) NOT NULL,
  `data_relatorio` date NOT NULL,
  `endereco` varchar(200) DEFAULT NULL,
  `consulta_id_consulta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `relatorio`
--

INSERT INTO `relatorio` (`id_relatorio`, `data_relatorio`, `endereco`, `consulta_id_consulta`) VALUES
(2, '2022-09-15', 'C\\Relatorios\\relatorio2.pdf', 3),
(4, '1998-02-15', '/home/kuroneko/Dev/Uploads/Relatorios/relatorio4consulta3', 3),
(5, '2022-11-05', '/Relatorios/relatorio5consulta3.pdf', 2);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `senha` varchar(200) NOT NULL,
  `admin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `username`, `senha`, `admin`) VALUES
(2, 'admin', '3hzi4r81f30g81bo5orq5ddbh3uuqoo28158si9djbh20p0sgo', 1),
(3, 'user', '45auvrm8e57zm8y2dyh0s3ows1n3bit9vrxsqcaikpyj7j7izn', 0),
(4, 'dada_user', '4ai62shviykclpd4zadmjhgdc6it8y6lqz2jfnj10di35visru', 0),
(7, 'mariana1212', '45auvrm8e57zm8y2dyh0s3ows1n3bit9vrxsqcaikpyj7j7izn', 1),
(9, 'medicoadmin', '3hzi4r81f30g81bo5orq5ddbh3uuqoo28158si9djbh20p0sgo', 1),
(10, 'funcionarioteste', '4gkmw3ki6ko6ovge1xyyi37vdki9qnxh57lqfbcjyf64sx98b', 0),
(11, 'gabrielmed', 'pcepgmq4e1fx3zw1ttkki37vjihe6vad91ewmgdynibbtqex1', 1),
(12, 'eufuncionario', '4gkmw3ki6ko6ovge1xyyi37vdki9qnxh57lqfbcjyf64sx98b', 1),
(13, 'testetesteteste12', '45auvrm8e57zm8y2dyh0s3ows1n3bit9vrxsqcaikpyj7j7izn', 0),
(14, 'funcionario', '45auvrm8e57zm8y2dyh0s3ows1n3bit9vrxsqcaikpyj7j7izn', 1),
(15, 'medico', '45auvrm8e57zm8y2dyh0s3ows1n3bit9vrxsqcaikpyj7j7izn', 1);

-- --------------------------------------------------------

--
-- Table structure for table `UsuarioAssociacao`
--

CREATE TABLE `UsuarioAssociacao` (
  `idUsuario` int(11) NOT NULL,
  `Cargo` enum('Funcionario','Medico') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `UsuarioAssociacao`
--

INSERT INTO `UsuarioAssociacao` (`idUsuario`, `Cargo`) VALUES
(4, 'Medico'),
(7, 'Funcionario'),
(9, 'Medico'),
(10, 'Funcionario'),
(11, 'Medico'),
(12, 'Funcionario'),
(14, 'Funcionario'),
(15, 'Medico');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agendamento`
--
ALTER TABLE `agendamento`
  ADD PRIMARY KEY (`id_agendamento`),
  ADD KEY `fk_agendamento_paciente1_idx` (`paciente_id_paciente`),
  ADD KEY `fk_agendamento_medico1_idx` (`medico_id_medico`),
  ADD KEY `fk_agendamento_atendente1_idx` (`funcionario_id_funcionario`);

--
-- Indexes for table `consulta`
--
ALTER TABLE `consulta`
  ADD PRIMARY KEY (`id_consulta`),
  ADD KEY `id_paciente` (`id_paciente`),
  ADD KEY `id_medico` (`id_medico`);

--
-- Indexes for table `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`id_funcionario`),
  ADD UNIQUE KEY `idUsuario_2` (`idUsuario`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indexes for table `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`id_medico`),
  ADD KEY `medico_ibfk_1` (`idUsuario`);

--
-- Indexes for table `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`id_paciente`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `prescricao`
--
ALTER TABLE `prescricao`
  ADD PRIMARY KEY (`id_prescricao`),
  ADD KEY `id_consulta` (`id_consulta`);

--
-- Indexes for table `relatorio`
--
ALTER TABLE `relatorio`
  ADD PRIMARY KEY (`id_relatorio`),
  ADD KEY `fk_relatorio_consulta1_idx` (`consulta_id_consulta`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`);

--
-- Indexes for table `UsuarioAssociacao`
--
ALTER TABLE `UsuarioAssociacao`
  ADD PRIMARY KEY (`idUsuario`,`Cargo`),
  ADD UNIQUE KEY `idUsuario` (`idUsuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agendamento`
--
ALTER TABLE `agendamento`
  MODIFY `id_agendamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `consulta`
--
ALTER TABLE `consulta`
  MODIFY `id_consulta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `funcionario`
--
ALTER TABLE `funcionario`
  MODIFY `id_funcionario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `medico`
--
ALTER TABLE `medico`
  MODIFY `id_medico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `paciente`
--
ALTER TABLE `paciente`
  MODIFY `id_paciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `prescricao`
--
ALTER TABLE `prescricao`
  MODIFY `id_prescricao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `relatorio`
--
ALTER TABLE `relatorio`
  MODIFY `id_relatorio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agendamento`
--
ALTER TABLE `agendamento`
  ADD CONSTRAINT `fk_agendamento_atendente1` FOREIGN KEY (`funcionario_id_funcionario`) REFERENCES `funcionario` (`id_funcionario`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_agendamento_medico1` FOREIGN KEY (`medico_id_medico`) REFERENCES `medico` (`id_medico`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_agendamento_paciente1` FOREIGN KEY (`paciente_id_paciente`) REFERENCES `paciente` (`id_paciente`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `consulta`
--
ALTER TABLE `consulta`
  ADD CONSTRAINT `consulta_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id_paciente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `consulta_ibfk_2` FOREIGN KEY (`id_medico`) REFERENCES `medico` (`id_medico`) ON UPDATE CASCADE;

--
-- Constraints for table `funcionario`
--
ALTER TABLE `funcionario`
  ADD CONSTRAINT `FK_Funcionario_UsuarioAssoc` FOREIGN KEY (`idUsuario`) REFERENCES `UsuarioAssociacao` (`idUsuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `medico`
--
ALTER TABLE `medico`
  ADD CONSTRAINT `FK_Medico_UsuarioAssoc` FOREIGN KEY (`idUsuario`) REFERENCES `UsuarioAssociacao` (`idUsuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `prescricao`
--
ALTER TABLE `prescricao`
  ADD CONSTRAINT `prescricao_ibfk_1` FOREIGN KEY (`id_consulta`) REFERENCES `consulta` (`id_consulta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `relatorio`
--
ALTER TABLE `relatorio`
  ADD CONSTRAINT `fk_relatorio_consulta1` FOREIGN KEY (`consulta_id_consulta`) REFERENCES `consulta` (`id_consulta`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `UsuarioAssociacao`
--
ALTER TABLE `UsuarioAssociacao`
  ADD CONSTRAINT `UsuarioAssociacao_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
