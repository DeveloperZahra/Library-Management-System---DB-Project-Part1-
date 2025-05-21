-------------------------USE THE DATABASE----------------------------------
use LibraryManagementSystem

---------------*Try deleting a member who:--------- 
--===============1•Has existing loans====== 
--===============2• Has written book reviews============

DELETE FROM Member WHERE MemberID=2;

SELECT * from Member

select * from loan

select * from ReviewBookMember 

-------------*Try deleting a book that---------
--===============1• Is currently on loan======== 
--===============2• Has multiple reviews attached to it=========


delete from Book where BookID =10;

SELECT * from Book

select * from loan

select * from ReviewBookMember 

----------------*Try inserting a loan for------------
--=============1• A member who doesn’t exist========= 
--============2• A book that doesn’t exist=========== 


SELECT * from Member

select * from loan

select * from Book 

INSERT INTO loan ( BookID, MemberID, loan_date, due_date, return_date, L_status)
VALUES
( 12, 12,'2025-05-03', '2025-05-17', '2025-05-17', 'returned');

---------------*Try updating a book’s genre to---------------
--========• A value not included in your allowed genre list (e.g., 'Sci-Fi')========


UPDATE Book
SET Genre = 'Reference'
WHERE BookID = 1;

------------*Try inserting a payment with--------
--=============1• A zero or negative amount======= 
--=============2• A missing payment method========= 



INSERT INTO Payment ( Payment_Date, Amount, Method)
VALUES
('2025-05-01', 1.00, 'cash');

-----*Try inserting a review for--------
--================1• A book that does not exist=========== 
--=============2• A member who was never registered========

INSERT INTO ReviewBookMember (BookID, MemberID, review_number) VALUES
(8, 5, 1);

select*from Book


-----*Try updating a foreign key field (like MemberID in Loan) to a value that doesn’t exist--------



select * from loan

UPDATE loan 
SET MemberID = 8