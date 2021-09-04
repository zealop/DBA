DROP DATABASE IF EXISTS EBook;
Create schema EBook;

CREATE TABLE EBook.Customer(
	Fname VARCHAR(15),
	Mname VARCHAR(15),
	Lname VARCHAR(15),
	Sex	  CHAR,
	DateOfBirth DATE,
	AddressCustomer VARCHAR(50),
	PhoneCustomer VARCHAR(11),
	EmailCustomer VARCHAR(50),
	PasswordCustomer VARCHAR(20),
	UserCustomer VARCHAR(20),
	IDCustomer CHAR(7) PRIMARY KEY NOT NULL
);

CREATE TABLE EBook.CreditCard(
	NumberCard VARCHAR(16) PRIMARY KEY NOT NULL,
	EndTime DATE,
	NameBank VARCHAR(50),
	NameOwer VARCHAR(50),
	StartTime DATE,
	NameBranch VARCHAR(50),
	IDCustomer CHAR(7) NOT NULL,
	FOREIGN KEY (IDCustomer) REFERENCES EBook.Customer(IDCustomer)
);

CREATE TABLE EBook.Payment(
	IDPayment CHAR(7) PRIMARY KEY NOT NULL
);

CREATE TABLE EBook.CardPayMent(
	IDPayment CHAR(7) PRIMARY KEY  NOT NULL,
	NumberCard VARCHAR(16),
	FOREIGN KEY (IDPayment) REFERENCES EBook.Payment(IDPayment),
	FOREIGN KEY (NumberCard) REFERENCES EBook.CreditCard(NumberCard)
);

CREATE TABLE EBook.Tranfer(
	IDPayment CHAR(7) PRIMARY KEY NOT NULL,
	BankAccountNumber VARCHAR(20),
	NameBank VARCHAR(50),
	NameBranch VARCHAR(50),
	FOREIGN KEY (IDPayment) REFERENCES EBook.Payment(IDPayment)
);

CREATE TABLE EBook.Voucher(
	Discount SMALLINT,
	TimeOfVoucher DATETIME ,
	IDVoucher CHAR(7) PRIMARY KEY NOT NULL,
	VIDBook CHAR(7),
	VIDOrder CHAR(7)
);

CREATE TABLE EBook.Order(
	OIDPayment CHAR(7) NOT NULL,
	IDOrder CHAR(7) PRIMARY KEY NOT NULL,
	DateTime DATETIME ,
	Amount INT,
	CurrentPrice INT,
	PaymentTime DATETIME ,
	NameOfBook VARCHAR(50),
	IDBOOK CHAR(7) NOT NULL,
	IDVoucher CHAR(7) NOT NULL,
	FOREIGN KEY (OIDPayment) REFERENCES EBook.Payment(IDPayment),
	FOREIGN KEY (IDVoucher) REFERENCES EBook.Voucher(IDVoucher)
);

CREATE TABLE EBook.Book(
	IDBook CHAR(10) PRIMARY KEY NOT NULL,
	CurrentBookPrice INT DEFAULT 1,
	NameBook VARCHAR(50),
	CoverImage TEXT,
	BookSummary VARCHAR(255),
	BookPrice INT DEFAULT 1,
	BNamePublisher VARCHAR(50),
	PublisherYear CHAR(4),
	PublisherTime DATE
);

CREATE TABLE EBook.Ordered(
	IDCustomer CHAR(7),
	OIDBook CHAR(7) NOT NULL,
	OIDOrder CHAR(7) NOT NULL,
	PRIMARY KEY(OIDBook,OIDOrder),
	FOREIGN KEY (OIDBook) REFERENCES EBook.Book(IDBook),
	FOREIGN KEY (OIDOrder) REFERENCES EBook.Order(IDOrder),
	FOREIGN KEY (IDCustomer) REFERENCES EBook.Customer(IDCustomer)
);

CREATE TABLE EBook.Comment(
	IDCustomer CHAR(7) NOT NULL,
	CmtTime DATETIME  NOT NULL,
	IDBookC CHAR(7) NOT NULL,
	PRIMARY KEY(IDCustomer,CmtTime,IDBookC),
	FOREIGN KEY (IDBookC) REFERENCES EBook.Book(IDBook),
	FOREIGN KEY (IDCustomer) REFERENCES EBook.Customer(IDCustomer)
);

CREATE TABLE EBook.RComment(
	IDCustomer CHAR(7) NOT NULL,
	IDBookC CHAR(7) NOT NULL,
	RTime DATETIME  NOT NULL,
	PRIMARY KEY(RTime,IDBookC),
	FOREIGN KEY(IDCustomer,RTime, IDBookC) REFERENCES EBook.Comment(IDCustomer,CmtTime,IDBookC)
);

CREATE TABLE EBook.Content(
	Evaluate SMALLINT CHECK (Evaluate>=0 AND Evaluate <=5),
	Comment VARCHAR(255),
	ShippingQuantity SMALLINT CHECK (ShippingQuantity>=0 AND ShippingQuantity <=5),
	ServiceQuantity SMALLINT CHECK (ServiceQuantity>=0 AND ServiceQuantity <=5),
	IDCustomer CHAR(7) NOT NULL,
	IDBookC CHAR(7) NOT NULL,
	Time DATETIME  NOT NULL,
	PRIMARY KEY(IDBookC,IDCustomer,Time),
	FOREIGN KEY(IDCustomer,Time, IDBookC) REFERENCES EBook.Comment(IDCustomer,CmtTime,IDBookC)
);

CREATE TABLE EBook.AvailableObject(
	IDVoucher CHAR(7),
	AvailableOn VARCHAR(50), /*check thuoc the loai nao*/
	PRIMARY KEY(IDVoucher,AvailableOn)
);

CREATE TABLE EBook.Attached(
	IDBook CHAR(10) NOT NULL,
	IDCategory CHAR(7) NOT NULL,
	PRIMARY KEY(IDBook,IDCategory)
);
CREATE TABLE EBook.Category(
	NumberOfBook INT(255) DEFAULT 0,
	NameCategory VARCHAR(50),
	IDCategory CHAR(7) PRIMARY KEY NOT NULL
);
CREATE TABLE EBook.TypeOfBook(
	IDBook CHAR(7) NOT NULL,
	BookType VARCHAR(50),
	PRIMARY KEY(IDBook,BookType)
);
CREATE TABLE EBook.KeyWord(
	IDBook CHAR(7) NOT NULL,
	BKeyWord VARCHAR(20) NOT NULL,
	PRIMARY KEY(IDBook,BKeyWord)
);
CREATE TABLE EBook.EBook(
	IDBook CHAR(7) PRIMARY KEY NOT NULL,
	AddressBook VARCHAR(50)
);
CREATE TABLE EBook.PaperBook(
	IDBook CHAR(7) PRIMARY KEY NOT NULL,
	SIDStore CHAR(7)
);
CREATE TABLE EBook.WrittenBy(
	IDBook CHAR(10) NOT NULL,
	IDAuthor CHAR(7) NOT NULL,
	PRIMARY KEY (IDBook, IDAuthor)
);
CREATE TABLE EBook.Author(
	IDAuthor CHAR(7) PRIMARY KEY NOT NULL,
	Fname VARCHAR(15),
	Mname VARCHAR(15),
	Lname VARCHAR(15),
	AddressAuthor VARCHAR(50),
	EmailAuthor VARCHAR(50),
	PhoneAuthor VARCHAR(11)
);
CREATE TABLE EBook.Contact(
	CIDAuthor CHAR(7) NOT NULL,
	CIDStaff CHAR(7) NOT NULL,
	PRIMARY KEY(CIDAuthor, CIDStaff)
);
CREATE TABLE EBook.Publisher(
	NamePublisher VARCHAR(50) PRIMARY KEY NOT NULL,
	AddressPublisher VARCHAR(50),
	PhonePublisher VARCHAR(11),
	EmailPublisher VARCHAR(50),
	BusinessCode CHAR(7)
);
CREATE TABLE EBook.OrderBook(
	ONamePublisher VARCHAR(50) NOT NULL,
	OrderedTime DATETIME ,
	OIDStaff CHAR(7) NOT NULL,
	PRIMARY KEY(ONamePublisher, OIDStaff)
);
CREATE TABLE EBook.Staff(
	Fname VARCHAR(15),
	Mname VARCHAR(15),
	Lname VARCHAR(15),
	AddressStaff VARCHAR(50),
	EmailStaff VARCHAR(50),
	PhoneStaff VARCHAR(11),
	PasswordStaff VARCHAR(20),
	UserStaff VARCHAR(20),
	IDStaff CHAR(7) PRIMARY KEY NOT NULL,
	SIDStorage CHAR(7)
);
CREATE TABLE EBook.InventoryReceivingDeliveryNote(
	IDNote CHAR(7) PRIMARY KEY NOT NULL,
	NameStaff VARCHAR(50),
	Time DATETIME ,
	StoreAddress VARCHAR(50),
	NameOfBook VARCHAR(50),
	IDOfBook CHAR(7) NOT NULL,
	AmountOfBook INT,
	CurrentPriceOfBook INT,
	IDIDStaff CHAR(7)
);
CREATE TABLE EBook.BookStorage(
	AddressStorage VARCHAR(50),
	EmailStorage VARCHAR(50),
	PhoneStorage VARCHAR(11),
	NameStorage VARCHAR(50),
	IDStorage CHAR(7) PRIMARY KEY NOT NULL
);
CREATE TABLE EBook.StorageTypeBook(
	TIDStorage CHAR(7) NOT NULL,
	TypeBook VARCHAR(50) NOT NULL,
	PRIMARY KEY(TIDStorage,TypeBook)
);



ALTER TABLE EBook.Voucher
ADD FOREIGN KEY (VIDBook) REFERENCES EBook.Book(IDBook),
ADD	FOREIGN KEY (VIDOrder) REFERENCES EBook.Order(IDOrder);

ALTER TABLE EBook.AvailableObject
ADD FOREIGN KEY (IDVoucher) REFERENCES EBook.Voucher(IDVoucher);

ALTER TABLE EBook.Book
ADD FOREIGN KEY (BNamePublisher) REFERENCES EBook.Publisher(NamePublisher);

ALTER TABLE EBook.Attached
ADD FOREIGN KEY (IDBook) REFERENCES EBook.Book(IDBook),
ADD	FOREIGN KEY (IDCategory) REFERENCES EBook.Category(IDCategory);

ALTER TABLE EBook.TypeOfBook
ADD FOREIGN KEY (IDBook) REFERENCES EBook.Book(IDBook);

ALTER TABLE EBook.KeyWord
ADD FOREIGN KEY (IDBook) REFERENCES EBook.Book(IDBook);

ALTER TABLE EBook.EBook
ADD FOREIGN KEY (IDBook) REFERENCES EBook.Book(IDBook);

ALTER TABLE EBook.PaperBook
ADD FOREIGN KEY (IDBook) REFERENCES EBook.Book(IDBook),
ADD	FOREIGN KEY (SIDStore) REFERENCES EBook.BookStorage(IDStorage);

ALTER TABLE EBook.WrittenBy
ADD FOREIGN KEY (IDBook) REFERENCES EBook.Book(IDBook) ON DELETE CASCADE,
ADD	FOREIGN KEY (IDAuthor) REFERENCES EBook.Author(IDAuthor) ON DELETE CASCADE;

ALTER TABLE EBook.Contact
ADD FOREIGN KEY (CIDStaff) REFERENCES EBook.Staff(IDStaff),
ADD	FOREIGN KEY (CIDAuthor) REFERENCES EBook.Author(IDAuthor);

ALTER TABLE EBook.OrderBook
ADD FOREIGN KEY (ONamePublisher) REFERENCES EBook.Publisher(NamePublisher),
ADD	FOREIGN KEY (OIDStaff) REFERENCES EBook.Staff(IDStaff);

ALTER TABLE EBook.Staff
ADD FOREIGN KEY (SIDStorage) REFERENCES EBook.BookStorage(IDStorage);

ALTER TABLE EBook.InventoryReceivingDeliveryNote
ADD FOREIGN KEY (IDIDStaff) REFERENCES EBook.Staff(IDStaff);

ALTER TABLE EBook.StorageTypeBook
ADD FOREIGN KEY (TIDStorage) REFERENCES EBook.BookStorage(IDStorage);