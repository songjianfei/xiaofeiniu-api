#--1 创建数据库

DROP DATABASE IF EXISTS fn;
CREATE DATABASE fn CHARSET=UTF8;
USE fn;

#--2 创建数据表
#--2-1 管理员信息表
CREATE TABLE  xfn_admin(
    aid INT PRIMARY KEY AUTO_INCREMENT,  #--管理员编号
    aname VARCHAR(32) UNIQUE,  #--管理员用户名
    apwd VARCHAR(64)     #--管理员密码
);
 #--2-2 项目全局设置
CREATE TABLE xfn_settings(
    sd INT PRIMARY KEY AUTO_INCREMENT,   #--编号
    appName VARCHAR(32),    #--引用、店家名称
    apiUrl VARCHAR(64),    #--数据api子系统地址
    AdminUrl VARCHAR(64),  #--管理后台子系统地址
    appUrl VARCHAR(64),    #--顾客app子系统地址
    icp  VARCHAR(64),      #--系统备案号
    copyright  VARCHAR(128)   # --系统版权声明
);
 #--2-3 桌台信息表
CREATE TABLE xfn_table(
    tid  INT PRIMARY KEY AUTO_INCREMENT,   #--桌台编号
    tname VARCHAR(64),    #--桌台昵称
    tpe VARCHAR(16),    #--桌台类型
    stus INT
);
 #--2-4 桌台预定信息表
CREATE TABLE xfn_reservation(
    rid INT PRIMARY KEY AUTO_INCREMENT,   
    contactName VARCHAR(64),
    phone VARCHAR(16),       #--联系电话
    contactTime BIGINT,     # --联系时间
    dinnerTime BIGINT,       #--预约用餐时间
    tableId INT,
    FOREIGN KEY (tableId) REFERENCES xfn_table (tid)   #外键
);
 #--2-5 菜品分类
CREATE TABLE xfn_category(
    cid INT PRIMARY KEY AUTO_INCREMENT,  
    cname  VARCHAR(32)
);
 #--2-6 菜品信息表
CREATE TABLE xfn_dish(
    did INT PRIMARY KEY AUTO_INCREMENT,    #--菜品编号
    title VARCHAR(32),      #--菜品名称
    imgUrl VARCHAR(128),    #--图片地址
    price DECIMAL(6,2),      #--价格
    detail VARCHAR(128),     #--详细描述信息 
    categoryId  INT, 
    FOREIGN KEY (categoryId) REFERENCES xfn_category (cid)   #外键
);
#--2-7 订单表
CREATE TABLE xfn_order(
    oid INT PRIMARY KEY AUTO_INCREMENT,  
    startTime BIGINT,
    endTime BIGINT,   
    customerCount INT,   #用餐人数
    tableId INT,   #桌台编号
    FOREIGN KEY (tableId) REFERENCES xfn_table (tid)   #外键
);
#--2-8  订单详细信息表
CREATE TABLE xfn_order_detail(
    did INT PRIMARY KEY AUTO_INCREMENT,
    dishId INT,   #菜品编号 
    dishCount INT,  #菜品数量
    customerCount VARCHAR(64),   #点餐用户称呼
    orderId INT,
    FOREIGN KEY (dishId) REFERENCES xfn_dish (did),   #外键
    FOREIGN KEY (orderId) REFERENCES xfn_order (oid)  #外键
);
#管理用户插入信息
INSERT INTO xfn_admin VALUES
(null,'SJF',PASSWORD('123')),
(null,'Different',PASSWORD('123')),
(null,'Infinite',PASSWORD('123'));

INSERT INTO  xfn_settings VALUES
(null,'小牛','http://127.0.0.1:8090','http://127.0.0.1:8091','http://127.0.0.1:8092','京ICP备12003709号-3','Copyright © 北京达内金桥科技有限公司版权所有');

INSERT INTO xfn_table VALUES
(null,'福满堂','6-8人桌',1),
(null,'金镶玉','4人桌',2),
(null,'手气天','10人桌',3),
(null,'全家福','2人桌',0);

INSERT INTO xfn_reservation VALUES
(null,'钉钉','18329359979',1548404830402,1548410400000,1),
(null,'丫丫','18329359979',1548404830402,1548410400000,2),
(null,'豆豆','18329359979',1548404830402,1548410400000,3),
(null,'花花','18329359979',1548404830402,1548410400000,4),
(null,'糖糖','18329359979',1548404830402,1548410400000,2);

INSERT INTO xfn_category VALUES
(null,'肉类'),
(null,'丸子类'),
(null,'海鲜河鲜类'),
(null,'蔬菜豆制品'),
(null,'菌菇类');

INSERT INTO xfn_dish VALUES
(10000,'草鱼片','CE7I9470.jpg',35,'选鲜活草鱼，切出鱼片冷鲜保存。锅开后再煮1分钟左右即可食用。',1),
(null,'脆皮肠','CE7I9017.jpg',28,'锅开后再煮3分钟左右即可食用。',1),
(null,'酥肉','HGS_4760.jpg',30,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮3分钟左右即可食用。',1),
(null,'现炸酥肉(非清真)','HGS_4760-1.jpg',32,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮1分钟左右即可食用，也可直接食用',1),
(null,'牛百叶','CE7I9302.jpg',32,'毛肚切丝后，配以调味料腌制而成。锅开后再煮2分钟左右即可食用。',1),
(null,'腰花','CE7I9287.jpg',32,'选用大型厂家冷鲜腰花，经过解冻、清洗、切片而成。锅开后涮30秒左右即可食用。',1),
(null,'猪脑花','zl.jpg',32,'选用大型厂家冷鲜猪脑经过清洗，过水、撕膜而成。肉质细腻，锅开后再煮8分钟左右即可食用。',1),
(null,'午餐肉','wcr.jpg',32,'锅开后再煮2分钟左右即可食用。',1),
(null,'牛仔骨','1-CE7I5290.jpg',32,'牛仔骨又称牛小排，选自资质合格的厂家生产配送。锅开后再煮5分钟左右即可食用。',1),
(null,'新西兰羊肉卷','CE7I8804_1.jpg',32,'选用新西兰羔羊肉的前胸和肩胛为原料，在国内经过分割、压制成型，肥瘦均匀。锅开后涮30秒左右即可食用。',1),
(null,'捞派黄喉','EU0A01121.jpg',32,'黄喉主要是猪和牛的大血管，以脆爽见长，是四川火锅中的经典菜式。捞派黄喉选用猪黄喉，相比牛黄喉，猪黄喉只有30cm可用，肉质比牛黄喉薄，口感更脆。 捞派黄喉，通过去筋膜、清水浸泡15小时以上，自然去除黄喉的血水和腥味。口感脆嫩弹牙，是川味火锅的经典菜式。',1),
(null,'千层毛肚','CE7I89001.jpg',32,'选自牛的草肚，加入葱、姜、五香料一起煮熟后切片而成。五香味浓、耙软化渣。锅开后再煮3分钟左右即可食用。',1),
(null,'捞派脆脆毛肚','md.jpg',32,'选自牛的草肚，采用流水清洗、撕片等工艺，加入各种调味料腌制而成。口感脆嫩，锅开后再采用“七上八下”的方法涮15秒即可食用。',1),
(null,'捞派嫩羊肉','cyr.jpg',32,'羊后腿肉肉质紧实，肥肉少，以瘦肉为主；肉中夹筋，筋肉相连。肉质相比前腿肉更为细嫩，用途广，一般用于烧烤、酱制等用途。海底捞只选用生长周期达到6—8个月的草原羔羊，肉嫩筋少而膻味少。精选羔羊后腿肉，肉质紧实，瘦而不柴，再用红油腌制入味，肉香与油香充分融合，一口咬下去鲜嫩多汁、肉味十足。',1),
(null,'草原羔羊肉','CE7I6859.jpg',32,'选自内蒙锡林郭勒大草原10月龄以下羔羊，经过排酸、切割、冷冻而成。锅开后涮30秒左右即可食用。',1);


INSERT INTO xfn_order VALUES
(null,1548406954701,1548406977342,4,1),
(null,1548408873506,1548408884539,6,2),
(null,1548408898471,1548408910640,2,3),
(null,1548408920326,1548408929719,8,1);

INSERT INTO xfn_order_detail VALUES
(null,10000,1,'丁丁',1),
(null,10001,2,'花花',2),
(null,10002,3,'豆豆',3),
(null,10003,4,'丫丫',4);