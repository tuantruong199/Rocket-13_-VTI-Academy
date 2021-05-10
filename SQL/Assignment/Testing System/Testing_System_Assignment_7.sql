-- Question 5
DROP TRIGGER IF EXISTS tr_DeleteAd;
DELIMITER $$
	CREATE TRIGGER tr_DeleteAd
    BEFORE DELETE ON `account`
    FOR EACH ROW
    BEGIN
			DECLARE out_email VARCHAR(50);
            SELECT a.Email  INTO out_email FROM `account` a WHERE a.AccountID = OLD.AccountID;
            IF out_email ='lgoodge0@msn.com' THEN
            SIGNAL SQLSTATE '12345' SET
            MESSAGE_TEXT = 'Can not Del This Acc';
            END IF;
    END$$
DELIMITER ;
DELETE FROM  `account` a WHERE a.AccountID =1;

-- Question 1
DROP TRIGGER IF EXISTS Tr_InsertGroup;
DELIMITER $$
		CREATE TRIGGER Tr_InsertGroup
		BEFORE INSERT ON `group`
        FOR EACH ROW
        BEGIN
				DECLARE out_date DATETIME;
                SELECT year(g.CreateDate) INTO out_date 
                FROM `group` g WHERE g.GroupID =  NEW.GroupID;
                IF year(out_date) < year((now()-1)) THEN
                SIGNAL SQLSTATE '12345' SET
                MESSAGE_TEXT ='Can not insert group';
                END IF;
        END$$
DELIMITER ;
INSERT INTO `group`(GroupID,GroupName,CreatorID,CreateDate) 
VALUE (20,'ABC',1,'2018-06-09 00:00:00');

-- Question 2
DROP TRIGGER IF EXISTS tr_insertsale;
DELIMITER $$
		CREATE TRIGGER tr_insertsale
        BEFORE INSERT ON `account`
        FOR EACH ROW
        BEGIN
				DECLARE id_dep MEDIUMINT;
                SELECT a.DepartmentID INTO id_dep FROM `account` a WHERE a.AccountID = NEW.AccountID;
                IF id_dep = 8 THEN
                SIGNAL SQLSTATE '12345'
                SET MESSAGE_TEXT ='Department "Sale" cannot add more user';
                END IF;
        END$$
DELIMITER ;
INSERT INTO `account`(Email,Username,FullName,DepartmentID,PositionID)
VALUE ('tuan@gmail.com','abc','abc',8,1);
