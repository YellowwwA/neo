use testdb;

CREATE TABLE `st_grade` (
  `ST_ID` int(11) NOT NULL,
  `Linux` int(11) DEFAULT NULL,
  `DB` int(11) DEFAULT NULL,
  PRIMARY KEY (`ST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `st_grade` VALUES (202501,90,80),(202502,70,95),(202503,80,65);