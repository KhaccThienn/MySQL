-- khoi tao database

CREATE DATABASE xaydung


CREATE TABLE Kho (
	MaKho Varchar(3) not null PRIMARY KEY,
    TenKho varchar(50) NOT null,
    DiaChi varchar(100)
);

CREATE TABLE VatTu(
	MaVT varchar(4) NOT null,
    TenVT varchar(50) NOT null,
    Dvtvt varchar(10)
);

CREATE TABLE NXVT(
	IDCt int PRIMARY KEY AUTO_INCREMENT,
    Loai varchar(1) NOT null,
    So varchar(5) NOT null,
    Ngay Date NOT null,
    TriGia int CHECK(TriGia >= 0),
    MaKho varchar(3) NOT null,
    DienGiai varchar(100),
    FOREIGN KEY (MaKho) REFERENCES Kho(MaKho)
);

CREATE TABLE CTNXVT(
	IDCt int NOT null,
    MaVT varchar(4) NOT null,
    SoLuong int CHECK(SoLuong >=0),
    DonGia float CHECK(DonGia >= 0),
    PRIMARY KEY (IDCt, MaVT),
    FOREIGN KEY (IDCt) REFERENCES NXVT(IDCt),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT)
)

-- them du lieu vao cac bang
-- kho:
INSERT INTO kho VALUES
("100", "Kho Cho Lon", ""),
("110", "Kho Chi Nhanh Phu Hoa Tan", ""),
("120", "Kho Chi Nhanh Sai Gon", ""),
("300", "Kho Thu Duc", ""),
("310", "Kho Nha May Nuoc Thu Duc", "");

-- vat tu

INSERT INTO VatTu VALUES
("T001", "TLK DORIS 15", "Cai"),
("T002", "TLK DORIS 40 LY", "Cai"),
("D001", "Dong Ho Nuoc 80 LY", "Cai"),
("R001", "RACCORD TLK KENT 15MM", "Bo"),
("C001", "CHAMBER B25", "Cai");

-- nxvt
INSERT INTO NXVT VALUES
("1", "N", "0001","2004-01-01", "100", "Nhap Cua Cty TNHH HOan My"),
("2", "N", "0002","2004-01-12", "100", ""),
("3", "N", "0003","2004-01-12", "100", ""),
("4", "N", "0004","2004-01-14", "110", ""),
("5", "X", "0005","2004-01-14", "100", ""),
("6", "X", "0006","2004-02-17", "110", ""),
("7", "X", "0007","2004-02-20", "110", "");

-- ctnxvt
INSERT INTO CTNXVT VALUES
("1", "T001", 100, 20000),
("1", "T002", 1000, 30000),
("1", "D001", 1000, 60000),
("2", "R001", 200, 5000),
("2", "C001", 500, 7000),
("3", "T001", 700, 20000),
("3", "T002", 500, 30000),
("4", "D001", 500, 60000),
("5", "R001", 1000, 5000),
("6", "T002", 200, 30000),
("6", "D001", 200, 60000),
("7", "R001", 400, 5000),
("7", "C001", 400, 7000),

-- truy van
-- a:
SELECT nx.Loai, nx.So, nx.Ngay, k.TenKho, nx.TriGia
FROM nxvt nx INNER JOIN kho k ON nx.MaKho = k.MaKho
WHERE nx.TriGia <= 1000000


-- b:
SELECT k.MaKho, k.TenKho, k.DiaChi
FROM kho k LEFT JOIN nxvt nx ON nx.MaKho = k.MaKho
GROUP BY k.MaKho, k.TenKho, k.DiaChi
HAVING COUNT(nx.MaKho) = 0
-- or ?
SELECT k.MaKho, k.TenKho, k.DiaChi
FROM kho k LEFT JOIN nxvt nx ON nx.MaKho = k.MaKho LEFT JOIN ctnxvt ct ON ct.IDCt = nx.IDCt
GROUP BY k.MaKho, k.TenKho, k.DiaChi
HAVING COUNT(ct.IDCt) = 0
-- c:
SELECT k.MaKho, k.TenKho, COUNT(IF(nx.Loai = "N", "Nhap", null)) AS "TongSoCTuNhap",COUNT(IF(nx.Loai = "X", "Xuat", null)) AS "TongSoCTuXuat"
FROM kho k INNER JOIN nxvt nx ON k.MaKho = nx.MaKho
GROUP BY k.MaKho, k.TenKho

-- d:
SELECT MONTH(nxvt.Ngay) AS Thang, vt.MaVT, vt.TenVT
FROM vattu vt INNER JOIN ctnxvt ct ON vt.MaVT = ct.MaVT INNER JOIN nxvt ON nxvt.IDCt = ct.IDCt -- chua xong