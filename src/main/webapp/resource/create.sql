

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

alter table feature add column function_name varchar(1024) ;
alter table module add column function_name varchar(1024) ;
alter table l1_component add column function_name varchar(1024) ;
alter table l2_component add column function_name varchar(1024) ;
alter table l3_component add column function_name varchar(1024) ;

update product set function_name = "product";
update feature set function_name = "feature";
update module set function_name = "module";
update l1_component set function_name = "l1_component";
update l2_component set function_name = "l2_component";
update l3_component set function_name = "l3_component";