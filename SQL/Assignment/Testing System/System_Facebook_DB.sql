-- Ques3: Bạn hãy lấy dữ liệu của tất cả nhân viên đang làm việc tại Vietnam.
SELECT s.Staff_id,s.First_Name,s.Last_Name FROM staff s
INNER JOIN office o ON s.Office_id = o.Office_id
INNER JOIN `national` n ON o.National_id = n.National_id
WHERE n.National_Name ='VietNam';

-- Ques4: Lấy ra ID, FullName, Email, National của mỗi nhân viên.
SELECT s.Staff_id,s.First_Name,s.Last_Name,s.Email,n.National_Name FROM staff s
INNER JOIN office o ON s.Office_id = o.Office_id
INNER JOIN `national` n ON o.National_id = n.National_id;

-- Ques5: Lấy ra tên nước mà nhân viên có Email: "daonq@viettel.com.vn" đang làm việc.
SELECT n.National_Name FROM staff s
INNER JOIN office o ON s.Office_id = o.Office_id
INNER JOIN `national` n ON o.National_id = n.National_id
WHERE s.Email='daonq@viettel.com.vn';

-- Ques6: Bạn hãy tìm xem trên hệ thống có quốc gia nào có thông tin trên hệ thống nhưng không có nhân viên nào đang làm việc.
SELECT n.National_Name FROM office o
LEFT JOIN staff s ON s.Office_id = o.Office_id
INNER JOIN `national` n ON o.National_id = n.National_id
WHERE s.Office_id is NULL;

-- Ques7: Thống kê xem trên thế giới có bao nhiêu quốc gia mà FB đang hoạt động sử dụng  tiếng Anh làm ngôn ngữ chính.
SELECT COUNT(National_Name) AS SL FROM `national` 
WHERE Language_Main = 'English';

-- Ques8: Viết lệnh để lấy ra thông tin nhân viên có tên (First_Name) có 10 ký tự, bắt đầu bằng chữ N và kết thúc bằng chữ C.
SELECT First_Name,Last_Name,Email
FROM staff WHERE length(First_Name) = 10
			AND First_Name LIKE 'N%C';

-- Ques9: Bạn hãy tìm trên hệ thống xem có nhân viên nào đang làm việc nhưng do nhập khi nhập liệu bị lỗi mà nhân viên đó vẫn chưa cho thông tin về trụ sở làm việc(Office).
SELECT s.Staff_id,s.First_Name,s.Last_Name,s.Email FROM staff s
RIGHT JOIN office o ON s.Office_id = o.Office_id
WHERE s.Staff_id is NULL;

-- Ques10: Nhân viên có mã ID =9 hiện tại đã nghỉ việc, bạn hãy xóa thông tin của nhân viên này trên hệ thống.
DELETE FROM staff 
WHERE Staff_id = 9;

-- Ques11: FB vì 1 lý do nào đó không còn muốn hoạt động tại Australia nữa, và Mark Zuckerberg muốn bạn xóa tất cả các thông tin trên hệ thống liên quan đến quốc gia này. Hãy tạo 1 Procedure có đầu vào là tên quốc gia cần xóa thông tin để làm việc này và gửi lại cho anh ấy.
DROP PROCEDURE IF EXISTS pr_DeleteNational;
DELIMITER $$
CREATE PROCEDURE pr_DeleteNational(IN Name_National NVARCHAR(50))
BEGIN
		DELETE FROM `national`
        WHERE National_Name = Name_National;
END$$
DELIMITER ;
CALL pr_DeleteNational('Australia');

-- Ques12: Mark muốn biết xem hiện tại đang có bao nhiêu nhân viên trên toàn thế giới đang làm việc cho anh ấy, hãy viết cho anh ấy 1 Function để a ấy có thể lấy dữ liệu này 1 cách  nhanh chóng.
DROP FUNCTION IF EXISTS fn_GetCountStaff;
DELIMITER $$
CREATE FUNCTION fn_GetCountStaff() RETURNS MEDIUMINT
BEGIN
		DECLARE SL MEDIUMINT;
		SELECT COUNT(s.Staff_id) AS SL INTO SL 
        FROM
        staff s;
        RETURN SL;
END$$
DELIMITER ;
SELECT fn_GetCountStaff();

-- Ques13: Để thuận tiện cho việc quản trị Mark muốn số lượng nhân viên tại mỗi quốc gia chỉ tối đa 10.000 người. Bạn hãy tạo trigger cho table Staff chỉ cho phép insert mỗi quốc gia có tối đa 10.000 nhân viên giúp anh ấy (có thể cấu hình số lượng nhân viên nhỏ hơn vd 11 nhân viên để Test).
DROP TRIGGER IF EXISTS tr_numberStaff;
DELIMITER $$
	CREATE TRIGGER tr_numberStaff
    BEFORE INSERT ON `staff`
    FOR EACH ROW
    BEGIN
			DECLARE num_staff INT;
            SELECT COUNT(s.Staff_id) INTO num_staff 
            FROM staff s 
			INNER JOIN office o ON s.Office_id = o.Office_id
			INNER JOIN `national` n ON o.National_id = n.National_id
            WHERE n.National_id = OLD.National_id;
            IF num_staff > 4 THEN 
            SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'Can not insert staff';
            END IF;
            
    END$$
DELIMITER ;
INSERT INTO staff(First_Name,Last_Name,Email,Office_id)
VALUE ('abcaaaada','abcaaa','abcaa@gmail.com',1);
-- Ques14: Bạn hãy viết 1 Procedure để lấy ra tên trụ sở mà có số lượng nhân viên đang làm  việc nhiều nhất.
DROP PROCEDURE IF EXISTS pr_Maxcount;
DELIMITER $$
CREATE PROCEDURE pr_Maxcount()
BEGIN
		SELECT o.Street_Address FROM office o
        INNER JOIN staff s ON o.Office_id = s.Office_id
        GROUP BY o.Office_id
        HAVING COUNT(s.Staff_id) = (SELECT MAX(maxs) FROM( SELECT COUNT(s.Staff_id) AS maxs FROM office o
        INNER JOIN staff s ON o.Office_id = s.Office_id GROUP BY o.Office_id) AS temp );
END$$
DELIMITER ;