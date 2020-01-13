-- --------
-- 检索数据
-- --------

-- SELECT prod_name FROM products;
-- SELECT  prod_id, prod_name, prod_price
-- FROM products;
-- SELECT * FROM products
-- SELECT DISTINCT vend_id FROM products;
-- SELECT DISTINCT vend_id, prod_price FROM products;
-- SELECT prod_name FROM products LIMIT 5; 
-- SELECT prod_name FROM products LIMIT 5 OFFSET 5;

-- ------------
-- 检索排序数据
-- ------------

-- SELECT prod_name FROM products ORDER BY prod_name;
-- SELECT prod_name FROM products ORDER BY prod_price;
-- SELECT prod_id, prod_price, prod_name FROM products ORDER BY prod_price;
-- SELECT prod_id, prod_price, prod_name FROM products ORDER BY prod_price, prod_name;
-- SELECT prod_id, prod_price, prod_name FROM products ORDER BY 2, 3; 
-- SELECT prod_id, prod_price, prod_name FROM products ORDER BY prod_price DESC;
-- SELECT prod_id, prod_price, prod_name FROM products ORDER BY prod_price DESC, prod_name;

-- --------
-- 过滤数据
-- --------

-- SELECT prod_name, prod_price
-- FROM products
-- WHERE prod_price = 3.49;

-- SELECT prod_name, prod_price
-- FROM products
-- WHERE prod_price < 10;

-- SELECT vend_id, prod_name
-- FROM Products
-- WHERE vend_id <> 'DLL01';

-- SELECT prod_name, prod_price
-- FROM Products
-- WHERE prod_price BETWEEN 5 AND 10;

-- SELECT prod_name
-- FROM Products
-- WHERE cust_email IS NULL;

-- ------------
-- 高级数据过滤
-- ------------

-- SELECT prod_id, prod_price, prod_name
-- FROM products
-- WHERE vend_id = 'DLL01' AND prod_price <= 4;

-- SELECT prod_name, prod_price
-- FROM Products
-- WHERE vend_id = 'DLL01' OR vend_id = 'BRS01';

-- SELECT prod_name, prod_price
-- FROM Products
-- WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'
-- AND prod_price >= 10;

-- SELECT prod_name, prod_price
-- FROM Products
-- WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01')
-- AND prod_price >= 10;

-- SELECT prod_name, prod_price
-- FROM Products
-- WHERE vend_id IN ( 'DLL01', 'BRS01' )
-- ORDER BY prod_name;

-- SELECT prod_name
-- FROM Products
-- WHERE NOT vend_id = 'DLL01'
-- ORDER BY prod_name;

-- --------------
-- 通配符进行过滤
-- --------------

-- SELECT prod_id, prod_name
-- FROM Products
-- WHERE prod_name LIKE 'Fish%';

-- SELECT prod_id, prod_name
-- FROM Products
-- WHERE prod_name LIKE '%bean bag%';

-- SELECT prod_name
-- FROM Products
-- WHERE prod_name LIKE 'F%y';

-- SELECT prod_id, prod_name
-- FROM Products
-- WHERE prod_name LIKE '__ inch teddy bear';

-- SELECT cust_contact
-- FROM Customers
-- WHERE cust_contact LIKE '[JM]%'
-- ORDER BY cust_contact;

-- SELECT cust_contact
-- FROM Customers
-- WHERE cust_contact LIKE '[^JM]%'
-- ORDER BY cust_contact;

-- ------------
-- 创建计算字段
-- ------------

-- SELECT Concat(vend_name, ' (', vend_country, ')')
-- FROM Vendors
-- ORDER BY vend_name;

-- SELECT Concat(vend_name, ' (', vend_country, ')')
-- AS vend_title
-- FROM Vendors
-- ORDER BY vend_name;

-- SELECT prod_id,
-- quantity,
-- item_price,
-- quantity*item_price AS expanded_price
-- FROM OrderItems
-- WHERE order_num = 20008;

-- ----------------
-- 使用数据处理函数
-- ----------------

-- SELECT vend_name, UPPER(vend_name) AS vend_name_upcase
-- FROM Vendors
-- ORDER BY vend_name;

-- SELECT cust_name, cust_contact
-- FROM Customers
-- WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');

-- SELECT order_num
-- FROM Orders
-- WHERE YEAR(order_date) = 2012;

-- --------
-- 汇总数据
-- --------

-- SELECT AVG(prod_price) AS avg_price
-- FROM Products;

-- SELECT AVG(prod_price) AS avg_price
-- FROM Products
-- WHERE vend_id = 'DLL01';

-- SELECT COUNT(*) AS num_cust
-- FROM Customers;

-- SELECT COUNT(cust_email) AS num_cust
-- FROM Customers;

-- SELECT MAX(prod_price) AS max_price
-- FROM Products;

-- SELECT MIN(prod_price) AS min_price
-- FROM Products;

-- SELECT SUM(quantity) AS items_ordered
-- FROM OrderItems
-- WHERE order_num = 20005;

-- SELECT SUM(item_price*quantity) AS total_price
-- FROM OrderItems
-- WHERE order_num = 20005;

-- SELECT AVG(DISTINCT prod_price) AS avg_price
-- FROM Products
-- WHERE vend_id = 'DLL01';

-- SELECT COUNT(*) AS num_items,
-- 	   MIN(prod_price) AS price_min,
-- 	   MAX(prod_price) AS price_max,
-- 	   AVG(prod_price) AS price_avg
-- FROM Products;

-- --------
-- 分组数据
-- --------

-- SELECT COUNT(*) AS num_prods
-- FROM Products
-- WHERE vend_id = 'DLL01';

-- SELECT vend_id, COUNT(*) AS num_prods
-- FROM Products
-- GROUP BY vend_id;

-- SELECT cust_id, COUNT(*) AS orders
-- FROM Orders
-- GROUP BY cust_id
-- HAVING COUNT(*) >= 2;

-- SELECT vend_id, COUNT(*) AS num_prods
-- FROM Products
-- WHERE prod_price >= 4
-- GROUP BY vend_id
-- HAVING COUNT(*) >= 2;

-- SELECT vend_id, COUNT(*) AS num_prods
-- FROM Products
-- GROUP BY vend_id
-- HAVING COUNT(*) >= 2;

-- SELECT order_num, COUNT(*) AS items
-- FROM OrderItems
-- GROUP BY order_num
-- HAVING COUNT(*) >= 3;

-- SELECT order_num, COUNT(*) AS items
-- FROM OrderItems
-- GROUP BY order_num
-- HAVING COUNT(*) >= 3
-- ORDER BY items, order_num;

-- ----------
-- 使用子查询
-- ----------

-- SELECT order_num
-- FROM OrderItems
-- WHERE prod_id = 'RGAN01';

-- SELECT cust_id
-- FROM Orders
-- WHERE order_num IN (20007,20008);

-- SELECT cust_name, cust_contact
-- FROM Customers
-- WHERE cust_id IN ('1000000004','1000000005');

-- SELECT cust_name, cust_contact
-- FROM Customers
-- WHERE cust_id IN (SELECT cust_id
-- 				  FROM Orders
-- 				  WHERE order_num IN (SELECT order_num
-- 								      FROM OrderItems
-- 									  WHERE prod_id = 'RGAN01'));

-- SELECT cust_name,
--        cust_state,
--        (SELECT COUNT(*)
-- 	    FROM Orders
-- 		WHERE Orders.cust_id = Customers.cust_id) AS orders
-- FROM Customers
-- ORDER BY cust_name;

-- -------
-- 联结表
-- -------

-- SELECT vend_name, prod_name, prod_price
-- FROM Vendors, Products
-- WHERE Vendors.vend_id = Products.vend_id;

-- SELECT vend_name, prod_name, prod_price
-- FROM Vendors, Products;

-- SELECT vend_name, prod_name, prod_price
-- FROM Vendors INNER JOIN Products
-- ON Vendors.vend_id = Products.vend_id;

-- SELECT prod_name, vend_name, prod_price, quantity
-- FROM OrderItems, Products, Vendors
-- WHERE Products.vend_id = Vendors.vend_id
-- AND OrderItems.prod_id = Products.prod_id
-- AND order_num = 20007;

-- SELECT cust_name, cust_contact
-- FROM Customers, Orders, OrderItems
-- WHERE Customers.cust_id = Orders.cust_id
-- AND OrderItems.order_num = Orders.order_num
-- AND prod_id = 'RGAN01';

-- -----------
-- 创建高级联结
-- -----------

-- SELECT cust_name, cust_contact
-- FROM Customers AS C, Orders AS O, OrderItems AS OI
-- WHERE C.cust_id = O.cust_id
-- AND OI.order_num = O.order_num
-- AND prod_id = 'RGAN01';

-- SELECT cust_id, cust_name, cust_contact
-- FROM Customers
-- WHERE cust_name = (SELECT cust_name
-- 				   FROM Customers
-- 				   WHERE cust_contact = 'Jim Jones');
-- 			
-- SELECT c1.cust_id, c1.cust_name, c1.cust_contact
-- FROM Customers AS c1, Customers AS c2
-- WHERE c1.cust_name = c2.cust_name
-- AND c2.cust_contact = 'Jim Jones';

-- SELECT C.*, O.order_num, O.order_date,
-- OI.prod_id, OI.quantity, OI.item_price
-- FROM Customers AS C, Orders AS O, OrderItems AS OI
-- WHERE C.cust_id = O.cust_id
-- AND OI.order_num = O.order_num
-- AND prod_id = 'RGAN01';

-- SELECT C.*, O.*, OI.*
-- FROM Customers AS C, Orders AS O, OrderItems AS OI
-- WHERE C.cust_id = O.cust_id
-- AND OI.order_num = O.order_num
-- AND prod_id = 'RGAN01';

-- SELECT Customers.cust_id, Orders.order_num
-- FROM Customers INNER JOIN Orders
-- ON Customers.cust_id = Orders.cust_id;

-- SELECT Customers.cust_id, Orders.order_num
-- FROM Customers LEFT OUTER JOIN Orders
-- ON Customers.cust_id = Orders.cust_id;

-- SELECT Customers.cust_id, Orders.order_num
-- FROM Customers RIGHT OUTER JOIN Orders
-- ON Orders.cust_id = Customers.cust_id;

-- SELECT Customers.cust_id, Orders.order_num
-- FROM Customers LEFT OUTER JOIN Orders
-- ON Customers.cust_id = Orders.cust_id
-- UNION
-- SELECT Customers.cust_id, Orders.order_num
-- FROM Customers RIGHT OUTER JOIN Orders
-- ON Orders.cust_id = Customers.cust_id;

-- SELECT Customers.cust_id,
-- 	   COUNT(Orders.order_num) AS num_ord
-- FROM Customers INNER JOIN Orders
-- ON Customers.cust_id = Orders.cust_id
-- GROUP BY Customers.cust_id;

-- SELECT Customers.cust_id,
-- COUNT(Orders.order_num) AS num_ord
-- FROM Customers LEFT OUTER JOIN Orders
-- ON Customers.cust_id = Orders.cust_id
-- GROUP BY Customers.cust_id;

-- --------
-- 组合查询
-- --------

-- SELECT cust_name, cust_contact, cust_email
-- FROM Customers
-- WHERE cust_state IN ('IL','IN','MI')
-- UNION
-- SELECT cust_name, cust_contact, cust_email
-- FROM Customers
-- WHERE cust_name = 'Fun4All';

-- SELECT cust_name, cust_contact, cust_email
-- FROM Customers
-- WHERE cust_state IN ('IL','IN','MI')
-- OR cust_name = 'Fun4All';

-- SELECT cust_name, cust_contact, cust_email
-- FROM Customers
-- WHERE cust_state IN ('IL','IN','MI')
-- UNION
-- SELECT cust_name, cust_contact, cust_email
-- FROM Customers
-- WHERE cust_name = 'Fun4All'
-- ORDER BY cust_name, cust_contact;

-- --------
-- 插入数据
-- --------

-- INSERT INTO Customers
-- VALUES('1000000006',
-- 		'Toy Land',
-- 		'123 Any Street',
-- 		'New York',
-- 		'NY',
-- 		'11111',
-- 		'USA',
-- 		NULL,
-- 		NULL);

-- INSERT INTO Customers(cust_id,
-- 					  cust_name,
-- 					  cust_address,
-- 					  cust_city,
-- 					  cust_state,
-- 					  cust_zip,
-- 					  cust_country,
-- 					  cust_contact,
-- 					  cust_email)
-- VALUES('1000000007',
-- 		'Toy Land',
-- 		'123 Any Street',
-- 		'New York',
-- 		'NY',
-- 		'11111',
-- 		'USA',
-- 		NULL,
-- 		NULL);

-- INSERT INTO Customers(cust_id,
-- 					  cust_contact,
-- 					  cust_email,
-- 					  cust_name,
-- 					  cust_address,
-- 					  cust_city,
-- 					  cust_state,
-- 					  cust_zip)
-- VALUES('1000000008',
-- 		NULL,
-- 		NULL,
-- 		'Toy Land',
-- 		'123 Any Street',
-- 		'New York',
-- 		'NY',
-- 		'11111');
--         
-- INSERT INTO Customers(cust_id,
-- 					  cust_name,
-- 					  cust_address,
-- 					  cust_city,
-- 					  cust_state,
-- 					  cust_zip,
-- 					  cust_country)
-- VALUES('1000000009',
-- 		'Toy Land',
-- 		'123 Any Street',
-- 		'New York',
-- 		'NY',
-- 		'11111',
-- 		'USA');
        
-- INSERT INTO Customers(cust_id,
-- 					  cust_contact,
-- 					  cust_email,
-- 					  cust_name,
-- 					  cust_address,
-- 					  cust_city,
-- 					  cust_state,
-- 					  cust_zip,
-- 					  cust_country)
-- SELECT cust_id,
-- 	cust_contact,
-- 	cust_email,
-- 	cust_name,
-- 	cust_address,
-- 	cust_city,
-- 	cust_state,
-- 	cust_zip,
-- 	cust_country
-- FROM CustNew;

-- CREATE TABLE CustCopy LIKE Customers;
-- INSERT INTO CustCopy SELECT * FROM Customers;

-- CREATE TABLE CustCopy1 SELECT * FROM Customers;

-- -------------
-- 更新和删除数据
-- -------------

-- UPDATE Customers
-- SET cust_email = 'kim@thetoystore.com'
-- WHERE cust_id = '1000000005';

-- UPDATE Customers
-- SET cust_contact = 'Sam Roberts',
--     cust_email = 'sam@toyland.com'
-- WHERE cust_id = '1000000006';

-- UPDATE Customers
-- SET cust_email = NULL
-- WHERE cust_id = '1000000005';

-- DELETE FROM Customers
-- WHERE cust_id = '1000000006';

-- -------------
-- 创建和操纵表
-- -------------

-- CREATE TABLE Products1
-- (
-- 	prod_id     CHAR(10)        NOT NULL,
-- 	vend_id     CHAR(10)        NOT NULL,
-- 	prod_name   CHAR(254)       NOT NULL,
-- 	prod_price  DECIMAL(8,2)    NOT NULL,
-- 	prod_desc   VARCHAR(1000)   NULL
-- );

-- CREATE TABLE Vendors1
-- (
-- 	vend_id      	CHAR(10)   NOT NULL,
-- 	vend_name    	CHAR(50)   NOT NULL,
-- 	vend_address 	CHAR(50)   ,
-- 	vend_city    	CHAR(50)   ,
-- 	vend_state   	CHAR(5)    ,
-- 	vend_zip     	CHAR(10)   ,
-- 	vend_country 	CHAR(50)
-- );

-- CREATE TABLE OrderItems1
-- (
-- 	order_num  		INTEGER    		NOT NULL,
-- 	order_item 		INTEGER    		NOT NULL,
-- 	prod_id    		CHAR(10)   		NOT NULL,
-- 	quantity   		INTEGER    		NOT NULL 	DEFAULT 1,
-- 	item_price 		DECIMAL(8,2) 	NOT NULL
-- );

-- CREATE TABLE Orders1
-- (
-- 	order_num    INTEGER     NOT NULL,
-- 	order_date   DATETIME    NOT NULL   DEFAULT NOW(),
-- 	cust_id      CHAR(10)    NOT NULL
-- );

-- ALTER TABLE Vendors
-- ADD vend_phone CHAR(20);

-- ALTER TABLE Vendors
-- DROP COLUMN vend_phone;

-- DROP TABLE CustCopy; 

-- ALTER TABLE vendors1 RENAME To vendors2;

-- ---------
-- 使用视图
-- ---------

-- CREATE VIEW ProductCustomers AS
-- SELECT cust_name, cust_contact, prod_id
-- FROM Customers, Orders, OrderItems
-- WHERE Customers.cust_id = Orders.cust_id
-- AND OrderItems.order_num = Orders.order_num;

-- SELECT cust_name, cust_contact
-- FROM ProductCustomers
-- WHERE prod_id = 'RGAN01';

-- CREATE VIEW VendorLocations AS
-- SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
-- AS vend_title
-- FROM Vendors;

-- SELECT *
-- FROM VendorLocations;

-- DROP VIEW VendorLocations; 

-- ------------
-- 使用存储过程
-- ------------

-- DELIMITER //

-- CREATE PROCEDURE productpricing()
-- BEGIN
-- 	SELECT avg(prod_price) as priceAverage
--     FROM products;
-- END //

-- DELIMITER ;

-- CALL productpricing();

-- DROP PROCEDURE productpricing;

-- DROP PROCEDURE IF EXISTS productpricing

-- DELIMITER //

-- CREATE PROCEDURE productpricing(
-- 	OUT pl DECIMAL(8,2),
--     OUT ph DECIMAL(8,2),
--     OUT pa DECIMAL(8,2)
-- )
-- BEGIN
-- 	SELECT min(prod_price)
--     INTO pl
--     FROM products;
--     SELECT max(prod_price)
--     INTO ph
--     FROM products;
--     SELECT avg(prod_price)
--     INTO pa
--     FROM products;
-- end //

-- DELIMITER ;

-- CALL productpricing(@pricelow,
-- 				    @pricehigh,
--                     @priceaverage);
--                     
-- SELECT @pricehigh, @pricelow, @priceaverage;

-- DELIMITER //

-- CREATE PROCEDURE ordertotal(
-- 	IN onumber INT,
--     OUT ototal DECIMAL(8,2)
-- )
-- BEGIN
-- 	SELECT sum(item_price * quantity)
--     FROM orderitems
--     WHERE order_num = onumber
--     INTO ototal;
-- END //

-- DELIMITER ;

-- CALL ordertotal(20005, @total);

-- SELECT @total;

-- DELIMITER //

-- -- Name: ordertotal
-- -- Parameters: onumber = order number
-- -- 			   taxable = 0 if not taxable, 1 if taxable
-- --			   ototal = order total variable

-- CREATE PROCEDURE ordertotal(
-- 	IN onumber INT,
--     IN taxable BOOLEAN,
--     OUT ototal DECIMAL(8,2)
-- ) COMMENT 'Obtain order total, optionally adding tax'
-- BEGIN

-- 	-- Declare variable for total
-- 	DECLARE total DECIMAL(8,2);
--     -- Declare variable oercentage
--     DECLARE taxrate INT DEFAULT 6;

-- 	-- Get the Order total
--     SELECT sum(item_price * quantity)
--     FROM orderitems
--     WHERE order_num = onumber
--     INTO total;
--     
--     -- Is this taxable?
--     IF taxable THEN
-- 		-- Yes, so add taxrate to the total
--         SELECT total + (total / 100 * taxrate) INTO total;
-- 	END IF;
--     
--     -- And finally, save to out variable
--     SELECT total INTO ototal;

-- END //

-- DELIMITER ;

-- CALL ordertotal(20005, 0, @total);
-- SELECT @total;

-- CALL ordertotal(20005, 1, @total);
-- SELECT @total;

-- SHOW CREATE PROCEDURE ordertotal;

-- SHOW PROCEDURE STATUS;

-- SHOW PROCEDURE STATUS LIKE 'ordertotal';

-- ---------
-- 使用游标
-- ---------

-- DELIMITER //

-- CREATE PROCEDURE processorders()
-- BEGIN
-- 	DECLARE ordernumbers CURSOR
--     FOR
--     SELECT order_num FROM orders;
--     
--     OPEN ordernumbers;
--     
--     CLOSE ordernumbers;
-- END //

-- DELIMITER ;

-- DELIMITER //

-- CREATE PROCEDURE processorders()
-- BEGIN
-- 	DECLARE o INT;

-- 	DECLARE ordernumbers CURSOR
--     FOR
--     SELECT order_num FROM orders;
--     
--     OPEN ordernumbers;
--     
--     FETCH ordernumbers INTO o;
--     
--     SELECT o;
--     
--     CLOSE ordernumbers;
-- END //

-- DELIMITER ;

-- CALL processorders();]

-- DELIMITER //

-- CREATE PROCEDURE processorders1()
-- BEGIN
-- 	DECLARE done BOOLEAN DEFAULT 0;
--     DECLARE o INT;
--     
--     DECLARE ordernumbers CURSOR
--     FOR
--     SELECT order_num FROM orders;
--     
--     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
--     
--     OPEN ordernumbers;
--     
--     REPEAT
-- 		FETCH ordernumbers INTO o;
-- 	UNTIL done END REPEAT;
--     
--     CLOSE ordernumbers;
-- END //

-- DELIMITER ;

-- CALL processorders1();

-- DELIMITER //

-- CREATE PROCEDURE processorders2()
-- BEGIN
-- 	DECLARE done BOOLEAN DEFAULT 0;
--     DECLARE o INT;
--     DECLARE t DECIMAL(8,2);
--     
--     DECLARE ordernumbers CURSOR
--     FOR
--     SELECT order_num FROM orders;
--     
--     DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
--     
--     CREATE TABLE IF NOT EXISTS ordertotals
-- 		(order_num INT, total DECIMAL(8,2));
--     
--     OPEN ordernumbers;
--     
--     REPEAT
-- 		FETCH ordernumbers INTO o;
--         CALL ordertotal(o, 1, t);
--         INSERT INTO ordertotals(order_num, total) VALUES(o, t);
-- 	UNTIL done END REPEAT;
--     
--     CLOSE ordernumbers;
-- END //

-- DELIMITER ;

-- CALL processorders2(); 

-- SELECT * FROM ordertotals;

-- ----------
-- 使用触发器
-- ----------

-- CREATE TRIGGER newproduct AFTER INSERT ON products
-- FOR EACH ROW SELECT 'Product added' INTO @ee;

-- INSERT INTO products(prod_id,
-- 					 vend_id,
--                      prod_name,
--                      prod_price,
--                      prod_desc)
-- 			VALUES('BNG011',
-- 				   'DLL01',
--                    'happy',
--                    3.99,
--                    'happy birthday');

-- SELECT @ee;

-- DROP TRIGGER newproduct;

-- CREATE TRIGGER neworder AFTER INSERT ON orders
-- FOR EACH ROW SELECT NEW.order_num INTO @ee1;

-- INSERT INTO orders(order_num, order_date, cust_id)
-- VALUES(20002, now(), 1000000001);

-- SELECT @ee1;

-- DELIMITER //

-- CREATE TRIGGER deleteorder BEFORE DELETE ON orders
-- FOR EACH ROW
-- BEGIN
-- 	INSERT INTO archive_orders(order_num, order_date, cust_id)
--     VALUES(OLD.order_num, OLD.order_date, OLD.cust_id);
-- END //

-- DELIMITER ;

-- CREATE TRIGGER updatevendor BEFORE UPDATE ON vendors
-- FOR EACH ROW SET NEW.vend_state = upper(NEW.vend_state);

-- ------------
-- 管理事务处理
-- ------------

