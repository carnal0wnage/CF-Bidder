SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `Bidder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bidder` ;

CREATE  TABLE IF NOT EXISTS `Bidder` (
  `username` VARCHAR(50) NOT NULL ,
  `password` VARCHAR(50) NOT NULL ,
  `fullname` VARCHAR(250) NULL DEFAULT NULL ,
  `address` VARCHAR(250) NULL DEFAULT NULL ,
  `city` VARCHAR(50) NULL DEFAULT NULL ,
  `state` VARCHAR(2) NULL DEFAULT NULL ,
  `zip` VARCHAR(5) NULL DEFAULT NULL ,
  `phone` VARCHAR(50) NULL DEFAULT NULL ,
  `email` VARCHAR(250) NULL DEFAULT NULL ,
  PRIMARY KEY (`username`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Category` ;

CREATE  TABLE IF NOT EXISTS `Category` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Item` ;

CREATE  TABLE IF NOT EXISTS `Item` (
  `id` INT(11) NOT NULL ,
  `category_id` INT(11) NOT NULL ,
  `name` VARCHAR(100) NULL DEFAULT NULL ,
  `description` TEXT NULL DEFAULT NULL ,
  `photo_file` VARCHAR(100) NULL DEFAULT NULL ,
  `bid_amount` INT(11) NOT NULL ,
  `minimum_bid` INT(11) NOT NULL ,
  `bidder_id` VARCHAR(50) NULL DEFAULT NULL ,
  `status` TINYINT(1) NULL DEFAULT NULL ,
  `maximum_bid` INT(11) NOT NULL ,
  `close_time` DATETIME NULL DEFAULT NULL ,
  `submitter_name` VARCHAR(255) NULL DEFAULT NULL ,
  `submitter_phone` VARCHAR(50) NULL DEFAULT NULL ,
  `date_paid` DATE NULL DEFAULT NULL ,
  `checkno` VARCHAR(10) NULL DEFAULT NULL ,
  `cash` VARCHAR(10) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `item_cat_id` (`category_id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `Log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Log` ;

CREATE  TABLE IF NOT EXISTS `Log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `item_id` INT(11) NOT NULL ,
  `bid_amount` INT(11) NOT NULL ,
  `bidder_id` VARCHAR(50) NOT NULL ,
  `bid_date` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `log_item` (`item_id` ASC) )
ENGINE = MyISAM
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `Master`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Master` ;

CREATE  TABLE IF NOT EXISTS `Master` (
  `mst_no` INT(11) NOT NULL ,
  `mst_password` VARCHAR(50) NULL DEFAULT NULL ,
  `mst_status` TINYINT(1) NOT NULL ,
  `mst_close_time` DATETIME NULL DEFAULT NULL ,
  `mst_open_time` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`mst_no`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Insert default records
-- -----------------------------------------------------
INSERT INTO `Master` (mst_no,mst_password,mst_status,mst_close_time,mst_open_time) VALUES (1,'bid',0,NULL,NULL);
INSERT INTO `Category` (name) VALUES ('Clothing');
INSERT INTO `Category` (name) VALUES ('Entertainment');
INSERT INTO `Category` (name) VALUES ('Gift Cards/Certificates');
INSERT INTO `Category` (name) VALUES ('Household');
INSERT INTO `Category` (name) VALUES ('Miscellaneous');
INSERT INTO `Category` (name) VALUES ('Services');
INSERT INTO `Category` (name) VALUES ('Sports');
