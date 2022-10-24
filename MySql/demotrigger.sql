-- tao database demotrigger
CREATE DATABASE db_c2110h1_demotrigger;

CREATE TABLE students(
    id int PRIMARY KEY AUTO_INCREMENT,
    name varchar(50),
    gender tinyint,
    birthday date,
    address varchar(100),
    classname varchar(100)
);

-- tao trigger
DELIMITER //

CREATE TRIGGER check_year_valid 
BEFORE INSERT ON students  FOR EACH ROW
BEGIN
	IF(year(CURRENT_DATE) - year(NEW.birthday) < 18) THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'An error occurred';
    END IF;
    ROLLBACK;
END //

DELIMITER ;