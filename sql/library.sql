/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : localhost:3306
 Source Schema         : qing

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 11/03/2022 17:55:08
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
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (37, '收手吧阿祖.jpg', 'jpg', 31, 'http://localhost:9090/file/096ff7bd17fb43cca8342dde57f9403b.jpg', '93cd03f2a61f2719ccec04d2644b2cb1', 0, 1);
INSERT INTO `sys_file` VALUES (38, 'pink.jpg', 'jpg', 65, 'http://localhost:9090/file/19cd5fadb7a042e0ac50a4fef3bbb3ae.jpg', '826bee1012d46b68f6af327f1a7efceb', 0, 1);
INSERT INTO `sys_file` VALUES (39, '俺的图图呢.jpg', 'jpg', 12, 'http://localhost:9090/file/6b29c66802bf49c79a1dd560864b3c7e.jpg', '5fbe770b67fea403356f877257ba8c1d', 0, 1);
INSERT INTO `sys_file` VALUES (40, '哆啦V梦.jpg', 'jpg', 12, 'http://localhost:9090/file/ca26453f9ec74aab927d63581430455c.jpg', '89040393ff67e227b25b2131538900a5', 0, 1);
INSERT INTO `sys_file` VALUES (41, 'cry.jpg', 'jpg', 74, 'http://localhost:9090/file/86b90473f4d14864a0f50c4684106107.jpg', '03098b2073c1caa2a41bddda6245632f', 0, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (2, '数据报表', '/dashbord', 'el-icon-s-marketing', '11', NULL, 'Dashbord', 100);
INSERT INTO `sys_menu` VALUES (4, '系统管理', NULL, 'el-icon-s-grid', NULL, NULL, NULL, 300);
INSERT INTO `sys_menu` VALUES (5, '用户管理', '/user', 'el-icon-user', NULL, 4, 'User', 301);
INSERT INTO `sys_menu` VALUES (6, '角色管理', '/role', 'el-icon-s-custom', NULL, 4, 'Role', 302);
INSERT INTO `sys_menu` VALUES (7, '菜单管理', '/menu', 'el-icon-menu', NULL, 4, 'Menu', 303);
INSERT INTO `sys_menu` VALUES (8, '文件管理', '/file', 'el-icon-document', NULL, 4, 'File', 304);
INSERT INTO `sys_menu` VALUES (9, '请作者喝杯咖啡', '/donate', 'el-icon-coffee\r\n', NULL, NULL, 'Donate', 200);
INSERT INTO `sys_menu` VALUES (10, '主页', '/home', 'el-icon-house', NULL, NULL, 'Home', 0);
INSERT INTO `sys_menu` VALUES (39, '课程管理', '/course', 'el-icon-menu', NULL, NULL, 'Course', 201);
INSERT INTO `sys_menu` VALUES (40, '图书管理', '', 'el-icon-notebook-1', '图书管理', NULL, '', 400);
INSERT INTO `sys_menu` VALUES (41, '读者管理', '/reader', 'el-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solidel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid\r\nel-icon-user-solid', '读者管理', NULL, 'Reader', 500);
INSERT INTO `sys_menu` VALUES (42, '借阅记录', '/record', 'el-icon-s-order', '借阅记录', NULL, 'Record', 600);
INSERT INTO `sys_menu` VALUES (43, '借阅图书', '/borrow', 'el-icon-notebook-1', '借阅图书', 40, 'Borrow', 402);
INSERT INTO `sys_menu` VALUES (44, '归还图书', '/return', 'el-icon-notebook-2', '归还图书', 40, 'Return', 403);

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
INSERT INTO `sys_role` VALUES (2, '学生', '学生', 'ROLE_STUDENT');
INSERT INTO `sys_role` VALUES (3, '老师', '老师', 'ROLE_TEACHER');
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
INSERT INTO `sys_role_menu` VALUES (1, 9);
INSERT INTO `sys_role_menu` VALUES (1, 10);
INSERT INTO `sys_role_menu` VALUES (1, 39);
INSERT INTO `sys_role_menu` VALUES (1, 40);
INSERT INTO `sys_role_menu` VALUES (1, 41);
INSERT INTO `sys_role_menu` VALUES (1, 42);
INSERT INTO `sys_role_menu` VALUES (1, 43);
INSERT INTO `sys_role_menu` VALUES (1, 44);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 5);
INSERT INTO `sys_role_menu` VALUES (2, 6);
INSERT INTO `sys_role_menu` VALUES (2, 7);
INSERT INTO `sys_role_menu` VALUES (2, 8);
INSERT INTO `sys_role_menu` VALUES (2, 9);
INSERT INTO `sys_role_menu` VALUES (2, 10);
INSERT INTO `sys_role_menu` VALUES (2, 39);
INSERT INTO `sys_role_menu` VALUES (2, 40);
INSERT INTO `sys_role_menu` VALUES (2, 41);
INSERT INTO `sys_role_menu` VALUES (2, 42);
INSERT INTO `sys_role_menu` VALUES (2, 43);
INSERT INTO `sys_role_menu` VALUES (2, 44);
INSERT INTO `sys_role_menu` VALUES (3, 2);
INSERT INTO `sys_role_menu` VALUES (3, 9);
INSERT INTO `sys_role_menu` VALUES (3, 10);
INSERT INTO `sys_role_menu` VALUES (3, 39);
INSERT INTO `sys_role_menu` VALUES (4, 2);
INSERT INTO `sys_role_menu` VALUES (4, 10);
INSERT INTO `sys_role_menu` VALUES (4, 40);
INSERT INTO `sys_role_menu` VALUES (4, 41);
INSERT INTO `sys_role_menu` VALUES (4, 42);

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'admin', '程序员青戈', 'admin@qq.com', '13988997788', '安徽合肥1', '2022-01-22 21:10:27', 'http://localhost:9090/file/19cd5fadb7a042e0ac50a4fef3bbb3ae.jpg', 'ROLE_ADMIN');
INSERT INTO `sys_user` VALUES (16, '222', NULL, '甄姬好大', '2', '2', '2', '2022-02-26 22:10:14', NULL, 'ROLE_TEACHER');
INSERT INTO `sys_user` VALUES (17, '333', '123', '我是三三哦豁', '3', '3', '3', '2022-02-26 22:10:18', 'http://localhost:9090/file/86b90473f4d14864a0f50c4684106107.jpg', 'ROLE_TEACHER');
INSERT INTO `sys_user` VALUES (18, 'nz', '123', '哪吒', '2', '2', '2', '2022-03-29 16:59:44', '', 'ROLE_STUDENT');
INSERT INTO `sys_user` VALUES (19, 'yss', '123', '亚瑟', '3', '3', '3', '2022-04-29 16:59:44', 'http://localhost:9090/file/ca26453f9ec74aab927d63581430455c.jpg', 'ROLE_STUDENT');
INSERT INTO `sys_user` VALUES (20, 'lx', '123', '李信', '2', '2', '2', '2022-05-29 17:12:04', '2', 'ROLE_TEACHER');
INSERT INTO `sys_user` VALUES (25, 'sir', '123', '安琪拉', NULL, NULL, NULL, '2022-06-08 17:00:47', NULL, NULL);
INSERT INTO `sys_user` VALUES (26, 'err', NULL, '妲己', '11', '1', '1', '2022-07-08 17:20:01', NULL, NULL);
INSERT INTO `sys_user` VALUES (28, 'ddd', '123', 'ddd', '', '', '', '2022-11-09 10:41:07', '', 'ROLE_STUDENT');
INSERT INTO `sys_user` VALUES (29, 'ffff', '123', NULL, NULL, NULL, NULL, '2022-12-10 11:53:31', NULL, 'ROLE_STUDENT');
INSERT INTO `sys_user` VALUES (30, '123', '123', NULL, NULL, NULL, NULL, '2022-03-11 16:45:06', NULL, 'ROLE_USER');

-- ----------------------------
-- Table structure for t_book
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书ID',
    `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '书名',
    `isbn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ISBN码',
    `author` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '作者',
    `publisher` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '出版社',
    `publish_time` date DEFAULT NULL COMMENT '出版时间',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '上架时间',
    `nums` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '馆藏数量',
    `status` tinyint(1) DEFAULT '1' COMMENT '图书状态：1-上架 0-下架',
    `img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图书封面',
    `version` int(11) DEFAULT '1' COMMENT '乐观锁',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for t_record
-- ----------------------------
DROP TABLE IF EXISTS `t_record`;
CREATE TABLE `t_record` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '借书记录id',
    `user_id` int(11) NOT NULL COMMENT '用户ID',
    `book_id` int(11) NOT NULL COMMENT '图书ID',
    `borrow_time` date DEFAULT NULL COMMENT '借书时间',
    `expire_time` date DEFAULT NULL COMMENT '到期时间',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `status` tinyint(1) DEFAULT '0' COMMENT '借阅记录状态：1-已还 0-未还 2-逾期',
    `renew` tinyint(1) DEFAULT NULL COMMENT '是否续借：0-未续借 1：已续借',
    `return_time` datetime DEFAULT NULL COMMENT '还书时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
