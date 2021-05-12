DROP DATABASE IF EXISTS Facebook_DB;
CREATE DATABASE Facebook_DB;
USE Facebook_DB;
DROP TABLE IF EXISTS `National`;
CREATE TABLE `National`(
		National_id MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		National_Name NVARCHAR(50) NOT NULL,
		Language_Main VARCHAR(50) NOT NULL
);
CREATE TABLE `Office`(
		Office_id MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
		Street_Address NVARCHAR(50) NOT NULL, 
		National_id MEDIUMINT UNSIGNED NOT NULL ,
        FOREIGN KEY(National_id) REFERENCES `National`(National_id) ON DELETE CASCADE
);
CREATE TABLE Staff (
		Staff_id MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
		First_Name NVARCHAR(50) NOT  NULL, 
		Last_Name NVARCHAR(50) NOT  NULL, 
		Email VARCHAR(50) NOT NULL, 
		Office_id MEDIUMINT UNSIGNED NOT NULL,
        FOREIGN KEY(Office_id) REFERENCES `Office`(Office_id) ON DELETE CASCADE
);

INSERT INTO `National`(National_Name, Language_Main)
VALUE 		('VietNam','Vietnamese'),
			('England','English'),
			('America','English'),
			('Japan','Japanese'),
			('China','Chinese'),
			('Korea','Korean'),
			('Thailand','Thai'),
			('Campuchia','Cambodian'),
			('Indonesia','English'),
			('Myanmar','English');

INSERT INTO Office (Street_Address, National_id)
VALUE 		('Street_Address 1',1),
			('Street_Address 2',2),
			('Street_Address 3',3),
			('Street_Address 4',4),
			('Street_Address 5',5),
			('Street_Address 6',8),
			('Street_Address 7',1),
			('Street_Address 8',6),
			('Street_Address 9',1),
			('Street_Address 10',7),
			('Street_Address 11',9);

INSERT INTO Staff(First_Name, Last_Name, Email, Office_id)
VALUE 		('Tuan','Truong','tuan@gmail.com',1),
			('Binh','Vu','binh@gmail.com',2),
			('Jack','Michel','jack@gmail.com',3),
			('Blue','Mr','blue@gmail.com',4),
			('Green','Mrs','green@gmail.com',5),
			('Red','Mr','red@gmail.com',6),
			('Cam','Sama','cam@gmail.com',7),
			('Sun','Tony','sun@gmail.com',8),
			('Pink','Nguyen','pink@gmail.com',9),
			('Orange','Van','van@gmail.com',10);