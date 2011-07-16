SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `slms` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `slms` ;

-- -----------------------------------------------------
-- Table `slms`.`config_tbl`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`config_tbl` ;

CREATE  TABLE IF NOT EXISTS `slms`.`config_tbl` (
  `max_sl` INT(11) NOT NULL ,
  `max_cl` INT(11) NOT NULL ,
  `el_12_mnths` DECIMAL(4,2) NOT NULL ,
  `el_24_mnths` DECIMAL(4,2) NOT NULL ,
  `el_36_mnths` DECIMAL(4,2) NOT NULL ,
  `el_48_mnths` DECIMAL(4,2) NOT NULL ,
  `el_60_mnths` DECIMAL(4,2) NOT NULL ,
  `el_72_mnths` DECIMAL(4,2) NOT NULL ,
  `el_84_mnths` DECIMAL(4,2) NOT NULL ,
  `el_96_mnths` DECIMAL(4,2) NOT NULL ,
  `el_108_mnths` DECIMAL(4,2) NOT NULL ,
  `el_120_mnths` DECIMAL(4,2) NOT NULL ,
  `el_120_plus` DECIMAL(4,2) NOT NULL ,
  `el_cf_allow` CHAR(2) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `sl_cf_allow` CHAR(2) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `cl_cf_allow` CHAR(2) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `max_el_cf` INT(11) NOT NULL ,
  `max_sl_cf` INT(11) NOT NULL ,
  `max_cl_cf` INT(11) NOT NULL ,
  `last_year_month` CHAR(4) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `slms`.`leave_application`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`leave_application` ;

CREATE  TABLE IF NOT EXISTS `slms`.`leave_application` (
  `leave_id` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `current_Status` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  UNIQUE INDEX `leave_id` (`leave_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `slms`.`leave_approved`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`leave_approved` ;

CREATE  TABLE IF NOT EXISTS `slms`.`leave_approved` (
  `leave_id` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `approved_by` CHAR(6) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `approved_on` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  UNIQUE INDEX `leave_id` (`leave_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `slms`.`leave_rejected`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`leave_rejected` ;

CREATE  TABLE IF NOT EXISTS `slms`.`leave_rejected` (
  `leave_id` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `rejected_by` CHAR(6) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `rejected_on` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `reject_reason` VARCHAR(250) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  PRIMARY KEY (`leave_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `slms`.`leave_reapplied`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`leave_reapplied` ;

CREATE  TABLE IF NOT EXISTS `slms`.`leave_reapplied` (
  `leave_id` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `new_leave_id` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  UNIQUE INDEX `leave_id` (`leave_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `slms`.`leave_taken`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`leave_taken` ;

CREATE  TABLE IF NOT EXISTS `slms`.`leave_taken` (
  `leave_id` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `rec_moved_on` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`leave_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `slms`.`leave_master`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`leave_master` ;

CREATE  TABLE IF NOT EXISTS `slms`.`leave_master` (
  `sno` INT(11) NOT NULL AUTO_INCREMENT ,
  `leave_id` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `emp_id` CHAR(6) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `leave_type` CHAR(2) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `leave_applied_on` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `leave_start_date` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `num_of_days` DECIMAL(4,1) NOT NULL ,
  PRIMARY KEY (`sno`) ,
  UNIQUE INDEX `leave_id` (`leave_id` ASC) ,
  CONSTRAINT `fk_leave_master_leave_application`
    FOREIGN KEY (`leave_id` )
    REFERENCES `slms`.`leave_application` (`leave_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_leave_master_leave_approved1`
    FOREIGN KEY (`leave_id` )
    REFERENCES `slms`.`leave_approved` (`leave_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_leave_master_leave_rejected1`
    FOREIGN KEY (`leave_id` )
    REFERENCES `slms`.`leave_rejected` (`leave_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_leave_master_leave_reapplied1`
    FOREIGN KEY (`leave_id` )
    REFERENCES `slms`.`leave_reapplied` (`leave_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_leave_master_leave_taken1`
    FOREIGN KEY (`leave_id` )
    REFERENCES `slms`.`leave_taken` (`leave_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `slms`.`dept_table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`dept_table` ;

CREATE  TABLE IF NOT EXISTS `slms`.`dept_table` (
  `dept_sno` INT NOT NULL AUTO_INCREMENT ,
  `dept_code` CHAR(4) NULL ,
  `dept_name` VARCHAR(100) NULL ,
  PRIMARY KEY (`dept_sno`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `slms`.`emp_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`emp_details` ;

CREATE  TABLE IF NOT EXISTS `slms`.`emp_details` (
  `sno` INT NOT NULL AUTO_INCREMENT ,
  `emp_id` CHAR(6) NOT NULL ,
  `date_of_birth` CHAR(6) NOT NULL ,
  `desk_num` CHAR(4) NULL ,
  `mobile_num` VARCHAR(16) NULL ,
  `home_num` VARCHAR(10) NULL ,
  PRIMARY KEY (`sno`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `slms`.`emp_master`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`emp_master` ;

CREATE  TABLE IF NOT EXISTS `slms`.`emp_master` (
  `sno` INT(11) NOT NULL ,
  `emp_id` CHAR(6) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `emp_name` VARCHAR(125) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `manager_id` CHAR(6) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `emp_doj` CHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `dept_code` CHAR(4) NULL ,
  PRIMARY KEY (`sno`) ,
  INDEX `fk_emp_details_leave_master1` (`emp_id` ASC) ,
  INDEX `fk_emp_master_dept_table1` (`dept_code` ASC) ,
  CONSTRAINT `fk_emp_details_leave_master1`
    FOREIGN KEY (`emp_id` )
    REFERENCES `slms`.`leave_master` (`emp_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emp_master_dept_table1`
    FOREIGN KEY (`dept_code` )
    REFERENCES `slms`.`dept_table` (`dept_code` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emp_master_emp_details1`
    FOREIGN KEY (`emp_id` )
    REFERENCES `slms`.`emp_details` (`emp_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `slms`.`table_to_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`table_to_user` ;

CREATE  TABLE IF NOT EXISTS `slms`.`table_to_user` (
  `cl_table_name` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `sl_table_name` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `el_table_name` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `slms`.`holiday_2011`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`holiday_2011` ;

CREATE  TABLE IF NOT EXISTS `slms`.`holiday_2011` (
  `idholiday_2011` INT NOT NULL AUTO_INCREMENT ,
  `date` VARCHAR(45) NOT NULL ,
  `date` VARCHAR(25) NOT NULL ,
  `occasion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idholiday_2011`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `slms`.`logon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slms`.`logon` ;

CREATE  TABLE IF NOT EXISTS `slms`.`logon` (
  `userid` INT NOT NULL ,
  `username` VARCHAR(75) NOT NULL ,
  `useremail` VARCHAR(150) NOT NULL ,
  `password` VARCHAR(50) NOT NULL ,
  `userlevel` INT(1) NULL ,
  PRIMARY KEY (`userid`) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) )
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
