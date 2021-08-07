CREATE DATABASE bookinfo;
USE bookinfo;

CREATE TABLE `ratings` (
  `ReviewID` INT NOT NULL,
  `Rating` INT,
  PRIMARY KEY (`ReviewID`)
);