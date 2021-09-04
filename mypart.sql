-- Cau 1
SELECT b.*, CONCAT_WS(' ', a.FName, a.MName, a.LName) as Author
    FROM book b, writtenby wb, author a
    WHERE (wb.IDBook = b.IDBook) AND (wb.IDAuthor = a.IDAuthor)
	ORDER BY Author;

SELECT CONCAT_WS(' ', a.FName, a.MName, a.LName) as Author, COUNT(wb.IDBook) as Amount
	FROM writtenby wb
	LEFT OUTER JOIN author a on (wb.IDAuthor = a.IDAuthor)
	HAVING COUNT(wb.IDBook) > 5
	ORDER BY Author;

SELECT a.*, COUNT(wb.IDBook) as BookAmount
	FROM author a
	LEFT OUTER JOIN writtenby wb ON (wb.IDAuthor = a.IDAuthor)
	HAVING BookAmount > 5
	ORDER BY a.IDAuthor;

SELECT c.NameCategory as Category, b.NameBook as Book
	FROM book b, category c, attached a
	WHERE(a.IDBook = b. IDBook)AND (a.IDCategory = c.IDCategory)
	ORDER BY Category;

SELECT b.BNamePublisher, COUNT(b.IDBook) as Amount, AVG(b.BookPrice) as Average
	FROM book b
	WHERE b.BNamePublisher IS NOT NULL
	ORDER BY BNamePublisher;

SELECT p.*, b.BNamePublisher, COUNT(b.IDBook) as Amount, AVG(b.BookPrice) as Average
	FROM book b, publisher p
	HAVING(b.BNamePublisher = p.NamePublisher)AND Amount > 5
	ORDER BY NamePublisher;
-- Cau 2
DELIMITER $$
-- Hien thi cac sach co gia ban tu min toi max
CREATE PROCEDURE `GetBookInRange`(IN `minPrice` INT(255), IN `maxPrice` INT(255))
BEGIN
	IF(minPrice > maxPrice) THEN
    SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Min Price can not be higher than max Price';
	END IF;

    IF(minPrice < 0 or maxPrice <0) THEN
    SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Min/max Price can not be negative';
	END IF;

	SELECT * 
 	FROM book
	WHERE CurrentBookPrice >= minPrice
    AND CurrentBookprice <= maxPrice;
END$$

SET @p0='99'; SET @p1='900'; CALL `GetBookInRange`(@p0, @p1); 
-- Giam gia tat ca sach 1 luong %
CREATE  PROCEDURE `MassBookDiscount`(IN `percent` INT(255))
BEGIN
	IF(percent <=0 OR percent >= 100) THEN
    SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Discount % must be between 1%-99%';
	END IF;

	UPDATE book SET
    CurrentBookPrice = FLOOR(BookPrice*(1-percent/100));
END$$
-- Cau 3
-- Tu dong set currentbookprice
CREATE TRIGGER `AutoBookPrice`
BEFORE INSERT ON book
FOR EACH ROW
SET NEW.CurrentBookPrice = NEW.BookPrice;

-- Cap nhat so luong sach trong category
CREATE TRIGGER `NewBookInCategory`
AFTER INSERT ON attached
FOR EACH ROW 
UPDATE category SET NumberOfBook = NumberOfBook + 1 WHERE IDCategory = NEW.IDCategory;

CREATE TRIGGER `DelBookInCategory`
AFTER DELETE ON attached
FOR EACH ROW 
UPDATE category SET NumberOfBook = NumberOfBook - 1 WHERE IDCategory = OLD.IDCategory;

CREATE TRIGGER `UpdateBookInCategory`
AFTER UPDATE ON attached
FOR EACH ROW 
BEGIN
UPDATE category SET NumberOfBook = NumberOfBook + 1 WHERE IDCategory = NEW.IDCategory;
UPDATE category SET NumberOfBook = NumberOfBook - 1 WHERE IDCategory = OLD.IDCategory;
END;$$

UPDATE `attached` SET `IDCategory` = '1'
 WHERE `attached`.`IDBook` = 'b' AND `attached`.`IDCategory` = '3'; 

INSERT INTO `attached` (`IDBook`, `IDCategory`) VALUES ('164275739X', '3');
-- Cau 4
CREATE FUNCTION `AuthorLevel`(authorID INT(255))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE aLevel VARCHAR(20);
	DECLARE book INT(255);
	DECLARE exist VARCHAR(20);

	SELECT IDAuthor, COUNT(wb.IDBook) 
		INTO exist, book 
		FROM writtenby wb WHERE wb.IDAuthor = authorID;
	
	IF(exist IS NULL) THEN
    SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Author does not exist';
	END IF;

    IF book < 3 THEN
		SET aLevel = 'FRESH';
    ELSEIF (book < 10) THEN
        SET aLevel = 'TRUSTED';
    ELSE
        SET aLevel = 'PARTNER';
    END IF;

	RETURN (aLevel);
END$$

DELIMITER ;

SET @p0='1'; SELECT `AuthorLevel`(@p0) AS `AuthorLevel`; 