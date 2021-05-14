-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PrePro1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PrePro1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PrePro1` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema Steam
-- -----------------------------------------------------
USE `PrePro1` ;

-- -----------------------------------------------------
-- Table `PrePro1`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Countries` (
  `countryId` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(64) NOT NULL,
  PRIMARY KEY (`countryId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Users` (
  `userid` BIGINT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(64) NOT NULL,
  `lastname` NVARCHAR(64) NOT NULL,
  `password` VARBINARY(200) NOT NULL,
  `mail` NVARCHAR(128) NOT NULL,
  `birthdate` DATE NOT NULL,
  `countryId` SMALLINT NOT NULL,
  PRIMARY KEY (`userid`),
  INDEX `fk_Users_Countries2_idx` (`countryId` ASC) VISIBLE,
  CONSTRAINT `fk_Users_Countries2`
    FOREIGN KEY (`countryId`)
    REFERENCES `PrePro1`.`Countries` (`countryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Publishers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Publishers` (
  `publisherId` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(128) NOT NULL,
  `company_name` NVARCHAR(256) NOT NULL,
  `countryId` SMALLINT NOT NULL,
  `mail` NVARCHAR(128) NOT NULL,
  `webSiteURL` NVARCHAR(128) NULL,
  PRIMARY KEY (`publisherId`),
  INDEX `fk_Publishers_Countries1_idx` (`countryId` ASC) VISIBLE,
  CONSTRAINT `fk_Publishers_Countries1`
    FOREIGN KEY (`countryId`)
    REFERENCES `PrePro1`.`Countries` (`countryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Badges_Levels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Badges_Levels` (
  `badge_levelId` TINYINT NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`badge_levelId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`ESRB_Clasification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`ESRB_Clasification` (
  `ESRB_ClasificationId` TINYINT NOT NULL AUTO_INCREMENT,
  `ageBegin` TINYINT NOT NULL,
  `description` NVARCHAR(128) NOT NULL,
  PRIMARY KEY (`ESRB_ClasificationId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`GenderType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`GenderType` (
  `idGenderType` TINYINT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idGenderType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Games`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Games` (
  `Gameid` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(64) NOT NULL,
  `description` NVARCHAR(2048) NOT NULL,
  `iconURL` NVARCHAR(128) NOT NULL,
  `URL` NVARCHAR(128) NOT NULL,
  `enabled` BIT NOT NULL DEFAULT 1,
  `ESRB_ClasificationId` TINYINT NOT NULL,
  `idGenderType` TINYINT NOT NULL,
  PRIMARY KEY (`Gameid`),
  INDEX `fk_Games_ESRB_Clasification1_idx` (`ESRB_ClasificationId` ASC) VISIBLE,
  INDEX `fk_Games_GenderType1_idx` (`idGenderType` ASC) VISIBLE,
  CONSTRAINT `fk_Games_ESRB_Clasification1`
    FOREIGN KEY (`ESRB_ClasificationId`)
    REFERENCES `PrePro1`.`ESRB_Clasification` (`ESRB_ClasificationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Games_GenderType1`
    FOREIGN KEY (`idGenderType`)
    REFERENCES `PrePro1`.`GenderType` (`idGenderType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Badges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Badges` (
  `badgeId` BIGINT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(128) NOT NULL,
  `Gameid` INT NOT NULL,
  `iconURL` NVARCHAR(128) NOT NULL,
  `miniDescription` NVARCHAR(256) NULL DEFAULT NULL,
  `badge_levelId` TINYINT NOT NULL,
  PRIMARY KEY (`badgeId`),
  INDEX `fk_Badges_Badges_Levels1_idx` (`badge_levelId` ASC) VISIBLE,
  INDEX `fk_Badges_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_Badges_Badges_Levels1`
    FOREIGN KEY (`badge_levelId`)
    REFERENCES `PrePro1`.`Badges_Levels` (`badge_levelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Badges_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Games_Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Games_Categories` (
  `game_categoryId` TINYINT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(32) NOT NULL,
  `description` NVARCHAR(128) NOT NULL,
  PRIMARY KEY (`game_categoryId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`in-store_game_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`in-store_game_info` (
  `storeId` BIGINT NOT NULL,
  `price` DOUBLE(6,2) NOT NULL DEFAULT 0,
  `discount` DOUBLE(5,2) NOT NULL DEFAULT 0,
  `ranking` DOUBLE(2,1) NOT NULL DEFAULT 0,
  `enabled` BIT NOT NULL DEFAULT 1,
  `publisher_price` DOUBLE(5,2) GENERATED ALWAYS AS (100.00) VIRTUAL,
  PRIMARY KEY (`storeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Games`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Games` (
  `Gameid` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(64) NOT NULL,
  `description` NVARCHAR(2048) NOT NULL,
  `iconURL` NVARCHAR(128) NOT NULL,
  `URL` NVARCHAR(128) NOT NULL,
  `enabled` BIT NOT NULL DEFAULT 1,
  `ESRB_ClasificationId` TINYINT NOT NULL,
  `idGenderType` TINYINT NOT NULL,
  PRIMARY KEY (`Gameid`),
  INDEX `fk_Games_ESRB_Clasification1_idx` (`ESRB_ClasificationId` ASC) VISIBLE,
  INDEX `fk_Games_GenderType1_idx` (`idGenderType` ASC) VISIBLE,
  CONSTRAINT `fk_Games_ESRB_Clasification1`
    FOREIGN KEY (`ESRB_ClasificationId`)
    REFERENCES `PrePro1`.`ESRB_Clasification` (`ESRB_ClasificationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Games_GenderType1`
    FOREIGN KEY (`idGenderType`)
    REFERENCES `PrePro1`.`GenderType` (`idGenderType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`pictures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`pictures` (
  `pictureId` BIGINT NOT NULL AUTO_INCREMENT,
  `pictureURL` NVARCHAR(128) NOT NULL,
  `deleted` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`pictureId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`pictures_per_game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`pictures_per_game` (
  `pictureId` BIGINT NOT NULL,
  `Gameid` INT NOT NULL,
  INDEX `fk_pictures_per_game_pictures1_idx` (`pictureId` ASC) VISIBLE,
  INDEX `fk_pictures_per_game_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_pictures_per_game_pictures1`
    FOREIGN KEY (`pictureId`)
    REFERENCES `PrePro1`.`pictures` (`pictureId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pictures_per_game_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Users` (
  `userid` BIGINT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(64) NOT NULL,
  `lastname` NVARCHAR(64) NOT NULL,
  `password` VARBINARY(200) NOT NULL,
  `mail` NVARCHAR(128) NOT NULL,
  `birthdate` DATE NOT NULL,
  `countryId` SMALLINT NOT NULL,
  PRIMARY KEY (`userid`),
  INDEX `fk_Users_Countries2_idx` (`countryId` ASC) VISIBLE,
  CONSTRAINT `fk_Users_Countries2`
    FOREIGN KEY (`countryId`)
    REFERENCES `PrePro1`.`Countries` (`countryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Game_Sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Game_Sessions` (
  `game_session_id` BIGINT NOT NULL AUTO_INCREMENT,
  `userid` BIGINT NOT NULL,
  `Gameid` INT NOT NULL,
  `start` DATETIME NOT NULL,
  `finish` DATETIME NOT NULL,
  `favorite` BIT NOT NULL DEFAULT 0,
  `isPublic` BIT NOT NULL DEFAULT 0,
  `deleted` BIT NOT NULL DEFAULT 0,
  `captureURL` NVARCHAR(128) NULL DEFAULT NULL,
  PRIMARY KEY (`game_session_id`),
  INDEX `fk_Game_Sessions_Users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_Game_Sessions_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_Game_Sessions_Users1`
    FOREIGN KEY (`userid`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Game_Sessions_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`picturePerPerson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`picturePerPerson` (
  `default` BIT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `pictureId` BIGINT NOT NULL,
  `userid` BIGINT NOT NULL,
  INDEX `fk_picturePerPerson_pictures1_idx` (`pictureId` ASC) VISIBLE,
  INDEX `fk_picturePerPerson_Users1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_picturePerPerson_pictures1`
    FOREIGN KEY (`pictureId`)
    REFERENCES `PrePro1`.`pictures` (`pictureId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_picturePerPerson_Users1`
    FOREIGN KEY (`userid`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Languages` (
  `languageId` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(32) NOT NULL,
  `culture` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`languageId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Contexts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Contexts` (
  `contextId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`contextId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Translations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Translations` (
  `translationId` BIGINT NOT NULL AUTO_INCREMENT,
  `translationCode` BIGINT NOT NULL,
  `languageId` SMALLINT NOT NULL,
  `contextId` INT NOT NULL,
  `referenceId` BIGINT NOT NULL,
  `caption` NVARCHAR(128) NOT NULL DEFAULT 'text',
  PRIMARY KEY (`translationId`),
  INDEX `fk_Translations_Contexts1_idx` (`contextId` ASC) VISIBLE,
  INDEX `fk_Translations_Languages1_idx` (`languageId` ASC) VISIBLE,
  CONSTRAINT `fk_Translations_Contexts1`
    FOREIGN KEY (`contextId`)
    REFERENCES `PrePro1`.`Contexts` (`contextId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Translations_Languages1`
    FOREIGN KEY (`languageId`)
    REFERENCES `PrePro1`.`Languages` (`languageId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Store` (
  `storeId` BIGINT NOT NULL AUTO_INCREMENT,
  `about` NVARCHAR(4096) NULL,
  `title` NVARCHAR(64) NOT NULL,
  `defautlLanguageId` SMALLINT NOT NULL,
  PRIMARY KEY (`storeId`),
  INDEX `fk_Store_Languages1_idx` (`defautlLanguageId` ASC) VISIBLE,
  CONSTRAINT `fk_Store_Languages1`
    FOREIGN KEY (`defautlLanguageId`)
    REFERENCES `PrePro1`.`Languages` (`languageId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Games_has_store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Games_has_store` (
  `storeId` BIGINT NOT NULL,
  `default` BIT NOT NULL,
  `posttime` DATETIME NOT NULL,
  `Gameid` INT NOT NULL,
  INDEX `fk_Games_has_store_Store1_idx` (`storeId` ASC) VISIBLE,
  INDEX `fk_Games_has_store_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_Games_has_store_Store1`
    FOREIGN KEY (`storeId`)
    REFERENCES `PrePro1`.`Store` (`storeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Games_has_store_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`EntityTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`EntityTypes` (
  `entityTypeId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`entityTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Severity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Severity` (
  `severityId` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`severityId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`AppSources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`AppSources` (
  `appSourceId` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`appSourceId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`LogTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`LogTypes` (
  `logTypeId` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`logTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Logs` (
  `logId` BIGINT NOT NULL AUTO_INCREMENT,
  `posttime` DATETIME NOT NULL,
  `description` NVARCHAR(256) NULL,
  `computerName` VARCHAR(64) NOT NULL,
  `userName` NVARCHAR(64) NOT NULL,
  `ipAdress` VARBINARY(32) NOT NULL,
  `refId1` BIGINT NULL,
  `refId2` BIGINT NULL,
  `oldValue` NVARCHAR(200) NULL,
  `newValue` NVARCHAR(200) NULL,
  `checksum` VARBINARY(256) NOT NULL,
  `entityTypeId` INT NOT NULL,
  `severityId` SMALLINT NOT NULL,
  `appSourceId` SMALLINT NOT NULL,
  `logTypeId` SMALLINT NOT NULL,
  PRIMARY KEY (`logId`),
  INDEX `fk_Logs_EntityTypes1_idx` (`entityTypeId` ASC) VISIBLE,
  INDEX `fk_Logs_Severity1_idx` (`severityId` ASC) VISIBLE,
  INDEX `fk_Logs_AppSources1_idx` (`appSourceId` ASC) VISIBLE,
  INDEX `fk_Logs_LogTypes1_idx` (`logTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_Logs_EntityTypes1`
    FOREIGN KEY (`entityTypeId`)
    REFERENCES `PrePro1`.`EntityTypes` (`entityTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logs_Severity1`
    FOREIGN KEY (`severityId`)
    REFERENCES `PrePro1`.`Severity` (`severityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logs_AppSources1`
    FOREIGN KEY (`appSourceId`)
    REFERENCES `PrePro1`.`AppSources` (`appSourceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logs_LogTypes1`
    FOREIGN KEY (`logTypeId`)
    REFERENCES `PrePro1`.`LogTypes` (`logTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Merchants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Merchants` (
  `merchantId` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `URL` NVARCHAR(128) NOT NULL,
  `enabled` BIT NOT NULL DEFAULT 1,
  `iconURL` NVARCHAR(128) NOT NULL,
  PRIMARY KEY (`merchantId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`item_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`item_category` (
  `item_category_Id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`item_category_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Gifts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Gifts` (
  `giftId` BIGINT NOT NULL AUTO_INCREMENT,
  `description` NVARCHAR(256) NULL,
  `date` DATETIME NOT NULL,
  `item_category_Id` TINYINT NOT NULL,
  `idToPay` BIGINT NOT NULL,
  `toId` BIGINT NOT NULL,
  `fromId` BIGINT NOT NULL,
  PRIMARY KEY (`giftId`),
  INDEX `fk_Gifts_item_category1_idx` (`item_category_Id` ASC) VISIBLE,
  INDEX `fk_Gifts_Users1_idx` (`toId` ASC) VISIBLE,
  INDEX `fk_Gifts_Users2_idx` (`fromId` ASC) VISIBLE,
  CONSTRAINT `fk_Gifts_item_category1`
    FOREIGN KEY (`item_category_Id`)
    REFERENCES `PrePro1`.`item_category` (`item_category_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gifts_Users1`
    FOREIGN KEY (`toId`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gifts_Users2`
    FOREIGN KEY (`fromId`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`RelationshipTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`RelationshipTypes` (
  `relationshipTypeId` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`relationshipTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Relationships` (
  `relationshipId` BIGINT NOT NULL AUTO_INCREMENT,
  `posttime` DATETIME NOT NULL,
  `isPublic` BIT NOT NULL DEFAULT 1,
  `relationshipTypeId` TINYINT NOT NULL,
  `userid` BIGINT NOT NULL,
  `otherUserId` BIGINT NOT NULL,
  PRIMARY KEY (`relationshipId`),
  INDEX `fk_Relationships_RelationshipTypes1_idx` (`relationshipTypeId` ASC) VISIBLE,
  INDEX `fk_Relationships_Users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_Relationships_Users2_idx` (`otherUserId` ASC) VISIBLE,
  CONSTRAINT `fk_Relationships_RelationshipTypes1`
    FOREIGN KEY (`relationshipTypeId`)
    REFERENCES `PrePro1`.`RelationshipTypes` (`relationshipTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Relationships_Users1`
    FOREIGN KEY (`userid`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Relationships_Users2`
    FOREIGN KEY (`otherUserId`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`GameOwnSpecs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`GameOwnSpecs` (
  `gameOwnSpecsId` BIGINT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(64) NOT NULL,
  `description` NVARCHAR(256) NOT NULL,
  `Gameid` INT NOT NULL,
  PRIMARY KEY (`gameOwnSpecsId`),
  INDEX `fk_GameOwnSpecs_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_GameOwnSpecs_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Experiences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Experiences` (
  `experienceId` BIGINT NOT NULL AUTO_INCREMENT,
  `totalHoursPlayed` INT NOT NULL,
  `userRaiting` DOUBLE(2,1) NULL DEFAULT 0.0,
  `totalBadges` SMALLINT NULL DEFAULT 0,
  `level` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `userid` BIGINT NOT NULL,
  `Gameid` INT NOT NULL,
  PRIMARY KEY (`experienceId`),
  INDEX `fk_Experiences_Users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_Experiences_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_Experiences_Users1`
    FOREIGN KEY (`userid`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Experiences_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Events` (
  `eventId` BIGINT NOT NULL AUTO_INCREMENT,
  `Gameid` INT NOT NULL,
  `title` NVARCHAR(64) NOT NULL,
  `start` DATETIME NOT NULL,
  `end` DATETIME NULL DEFAULT NULL,
  `description` NVARCHAR(512) NULL DEFAULT NULL,
  `userslikes` INT NOT NULL,
  `imageURL` NVARCHAR(128) NULL DEFAULT NULL,
  `webURL` NVARCHAR(128) NULL DEFAULT NULL,
  PRIMARY KEY (`eventId`),
  INDEX `fk_Events_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_Events_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`TransTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`TransTypes` (
  `transTypeId` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`transTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`PurchaseOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`PurchaseOrder` (
  `idPurchaseOrder` BIGINT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(12,2) NOT NULL,
  `quantity` SMALLINT NOT NULL,
  `mail` NVARCHAR(128) NOT NULL,
  `date` DATETIME NOT NULL,
  `item_category_Id` TINYINT NOT NULL,
  `idForOrder` BIGINT NOT NULL,
  `buyerId` BIGINT NOT NULL,
  `itemForId` BIGINT NOT NULL,
  PRIMARY KEY (`idPurchaseOrder`),
  INDEX `fk_PurchaseOrder_item_category1_idx` (`item_category_Id` ASC) VISIBLE,
  INDEX `fk_PurchaseOrder_Users1_idx` (`buyerId` ASC) VISIBLE,
  INDEX `fk_PurchaseOrder_Users2_idx` (`itemForId` ASC) VISIBLE,
  CONSTRAINT `fk_PurchaseOrder_item_category1`
    FOREIGN KEY (`item_category_Id`)
    REFERENCES `PrePro1`.`item_category` (`item_category_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PurchaseOrder_Users1`
    FOREIGN KEY (`buyerId`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PurchaseOrder_Users2`
    FOREIGN KEY (`itemForId`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`PaymentStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`PaymentStatus` (
  `idPaymentStatus` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`idPaymentStatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`PaymentsAttempts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`PaymentsAttempts` (
  `paymentAttemptId` BIGINT NOT NULL AUTO_INCREMENT,
  `posttime` DATETIME NOT NULL,
  `amount` DOUBLE NOT NULL,
  `currencySymbol` VARCHAR(5) NOT NULL,
  `referenceNumber` BIGINT NULL DEFAULT NULL,
  `errorNumber` INT NULL DEFAULT NULL,
  `articleTransNumber` BIGINT NOT NULL,
  `description` NVARCHAR(350) NOT NULL,
  `username` NVARCHAR(64) NOT NULL,
  `ipAddress` VARBINARY(32) NOT NULL,
  `checksum` VARBINARY(256) NOT NULL,
  `computerName` NVARCHAR(64) NOT NULL,
  `idToPay` BIGINT NOT NULL,
  `merchantId` TINYINT NOT NULL,
  `item_category_Id` TINYINT NOT NULL,
  `idPaymentStatus` TINYINT NOT NULL,
  `userid` BIGINT NOT NULL,
  PRIMARY KEY (`paymentAttemptId`),
  INDEX `fk_PaymentsAttempts_Merchants1_idx` (`merchantId` ASC) VISIBLE,
  INDEX `fk_PaymentsAttempts_item_category1_idx` (`item_category_Id` ASC) VISIBLE,
  INDEX `fk_PaymentsAttempts_PaymentStatus1_idx` (`idPaymentStatus` ASC) VISIBLE,
  INDEX `fk_PaymentsAttempts_Users1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_PaymentsAttempts_Merchants1`
    FOREIGN KEY (`merchantId`)
    REFERENCES `PrePro1`.`Merchants` (`merchantId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PaymentsAttempts_item_category1`
    FOREIGN KEY (`item_category_Id`)
    REFERENCES `PrePro1`.`item_category` (`item_category_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PaymentsAttempts_PaymentStatus1`
    FOREIGN KEY (`idPaymentStatus`)
    REFERENCES `PrePro1`.`PaymentStatus` (`idPaymentStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PaymentsAttempts_Users1`
    FOREIGN KEY (`userid`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Transactions` (
  `idTransactions` BIGINT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) NOT NULL,
  `posttime` DATETIME NOT NULL,
  `description` NVARCHAR(128) NOT NULL,
  `transTypeId` SMALLINT NOT NULL,
  `username` NVARCHAR(64) NOT NULL,
  `computerName` NVARCHAR(64) NOT NULL,
  `ipAddress` VARBINARY(32) NOT NULL,
  `checksum` VARBINARY(300) NOT NULL,
  `idPurchaseOrder` BIGINT NOT NULL,
  `paymentAttemptId` BIGINT NOT NULL,
  PRIMARY KEY (`idTransactions`),
  INDEX `fk_Transactions_TransTypes1_idx` (`transTypeId` ASC) VISIBLE,
  INDEX `fk_Transactions_PurchaseOrder1_idx` (`idPurchaseOrder` ASC) VISIBLE,
  INDEX `fk_Transactions_PaymentsAttempts1_idx` (`paymentAttemptId` ASC) VISIBLE,
  CONSTRAINT `fk_Transactions_TransTypes1`
    FOREIGN KEY (`transTypeId`)
    REFERENCES `PrePro1`.`TransTypes` (`transTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transactions_PurchaseOrder1`
    FOREIGN KEY (`idPurchaseOrder`)
    REFERENCES `PrePro1`.`PurchaseOrder` (`idPurchaseOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transactions_PaymentsAttempts1`
    FOREIGN KEY (`paymentAttemptId`)
    REFERENCES `PrePro1`.`PaymentsAttempts` (`paymentAttemptId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Wish_States`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Wish_States` (
  `wish_State_Id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`wish_State_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Actions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Actions` (
  `actionId` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`actionId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Game_Logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Game_Logs` (
  `game_Log_Id` BIGINT NOT NULL AUTO_INCREMENT,
  `posttime` DATETIME NOT NULL,
  `ipAddress` VARBINARY(32) NOT NULL,
  `actionId` TINYINT NOT NULL,
  `game_session_id` BIGINT NOT NULL,
  PRIMARY KEY (`game_Log_Id`),
  INDEX `fk_Game_Logs_Action1_idx` (`actionId` ASC) VISIBLE,
  INDEX `fk_Game_Logs_Game_Sessions1_idx` (`game_session_id` ASC) VISIBLE,
  CONSTRAINT `fk_Game_Logs_Action1`
    FOREIGN KEY (`actionId`)
    REFERENCES `PrePro1`.`Actions` (`actionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Game_Logs_Game_Sessions1`
    FOREIGN KEY (`game_session_id`)
    REFERENCES `PrePro1`.`Game_Sessions` (`game_session_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`BadgesPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`BadgesPerUser` (
  `achievementDate` DATETIME NOT NULL,
  `badgeId` BIGINT NOT NULL,
  `userid` BIGINT NOT NULL,
  INDEX `fk_BadgesPerUser_Badges1_idx` (`badgeId` ASC) VISIBLE,
  INDEX `fk_BadgesPerUser_Users1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_BadgesPerUser_Badges1`
    FOREIGN KEY (`badgeId`)
    REFERENCES `PrePro1`.`Badges` (`badgeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BadgesPerUser_Users1`
    FOREIGN KEY (`userid`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`GameSaleInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`GameSaleInfo` (
  `Gameid` INT NOT NULL,
  `publisherId` INT NOT NULL,
  `retailPrice` DOUBLE(12,2) NOT NULL,
  `currencySymbol` VARCHAR(5) NOT NULL,
  `discount` DOUBLE(3,2) NOT NULL DEFAULT 0.0,
  `publisher_percentage` DOUBLE(3,2) NOT NULL DEFAULT 1.00,
  `isCurrentRunning` BIT NOT NULL DEFAULT 0,
  `posttime` DATETIME NOT NULL,
  `checksum` VARBINARY(300) NOT NULL,
  `ipAddress` VARBINARY(32) NOT NULL,
  `username` NVARCHAR(64) NOT NULL,
  INDEX `fk_GameSaleInfo_Publishers1_idx` (`publisherId` ASC) VISIBLE,
  INDEX `fk_GameSaleInfo_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_GameSaleInfo_Publishers1`
    FOREIGN KEY (`publisherId`)
    REFERENCES `PrePro1`.`Publishers` (`publisherId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GameSaleInfo_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`FiltersTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`FiltersTypes` (
  `filterTypeId` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `value1` BIGINT NOT NULL,
  `value2` BIGINT NULL DEFAULT NULL,
  `isAlive` BIT NOT NULL DEFAULT 0,
  `storeId` BIGINT NOT NULL,
  PRIMARY KEY (`filterTypeId`),
  INDEX `fk_FiltersTypes_Store1_idx` (`storeId` ASC) VISIBLE,
  CONSTRAINT `fk_FiltersTypes_Store1`
    FOREIGN KEY (`storeId`)
    REFERENCES `PrePro1`.`Store` (`storeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`GameVideos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`GameVideos` (
  `idGameVideo` INT NOT NULL AUTO_INCREMENT,
  `URL` NVARCHAR(128) NOT NULL,
  `enabled` BIT NOT NULL DEFAULT 1,
  `Gameid` INT NOT NULL,
  PRIMARY KEY (`idGameVideo`),
  INDEX `fk_GameVideos_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_GameVideos_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`PlatformsType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`PlatformsType` (
  `idPlatformType` TINYINT NOT NULL AUTO_INCREMENT,
  `platform` NVARCHAR(32) NOT NULL,
  PRIMARY KEY (`idPlatformType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Statistics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Statistics` (
  `idStatistics` INT NOT NULL AUTO_INCREMENT,
  `salesCount` INT NOT NULL,
  `acquiredMoney` DOUBLE(12,2) NOT NULL DEFAULT 0.0,
  `hoursPlayed` BIGINT NOT NULL,
  `giftedCount` INT NULL DEFAULT NULL,
  `Gameid` INT NOT NULL,
  PRIMARY KEY (`idStatistics`),
  INDEX `fk_Statistics_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_Statistics_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Reviews` (
  `idReviews` INT NOT NULL AUTO_INCREMENT,
  `userid` BIGINT NOT NULL,
  `Gameid` INT NOT NULL,
  `votes` INT NOT NULL,
  `comment` NVARCHAR(4096) NULL DEFAULT NULL,
  `date` DATETIME NOT NULL,
  `deleted` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idReviews`),
  INDEX `fk_Reviews_Users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_Reviews_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_Reviews_Users1`
    FOREIGN KEY (`userid`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reviews_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Wish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Wish` (
  `idWish` BIGINT NOT NULL AUTO_INCREMENT,
  `userid` BIGINT NOT NULL,
  `Gameid` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `wish_State_Id` TINYINT NOT NULL,
  PRIMARY KEY (`idWish`),
  INDEX `fk_Wish_Wish_States1_idx` (`wish_State_Id` ASC) VISIBLE,
  INDEX `fk_Wish_Users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_Wish_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_Wish_Wish_States1`
    FOREIGN KEY (`wish_State_Id`)
    REFERENCES `PrePro1`.`Wish_States` (`wish_State_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Wish_Users1`
    FOREIGN KEY (`userid`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Wish_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`GamesPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`GamesPerUser` (
  `userid` BIGINT NOT NULL,
  `Gameid` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `hoursPlayed` INT NOT NULL,
  `idPurchaseOrder` BIGINT NOT NULL,
  INDEX `fk_GamesPerUser_PurchaseOrder1_idx` (`idPurchaseOrder` ASC) VISIBLE,
  INDEX `fk_GamesPerUser_Users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_GamesPerUser_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_GamesPerUser_PurchaseOrder1`
    FOREIGN KEY (`idPurchaseOrder`)
    REFERENCES `PrePro1`.`PurchaseOrder` (`idPurchaseOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GamesPerUser_Users1`
    FOREIGN KEY (`userid`)
    REFERENCES `PrePro1`.`Users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GamesPerUser_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PrePro1`.`Game_Platforms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PrePro1`.`Game_Platforms` (
  `Gameid` INT NOT NULL,
  `idPlatformType` TINYINT NOT NULL,
  INDEX `fk_Game_Platforms_PlatformsType1_idx` (`idPlatformType` ASC) VISIBLE,
  INDEX `fk_Game_Platforms_Games1_idx` (`Gameid` ASC) VISIBLE,
  CONSTRAINT `fk_Game_Platforms_PlatformsType1`
    FOREIGN KEY (`idPlatformType`)
    REFERENCES `PrePro1`.`PlatformsType` (`idPlatformType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Game_Platforms_Games1`
    FOREIGN KEY (`Gameid`)
    REFERENCES `PrePro1`.`Games` (`Gameid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
