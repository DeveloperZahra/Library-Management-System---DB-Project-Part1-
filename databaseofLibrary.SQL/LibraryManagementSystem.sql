-------------------CREATE THE DATABASE WITH NAME---------------------------
create database LibraryManagementSystem
-------------------------USE THE DATABASE----------------------------------
use LibraryManagementSystem
--------------------------DDL (CREATION OF ALL TABLES)----------------------

--------TO CREATE LIBRARY TABLE--------
CREATE TABLE Library (
LibraryID INT PRIMARY KEY identity(1,1) NOT NULL,
LibraryName VARCHAR (200) NOT NULL,
LibraryLocation VARCHAR (200) not null, 
EstablishedYear INT NOT NULL CHECK (EstablishedYear >1994)

);

----------TO CREATE Library_Contact_Number TABLE--------
CREATE TABLE Library_Contact_Number (
ContactNumber INT NOT NULL CONSTRAINT CK_Only8Digits CHECK(LEN(RTRIM(ContactNumber)) = 8),
LibraryID INT, FOREIGN KEY (LibraryID) REFERENCES Library(LibraryID)  
	ON DELETE CASCADE 
    ON UPDATE CASCADE,
    PRIMARY KEY(LibraryID, ContactNumber)

	);

------------TO CREATE BOOK TABLE----------
CREATE TABLE Book (
BookID INT  PRIMARY KEY identity(1,1) NOT NULL,
ISBN VARCHAR (200) NOT NULL UNIQUE,
Title VARCHAR (200) NOT NULL ,
Genre VARCHAR (200) NOT NULL, 
Price INT NOT NULL CONSTRAINT CK_GraterThanZero CHECK(Price > 0),
AvailabilityStatus VARCHAR (200) NOT NULL DEFAULT 'TRUE',
ShelfLocation VARCHAR (200) NOT NULL,
LibraryID INT, FOREIGN KEY (LibraryID) REFERENCES Library(LibraryID)
ON DELETE CASCADE 
    ON UPDATE CASCADE
);


----------TO CREATE Member TABLE-----------------
CREATE TABLE Member(
MemberID INT  PRIMARY KEY identity(1,1) NOT NULL,
F_Name VARCHAR (200) NOT NULL,
M_Name VARCHAR (200) NOT NULL,
L_Name VARCHAR (200) NOT NULL,
Member_Phone VARCHAR (20) NOT NULL UNIQUE,
Member_email VARCHAR (200) NOT NULL,
Membership_Start_Date Date NOT NULL

);

---------TO CREATE Review TABLE----------------------------
create table review (

review_number int primary key identity (1,1) NOT NULL,
Rating decimal (2,1) not null,
Reviw_Date date not null,
Comments varchar(200) not null DEFAULT 'No comments'
);


--------TO CREATE Review (Book_Member) TABLE--------------
CREATE TABLE ReviewBookMember( 
BookID INT NOT NULL,
MemberID INT NOT NULL,
review_number INT NOT NULL
primary key(BookID, MemberID)
);


-----------TO CREATE  Loan TABLE----------------------------
CREATE TABLE loan (
LoanID INT  PRIMARY KEY identity(1,1) NOT NULL,
return_date Date NOT NULL,
due_date  Date NOT NULL,
loan_date Date NOT NULL,
L_status varchar(200) not null default 'issued',
 BookID INT CONSTRAINT FK_Loan_BookID FOREIGN KEY (BookID)REFERENCES Book(BookID)
        ON DELETE CASCADE 
    ON UPDATE CASCADE,
MemberID INT CONSTRAINT FK_Loan_MemberID FOREIGN KEY (MemberID)REFERENCES Member(MemberID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

---------------TO CREATE BookLoan TABLE---------------
CREATE TABLE  BookLoans(

LoanID INT not null,
BookID INT not null,
MemberID INT not null
PRIMARY KEY (LoanID, BookID, MemberID)
);

----------------TO CREATE Staff TABLE--------------------
CREATE TABLE  Staff (

StaffID INT  PRIMARY KEY identity(1,1) NOT NULL,
Staff_F_Name  VARCHAR (200) NOT NULL,
Staff_M_Name   VARCHAR (200)  NOT NULL,
Staff_L_Name   VARCHAR (200) NOT NULL,
Position  VARCHAR  NOT NULL,
ContactNumber INT CONSTRAINT CK_Only8Digits_New CHECK(LEN(RTRIM(ContactNumber)) = 8),
LibraryID INT, FOREIGN KEY (LibraryID) REFERENCES Library(LibraryID)
ON DELETE CASCADE 
    ON UPDATE CASCADE
);
------------TO CREATE Payment TABLE---------------
CREATE TABLE Payment (
PaymentID INT  PRIMARY KEY identity(1,1) NOT NULL,
Payment_Date DATE NOT NULL,
Amount INT NOT NULL CONSTRAINT CK_GraterThanZero_Amount CHECK(Amount > 0),
Method  VARCHAR (200)  NOT NULL
);
-------------TO CREATE Loan_Pay TABLE------------

CREATE TABLE  loan_pay (

LoanID int not null,
PaymentID int not null,
BookID int not null,
MemberID int not null
);

--------------Use Alter in Member table ---------

ALTER TABLE Member
ALTER COLUMN M_Name VARCHAR (200);

EXEC sp_rename 'Member.M_Name', 'Midname', 'COLUMN';

ALTER TABLE Member
DROP COLUMN Midname;


ALTER TABLE Member
	Add LibID int foreign key references Library(LibraryID)

------------truncate & Drop ReviewBookMember table----------
truncate table ReviewBookMember

drop table ReviewBookMember




-------------------------------------DML (INSERATION DATA TO THE TABLES)--------------------
------------ insert values to libraries table--------------------
INSERT INTO Library (LibraryName, LibraryLocation, EstablishedYear)
VALUES
('NPL', 'Muscat', '1996'),
('SQU Lib', 'Al Khoudh', '2001'),
('SalalahLib', 'Salalah', '1995');

----------------display all data in libraries table--------------

select * from Library

-------- insert values to library_ContactPhone table---------
INSERT INTO Library_Contact_Number (LibraryID, ContactNumber) 
VALUES
(3, '12345678'),
(4, '87654321'),
(5, '21345867');

------------display all data in library_ContactPhone table-----------
select * from Library_Contact_Number


--------------------- insert value to book table--------------
INSERT INTO Book(ISBN, Title, Genre, Price, AvailabilityStatus, ShelfLocation, LibraryID) VALUES
(9781001, 'Desert Tales', 'Fiction', 4.500, 1, 'A1', 3),
(9781002, 'Oman History', 'Non-fiction', 6.750, 1, 'B2', 3),
(9781003, 'Math Guide', 'Reference', 3.250, 1, 'C3', 4),
(9781004, 'Science Fun', 'Children', 2.800, 1, 'D1', 4),
(9781005, 'Falaj Story', 'Fiction', 5.000, 0, 'A3', 5),
(9781006, 'World Atlas', 'Reference', 7.950, 1, 'C1', 5),
(9781007, 'Think Big', 'Non-fiction', 4.400, 1, 'B1', 3),
(9781008, 'Quran Kids', 'Children', 3.000, 1, 'D2', 4);

-----------display all data in Book table-----------
select * from Book

------------ insert values to member table------------ 
INSERT INTO Member (F_Name, M_Name, L_Name,Member_Phone, Member_email, Membership_Start_Date) VALUES
('Ali', 'Saeed', 'AlHarthy', '81234567','ali.h@gmail.com', '2024-01-15'),
('Eman', 'Ahmed', 'AlRaisi',  '82345678', 'Eman.r@gmail.com','2024-03-20'),
('Khalid', 'Nasser', 'AlBusaidi',  '83456789', 'Khalid.b@gmail.com','2024-05-10'),
('Zahra', 'Hamad', 'Alhabsi', '84567890','Zahra.l@gmail.com', '2024-07-01'),
('Hamed', 'Yousuf', 'AlFarsi','85678901',  'hamed.f@gmail.com', '2024-08-25'),
('Sara', 'Said', 'AlAbri',  '87651243', 'sara.a@gmail.com','2024-10-02'),
('Nasser', 'Ali', 'AlHinai', '82176453', 'nasser.h@gmail.com', '2023-11-18');

--------------------display all data in Mamber table---------------
select * from Member



---------------------insert values to review table-----------------
INSERT INTO review (Rating, Reviw_Date, Comments)
VALUES 
(4.5, '2025-05-10', 'Excellent and fast service. I thank the team for their assistance'),
(3.0, '2025-05-12', 'Very satisfied with the experience. I recommend dealing with them, especially in Muscat.'),
(5.0, '2025-05-14', 'The experience was below expectations. I hope they improve the quality of technical support.'),
(2.5, '2025-05-15', 'Good service. The staff is cooperative and understanding.'),
(4.0, '2025-05-17', 'Good service. The staff is cooperative and understanding.');
------------------display all data in review table-------------------
select * from review

-------------insert valuses to ReviewBookMember table-----------------
INSERT INTO ReviewBookMember (BookID, MemberID, review_number) VALUES
(1, 5, 1),
(10, 6, 2),
(2, 5, 3),
(1, 3, 4),
(3, 7, 5),
(2, 2, 5);
------------------display all data in ReviewBookMember table-------------------
select * from ReviewBookMember

----------------insert valuse loan table-------------------------
INSERT INTO loan ( loan_date, due_date, return_date, L_status)
VALUES
( '2025-05-01', '2025-05-15', '2025-05-14', 'returned'),
('2025-05-03', '2025-05-17', '2025-05-17', 'returned'),
( '2025-05-05', '2025-05-19', '2025-05-20', 'returned'),
( '2025-05-07', '2025-05-21', '2025-05-19', 'returned'),
('2025-05-10', '2025-05-24', '2025-05-23', 'returned'),
( '2025-05-12', '2025-05-26', '2025-05-26', 'returned'),
('2025-05-15', '2025-05-29', '2025-05-28', 'returned'),
( '2025-05-17', '2025-05-31', '2025-05-31', 'returned'),
( '2025-05-18', '2025-06-01', '2025-06-01', 'returned'),
( '2025-05-19', '2025-06-02', '2025-06-03', 'returned');

------------------display all data in loan table-------------------
select * from loan



---------inseart values to BookLoan --------------
INSERT INTO BookLoans (LoanID, BookID, MemberID)
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 4),
(5, 5, 3),
(6, 6, 3);
----------------------display all data in BookLoan table
select * from BookLoans


------------insert values to Staff table---------------------------------
INSERT INTO staff (Staff_F_Name, Staff_M_Name, Staff_L_Name, Position, ContactNumber, LibraryID) VALUES
('Ali', 'Saeed', 'AlBalushi', 'Librarian', '99881234',3),
('Zahra', 'Hamed', 'Alhabsi', 'Assistant', '99221100', 4),
('Ahmed', 'Salim', 'AlShanfari', 'Manager', '92334455', 5);


---------- change size of F_name, M_name, L_name ---------
ALTER TABLE Staff
ALTER COLUMN Staff_F_Name VARCHAR(200);

ALTER TABLE Staff
ALTER COLUMN Staff_M_Name VARCHAR(200);

ALTER TABLE Staff
ALTER COLUMN Staff_L_Name VARCHAR(200);

---------------display all data in Staff-----------------
select * from Staff

-------------insert values to Payment table--------------------
INSERT INTO Payment (Payment_Date, Amount, Method)
VALUES
('2025-05-01', 2.500, 'cash'),
('2025-05-03', 1.750, 'card'),
('2025-05-07', 3.000, 'online'),
('2025-05-10', 2.250, 'cash'),
('2025-05-12', 4.100, 'card');

---------------display all data in Payment-----------------
select * from Payment

-----------------insert values to loan_pay table-----------
INSERT INTO loan_pay (LoanID, PaymentID, BookID, MemberID)
VALUES
(1, 1, 1, 1),
(2, 2, 2, 1),
(3, 3, 3, 2);

---------------display all data in loan_pay-----------------
select * from loan_pay

------------- Use DML to simulate real application behavior---------- 
---------------- Mark books as returned------------------- 
UPDATE Book
set AvailabilityStatus = 1
where ISBN = 9781002;

---------Update loan status-------- 
UPDATE loan
SET L_status = 'Issued'
WHERE LoanID = 5;

select * from loan

--------- Delete review-------------
DELETE FROM Review
WHERE review_number= 11;

select * from Review

----------Update & delete Payment------------- 


update Payment
set Amount +=5.5

DELETE FROM Payment
WHERE PaymentID = 3;

select * from Payment

---------Update Staff-----------

update Staff
set Staff_F_Name='Ali', ContactNumber=92105563

