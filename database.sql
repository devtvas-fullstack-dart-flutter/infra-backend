-- MySQL Script generated by MySQL Workbench
-- Mon Jul  4 12:16:14 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema delivery
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema delivery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `delivery` DEFAULT CHARACTER SET utf8 ;
USE `delivery` ;

-- -----------------------------------------------------
-- Table `delivery`.`tb_pushs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery`.`tb_pushs` ;

CREATE TABLE IF NOT EXISTS `delivery`.`tb_pushs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(120) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `dtCreated` DATETIME DEFAULT now(),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery`.`tb_usuarios` ;

CREATE TABLE IF NOT EXISTS `delivery`.`tb_usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(30) NOT NULL,
  `sobrenome` VARCHAR(60) NOT NULL,
  `dtNasc` DATETIME NOT NULL,
  `documento` VARCHAR(14) NOT NULL,
  `email` VARCHAR(140) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `deviceToken` VARCHAR(255) NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `stattus` VARCHAR(1) NOT NULL,
  `dtCreated` DATETIME DEFAULT now(),
  `dtUpdated` DATETIME NULL,
  `idPushs` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `documento_UNIQUE` (`documento` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  INDEX `fk_tb_usuarios_tb_pushs1_idx` (`idPushs` ASC) ,
  CONSTRAINT `fk_tb_usuarios_tb_pushs1`
    FOREIGN KEY (`idPushs`)
    REFERENCES `delivery`.`tb_pushs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_permissoes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery`.`tb_permissoes` ;

CREATE TABLE IF NOT EXISTS `delivery`.`tb_permissoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `status` VARCHAR(1) NOT NULL,
  `dtCreated` DATETIME DEFAULT now(),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_usuario_permissao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery`.`tb_usuario_permissao` ;

CREATE TABLE IF NOT EXISTS `delivery`.`tb_usuario_permissao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idUsuario` INT NOT NULL,
  `idPermissao` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_usuario_permissao_tb_usuarios_idx` (`idUsuario` ASC) ,
  INDEX `fk_tb_usuario_permissao_tb_permissoes1_idx` (`idPermissao` ASC) ,
  CONSTRAINT `fk_tb_usuario_permissao_tb_usuarios`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `delivery`.`tb_usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_usuario_permissao_tb_permissoes1`
    FOREIGN KEY (`idPermissao`)
    REFERENCES `delivery`.`tb_permissoes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_estabelecimentos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery`.`tb_estabelecimentos` ;

CREATE TABLE IF NOT EXISTS `delivery`.`tb_estabelecimentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `phone` VARCHAR(11) NULL,
  `description` VARCHAR(150) NULL,
  `imageUrl` VARCHAR(255) NULL,
  `latitude` VARCHAR(15) NOT NULL,
  `longitude` VARCHAR(15) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `addressNumber` VARCHAR(6) NOT NULL,
  `addressOptional` VARCHAR(15) NULL,
  `status` VARCHAR(1) NULL,
  `dtCreated` DATETIME DEFAULT now(),
  `dtUpdated` DATETIME NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC) ,
  INDEX `fk_tb_estabelecimentos_tb_usuarios1_idx` (`idUsuario` ASC) ,
  CONSTRAINT `fk_tb_estabelecimentos_tb_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `delivery`.`tb_usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery`.`tb_categorias` ;

CREATE TABLE IF NOT EXISTS `delivery`.`tb_categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(110) NULL,
  `dtCreated` DATETIME DEFAULT now(),
  `dtModified` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_produtos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery`.`tb_produtos` ;

CREATE TABLE IF NOT EXISTS `delivery`.`tb_produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(120) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `price` DOUBLE NOT NULL,
  `status` VARCHAR(1) NOT NULL,
  `dtCreated` DATETIME DEFAULT now(),
  `dtModified` DATETIME NULL,
  `idCategoria` INT NOT NULL,
  `idEstabelecimento` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_produtos_tb_categorias1_idx` (`idCategoria` ASC) ,
  INDEX `fk_tb_produtos_tb_estabelecimentos1_idx` (`idEstabelecimento` ASC) ,
  CONSTRAINT `fk_tb_produtos_tb_categorias1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `delivery`.`tb_categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_produtos_tb_estabelecimentos1`
    FOREIGN KEY (`idEstabelecimento`)
    REFERENCES `delivery`.`tb_estabelecimentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`.`tb_pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery`.`tb_pedidos` ;

CREATE TABLE IF NOT EXISTS `delivery`.`tb_pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(1) NOT NULL,
  `dtCreated` DATETIME DEFAULT now(),
  `dtModified` DATETIME NULL,
  `idUsuario` INT NOT NULL,
  `idProduto` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_pedidos_tb_usuarios1_idx` (`idUsuario` ASC) ,
  INDEX `fk_tb_pedidos_tb_produtos1_idx` (`idProduto` ASC) ,
  CONSTRAINT `fk_tb_pedidos_tb_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `delivery`.`tb_usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_pedidos_tb_produtos1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `delivery`.`tb_produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
