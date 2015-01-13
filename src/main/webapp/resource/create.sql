

############ TABLE FEATURE ##########
CREATE TABLE `longxin`.`feature` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `PRODUCT` INT NOT NULL,
  `FEATURE_NAME` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FEATURE_FK1_idx` (`PRODUCT` ASC),
  CONSTRAINT `FEATURE_FK1`
    FOREIGN KEY (`PRODUCT`)
    REFERENCES `longxin`.`product` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

 ############ TABLE FUNCTION ##########   
CREATE TABLE `longxin`.`function` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `FEATURE` INT NOT NULL,
  `FUNCTION_NAME` VARCHAR(128) NULL,
  PRIMARY KEY (`ID`),
  INDEX `FUNCTION_FK1_idx` (`FEATURE` ASC),
  CONSTRAINT `FUNCTION_FK1`
    FOREIGN KEY (`FEATURE`)
    REFERENCES `longxin`.`feature` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

alter table users modify role varchar(40) not null ;
 
insert department values(2,"B");
