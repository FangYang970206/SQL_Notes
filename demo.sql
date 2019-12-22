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

