SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_vendas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_vendas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_vendas` DEFAULT CHARACTER SET utf8 ;
USE `db_vendas` ;

-- -----------------------------------------------------
-- Table `db_vendas`.`linha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_vendas`.`linha` (
  `id_linha` INT NOT NULL AUTO_INCREMENT,
  `linha` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_linha`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `db_vendas`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_vendas`.`marca` (
  `id_marca` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_marca`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `db_vendas`.`tabela1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_vendas`.`tabela1` (
  `ano` INT NOT NULL,
  `mes` INT NOT NULL,
  `qtd` INT NOT NULL,
  PRIMARY KEY (`ano`, `mes`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `db_vendas`.`tabela2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_vendas`.`tabela2` (
  `idMarca` INT NOT NULL,
  `idLinha` INT NOT NULL,
  `qtd` INT NOT NULL,
  PRIMARY KEY (`idMarca`, `idLinha`),
  INDEX `fk_tabela2_linha_idx` (`idLinha` ASC) VISIBLE,
  CONSTRAINT `fk_tabela2_linha`
    FOREIGN KEY (`idLinha`)
    REFERENCES `db_vendas`.`linha` (`id_linha`),
  CONSTRAINT `fk_tabela2_marca`
    FOREIGN KEY (`idMarca`)
    REFERENCES `db_vendas`.`marca` (`id_marca`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `db_vendas`.`tabela3`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_vendas`.`tabela3` (
  `idMarca` INT NOT NULL,
  `ano` INT NOT NULL,
  `mes` INT NOT NULL,
  `qtd` INT NOT NULL,
  PRIMARY KEY (`idMarca`, `ano`, `mes`),
  CONSTRAINT `fk_tabela3_marca`
    FOREIGN KEY (`idMarca`)
    REFERENCES `db_vendas`.`marca` (`id_marca`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `db_vendas`.`tabela4`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_vendas`.`tabela4` (
  `idLinha` INT NOT NULL,
  `ano` INT NOT NULL,
  `mes` INT NOT NULL,
  `qtd` INT NOT NULL,
  PRIMARY KEY (`idLinha`, `ano`, `mes`),
  CONSTRAINT `fk_tabela4_linha`
    FOREIGN KEY (`idLinha`)
    REFERENCES `db_vendas`.`linha` (`id_linha`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
