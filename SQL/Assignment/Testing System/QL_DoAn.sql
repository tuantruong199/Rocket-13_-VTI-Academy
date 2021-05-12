DROP DATABASE IF EXISTS `QL_DoAn`;
CREATE DATABASE  `QL_DoAn`;
USE `QL_DoAn`;

DROP TABLE IF EXISTS `GiangVien`;
CREATE TABLE `GiangVien`(
	Id_GV MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Ten_GV   NVARCHAR(50) NOT NULL,
    Tuoi TINYINT NOT NULL,
    HocVi CHAR(10) NOT NULL
);

DROP TABLE IF EXISTS `SinhVien`;
CREATE TABLE `SinhVien`(
	Id_SV MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Ten_SV   NVARCHAR(50) NOT NULL,
    NamSinh INT NOT NULL,
    QueQuan  NVARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS `DeTai`;
CREATE TABLE `DeTai`(
	Id_DeTai MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Ten_DeTai   NVARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS `HuongDan`;
CREATE TABLE `HuongDan`(
	Id MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Id_SV   MEDIUMINT UNSIGNED NOT NULL,
    Id_DeTai MEDIUMINT UNSIGNED NOT NULL,
    Id_GV MEDIUMINT UNSIGNED NOT NULL,
    Diem TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (Id_SV) REFERENCES `SinhVien`(Id_SV) ON DELETE CASCADE,
	FOREIGN KEY (Id_DeTai) REFERENCES `DeTai`(Id_DeTai) ON DELETE CASCADE,
	FOREIGN KEY (Id_GV) REFERENCES `GiangVien`(Id_GV) ON DELETE CASCADE
);
INSERT INTO `GiangVien`(Ten_GV,Tuoi,HocVi)
VALUES ('Giang Vien 1','50','GS'),
		('Giang Vien 2','50','TS'),
        ('Giang Vien 3','50','Ths'),
        ('Giang Vien 4','50','PGS'),
        ('Giang Vien 5','50','GS'),
        ('Giang Vien 6','50','GS'),
        ('Giang Vien 7','50','TS'),
        ('Giang Vien 8','50','TS'),
        ('Giang Vien 9','50','GS'),
        ('Giang Vien 10','50','PGS');

INSERT INTO `SinhVien`(Ten_SV,NamSinh,QueQuan)
VALUES 	('Sinh vien 1','1999','Ha Noi'),
		('Sinh vien 2','1998','Ninh Binh'),
		('Sinh vien 3','1997','Ha Noi'),
		('Sinh vien 4','1999','Ha Nam'),
		('Sinh vien 5','1997','Ha Noi'),
		('Sinh vien 6','1999','Thai Binh'),
		('Sinh vien 7','1999','Ha Noi'),
		('Sinh vien 8','1996','Hai Duong'),
		('Sinh vien 9','1999','Ha Noi'),
		('Sinh vien 10','1997','Bac Ninh');

INSERT INTO `DeTai`(Ten_DeTai)
VALUES 	(N'Đề tài 1'),
		(N'Đề tài 2'),
		(N'Đề tài 3'),
		(N'Đề tài 4'),
		(N'Đề tài 5'),
		(N'Đề tài 6'),
		(N'Đề tài 7'),
		(N'Đề tài 8'),
		(N'Đề tài 9'),
		(N'Đề tài 10');

INSERT INTO `HuongDan`(Id_SV,Id_DeTai,Id_GV,Diem)
VALUES 	('1','10','1','8'),
('2','9','2','8'),
('3','8','3','5'),
('4','7','4','7'),
('5','6','5','8'),
('6','5','6','9'),
('7','4','7','8'),
('8','3','8','6'),
('9','2','9','9'),
('10','1','10','7');