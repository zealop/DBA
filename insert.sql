DELETE FROM `publisher`;
INSERT INTO `publisher` (`NamePublisher`, `AddressPublisher`, `PhonePublisher`, `EmailPublisher`, `BusinessCode`) 
VALUES 
('Seven Seas', NULL, NULL, NULL, NULL);,
('Test Publisher', NULL, NULL, NULL, NULL); 

DELETE FROM `author`;
INSERT INTO `author` (`IDAuthor`, `Fname`, `Mname`, `Lname`, `AddressAuthor`, `EmailAuthor`, `PhoneAuthor`) 
VALUES 
('1', 'Yuyuko', NULL, 'Takemiya', NULL, NULL, NULL),
('2', 'Test', NULL, 'Tester', NULL, NULL, NULL); 

DELETE FROM `book`;
INSERT INTO `book` (`IDBook`, `CurrentBookPrice`, `NameBook`, `CoverImage`, `BookSummary`, `BookPrice`, `BNamePublisher`, `PublisherYear`, `PublisherTime`) 
VALUES 
('1626927952', '899', 'Toradora! (Light Novel) Vol. 1', 'https://images-na.ssl-images-amazon.com/images/I/51yB1k81WaL._SX354_BO1,204,203,200_.jpg', 
'lorem ipsum', '899', 'Seven Seas', '2018', '2018-05-08'),
('1626928614', '999', 'Toradora! (Light Novel) Vol. 2', 'https://images-na.ssl-images-amazon.com/images/I/51EHGwJPsJL._SX354_BO1,204,203,200_.jpg', 
'lorem ipsum', '999', 'Seven Seas', '2018', '2018-08-07'),
('1626929386', '899', 'Toradora! (Light Novel) Vol. 3', 'https://images-na.ssl-images-amazon.com/images/I/51xx7zd8zpL._SX354_BO1,204,203,200_.jpg', 
'lorem ipsum', '899', 'Seven Seas', '2018', '2018-11-20'),
('1626929890', '999', 'Toradora! (Light Novel) Vol. 4', 'https://images-na.ssl-images-amazon.com/images/I/415gzBAzwBL._SX354_BO1,204,203,200_.jpg', 
'lorem ipsum', '999', 'Seven Seas', '2019', '2019-02-05'),
('1642750573', '999', 'Toradora! (Light Novel) Vol. 5', 'https://images-na.ssl-images-amazon.com/images/I/51RKHULCSZL._SX354_BO1,204,203,200_.jpg', 
'lorem ipsum', '999', 'Seven Seas', '2019', '2019-05-14'),
('164275112X', '999', 'Toradora! (Light Novel) Vol. 6', 'https://images-na.ssl-images-amazon.com/images/I/41V94nZyX1L._SX354_BO1,204,203,200_.jpg', 
'lorem ipsum', '999', 'Seven Seas', '2019', '2018-07-23'),
('1642757071', '999', 'Toradora! (Light Novel) Vol. 7', 'https://images-na.ssl-images-amazon.com/images/I/51U1eNHlZ1L._SX354_BO1,204,203,200_.jpg', 
'lorem ipsum', '999', 'Seven Seas', '2019', '2019-10-22'),
('164275739X', '999', 'Toradora! (Light Novel) Vol. 8', 'https://images-na.ssl-images-amazon.com/images/I/41XPGV3njYL._SX354_BO1,204,203,200_.jpg', 
'lorem ipsum', '999', 'Seven Seas', '2019', '2019-12-24'),
('1645051781', '999', 'Toradora! (Light Novel) Vol. 9', 'https://images-na.ssl-images-amazon.com/images/I/41EvgwxatrL._SX354_BO1,204,203,200_.jpg', 
'lorem ipsum', '999', 'Seven Seas', '2020', '2020-01-28'),
('1645054381', '999', 'Toradora! (Light Novel) Vol. 10', 'https://images-na.ssl-images-amazon.com/images/I/41LEuXDtCfL._SX354_BO1,204,203,200_.jpg', 
'lorem ipsum', '999', 'Seven Seas', '2020', '2020-08-04');

DELETE FROM `writtenby`;
INSERT INTO `writtenby` (`IDBook`, `IDAuthor`) 
VALUES 
('1626927952', '1'),
('1626928614', '1'),
('1626929386', '1'),
('1626929890', '1'),
('1642750573', '1'),
('164275112X', '1'),
('1642757071', '1'),
('164275739X', '1'),
('1645051781', '1'),
('1645054381', '1');

DELETE FROM `category`;
INSERT INTO `category` (`IDCategory`, `NameCategory`) 
VALUES 
('1', 'Romance'),
('2', 'Comedy'),
('3', 'Horror'),
('4', 'Scifi');

DELETE FROM `attached`
INSERT INTO `category` (`IDBook`, `IDCategory`) 
VALUES 
('1626927952', '1'),
('164275112X', '1'),
('164275112X', '2');