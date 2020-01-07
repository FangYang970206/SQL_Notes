# SQL Notes

记录一下学习SQL必知必会一书的笔记。

[TOC]

## 环境安装

首先配置SQL环境（只在Win10测试过），这里我安装的是MySQL和MySQL WorkBench，[百度云盘](https://pan.baidu.com/s/1ukbLZs-3IMWlAt06Fi2USA)，提取码：cqtf

先安装MySQL，压缩包是已经打包好的，解压后不用安装了，然后是配置步骤：

1. 将“根目录/bin”路径添加到环境变量Path中
2. 使用管理员cmd
3. 输入`mysqld --initialize-insecure --user=mysql`
4. 然后输入`mysqld --install mysql`
5. 然后输入`net start mysql`
6. 然后输入 `mysql -u root -p`, 没有密码回车进入MySQL.

以上是配置MySQL, 然后是安装MySQL Workbench, 运行程序安装即可, 安装好后运行MySQL Workbench, 左下侧应该有一个MySQL Connection, 双击local instance mysql进入. 如果没有connection, 则需要点击+号创建新的connections.

![image-20191220115249023](assets/image-20191220115249023.png)

## 数据准备

当前进入的连接服务器只有sys数据库, 首先我们需要新建一个数据库, 点击左上角的第二个+号( Create New Schema button), 命名数据库为tysql, 然后点击右下角的apply, 然后再点击第二个apply即创建成功

![image-20191220120534569](assets/image-20191220120534569.png)

在Schemas中双击我们刚刚创建的tysql数据库, 然后在上面的百度云盘中, 有一个data文件夹用来生成数据, 我们把create.txt的内容拷贝到Query1窗口下, 然后点击 Query1窗口的第一个闪电运行程序, 运行完成后, 清空Query1的内容, 再把populate.txt的内容拷贝到Query1窗口下, 点击闪电运行程序, 运行完成后右键数据库tysql, 点击refresh all刷新数据库, Tables就会出现5个tables.

## 检索数据

```mysql
SELECT prod_name FROM products; -- 检索单列
SELECT prod_id, prod_name, prod_price FROM products; -- 检索多个列
SELECT * FROM products; -- 检索所有列
SELECT DISTINCT vend_id FROM products; -- 检索一个列中不同的值
SELECT DISTINCT vend_id, prod_price FROM products; -- 检索两个列中不同的值(以行来区别)
SELECT prod_name FROM products LIMIT 5; -- 检索一列的前5行
SELECT prod_name FROM products LIMIT 5 OFFSET 5; -- 检索一列的第6行到10行, 第一行索引是0, 所以OFFSET 5代表的是第六行
```

- 注释tips: 基于单行有`--`和`#`, 紧接它后面的即为注释, 多行的是使用`/*`和`*/`, 类似C/C++语言.

## 排序检索数据

SQL是由子句构成的, 有些子句是必需的, 有些是可选的, 一个子句通常由一个关键字加上所提供的数据组成。 比如SELECT XX 后面的FROM子句,  这是必需的, 而有些是可选的, 比如对检索出的数据进行排序的ORDER BY 子句.

- 注: 在指定一条ORDER BY 子句时，应该保证它是SELECT 语句中最后一条子句。如果它不是最后的子句，将会出现错误消息。

```mysql
-- 检索单列,并基于选择列排序
SELECT prod_name FROM products ORDER BY prod_name;
-- 检索单列,并基于非选择列排序
SELECT prod_name FROM products ORDER BY prod_price;
-- 检索多列, 基于单个选择列排序
SELECT prod_id, prod_price, prod_name FROM products ORDER BY prod_price;
-- 检索多列, 基于多个选择列排序, 先基于prod_price排序, prod_price中有相同的基于prod_name排序
SELECT prod_id, prod_price, prod_name FROM products ORDER BY prod_price, prod_name;
-- 基于选择列的次序排序, 2,3代表prod_price, prod_name
SELECT prod_id, prod_price, prod_name FROM products ORDER BY 2, 3; 
-- 默认是升序排序,在基于某列排序时,后面加上DESC, 则可以降序排列
SELECT prod_id, prod_price, prod_name FROM products ORDER BY prod_price DESC;
-- 先基于prod_price降序排列,然后基于prod_name升序排列
SELECT prod_id, prod_price, prod_name FROM products ORDER BY prod_price DESC, prod_name;
```

## 过滤数据

过滤数据使用where子句，where后面跟上搜索条件，条件为真会输出。

```mysql
SELECT prod_name, prod_price
FROM products
WHERE prod_price = 3.49;

SELECT prod_name, prod_price
FROM products
WHERE prod_price < 10;

-- 搜索字符串时需要加上单引号，数值则不需要加，此外<>一般可以替换!=，但有的系统不行。
SELECT vend_id, prod_name
FROM Products
WHERE vend_id <> 'DLL01'; 

SELECT prod_name, prod_price
FROM Products
WHERE prod_price BETWEEN 5 AND 10;
```

除了上面的示例，where子句还支持下面的操作符。

<img src="assets/image-20191222123236713.png" alt="image-20191222123236713" style="zoom: 67%;" />

## 高级数据过滤

上面一节中where的搜索条件时单个，这一节是组合多个操作符。

```mysql
-- 与运算
SELECT prod_id, prod_price, prod_name
FROM products
WHERE vend_id = 'DLL01' AND prod_price <= 4;

-- 或运算
SELECT prod_name, prod_price
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01';

-- 注：与运算的优先级要高于或运算，会导致意外输出
SELECT prod_name, prod_price
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'
AND prod_price >= 10;

-- 若需先进行或运算，需要将或运算括起来，然后进行与运算
SELECT prod_name, prod_price
FROM Products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01')
AND prod_price >= 10;

-- 等效于示例2的或运算，不过IN更好，好在更直观，更快，求值顺序不用担心以及可以再包括select语句
SELECT prod_name, prod_price
FROM Products
WHERE vend_id IN ( 'DLL01', 'BRS01' )
ORDER BY prod_name;

-- 非运算，更复杂的子句会比较有用，与IN搭配
SELECT prod_name
FROM Products
WHERE NOT vend_id = 'DLL01'
ORDER BY prod_name;
```

## 通配符进行过滤

对于文本，通常使用通配符来进行过滤，SQL语句中则使用LIKE子句进行通配符过滤。

```mysql
-- 字符匹配不同系统对于字符大小写是否相同不太一样，在MySQL workbench上是相同的

-- %号代表表示任何字符出现任意次数, Microsoft Access使用*而不是%
-- 通配符%看起来像是可以匹配任何东西，但有个例外，这就是NULL。
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE 'Fish%';

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%bean bag%';

-- 注：此匹配必须是F开头，y结尾，有时会存在y后面有空格，此时是不匹配的
SELECT prod_name
FROM Products
WHERE prod_name LIKE 'F%y';

-- _号代表只匹配单个字符，Microsoft Access使用？而不是_
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '__ inch teddy bear';

-- MySQL不支持中括号的集合操作，下面没有输出，只有微软的Access 和SQL Server 支持集合。
SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[JM]%'
ORDER BY cust_contact;
```

- 通配符搜索比较耗时，如果用其他操作符搜索可以达到目的，应用其他操作符。

- 通配符置于开始处，搜索起来是最慢的。
- 仔细注意通配符的位置。

## 创建计算字段

数据库中存储的数据一般不是我们想要的，要从数据库中检索出转换、计算或格式化过的数据，而不是检索
出数据，然后再在客户端应用程序中重新格式化（增加客户端的负担）。

```mysql
-- 要生成一个供应商报表，需要在格式化的名称中列出供应商的位置，使用Concat函数组合数据
SELECT Concat(vend_name, ' (', vend_country, ')')
FROM Vendors
ORDER BY vend_name;

-- 上面的列没有名字，客户端无法引用，可以通过AS关键字赋予别名
SELECT Concat(vend_name, ' (', vend_country, ')')
	   AS vend_title
FROM Vendors
ORDER BY vend_name;

-- 对检索的数据进行算术运算（加减乘除皆可，这里是乘），得到总价格，并使用AS关键词得到别名，方便引用
SELECT prod_id,
quantity,
item_price,
quantity*item_price AS expanded_price
FROM OrderItems
WHERE order_num = 20008;
```

## 使用数据处理函数

这一节主要介绍使用数据库中的函数处理数据，当由于不同数据库的函数名不同以及有些并没有，所以书中许多函数的例子在mysql中没有，无法运行。

```mysql
-- 对字符串取大写
SELECT vend_name, UPPER(vend_name) AS vend_name_upcase
FROM Vendors
ORDER BY vend_name;

-- SOUNDEX是一个将任何文本串转换为描述其语音表示的字母数字模式的算法。打错了字母发音类似也会查找出来
SELECT cust_name, cust_contact
FROM Customers
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');

-- 得到当前的年份
SELECT order_num
FROM Orders
WHERE YEAR(order_date) = 2012;
```

以下是一些常用的文本处理函数，MySQL都支持。

<img src="assets/image-20191227222444041.png" alt="image-20191227222444041" style="zoom: 67%;" />

以下是一些常用的数值函数。

<img src="assets/image-20191227222834589.png" alt="image-20191227222834589" style="zoom:67%;" />

## 汇总数据

这节是聚集函数进行汇总数据，有以下五个函数：

<img src="assets/image-20191229154029240.png" alt="image-20191229154029240" style="zoom:80%;" />

代码如下：

```mysql
SELECT AVG(prod_price) AS avg_price
FROM Products;

SELECT AVG(prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';

-- COUNT(*)对表中行的数目进行计数，不管表列中包含的是空值还是非空值。
SELECT COUNT(*) AS num_cust
FROM Customers;

-- 没有*号就忽略空值
SELECT COUNT(cust_email) AS num_cust
FROM Customers;

SELECT MAX(prod_price) AS max_price
FROM Products;

SELECT MIN(prod_price) AS min_price
FROM Products;

SELECT SUM(quantity) AS items_ordered
FROM OrderItems
WHERE order_num = 20005;

SELECT SUM(item_price*quantity) AS total_price
FROM OrderItems
WHERE order_num = 20005;

-- DISTINCT是去除重值
SELECT AVG(DISTINCT prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';

SELECT COUNT(*) AS num_items,
	   MIN(prod_price) AS price_min,
	   MAX(prod_price) AS price_max,
	   AVG(prod_price) AS price_avg
FROM Products;
```

## 分组数据

这一节是将数据分组，使用GROUP by 和 HAVING 子句。

```mysql
-- 单个列单个类别的统计
SELECT COUNT(*) AS num_prods
FROM Products
WHERE vend_id = 'DLL01';

-- 使用GROUP BY对单个列多个类别进行统计
SELECT vend_id, COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id;

-- GROUP BY分组，HAVING进行组别过滤
SELECT cust_id, COUNT(*) AS orders
FROM Orders
GROUP BY cust_id
HAVING COUNT(*) >= 2;

-- WHERE过滤行，然后GROUP BY分组，最后使用HAVING过滤
SELECT vend_id, COUNT(*) AS num_prods
FROM Products
WHERE prod_price >= 4
GROUP BY vend_id
HAVING COUNT(*) >= 2;

-- GROUP BY分组，最后使用HAVING过滤
SELECT vend_id, COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id
HAVING COUNT(*) >= 2;

-- GROUP BY分组，HAVING过滤，最后ORDER BY排序 
SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;
```

GROUP BY子句的重要规定：

<img src="assets/image-20191229164429037.png" alt="image-20191229164429037" style="zoom: 67%;" />

HAVING和WHRER的区别：

<img src="assets/image-20191229164534027.png" alt="image-20191229164534027" style="zoom:67%;" />

ORDER BY和GROUP BY的区别：

<img src="assets/image-20191229164629859.png" alt="image-20191229164629859" style="zoom:67%;" />

SELECT子句顺序：

<img src="assets/image-20191229164716526.png" alt="image-20191229164716526" style="zoom:67%;" />

## 使用子查询

迄今为止所看到的所有SELECT 语句都是简单查询，即从单个数据库表中检索数据的单条语句。SQL 还允许创建子查询（subquery），即嵌套在其他查询中的查询。书中使用的数据库表都是关系表，订单存储在两个表中。每个订单包含订单编号、客户ID、订单日期，在Orders 表中存储为一行。各订单的物品存储在相关的OrderItems 表中。Orders 表不存储顾客信息，只存储顾客ID。顾客的实际信息存储在Customers 表中。

假如需要列出订购物品RGAN01 的所有顾客，应该怎样检索？下面列出具体的步骤。

1. 检索包含物品RGAN01 的所有订单的编号。
2. 检索具有前一步骤列出的订单编号的所有顾客的ID。
3. 检索前一步骤返回的所有顾客ID 的顾客信息。

每一步可以作为一个单独的查询进行。可以把一条SELECT 语句返回的结果用于另一条SELECT 语句的WHERE 子句。也可以使用子查询来把3个查询组合成一条语句。

```mysql
-- 分以下三个查询子句
SELECT order_num
FROM OrderItems
WHERE prod_id = 'RGAN01';

SELECT cust_id
FROM Orders
WHERE order_num IN (20007,20008); -- (20007,20008)是上一句的结果

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN ('1000000004','1000000005'); -- ('1000000004','1000000005')上一句的结果
```

或者使用子查询把以上三个查询组合成一条语句：

```mysql
-- WHERE 子句中使用子查询能够编写出功能很强且很灵活的SQL语句。
-- 作为子查询的SELECT 语句只能查询单个列。企图检索多个列将返回错误。
SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
				  FROM Orders
				  WHERE order_num IN (SELECT order_num
								      FROM OrderItems
									  WHERE prod_id = 'RGAN01'));
```

<img src="assets/image-20191229175913396.png" alt="image-20191229175913396" style="zoom: 67%;" />

使用子查询的另一方法是创建计算字段。假如需要显示Customers 表中每个顾客的订单总数。订单与相应的顾客ID 存储在Orders 表中。

执行这个操作，要遵循下面的步骤：

1. 从Customers 表中检索顾客列表；
2. 对于检索出的每个顾客，统计其在Orders 表中的订单数目。 

代码如下：

```mysql
-- orders就是一个计算字段，当中使用了完全限定列名，由于cust_id在两个表中都存在，所以需要指定完全限定--- 列名，不然会认为orders表中的cust_id与自己比较
SELECT cust_name,
       cust_state,
       (SELECT COUNT(*)
	    FROM Orders
		WHERE Orders.cust_id = Customers.cust_id) AS orders
FROM Customers
ORDER BY cust_name;
```

## 联结表

这一节是介绍如何将多个表联结起来，是SQL的极为重要的部分。关系表的设计就是要把信息分解成多个表，一类数据一个表。各表通过某些共同的值互相关联，所以叫关系型数据库。

例如，将产品和供应商分开用表进行存储的理由是：

- 同一供应商生产的每个产品，其供应商信息都是相同的，对每个产品重复此信息既浪费时间又浪费存储空间；
- 如果供应商信息发生变化，例如供应商迁址或电话号码变动，只需修改一次即可；
- 由于数据不重复，数据显然是一致的，使得处理数据和生成报表更简单。

- 可伸缩性好, 能够适应不断增加的工作量而不失败。

建立这种关系表也是有代价的, 如果数据存储在多个表, 怎样使用一条select语句检索数据? 

SQL的答案是联结, ，联结是一种机制，用来在一条SELECT 语句中关联表，因此称为联结。使用特殊的语法，可以联结多个表返回一组输出，联结在运行时关联表中正确的行。

```mysql
-- select选择的列From两个表, 通过where子句进行联结, 需要指定完全限定列名, 不然不知道是哪个vend_id
SELECT vend_name, prod_name, prod_price
FROM Vendors, Products
WHERE Vendors.vend_id = Products.vend_id;

-- 没有where,将是两个表的笛卡尔积,也就是两个表的行数相乘所得的表.又称叉联结
SELECT vend_name, prod_name, prod_price
FROM Vendors, Products;

-- 第一个sql语句是简单形式,这个是标准形式, 等值联结, 又称内联结.
SELECT vend_name, prod_name, prod_price
FROM Vendors INNER JOIN Products
ON Vendors.vend_id = Products.vend_id;

-- 联结三个表,有三个限制条件,前两个是联结三个表,最后一个是过滤订单
-- 注: 联结的表越多,性能越差
SELECT prod_name, vend_name, prod_price, quantity
FROM OrderItems, Products, Vendors
WHERE Products.vend_id = Vendors.vend_id
AND OrderItems.prod_id = Products.prod_id
AND order_num = 20007;

-- 上一讲的子查询用联结表写,更加清晰.
SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
AND OrderItems.order_num = Orders.order_num
AND prod_id = 'RGAN01';
```







