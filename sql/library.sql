/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : localhost:3306
 Source Schema         : library

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 18/03/2022 17:51:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
                           `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
                           `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课程名称',
                           `score` int(11) NULL DEFAULT NULL COMMENT '学分',
                           `times` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上课时间',
                           `state` tinyint(1) NULL DEFAULT NULL COMMENT '是否开课',
                           `teacher_id` int(11) NULL DEFAULT NULL COMMENT '授课老师id',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, '大学物理', 10, '40', 0, 16);
INSERT INTO `course` VALUES (2, '高等数学', 10, '45', NULL, 16);
INSERT INTO `course` VALUES (3, '大学英语', 10, '30', NULL, 16);

-- ----------------------------
-- Table structure for student_course
-- ----------------------------
DROP TABLE IF EXISTS `student_course`;
CREATE TABLE `student_course`  (
                                   `student_id` int(11) NOT NULL,
                                   `course_id` int(11) NOT NULL,
                                   PRIMARY KEY (`student_id`, `course_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student_course
-- ----------------------------
INSERT INTO `student_course` VALUES (1, 1);
INSERT INTO `student_course` VALUES (17, 1);
INSERT INTO `student_course` VALUES (17, 2);
INSERT INTO `student_course` VALUES (28, 1);
INSERT INTO `student_course` VALUES (28, 2);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
                             `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
                             `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
                             `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('user', 'el-icon-user', 'icon');
INSERT INTO `sys_dict` VALUES ('house', 'el-icon-house', 'icon');
INSERT INTO `sys_dict` VALUES ('menu', 'el-icon-menu', 'icon');
INSERT INTO `sys_dict` VALUES ('s-custom', 'el-icon-s-custom', 'icon');
INSERT INTO `sys_dict` VALUES ('s-grid', 'el-icon-s-grid', 'icon');
INSERT INTO `sys_dict` VALUES ('document', 'el-icon-document', 'icon');
INSERT INTO `sys_dict` VALUES ('coffee', 'el-icon-coffee\r\n', 'icon');
INSERT INTO `sys_dict` VALUES ('s-marketing', 'el-icon-s-marketing', 'icon');
INSERT INTO `sys_dict` VALUES ('notebook-1', 'el-icon-notebook-1', 'icon');
INSERT INTO `sys_dict` VALUES ('notebook-2', 'el-icon-notebook-2', 'icon');
INSERT INTO `sys_dict` VALUES ('s-custom', 'el-icon-s-custom', 'icon');
INSERT INTO `sys_dict` VALUES ('user-solid', 'el-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solidel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid', 'icon');
INSERT INTO `sys_dict` VALUES ('collection', 'el-icon-collection', 'icon');
INSERT INTO `sys_dict` VALUES ('s-order', 'el-icon-s-order', 'icon');

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
                             `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名称',
                             `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
                             `size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小(kb)',
                             `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '下载链接',
                             `md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件md5',
                             `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
                             `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否禁用链接',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (47, '哆啦V梦.jpg', 'jpg', 12, 'http://localhost:9090/file/27df67fa12a94bc3850a9fb4becf1f59.jpg', '89040393ff67e227b25b2131538900a5', 0, 1);
INSERT INTO `sys_file` VALUES (48, 'pink.jpg', 'jpg', 65, 'http://localhost:9090/file/da8d48ac70c14cc38d3cb5b93f4b4496.jpg', '826bee1012d46b68f6af327f1a7efceb', 0, 1);
INSERT INTO `sys_file` VALUES (49, 'pink.jpg', 'jpg', 65, 'http://localhost:9090/file/da8d48ac70c14cc38d3cb5b93f4b4496.jpg', '826bee1012d46b68f6af327f1a7efceb', 0, 1);
INSERT INTO `sys_file` VALUES (50, '收手吧阿祖.jpg', 'jpg', 31, 'http://localhost:9090/file/8b2338d556194eba8da3e00faae6f0de.jpg', '93cd03f2a61f2719ccec04d2644b2cb1', 0, 1);
INSERT INTO `sys_file` VALUES (51, '俺的图图呢.jpg', 'jpg', 12, 'http://localhost:9090/file/84efbae5735140e4bf63fdcd8463eebd.jpg', '5fbe770b67fea403356f877257ba8c1d', 0, 1);
INSERT INTO `sys_file` VALUES (52, '猫猫问号.jpg', 'jpg', 60, 'http://localhost:9090/file/f7061dd716d24589887a3461078eee77.jpg', 'e0799d0faaa2b10b95c1e8e08c2c5fc0', 0, 1);
INSERT INTO `sys_file` VALUES (53, 'pink.jpg', 'jpg', 65, 'http://localhost:9090/file/da8d48ac70c14cc38d3cb5b93f4b4496.jpg', '826bee1012d46b68f6af327f1a7efceb', 0, 1);
INSERT INTO `sys_file` VALUES (54, '火大.jpg', 'jpg', 9, 'http://localhost:9090/file/2171b7d453d2446ea548ae71df0eb1e0.jpg', '0b26fb5ad8f617117021535953a44892', 0, 1);
INSERT INTO `sys_file` VALUES (55, '收到.jpg', 'jpg', 19, 'http://localhost:9090/file/ba2e0c9866ca499a93eaf06b7c618c0d.jpg', '5a66e7a12caa170be2b439ae5ab032d8', 0, 1);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
                             `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
                             `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路径',
                             `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图标',
                             `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
                             `pid` int(11) NULL DEFAULT NULL COMMENT '父级id',
                             `page_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '页面路径',
                             `sort_num` int(11) NULL DEFAULT NULL COMMENT '排序',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (2, '数据报表', '/dashbord', 'el-icon-s-marketing', '11', NULL, 'Dashbord', 100);
INSERT INTO `sys_menu` VALUES (4, '系统管理', NULL, 'el-icon-s-grid', NULL, NULL, NULL, 900);
INSERT INTO `sys_menu` VALUES (5, '用户管理', '/user', 'el-icon-user', NULL, 4, 'admin/User', 301);
INSERT INTO `sys_menu` VALUES (6, '角色管理', '/role', 'el-icon-s-custom', NULL, 4, 'Role', 302);
INSERT INTO `sys_menu` VALUES (7, '菜单管理', '/menu', 'el-icon-menu', NULL, 4, 'Menu', 303);
INSERT INTO `sys_menu` VALUES (8, '文件管理', '/file', 'el-icon-document', NULL, 4, 'File', 304);
INSERT INTO `sys_menu` VALUES (10, '主页', '/home', 'el-icon-house', NULL, NULL, 'Home', 0);
INSERT INTO `sys_menu` VALUES (39, '课程管理', '/course', 'el-icon-menu', NULL, NULL, 'Course', 201);
INSERT INTO `sys_menu` VALUES (40, '图书管理', '/book', 'el-icon-notebook-1', '管理员图书管理', NULL, 'admin/Book', 400);
INSERT INTO `sys_menu` VALUES (41, '读者管理', '/reader', 'el-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solidel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid', '读者管理', NULL, 'admin/Reader', 500);
INSERT INTO `sys_menu` VALUES (42, '所有借阅记录', '/record', 'el-icon-s-order', '管理员查询所有借阅记录', NULL, 'admin/Record', 600);
INSERT INTO `sys_menu` VALUES (46, 'admin主页', '/admin/home', 'el-icon-house', 'admin主页', NULL, 'admin/Home', 50);
INSERT INTO `sys_menu` VALUES (47, '我的借阅记录', '/record', 'el-icon-s-order', '读者借阅记录', NULL, 'reader/Record', 601);
INSERT INTO `sys_menu` VALUES (48, '图书信息', '/book', 'el-icon-notebook-1', '用户查询图书信息', NULL, 'reader/Book', 401);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
                             `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
                             `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
                             `flag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '唯一标识',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', '管理员', 'ROLE_ADMIN');
INSERT INTO `sys_role` VALUES (4, '图书管理员', '图书管理员', 'ROLE_BOOK_MANAGER');
INSERT INTO `sys_role` VALUES (5, '读者', '读者', 'ROLE_READER');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
                                  `role_id` int(11) NOT NULL COMMENT '角色id',
                                  `menu_id` int(11) NOT NULL COMMENT '菜单id',
                                  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色菜单关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2);
INSERT INTO `sys_role_menu` VALUES (1, 4);
INSERT INTO `sys_role_menu` VALUES (1, 5);
INSERT INTO `sys_role_menu` VALUES (1, 6);
INSERT INTO `sys_role_menu` VALUES (1, 7);
INSERT INTO `sys_role_menu` VALUES (1, 8);
INSERT INTO `sys_role_menu` VALUES (1, 10);
INSERT INTO `sys_role_menu` VALUES (1, 39);
INSERT INTO `sys_role_menu` VALUES (1, 40);
INSERT INTO `sys_role_menu` VALUES (1, 41);
INSERT INTO `sys_role_menu` VALUES (1, 42);
INSERT INTO `sys_role_menu` VALUES (1, 46);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 9);
INSERT INTO `sys_role_menu` VALUES (2, 10);
INSERT INTO `sys_role_menu` VALUES (2, 40);
INSERT INTO `sys_role_menu` VALUES (2, 41);
INSERT INTO `sys_role_menu` VALUES (2, 42);
INSERT INTO `sys_role_menu` VALUES (2, 43);
INSERT INTO `sys_role_menu` VALUES (2, 44);
INSERT INTO `sys_role_menu` VALUES (2, 45);
INSERT INTO `sys_role_menu` VALUES (3, 2);
INSERT INTO `sys_role_menu` VALUES (3, 9);
INSERT INTO `sys_role_menu` VALUES (3, 10);
INSERT INTO `sys_role_menu` VALUES (3, 39);
INSERT INTO `sys_role_menu` VALUES (4, 2);
INSERT INTO `sys_role_menu` VALUES (4, 9);
INSERT INTO `sys_role_menu` VALUES (4, 10);
INSERT INTO `sys_role_menu` VALUES (4, 40);
INSERT INTO `sys_role_menu` VALUES (4, 41);
INSERT INTO `sys_role_menu` VALUES (4, 42);
INSERT INTO `sys_role_menu` VALUES (4, 45);
INSERT INTO `sys_role_menu` VALUES (5, 10);
INSERT INTO `sys_role_menu` VALUES (5, 47);
INSERT INTO `sys_role_menu` VALUES (5, 48);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
                             `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
                             `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
                             `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
                             `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
                             `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
                             `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
                             `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                             `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
                             `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
                             `credit` tinyint(4) NULL DEFAULT 100 COMMENT '信用积分：\r\n1、初始为100分，上限为100分；\r\n2、逾期一次扣10分；\r\n3、低于80分禁止借书；\r\n4、每个月的1号恢复10分；\r\n5、还书一次加5分。',
                             `baned` tinyint(4) NULL DEFAULT 0 COMMENT '是否被禁用：0-未被禁用 1-被禁用',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'admin', 'Closer', 'admin@qq.com', '1111111111111', 'hahahaha', '2022-01-22 21:10:27', 'http://localhost:9090/file/da8d48ac70c14cc38d3cb5b93f4b4496.jpg', 'ROLE_ADMIN', 100, 0);
INSERT INTO `sys_user` VALUES (17, '333', '123', '我是三三哦豁', '3', '3', '3', '2022-02-26 22:10:18', 'http://localhost:9090/file/da8d48ac70c14cc38d3cb5b93f4b4496.jpg', 'ROLE_READER', 100, 0);
INSERT INTO `sys_user` VALUES (18, 'nz', '123', '哪吒', '2', '2', '2', '2022-03-29 16:59:44', '', 'ROLE_READER', 100, 0);
INSERT INTO `sys_user` VALUES (19, 'yss', '123', '亚瑟', '3', '3', '3', '2022-04-29 16:59:44', '', 'ROLE_READER', 100, 0);
INSERT INTO `sys_user` VALUES (20, 'lx', '123', '李信', '2', '2', '2', '2022-05-29 17:12:04', '', 'ROLE_READER', 100, 0);
INSERT INTO `sys_user` VALUES (25, 'sir', '123', '安琪拉', NULL, NULL, NULL, '2022-06-08 17:00:47', '', 'ROLE_BOOK_MANAGER', 100, 0);
INSERT INTO `sys_user` VALUES (26, 'err', '123', '妲己', '11', '1', '1', '2022-07-08 17:20:01', '', 'ROLE_BOOK_MANAGER', 100, 0);
INSERT INTO `sys_user` VALUES (28, 'ddd', '123', 'ddd', '', '', '', '2022-11-09 10:41:07', '', 'ROLE_READER', 100, 1);
INSERT INTO `sys_user` VALUES (29, 'ffff', '123', NULL, NULL, NULL, NULL, '2022-12-10 11:53:31', '', 'ROLE_READER', 70, 0);
INSERT INTO `sys_user` VALUES (30, '123', '123', NULL, NULL, NULL, NULL, '2022-03-11 16:45:06', '', 'ROLE_READER', 100, 0);

-- ----------------------------
-- Table structure for t_book
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book`  (
                           `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书ID',
                           `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '书名',
                           `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'ISBN码',
                           `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '作者',
                           `publisher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '出版社',
                           `publish_time` date NULL DEFAULT NULL COMMENT '出版时间',
                           `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '上架时间',
                           `nums` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '馆藏数量',
                           `status` tinyint(1) NULL DEFAULT 1 COMMENT '图书状态：1-上架 0-下架',
                           `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书封面',
                           `version` int(11) NULL DEFAULT 1 COMMENT '乐观锁',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_book
-- ----------------------------
INSERT INTO `t_book` VALUES (1, '123', '6464618646846', '测试', '出版社', '2022-03-16', '2022-03-16 16:48:30', '7', 1, 'http://localhost:9090/file/da8d48ac70c14cc38d3cb5b93f4b4496.jpg', 10);
INSERT INTO `t_book` VALUES (2, 'Java编程基础', '1234563424234', '詹姆斯高斯林', 'Java出版社', '2022-03-15', '2022-03-17 11:44:30', '0', 1, 'http://localhost:9090/file/da8d48ac70c14cc38d3cb5b93f4b4496.jpg', 5);
INSERT INTO `t_book` VALUES (7, '收手吧，阿祖', '1233333333333', 'cat', '出版社', '2022-03-15', '2022-03-17 15:43:16', '1', 1, 'http://localhost:9090/file/8b2338d556194eba8da3e00faae6f0de.jpg', 16);
INSERT INTO `t_book` VALUES (8, '大耳朵图图', '1111111111111', 'niuniu', '出版社', '2022-03-16', '2022-03-17 15:43:14', '1', 1, 'http://localhost:9090/file/84efbae5735140e4bf63fdcd8463eebd.jpg', 18);
INSERT INTO `t_book` VALUES (9, '猫猫问号', '1111111111111', '猫猫', '猫猫出版社', '2022-03-17', '2022-03-17 11:44:32', '0', 1, 'http://localhost:9090/file/2171b7d453d2446ea548ae71df0eb1e0.jpg', 4);
INSERT INTO `t_book` VALUES (10, '测试', '1111111111111', '熊猫', '出版社', '2022-03-16', '2022-03-17 15:16:24', '3', 1, 'http://localhost:9090/file/ba2e0c9866ca499a93eaf06b7c618c0d.jpg', 9);

-- ----------------------------
-- Table structure for t_record
-- ----------------------------
DROP TABLE IF EXISTS `t_record`;
CREATE TABLE `t_record`  (
                             `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '借书记录id',
                             `user_id` int(11) NOT NULL COMMENT '用户ID',
                             `book_id` int(11) NOT NULL COMMENT '图书ID',
                             `borrow_time` date NULL DEFAULT NULL COMMENT '借书时间',
                             `expire_time` date NULL DEFAULT NULL COMMENT '到期时间',
                             `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
                             `status` tinyint(1) NULL DEFAULT 0 COMMENT '借阅记录状态：0-未还 1-已还 2-逾期',
                             `renew` tinyint(1) NULL DEFAULT NULL COMMENT '是否续借：0-未续借 1：已续借',
                             `return_time` datetime NULL DEFAULT NULL COMMENT '还书时间',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_record
-- ----------------------------
INSERT INTO `t_record` VALUES (1, 28, 1, '2022-03-17', '2022-06-17', '2022-03-17 15:46:06', 1, 1, '2022-03-17 15:51:10');
INSERT INTO `t_record` VALUES (2, 28, 7, '2022-03-17', '2022-05-17', '2022-03-17 15:46:40', 1, 0, '2022-03-17 15:58:24');
INSERT INTO `t_record` VALUES (3, 28, 8, '2022-03-17', '2022-06-17', '2022-03-17 15:46:42', 1, 1, '2022-03-17 15:57:57');
INSERT INTO `t_record` VALUES (4, 28, 8, '2022-03-17', '2022-05-17', '2022-03-17 15:58:40', 1, 0, '2022-03-17 16:08:55');
INSERT INTO `t_record` VALUES (5, 28, 10, '2022-03-17', '2022-06-17', '2022-03-17 15:58:55', 1, 1, '2022-03-17 16:09:01');
INSERT INTO `t_record` VALUES (6, 28, 10, '2022-03-17', '2022-05-17', '2022-03-17 17:50:48', 1, 0, '2022-03-18 11:07:08');
INSERT INTO `t_record` VALUES (7, 28, 8, '2022-03-18', '2022-06-18', '2022-03-18 11:11:45', 1, 1, '2022-03-18 11:11:53');
INSERT INTO `t_record` VALUES (8, 28, 8, '2022-03-18', '2022-05-18', '2022-03-18 11:12:07', 1, 0, '2022-03-18 16:05:08');
INSERT INTO `t_record` VALUES (9, 28, 7, '2022-03-18', '2022-05-18', '2022-03-18 11:12:12', 1, 0, '2022-03-18 16:05:08');
INSERT INTO `t_record` VALUES (10, 28, 8, '2022-03-18', '2022-05-18', '2022-03-18 16:07:07', 1, 0, '2022-03-18 16:07:20');
INSERT INTO `t_record` VALUES (11, 28, 7, '2022-03-18', '2022-05-18', '2022-03-18 16:13:05', 0, 0, NULL);

SET FOREIGN_KEY_CHECKS = 1;
