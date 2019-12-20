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
