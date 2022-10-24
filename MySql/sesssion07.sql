-- 1

-- tao database SQL_Session07_01

CREATE DATABASE SQL_Session07_01;

-- tao bang nxb

 CREATE TABLE IF NOT EXISTS `NXB` (
   `MaNXB` VARCHAR(255) NOT NULL PRIMARY KEY,
   `TenNXB` VARCHAR(255) NOT NULL,
   `DiaChi` VARCHAR(255)
 ) ENGINE = InnoDB;

 -- tao bang tac gia

 CREATE TABLE IF NOT EXISTS `TacGia` (
   `MaTG` VARCHAR(255) NOT NULL PRIMARY KEY,
   `TenTG` VARCHAR(255) NOT NULL
 ) ENGINE = InnoDB;

 -- tao bang Sach

 CREATE TABLE IF NOT EXISTS `Sach` (
   `MaSach` VARCHAR(255) NOT NULL PRIMARY KEY,
   `TenSach` VARCHAR(255) not NULL,
   `MaTG` VARCHAR(255) not NULL,
   `MaNXB` VARCHAR(255) not NULL,
   `SoTrang` int,
   `GiaTien` float,
    FOREIGN KEY (`MaTG`) REFERENCES `TacGia` (`MaTG`),
    FOREIGN KEY (`MaNXB`) REFERENCES `NXB` (`MaNXB`)
     
 ) ENGINE = InnoDB;

 -- insert du lieu 

 INSERT INTO `NXB` VALUES
 ("KD", "NXB Kim Dong", "Kim Dong - Hoang Mai - Ha Noi"),
 ("MK", "NXB Minh Khai", "Q1. Thanh Pho HCM"),
 ("QG", "NXB DH Quoc Gia", "Xuan Thuy - Cau Giay - Ha Noi");


 INSERT INTO `TacGia` VALUES
 ("TG01", "Nguyen Tuan Anh"),
 ("TG02", "Nguyen Quoc Hung"),
 ("TG03", "Tran Duc Thinh"),
 ("TG04", "Phan Thanh Lam");


 INSERT INTO `Sach` VALUES
 ("S01", "Toan Cao Cap", "TG03", "KD", 120, 25000),
 ("S12", "Dia Ly Kinh Te", "TG01", "MK", 100, 30000),
 ("S05", "Triet Hoc", "TG02", "MK", 300, 20000),
 ("S08", "Hoa Hoc", "TG04", "QG", 125, 15000),
 ("S02", "Hai Van Dam Duoi Bien", "TG02", "KD", 250, 40000);

 -- truy van du lieu
 -- 1,
SELECT s.MaSach, s.TenSach, tg.TenTG, s.SoTrang, s.GiaTien, nxb.TenNXB
FROM sach s INNER JOIN tacgia tg ON s.MaTG = tg.MaTG INNER JOIN nxb ON nxb.MaNXB = s.MaNXB
WHERE nxb.TenNXB LIKE "%Minh Khai%"

-- 2,
SELECT s.MaSach, s.TenSach, nxb.TenNXB, s.SoTrang, s.GiaTien, tg.TenTG
FROM sach s INNER JOIN tacgia tg ON s.MaTG = tg.MaTG INNER JOIN nxb ON nxb.MaNXB = s.MaNXB
WHERE tg.TenTG LIKE "%Nguyen Quoc Hung%"

-- 3,
SELECT tg.MaTG, tg.TenTG, COUNT(s.MaTG) AS "So Sach Viet"
FROM sach s INNER JOIN tacgia tg ON tg.MaTG = s.MaTG
GROUP BY tg.MaTG, tg.TenTG

-- 4,
SELECT nxb.MaNXB, nxb.TenNXB, COUNT(s.MaNXB) AS "So Sach Xuat Ban"
FROM sach s INNER JOIN nxb ON nxb.MaNXB = s.MaNXB
GROUP BY nxb.MaNXB, nxb.TenNXB

----------------------------------

-- 02
-- q1 + 2 + 3
-- tao database SQL_Session07_02
CREATE DATABASE `SQL_Session07_02` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- tao bang Aptech

CREATE TABLE Aptech(
  CodeID int PRIMARY KEY AUTO_INCREMENT,
    AptechName varchar(100)
);

-- tao bang AptechEmployees

CREATE TABLE AptechEmployees(
  EmployeeID int NOT null PRIMARY KEY AUTO_INCREMENT,
    CodeID int NOT null,
    EmployeeName varchar(255),
    DateOfBirth date,
    FOREIGN KEY (CodeID) REFERENCES Aptech(CodeID)
);

-- Tao Bang SalaryMonth

CREATE TABLE SalaryMonth(
  EmployeeID int NOT null,
    SalaryMonth float NOT null,
    SalaryYear float NOT null,
    Salary float,
    PRIMARY KEY (EmployeeID, SalaryMonth, SalaryYear),
    FOREIGN KEY (EmployeeID) REFERENCES AptechEmployees(EmployeeID)
)

-- q4:
-- 4.1:
ALTER TABLE `AptechEmployees` ADD CHECK(DateOfBirth BETWEEN "1970-01-01" AND "1985-01-01");
-- 4.2:
ALTER TABLE aptech ADD UNIQUE(AptechName);
-- 4.3:
ALTER TABLE SalaryMonth ALTER SalaryYear SET DEFAULT 2008;

-- q5:

-- them du lieu vao bang aptech
INSERT INTO `Aptech` VALUES
(null, "Ha Noi Aprotrain Aptech"),
(null, "Ha Noi Aprotrain Area");

-- them du lieu vao bang AptechEmployees
INSERT INTO `AptechEmployees` VALUES
(1, 1, "Ha Khanh Toan", "1980-11-11"),
(2, 1, "Tran Khanh Van", "1983-10-11"),
(3, 2, "Le Hong Hai", "1978-10-10");

-- them du lieu vao bang SalaryMonth
INSERT INTO `SalaryMonth` VALUES
(1, 11, 2008, 1000),
(1, 12, 2008, 1200),
(2, 12, 2008, 1300),
(3, 12, 2008, 1400);

-- q6:

SELECT ae.EmployeeID, ap.AptechName, ae.EmployeeName, ae.DateOfBirth, sm.SalaryMonth, sm.SalaryYear, sm.Salary
FROM aptechemployees ae INNER JOIN aptech ap ON ae.CodeID = ap.CodeID INNER JOIN salarymonth sm ON sm.EmployeeID = ae.EmployeeID
-- v2: create views
CREATE VIEW question6 AS
SELECT ae.EmployeeID, ap.AptechName, ae.EmployeeName, ae.DateOfBirth, sm.SalaryMonth, sm.SalaryYear, sm.Salary
FROM aptechemployees ae INNER JOIN aptech ap ON ae.CodeID = ap.CodeID INNER JOIN salarymonth sm ON sm.EmployeeID = ae.EmployeeID

SELECT * FROM question6

-- q7:

CREATE VIEW vw_question7
AS
SELECT ae.EmployeeID, ae.EmployeeName, ap.AptechName, ae.DateOfBirth
FROM aptechemployees ae INNER JOIN aptech ap ON ae.CodeID = ap.CodeID
WHERE ap.AptechName LIKE "%APROTRAIN%"
HAVING ap.AptechName LIKE "%Aptech%";

SELECT * FROM vw_question7;

-- q8:

CREATE TABLE SalaryMonth_backup AS SELECT * FROM SalaryMonth




--------------------------------------------
-- q1 + 2 + 3:

-- tao bang travels
CREATE TABLE travels(
    trID int NOT null,
    name varchar(100) NOT null,
    price float,
    catID int NOT null,
    startdate date,
    PRIMARY KEY (trID)
);

-- tao bang category
CREATE TABLE Categories( 
    catID int NOT null, 
    catName varchar(100), 
    counts int, PRIMARY KEY(catID) 
);

-- tao khoa ngoai 
ALTER TABLE travels ADD FOREIGN KEY (catID) REFERENCES categories(catID);

-- q4:
ALTER TABLE travels ADD CHECK(days BETWEEN 1 and 30);
ALTER TABLE travels ADD UNIQUE(name);
ALTER TABLE travels ALTER startdate SET DEFAULT CURRENT_TIMESTAMP;

-- q5:

-- insert du lieu cho bang category

INSERT INTO categories VALUES
(100, "Beaches", null),
(200, "Family Travel", null),
(300, "Food And Drink", null),
(400, "Skiing", null);

-- insert du lieu cho bang Travels

INSERT INTO travels VALUES
(10, "Manele Bay, Hawaii", 200, 2, 100, null),
(11, "Hilton Waikoala Village", 250, 4, 200, null),
(12, "ClearWater Beach, Florida", 300, 7, 100, "2011-02-01"),
(13, "Sandwich Paradise", 180, 2, 300, "2011-02-11"),
(14, "Cape May, New Jersay", 380, 4, 100, "2011-01-18");

-- q6:
SELECT ct.catID, ct.catName AS "Category", COUNT(tv.catID) AS "Quantity"
FROM categories ct JOIN travels tv ON ct.catID = tv.catID
GROUP BY ct.catID, ct.catName

-- q7  
SELECT tv.name, tv.price, tv.days, tv.startdate FROM travels tv WHERE tv.startdate > CURRENT_DATE;