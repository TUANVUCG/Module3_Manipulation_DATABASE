CREATE DATABASE SELLMNG;

USE SELLMNG;

CREATE TABLE CUSTOMER(
cID VARCHAR(50) PRIMARY KEY,
cName VARCHAR(50) NOT NULL,
cAge INT);

CREATE TABLE ORDERS(
oID VARCHAR(50) PRIMARY KEY,
cID VARCHAR(50) ,
oDate DATE,
oTotalPrice FLOAT,
CONSTRAINT FK_cID FOREIGN KEY (cID) REFERENCES CUSTOMER(cID));

CREATE TABLE PRODUCT(
pID VARCHAR(50) PRIMARY  KEY,
pName VARCHAR(50),
pPrice FLOAT);

CREATE TABLE ORDERDETAIL(
oID VARCHAR(50),
pID VARCHAR(50),
odQTY VARCHAR(50),
PRIMARY KEY (oID, pID),
CONSTRAINT FK_ORDERS FOREIGN KEY (oID) REFERENCES ORDERS(oID),
CONSTRAINT FK_PRODUCT FOREIGN KEY (pID) REFERENCES PRODUCT(pID));

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
SELECT O.oID, O.ODate,O.oTotalPrice
FROM ORDERS O; 

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT C.cName, P.pName
FROM CUSTOMER C
JOIN ORDERS O ON O.cID = C.cID
JOIN orderdetail OD ON O.oID = OD.oID
JOIN product P ON P.pID = OD.pID;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT cName
FROM customer
WHERE cID NOT IN (
SELECT cID
FROM orders);

/*Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
(giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)*/
SELECT orderdetail.oID,oDate, sum(orderdetail.odQTY * product.pPrice) as total
FROM orderdetail
join product on orderdetail.pID = product.pID
JOIN orders ON orders.oID = orderdetail.oID
group by orderdetail.oID;

select orderdetail.*,product.pPrice, odQTY*pPrice as total
from orderdetail
join product on orderdetail.pID = product.pID;