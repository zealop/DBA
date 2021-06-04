-- Cau 1
SELECT b.*, CONCAT_WS(' ', a.FName, a.MName, a.LName) as Author
    FROM book b
    LEFT OUTER JOIN writtenby wb ON (wb.IDBook = b.IDBook)
    LEFT OUTER JOIN author a on (wb.IDAuthor = a.IDAuthor)
	WHERE b.BNamePublisher IS NOT NULL
	ORDER BY Author;

SELECT CONCAT_WS(' ', a.FName, a.MName, a.LName) as Author, COUNT(wb.IDBook) as Amount, 
	FROM writtenby wb
	LEFT OUTER JOIN author a on (wb.IDAuthor = a.IDAuthor)
	HAVING COUNT(wb.IDBook) > 5
	ORDER BY Author;

SELECT b.NameBook as Book, c.NameCategory as Category
	FROM book b
	LEFT OUTER JOIN attached a ON (a.IDBook = b. IDBook)
	LEFT OUTER JOIN category c ON (a.IDCategory = c.IDCategory)
	ORDER BY Category;

SELECT b.BNamePublisher, COUNT(b.IDBook) as Amount, AVG(b.BookPrice) as Average
	FROM book b
	WHERE b.BNamePublisher IS NOT NULL
	ORDER BY BNamePublisher;
-- Cau 2
DELIMITER $$
-- Hien thi cac sach co gia ban tu min toi max
CREATE  PROCEDURE `GetBookInRange`(IN `minPrice` INT(255), IN `maxPrice` INT(255))
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

-- Giam gia tat ca sach 1 luong %
CREATE  PROCEDURE `MassBookDiscount`(IN `percent` INT(255))
BEGIN
	IF(percent <=0 OR percent >= 100) THEN
    SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Discount % must be between 1%-99%';
	END IF;

	UPDATE book SET
    CurrentBookPrice = FLOOR(CurrentBookPrice*(1-percent/100));
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

-- Cau 4
CREATE FUNCTION `BookPriceLevel`(price INT(255))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE bLevel VARCHAR(20);

    IF price > 3000 THEN
		SET bLevel = 'PRESTIGE';
    ELSEIF (price >= 1500 AND 
			price <= 3000) THEN
        SET bLevel = 'PREMIUM';
    ELSEIF credit < 1500 THEN
        SET bLevel = 'BUDGET';
    END IF;

	RETURN (bLevel);
END$$

DELIMITER ;

