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


