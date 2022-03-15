CREATE TABLE `t_book` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书ID',
    `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书名',
    `isbn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ISBN码',
    `author` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '作者',
    `publisher` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '出版社',
    `publish_time` date DEFAULT NULL COMMENT '出版时间',
    `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '上架时间',
    `nums` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '馆藏数量',
    `status` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图书状态：1-上架 0-下架',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
