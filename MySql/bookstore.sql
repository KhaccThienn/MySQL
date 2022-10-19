-- Question 1 + 2 + 3

-- Khoi Tao Database Bookstore
CREATE DATABASE `BookStore` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- Khoi Tao Bang Students

CREATE TABLE students(
	StudentID int PRIMARY KEY AUTO_INCREMENT, 
    Name varchar(50) NOT null,
    Age int CHECK(Age > 0 AND Age <= 50),
    Gender tinyint DEFAULT null
)

-- Khoi Tao Bang Books

CREATE TABLE IF NOT EXISTS `Books` (
  `BookID` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT null,
  `TotalPage` INT,
  `Type` VARCHAR(10),
  `Quantity` int
)

-- Khoi Tao Bang Borrows

CREATE TABLE IF NOT EXISTS `Borrows` (
  `BorrowID` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `StudentID` INT NOT NULL,
  `BookID` INT NOT NULL,
  `BorrowDate` date,
   FOREIGN KEY (`StudentID`) REFERENCES `students` (`StudentID`),
   FOREIGN KEY (`BookID`) REFERENCES `Books` (`BookID`)
)

-- Khoi Tao Bang DropOut

CREATE TABLE IF NOT EXISTS `DropOuts` (
  `DrpInt` INT PRIMARY KEY NOT NULL AUTO_INCREMENT ,
  `StudentID` int NOT NULL,
  `DrpDate` datetime
   FOREIGN KEY (`StudentID`) REFERENCES `students` (`StudentID`)
) 



-- insert du lieu cho bang students
INSERT INTO students VALUES 
(null, "Nguyen Thi Huyen", 19, 0), 
(null, "Mai Thanh Minh", 33, 1), 
(null, "Dao Thien Hai", 26, 1), 
(null, "Trinh Chan Tran", 24, 0), 
(null, "Diem Quynh", 30, null);

-- insert du lieu cho bang books
INSERT INTO books VALUES 
(null, "Word", 50, "Normal", 10),
(null, "Excel", 60, "Normal", 20),
(null, "DDSQL", 71, "Thick", 7),
(null, "LGC", 42, "Thin", 1),
(null, "HTML", 71, "Thick", 2)

-- insert du lieu cho bang Borrows

INSERT INTO Borrows VALUES
(null, 1, 1, "2012-07-29"),
(null, 4, 4, "2012-06-27")



-- Question 4:
INSERT INTO borrows VALUES
(null, 4, 3, "2012-07-30"),
(null, 4, 1, CURRENT_DATE),
(null, 4, 1, CURRENT_DATE),
(null, 2, 5, "2012-06-30")



-- Question 5:
-- 5.1
SELECT b.BookID, b.Name, b.TotalPage
FROM books b
WHERE b.TotalPage > 50
ORDER BY b.TotalPage ASC, b.Name ASC

--5.2
SELECT s.*, bk.Name
FROM students s INNER JOIN borrows br ON s.StudentID = br.StudentID INNER JOIN books bk ON bk.BookID = br.BookID

--5.3
SELECT s.StudentID, s.Name, s.Age, s.Gender, COUNT(br.BookID)
FROM students s LEFT JOIN borrows br ON s.StudentID = br.StudentID LEFT JOIN books bk ON bk.BookID = br.BookID
GROUP BY s.StudentID, s.Name, s.Age, s.Gender

--5.4
SELECT st.* FROM students st WHERE st.Gender IS null;

--5.5
SELECT bk.BookID, bk.Name, bk.TotalPage, bk.Type, bk.Quantity, COUNT(br.BookID)
FROM books bk LEFT JOIN borrows br ON br.BookID = bk.BookID
GROUP BY bk.BookID, bk.Name, bk.TotalPage, bk.Type, bk.Quantity -- van loi