-- Question 2 a)
SELECT s.Id_SV,s.Ten_SV 
FROM ql_doan.huongdan h
RIGHT JOIN sinhvien s ON h.Id_SV = s.Id_SV
WHERE Id_DeTai IS NULL;
-- Question 2 b)
SELECT COUNT(h.Id_SV)
FROM huongdan h
INNER JOIN detai  d ON d.Id_DeTai = h.Id_DeTai
WHERE d.Ten_DeTai LIKE N'Đề tài 6';

-- Question 3
CREATE VIEW SinhVienInfo AS
	SELECT s.Id_SV,s.Ten_SV,d.Ten_DeTai
    FROM sinhvien s
    INNER JOIN huongdan h ON h.Id_GV = s.Id_SV
    INNER JOIN detai d ON d.Id_DeTai = h.Id_DeTai;
SELECT * FROM SinhVienInfo;
DROP VIEW SinhVienInfo;

-- Question 4
DROP TRIGGER IF EXISTS Tr_Sinhvien;
DELIMITER $$
		CREATE TRIGGER Tr_Sinhvien
        BEFORE INSERT ON `ql_doan`.`sinhvien`
        FOR EACH ROW
        BEGIN
				IF NEW.NamSinh <=1950 THEN
                SIGNAL SQLSTATE '12345'
                SET MESSAGE_TEXT ='Moi ban kiem tra lai nam sinh';
                END IF;
        END$$
DELIMITER ;
INSERT INTO `ql_doan`.`sinhvien`(Ten_SV,NamSinh,QueQuan)
VALUE ('Sinh viên 12','1950','Abc');

-- Question 5
-- Question 6
DROP PROCEDURE IF EXISTS pr_DeleteStudent;
DELIMITER $$
CREATE PROCEDURE pr_DeleteStudent(IN namestudent NVARCHAR(50))
BEGIN
	DELETE FROM sinhvien s
    WHERE s.Ten_SV = namestudent;
END$$
DELIMITER ;
CALL pr_DeleteStudent(N'Sinh viên 1');