SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_spotify` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db_spotify` ;

-- -----------------------------------------------------
-- Table `db_spotify`.`tabela5`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`tabela5` (
  `description` VARCHAR(5000) NULL DEFAULT NULL,
  `id` VARCHAR(45) NOT NULL,
  `total_episodes` INT NULL DEFAULT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_spotify`.`tabela6`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`tabela6` (
  `id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(200) NULL DEFAULT NULL,
  `description` VARCHAR(2000) NULL DEFAULT NULL,
  `release_date` DATETIME NULL DEFAULT NULL,
  `duration_ms` INT NULL DEFAULT NULL,
  `language` VARCHAR(45) NULL DEFAULT NULL,
  `explicit` TINYINT NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_spotify`.`tabela7`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`tabela7` (
  `id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(200) NULL DEFAULT NULL,
  `description` VARCHAR(2000) NULL DEFAULT NULL,
  `release_date` DATETIME NULL DEFAULT NULL,
  `duration_ms` INT NULL DEFAULT NULL,
  `language` VARCHAR(45) NULL DEFAULT NULL,
  `explicit` TINYINT NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
