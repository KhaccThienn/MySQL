-- Bai Thuc Hanh MySQL
-------------------------------

-- A01: Nhap Du Lieu
CREATE DATABASE QLBanHang

CREATE TABLE VatTu(
	MaVT varchar(4) PRIMARY KEY,
    Ten varchar(100) UNIQUE,
    DVTinh varchar(10) DEFAULT "",
    PhanTram float CHECK(PhanTram >= 0 AND PhanTram <= 100)
);


CREATE TABLE Nhacc(
    MaNhaCC varchar(3) PRIMARY KEY,
    Ten varchar(100) UNIQUE,
    DiaChi varchar(200) UNIQUE,
    DienThoai varchar(20) DEFAULT "Chua Co"
)

CREATE TABLE DonDH(
    SoDH varchar(4) PRIMARY KEY,
    NgayDH datetime DEFAULT CURRENT_DATE,
    MaNhaCC varchar(3) not null,
    FOREIGN KEY (MaNhaCC) REFERENCES nhacc(MaNhaCC)
)

CREATE TABLE CTDonDH(
    SoDH varchar(4),
    MaVT varchar(4),
    SlDat int CHECK(SlDat > 0),
    PRIMARY KEY (SoDH, MaVT),
    FOREIGN KEY (SoDH) REFERENCES dondh(SoDH),
    FOREIGN KEY (MaVT) REFERENCES vattu(MaVT)
)   

CREATE TABLE PNhap(
    SoPN varchar(4) PRIMARY KEY,
    NgayNhap datetime,
    SoDH varchar(4),
    FOREIGN KEY (SoDH) REFERENCES dondh(SoDH)
)

CREATE TABLE CTPNhap(
    SoPN varchar(4),
    MaVT varchar(4),
    SlNhap int CHECK(SlNhap > 0),
    DgNhap float CHECK(DgNhap >0),
    PRIMARY KEY(SoPN, MaVT),
    FOREIGN KEY (SoPN) REFERENCES pnhap(SoPN),
    FOREIGN KEY (MaVT) REFERENCES vattu(MaVT)
)

CREATE TABLE PXuat(
    SoPX varchar(4) PRIMARY KEY,
    NgayXuat datetime,
    TenKH varchar(100),
);

CREATE TABLE CTPXuat(
    SoPX varchar(4),
    MaVT varchar(4),
    SlXuat int CHECK(SlXuat > 0),
    DgXuat float CHECK(DgXuat >0),
    PRIMARY KEY(SoPN, MaVT),
    FOREIGN KEY (SoPX) REFERENCES PXuat(SoPX),
    FOREIGN KEY (MaVT) REFERENCES vattu(MaVT)
)

CREATE TABLE TonKho(
    NamThang varchar(6),
    MaVT varchar(4),
    SlDau int DEFAULT 0 CHECK(SlDau >= 0),
    TongSln int DEFAULT 0 CHECK(TongSln >= 0),
    TongSlx int DEFAULT 0 CHECK(TongSlx >= 0),
    SlCuoi int GENERATED ALWAYS AS (SlDau + TongSln + TongSlx),
    PRIMARY KEY(NamThang, MaVT),
    FOREIGN KEY (MaVT) REFERENCES vattu(MaVT)
)

-- insert du lieu
INSERT INTO vattu VALUES
("DD01", "Dau DVD Hitachi 1 Dia", "Bo", 40),
("DD02", "Dau DVD Hitachi 3 Dia", "Bo", 40),
("TL15", "Tu Lanh Sanyo 150 Lit", "Cai", 25),
("TL90", "Tu Lanh Sanyo 90 Lit", "Cai", 20),
("TV14", "TV Sony 14 inches", "Cai", 10),
("TV29", "TV Sony 29 inches", "Cai", 10),
("VD01", "Dau VCD Sony 1 Dia", "Bo", 30),
("VD02", "Dau VCD Sony 3 Dia", "Bo", 30);

INSERT INTO Nhacc VALUES
("C01", "Le Minh Tri", "54 Hau Giang Q6 Tp HCM", "8781024"),
("C02", "Tran Minh Thach", "145 Hung Vuong My Tho", "7698154"),
("C03", "Hong Phuong", "154/85 Le Lai Q1 TP HCM", "9600125"),
("C04", "Nhat Thang", "198/40 Huong Lo 14 QTB TP HCM", "9600125"),
("C05", "Luu Nguyet Que", "178 Nguyen Van Luong Da Lat", "7964251"),
("C07", "Cao Minh Trung", "125 Le Quang Sung Nha Trang");

INSERT INTO DonDH VALUES 
("D001", "2005-01-15", "C03"),
("D002", "2005-01-30", "C01"),
("D003", "2005-10-02", "C02"),
("D004", "2005-02-17", "C05"),
("D005", "2005-01-03", "C02"),
("D006", "2005-03-12", "C05");

INSERT INTO CTDonDH VALUES
("D001", "DD01", 10),
("D001", "DD02", 15),
("D002", "VD02", 30),
("D003", "TV14", 10),
("D003", "TV29", 20),
("D004", "TL90", 10),
("D005", "TV14", 10),
("D005", "TV29", 20),
("D006", "TV14", 10),
("D006", "TV29", 20),
("D006", "VD01", 20);

INSERT INTO PNhap VALUES
("N001", "2005-01-17", "D001"),
("N002", "2005-01-20", "D001"),
("N003", "2005-01-31", "D002"),
("N004", "2005-02-15", "D003");

INSERT INTO CTPNhap VALUES
("N001", "DD01", 8, 2500000),
("N001", "DD02", 10, 3500000),
("N002", "DD01", 2, 2500000),
("N002", "DD02", 5, 3500000),
("N003", "VD02", 30, 2500000),
("N004", "TV14", 5, 2500000),
("N004", "TV29", 5, 3500000);

INSERT INTO PXuat VALUES
("X001", "2005-01-17", "Nguyen Ngoc Phuong Nhi"),
("X002", "2005-01-25", "Nguyen Hong Phuong"),
("X003", "2005-01-31", "Nguyen Tuan Tu");

INSERT INTO CTPXuat VALUES
("X001", "DD01", 2, 3500000),
("X002", "DD01", 1, 3500000),
("X002", "DD02", 5, 4900000),
("X003", "DD01", 3, 3500000),
("X003", "DD02", 2, 4900000),
("X003", "VD02", 10, 3250000);

INSERT INTO TonKho (NamThang, MaVT, SlDau, TongSln, TongSlx) VALUES
("200501", "DD01", 0,10,6),
("200501", "DD02", 0,15,7),
("200501", "VD02", 0,30,10),
("200502", "DD01", 4,0,0),
("200502", "DD02", 8,0,0),
("200502", "VD02", 20,0,0),
("200502", "TV14", 5,0,0),
("200502", "TV29", 12,0,0);
-------------------------------------------------------------------

-- A02: Truy Van Du Lieu
-- 1: Truy Van Select
-- a.1,
SELECT vt.*
FROM vattu vt
ORDER BY vt.Ten DESC

-- a.2,
SELECT nc.*
FROM nhacc nc
WHERE nc.DiaChi LIKE "%Q1 TP HCM%"
ORDER BY nc.Ten ASC

-- b,
SELECT cn.SoPN, cn.MaVT, cn.SlNhap, cn.DgNhap, SUM(cn.SlNhap * cn.DgNhap) AS "Thanh Tien"
FROM ctpnhap cn 
GROUP BY cn.SoPN, cn.MaVT, cn.SlNhap, cn.DgNhap

-- c,
SELECT pn.SoPN, pn.NgayNhap, pn.SoDH, SUM(ctn.SlNhap * ctn.DgNhap) AS "Tri Gia"
FROM pnhap pn INNER JOIN ctpnhap ctn ON pn.SoPN = ctn.SoPN
GROUP BY pn.SoPN, pn.NgayNhap, pn.SoDH

-- d,
SELECT nc.MaNhaCC, nc.Ten
FROM nhacc nc LEFT JOIN dondh dd ON dd.MaNhaCC = nc.MaNhaCC
GROUP BY nc.MaNhaCC, nc.Ten
HAVING COUNT(dd.MaNhaCC) <= 1

-- e,
SELECT *
FROM dondh dh
ORDER BY dh.NgayDH DESC

-- f,
SELECT px.SoPX, SUM(ctx.SlXuat * ctx.DgXuat) AS "Tong Tri Gia"
FROM pxuat px INNER JOIN ctpxuat ctx ON px.SoPX = ctx.SoPX
GROUP BY px.SoPX
ORDER BY SUM(ctx.SlXuat * ctx.DgXuat) DESC

-- g,
SELECT vt.MaVT, vt.Ten, vt.DVTinh, vt.PhanTram, SUM(ctx.SlXuat)
FROM vattu vt LEFT JOIN ctpxuat ctx ON vt.MaVT = ctx.MaVT
GROUP BY vt.MaVT, vt.Ten, vt.DVTinh, vt.PhanTram

-- h,
DELETE ctdondh FROM ctdondh LEFT JOIN dondh ON ctdondh.SoDH = dondh.SoDH WHERE dondh.NgayDH = "2005-01-15"

-- i, 
DELETE FROM ctpxuat

-- j,
INSERT INTO CTDonDH VALUES
("D001", "DD01", 10),
("D001", "DD02", 15)

INSERT INTO CTPXuat VALUES
("X001", "DD01", 2, 3500000),
("X002", "DD01", 1, 3500000),
("X002", "DD02", 5, 4900000),
("X003", "DD01", 3, 3500000),
("X003", "DD02", 2, 4900000),
("X003", "VD02", 10, 3250000);

-- k,
UPDATE `TonKho` SET
  TonKho.TongSln = 220,
  TonKho.TongSlx = 100
WHERE 1;
-- con l, m, n



-- 2, tao view
-- a,
CREATE VIEW vw_DMWT
AS
SELECT vt.MaVT, vt.Ten
FROM vattu vt;

SELECT * FROM vw_DMWT

-- b,
CREATE OR REPLACE VIEW vw_DonDH_TongSLNhap
AS
SELECT dh.SoDH, SUM(ctn.SlNhap) AS "Tong So Luong Nhap"
FROM dondh dh LEFT JOIN pnhap pn ON dh.SoDH = pn.SoDH LEFT JOIN ctpnhap ctn ON pn.SoPN = ctn.SoPN
GROUP BY dh.SoDH;

SELECT * FROM vw_DonDH_TongSLNhap;

-- c,
