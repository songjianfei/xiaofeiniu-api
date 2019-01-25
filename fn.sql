#--1 创建数据库

DROP DATABASE IF EXISTS fn;
CREATE DATABASE fn CHARSET=UTF8;
USE fn;

#--2 创建数据表
#--2-1 管理员信息表
CREATE TABLE  xfn_admin(
    aid INT,   #--管理员编号
    aname VARCHAR(32) UNIQUE,  #--管理员用户名
    apwd VARCHAR(64)     #--管理员密码
);
 #--2-2 项目全局设置
CREATE TABLE xfn_settings(
    sd INT PRIMARY KEY,   #--编号
    appName VARCHAR(32),    #--引用、店家名称
    apiUrl VARCHAR(64),    #--数据api子系统地址
    AdminUrl VARCHAR(64),  #--管理后台子系统地址
    appUrl VARCHAR(64),    #--顾客app子系统地址
    icp  VARCHAR(64),      #--系统备案号
    copyright  VARCHAR(128)   # --系统版权声明
);
 #--2-3 桌台信息表
CREATE TABLE xfn_table(
    tid  INT PRIMARY KEY,   #--桌台编号
    tname VARCHAR(64),    #--桌台昵称
    tpe VARCHAR(16),    #--桌台类型
    stus INT
);
 #--2-4 桌台预定信息表
CREATE TABLE xfn_reservation(
    rid INT PRIMARY KEY,   
    contactName VARCHAR(64),
    phone VARCHAR(16),       #--联系电话
    contactTime BIGINT,     # --联系时间
    dinnerTime BIGINT        #--预约用餐时间
);
 #--2-5 菜品分类
CREATE TABLE xfn_category(
    cid INT PRIMARY KEY,  
    cname  VARCHAR(32)
);
 #--2-6 菜品信息表
CREATE TABLE xfn_dish(
    did INT PRIMARY KEY,    #--菜品编号
    title VARCHAR(32),      #--菜品名称
    imgUrl VARCHAR(128),    #--图片地址
    price DECIMAL(6,2),      #--价格
    detail VARCHAR(128),     #--详细描述信息 
    categoryId  INT, 
    FOREIGN KEY (categoryId) REFERENCES xfn_category (cid)   #外键
);
#--2-7 订单表
CREATE TABLE xfn_order(
    oid INT PRIMARY KEY,  
    startTime BIGINT,
    endTime BIGINT,   
    customerCount INT,   #用餐人数
    tableId INT,   #桌台编号
    FOREIGN KEY (tableId) REFERENCES xfn_table (tid)   #外键
);
#--2-8  订单详细信息表
CREATE TABLE xfn_order_detail(
    did INT PRIMARY KEY,
    dishId INT,   #菜品编号
    FOREIGN KEY (dishId) REFERENCES xfn_dish (did),   #外键
    dishCount INT,  #菜品数量
    customerCount VARCHAR(64),   #点餐用户称呼
    orderId INT,
    FOREIGN KEY (orderId) REFERENCES xfn_order (oid)  #外键
);
#管理用户插入信息
INSERT INTO xfn_admin VALUES
(1,'SJF',123),
(2,'Different',123),
(3,'Infinite',123);
