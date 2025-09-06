/*
 Navicat Premium Data Transfer

 Source Server         : gf2
 Source Server Type    : MySQL
 Source Server Version : 80012 (8.0.12)
 Source Host           : localhost:3306
 Source Schema         : gf2

 Target Server Type    : MySQL
 Target Server Version : 80012 (8.0.12)
 File Encoding         : 65001

 Date: 14/07/2024 07:17:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin1无用
-- ----------------------------
DROP TABLE IF EXISTS `admin1无用`;
CREATE TABLE `admin1无用`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员用户名,长度10',
  `password` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码,长度10',
  `created_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin1无用
-- ----------------------------
INSERT INTO `admin1无用` VALUES (1, 'youxue', 'jinjin1984', NULL, NULL);
INSERT INTO `admin1无用` VALUES (2, 'admin', 'jinjin1984', NULL, NULL);

-- ----------------------------
-- Table structure for admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单id,为菜单的唯一识别.当前配置根据此项作为显示顺序了.sort字段未用',
  `menu_id` char(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '废,可备用',
  `menu_url` char(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '菜单所在的路由url.要在main.dart的getx路由设置',
  `menu_name` char(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '菜单名称',
  `parent_id` char(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '父节点id',
  `icon` blob NULL COMMENT '图标',
  `sort` tinyint(2) UNSIGNED ZEROFILL NOT NULL DEFAULT 00 COMMENT '显示菜单的序号,默认0',
  `isshow` bit(1) NOT NULL DEFAULT b'1' COMMENT '菜单是否显示.默认1显示',
  `created_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '设置后台的菜单名称和路径和菜单id' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_menu
-- ----------------------------
INSERT INTO `admin_menu` VALUES (14, '0', '/admin/wzxx', '网站信息', '0', 0x566D30776432517955586C565747785859544A6F56466C7464486456566C703054565A4F566B315865486C5762545672566D314B52324E49624664574D314A4D566C566156315A564D555668656A4139, 99, b'1', '2024-04-01 17:15:28', '2024-05-24 17:38:22');
INSERT INTO `admin_menu` VALUES (15, '0', '/admin/xtsz', '系统设置', '0', 0x28424C4F42292030206279746573, 01, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (16, '0', '/admin/yhgl', '用户管理', '0', 0x28424C4F42292030206279746573, 02, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (17, '0', '/admin/zdym', '站点域名', '14', 0x4B454A4D5430497049444167596E6C305A584D3D, 00, b'1', '2024-04-01 17:15:28', '2024-06-22 19:56:39');
INSERT INTO `admin_menu` VALUES (18, '0', '/admin/zdmc', '站点名称', '14', 0x28424C4F42292030206279746573, 00, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (19, '0', '/admin/gnsz', '功能设置', '15', 0x4B454A4D5430497049444167596E6C305A584D3D, 00, b'1', '2024-04-01 17:15:28', '2024-05-28 06:25:51');
INSERT INTO `admin_menu` VALUES (20, '0', '/admin/wjcc', '文件存储', '15', 0x28424C4F42292030206279746573, 00, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (21, '0', '/admin/yhxx', '用户信息', '16', 0x28424C4F42292030206279746573, 00, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (22, '0', '/admin/nrgn', '内容功能', '0', 0x28424C4F42292030206279746573, 03, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (23, '0', '/admin/wzfb', '文章发布', '22', 0x28424C4F42292030206279746573, 00, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (24, '0', '/admin/wzgl', '文章管理', '22', 0x28424C4F42292030206279746573, 00, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (25, '0', '/admin/qita', '其他', '0', 0x28424C4F42292030206279746573, 04, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (26, '0', '/admin/seo', 'seo', '25', 0x28424C4F42292030206279746573, 00, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (27, '0', '/admin/zpfb', '招聘发布', '22', 0x28424C4F42292030206279746573, 00, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (28, '0', '/admin/zpgl', '招聘管理', '22', 0x28424C4F42292030206279746573, 00, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (29, '0', '/admin/yhzx', '用户中心', '0', 0x28424C4F42292030206279746573, 05, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (30, '0', '/admin/grzx', '个人中心', '29', '', 00, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (31, '0', '/admin/zlxg', '资料修改', '29', 0x28424C4F42292030206279746573, 00, b'1', '2024-04-01 17:15:28', '2024-04-01 17:15:28');
INSERT INTO `admin_menu` VALUES (57, '0', '/admin/test1', '测试1', '0', NULL, 01, b'1', '2024-05-24 19:30:06', '2024-05-24 19:30:06');
INSERT INTO `admin_menu` VALUES (58, '0', '/admin/test11', '测试11', '57', NULL, 01, b'1', '2024-05-24 19:30:24', '2024-05-24 19:30:24');
INSERT INTO `admin_menu` VALUES (63, '0', '/admin/qxgl', '权限管理', '15', NULL, 01, b'1', '2024-05-28 06:43:11', '2024-05-28 06:43:11');
INSERT INTO `admin_menu` VALUES (64, '0', 'admin/test12', '测试12', '57', NULL, 01, b'1', '2024-06-23 06:28:03', '2024-06-23 06:28:03');

-- ----------------------------
-- Table structure for casbin_rule
-- ----------------------------
DROP TABLE IF EXISTS `casbin_rule`;
CREATE TABLE `casbin_rule`  (
  `ptype` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `v0` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `v1` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `v2` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `v3` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `v4` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `v5` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  INDEX `IDX_casbin_rule_ptype`(`ptype`) USING BTREE,
  INDEX `IDX_casbin_rule_v0`(`v0`) USING BTREE,
  INDEX `IDX_casbin_rule_v1`(`v1`) USING BTREE,
  INDEX `IDX_casbin_rule_v2`(`v2`) USING BTREE,
  INDEX `IDX_casbin_rule_v3`(`v3`) USING BTREE,
  INDEX `IDX_casbin_rule_v4`(`v4`) USING BTREE,
  INDEX `IDX_casbin_rule_v5`(`v5`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '管理后台权限规则.ptype的列:p填写权限,g为用户具备的角色.\r\n表格中的规则就是按照.角色是admin或user,权限对应表中的v1,也就是菜单的url.这里要说明的是,这里不写url也是可以的,只要能够唯一表示菜单页面的标识就行,且这个标识要与admin_menu表中的menu_url对应即可.访问规则是post/get等.此表只写入二级菜单即可,一级菜单只是一个提示作用,真正的控制权限是二级菜单哦.' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of casbin_rule
-- ----------------------------
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/gnsz', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/yhgl', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/yhxx', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/xtsz', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/grzx', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/wzfb', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/wzgl', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/wzxx', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/nrgn', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/zdmc', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/zpgl', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/zpfb', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/grzx', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/zlxg', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/yhzx', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/wzfb', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/test11', '', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/nrgn', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/wzxx', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/yhzx', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/user/user_get_article', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/yhgl', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/qita', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/zpfb', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/zhuce', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/test11', '', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/test1', '', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/test1', '', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/seo', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/qita', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'admin', '/admin/qxgl', 'post', '', '', '');
INSERT INTO `casbin_rule` VALUES ('p', 'user', '/admin/xtsz', 'post', '', '', '');

-- ----------------------------
-- Table structure for job_gangwei
-- ----------------------------
DROP TABLE IF EXISTS `job_gangwei`;
CREATE TABLE `job_gangwei`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gangwei` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_gangwei
-- ----------------------------
INSERT INTO `job_gangwei` VALUES (1, 'c开发', NULL, NULL);
INSERT INTO `job_gangwei` VALUES (2, 'python开发', NULL, NULL);
INSERT INTO `job_gangwei` VALUES (5, '单片机', NULL, NULL);
INSERT INTO `job_gangwei` VALUES (3, 'PLC', NULL, NULL);

-- ----------------------------
-- Table structure for ren_cai_zhao_pin
-- ----------------------------
DROP TABLE IF EXISTS `ren_cai_zhao_pin`;
CREATE TABLE `ren_cai_zhao_pin`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gong_si_ming` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '招聘的公司名',
  `gangwei` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '岗位',
  `renshu` int(11) NULL DEFAULT NULL COMMENT '招聘人数',
  `xueli` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '学历',
  `yaoqiu` varchar(1000) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '要求',
  `baoxian` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '包括:五险一金,包吃, 加班补助 包住 饭补 交通补助 年底双薪 周末双休',
  `xinchou` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '薪酬',
  `lianxifangshi` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '联系方式',
  `created_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  `liulanshu` int(11) NULL DEFAULT 0 COMMENT '浏览数',
  `yingpinzhe_id` json NULL COMMENT '应聘者id字符串.使用逗号分隔.插入时需要加逗号',
  `kaishishijian` datetime NULL DEFAULT NULL COMMENT '招聘的开始时间',
  `jieshushijian` datetime NULL DEFAULT NULL COMMENT '招聘的结束时间',
  `youxiang` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '接收简历通知的邮箱',
  `qita` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '其他,备用',
  `quanzhi` varchar(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '全职兼职',
  `dizhi` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '招聘地址',
  `gongzuonianxian` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '工作年限',
  `tupian` json NULL COMMENT '图片json',
  `zuozhe` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '发布者',
  `zhiding` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '0' COMMENT '置顶,默认字符串0',
  `jinghua` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '0' COMMENT '精华,默认字符串0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 151 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '人才招聘' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ren_cai_zhao_pin
-- ----------------------------
INSERT INTO `ren_cai_zhao_pin` VALUES (26, '游学电子990', '2', 1, '无要求', '1.二位分为0\n2.而乏味0\n', '[双休,加班补助]', '0-1000', '15241345678', '2023-02-05 09:49:23', '2023-05-27 05:27:00', 0, '{\"应聘者\": [{\"id\": \"1\", \"name\": \"jin\"}, {\"id\": \"2\", \"name\": \"yuan\"}, {\"id\": \"3\", \"name\": \"qing\"}, {\"id\": \"4\", \"name\": \"a\"}]}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '987654320', '', '全职', '市区', '无要求', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (142, '123123124', '2', 10, '专科', '12312123', '[带薪休假,加班补助,单休]', '6000-7000', '1', '2023-05-14 13:28:05', '2023-05-14 13:29:03', 0, '{\"应聘者\": []}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '123', '', '兼职', '黑山', '无要求', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (143, '234', '2', 6, '本科以上', '234', '[包吃]', '4000-5000', '2342', '2023-05-27 05:20:23', '2023-05-27 05:20:23', 0, '{\"应聘者\": []}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '23423', '', '兼职', '黑山', '1-2年', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (146, '123', '3', 1, '无要求', '1212', '[五险一金]', '0-1000', '12', '2023-05-28 00:26:01', '2023-05-28 00:26:01', 0, '{\"应聘者\": []}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '12', '', '全职', '黑山', '无要求', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (139, '123', '1', 11, '专科', '12312', '[包吃,带薪休假,单休]', '6000-7000', '11231', '2023-05-13 05:11:10', '2023-05-13 05:11:10', 0, '{\"应聘者\": []}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '123123', '', '兼职', '义县', '5-6年', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (138, 'werwerwer', '1', 10, '本科', 'wer', '[单休,电话补助]', '5000-6000', '345345', '2023-05-13 04:32:59', '2023-05-13 04:32:59', 0, '{\"应聘者\": []}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '11111111', '', '兼职', '义县', '5-6年', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (137, 'werwerwer', '2', 10, '本科', 'wer', '[包吃,双休]', '5000-6000', '23423423', '2023-05-13 04:30:32', '2023-05-13 04:30:32', 0, '{\"应聘者\": []}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '234234234', '', '兼职', '义县', '5-6年', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (140, '12', '2', 13, '本科', '12', '[包吃,五险一金]', '5000-6000', '12', '2023-05-13 06:01:15', '2023-05-13 06:01:15', 0, '{\"应聘者\": []}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '12', '', '兼职', '黑山', '3-4年', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (136, '4', '1', 6, '无要求', '5', '[五险一金,交通补助,包住]', '9000-10000', '1', '2023-05-11 21:44:42', '2023-05-11 21:44:42', 0, '{\"应聘者\": []}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '2', '', '全职', '义县', '1-2年', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"http://127.0.0.1:8199/upload_file/c24a91de-157a-4863-b705-f2b04778b2be.jpg\"}, {\"id\": \"2\", \"picurl\": \"http://127.0.0.1:8199/upload_file/3a92dd47-6737-4447-ba99-17a2ad24f9c4.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (132, '游学电子99', '2', 1, '无要求', '1', '[带薪休假]', '0-1000', '1', '2023-02-22 19:07:25', '2023-02-22 19:07:25', 0, '{\"应聘者\": [{\"id\": \"1\", \"name\": \"jin\"}, {\"id\": \"2\", \"name\": \"yuan\"}, {\"id\": \"3\", \"name\": \"qing\"}, {\"id\": \"4\", \"name\": \"a\"}]}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '1', '', '全职', '凌海', '1-2年', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"http://127.0.0.1:8199/upload_file/63912e39-8d7b-43c4-9ea1-60e20bdd5cee.png\"}, {\"id\": \"2\", \"picurl\": \"http://127.0.0.1:8199/upload_file/63912e39-8d7b-43c4-9ea1-60e20bdd5cee.png\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (135, '中国银行', '1', 1, '无要求', '1', '[包吃,五险一金]', '0-1000', '1', '2023-05-11 14:43:59', '2023-05-11 14:43:59', 0, '{\"应聘者\": []}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '1', '', '兼职', '凌海', '9-10年', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"http://127.0.0.1:8199/upload_file/11f334c3-3dc8-44b2-8f7d-18951e9b89ec.jpg\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"http://127.0.0.1:8199/upload_file/1dc49cab-5c7a-473a-a622-66d39fd332e9.jpg\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (141, '2', '1', 1, '无要求', '1', '[双休,加班补助]', '0-1000', '1', '2023-05-14 07:25:53', '2023-05-27 08:38:50', 0, '{\"应聘者\": [{\"id\": \"1\", \"name\": \"jin\"}, {\"id\": \"2\", \"name\": \"yuan\"}, {\"id\": \"3\", \"name\": \"qing\"}, {\"id\": \"4\", \"name\": \"a\"}]}', '2018-02-09 12:46:17', '2018-02-09 12:46:17', '1', '', '全职', '黑山', '无要求', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', 'youxue', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (148, '234', '1', 2, '本科以上', '234', '[]', '2000-3000', '2', '2023-05-30 11:00:31', '2023-05-30 11:00:31', 0, '{\"应聘者\": []}', '2018-02-09 20:46:17', '2018-02-09 20:46:17', '234', '', '全职', '市区', '无要求', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', 'youxue1', '0', '0');
INSERT INTO `ren_cai_zhao_pin` VALUES (150, '游学电子', '1', 8, '本科以上', '1.\n2.3\n4', '[带薪休假]', '1000-2000', '15241366729', '2023-12-16 10:56:39', '2023-12-16 10:56:39', 0, '{\"应聘者\": []}', '2018-02-09 20:46:17', '2018-02-09 20:46:17', '1515512@qq.com', '', '全职', '市区', '无要求', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}', '管理员', '', '');

-- ----------------------------
-- Table structure for test_redis
-- ----------------------------
DROP TABLE IF EXISTS `test_redis`;
CREATE TABLE `test_redis`  (
  `name` json NULL
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_redis
-- ----------------------------
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706298421-1\", \"Values\": {\"name\": \"2\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706298421-0\", \"Values\": {\"name\": \"1\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297771-0\", \"Values\": {\"name\": \"6\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297770-2\", \"Values\": {\"name\": \"5\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297770-1\", \"Values\": {\"name\": \"4\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297770-0\", \"Values\": {\"name\": \"3\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297769-1\", \"Values\": {\"name\": \"2\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297769-0\", \"Values\": {\"name\": \"1\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297016-1\", \"Values\": {\"name\": \"6\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297016-0\", \"Values\": {\"name\": \"5\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297015-0\", \"Values\": {\"name\": \"4\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297014-1\", \"Values\": {\"name\": \"3\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297014-0\", \"Values\": {\"name\": \"2\"}}');
INSERT INTO `test_redis` VALUES ('{\"ID\": \"1714706297013-0\", \"Values\": {\"name\": \"1\"}}');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `username` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通行证/用户名',
  `password` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `nickname` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `birthday` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出生日期',
  `beiyong1` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用.用户是否被禁用',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别0/1.1男0女',
  `qianming` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '签名',
  `shenfenzheng` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后登录ip',
  `touxiang` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `jifen` int(10) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '积分',
  `isadmin` bit(1) NULL DEFAULT b'0' COMMENT '管理员.布尔.1管理,0普通',
  `apinum` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '访问api的次数上限',
  `isused` bit(1) NOT NULL DEFAULT b'0' COMMENT '用户是否启用.0禁止1启用 bool',
  `apiused` int(11) NOT NULL DEFAULT 0 COMMENT '已经使用了多少次api.默认0',
  `create_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  `update_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1079 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1062, 'youxue', 'jinjin1984', '123@qq.com', '辽宁义县', '管理员', '15112345678', '19840318', '0', '男', '签名', '', '', 'http://127.0.0.1:8199/upload_file/3c4965df-0230-4e36-a916-be79d4d1c6d4.jpg', 0000000000, b'1', 0, b'1', 0, '2023-06-23 16:14:56', '2024-06-21 13:29:56');
INSERT INTO `user` VALUES (1071, 'youxue2', 'jinjin1984', '123456@qq.com', '辽宁锦州义县', '用户', '15112345678', '19840318', '0', '男', '用户签名', '', '', 'http://127.0.0.1:8199/upload_file/3c4965df-0230-4e36-a916-be79d4d1c6d4.jpg', 0000000000, b'0', 0, b'1', 0, '2023-06-23 16:14:56', '2024-06-21 18:18:27');
INSERT INTO `user` VALUES (1073, 'youxue4', 'jinjin1984', '123@qq.com', '锦州义县', 'jinjin1', '15112345678', '19840318', '0', '男', '', '', '', 'http://127.0.0.1:8199/upload_file/3c4965df-0230-4e36-a916-be79d4d1c6d4.jpg', 0000000000, b'0', 0, b'1', 0, '2023-06-23 16:14:56', '2023-06-23 16:14:56');
INSERT INTO `user` VALUES (1074, 'youxue3', 'jinjin1984', '123@qq.com', '锦州义县', 'jinjin1', '15112345678', '19840318', '0', '男', '', '', '', 'http://127.0.0.1:8199/upload_file/3c4965df-0230-4e36-a916-be79d4d1c6d4.jpg', 0000000000, b'0', 0, b'1', 0, '2023-06-23 16:14:56', '2023-06-23 16:14:56');
INSERT INTO `user` VALUES (1075, 'youxue1', 'jinjin1984', '123@qq.com', '锦州义县', 'jinjin1', '15112345678', '19840318', '0', '男', '', '', '', 'http://127.0.0.1:8199/upload_file/3c4965df-0230-4e36-a916-be79d4d1c6d4.jpg', 0000000000, b'0', 0, b'1', 0, '2023-06-23 16:14:56', '2023-06-23 16:14:56');
INSERT INTO `user` VALUES (1076, 'youxue5', 'youxue5', 'youxue5@q.com', '', 'youxue5', '12345678901', '', '', '', '', '', '', '', 0000000000, b'0', 0, b'0', 0, '2024-06-22 11:46:04', '2024-06-22 11:46:04');
INSERT INTO `user` VALUES (1077, 'youxue6', 'youxue6', 'youxue6@qq.com', '', 'youxue6', '12345678901', '', '', '', '', '', '', '', 0000000000, b'0', 0, b'0', 0, '2024-06-22 11:57:31', '2024-06-22 11:57:31');
INSERT INTO `user` VALUES (1078, 'youxue7', 'youxue7', 'youxue7@qq.com', '', 'youxue7', '12345678901', '', '', '', '', '', '', '', 0000000000, b'0', 0, b'0', 0, '2024-06-22 12:03:48', '2024-06-22 12:03:48');

-- ----------------------------
-- Table structure for user_api_limit
-- ----------------------------
DROP TABLE IF EXISTS `user_api_limit`;
CREATE TABLE `user_api_limit`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `url` json NOT NULL COMMENT '接口的路由\r\n ,如{\"urls\": [{\"id\": \"1\", \"url\": \"/hello\"}, {\"id\": \"2\", \"url\": \"/readdata\"}, ]}',
  `maxnum` int(11) NOT NULL DEFAULT 0 COMMENT '当前接口最大次数数量',
  `currentnum` int(11) NOT NULL DEFAULT 0 COMMENT '当前使用的接口次数数量',
  `isopen` bit(1) NOT NULL DEFAULT b'0' COMMENT '0禁止1开启限制',
  `ismax` bit(1) NOT NULL DEFAULT b'0' COMMENT '0未达到最大限制1达到了最大次数限制',
  `created_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_api_limit
-- ----------------------------
INSERT INTO `user_api_limit` VALUES (2, 1, '{\"urls\": [{\"id\": \"1\", \"url\": \"/hello\"}, {\"id\": \"2\", \"url\": \"/readdata\"}]}', 0, 0, b'0', b'0', NULL, NULL);

-- ----------------------------
-- Table structure for user_menu
-- ----------------------------
DROP TABLE IF EXISTS `user_menu`;
CREATE TABLE `user_menu`  (
  `user_menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `user_menu_id` tinyint(4) NULL DEFAULT NULL COMMENT '应该是随意设置',
  `user_menu_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `user_menu_parentid` tinyint(4) NULL DEFAULT NULL,
  `id` int(11) NOT NULL,
  `created_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入'
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '用户菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_menu
-- ----------------------------
INSERT INTO `user_menu` VALUES ('首页', 1, '/user/UserGather', 0, 1, NULL, NULL);
INSERT INTO `user_menu` VALUES ('文章', 2, '/user/wenzhang/Wenzhangfenlei', 0, 2, NULL, NULL);
INSERT INTO `user_menu` VALUES ('招聘', 3, '/user/zhaopin/Zhaopingangwei', 0, 3, NULL, NULL);
INSERT INTO `user_menu` VALUES ('关于', 4, '/user/gongsijianjie/Jianjie', 0, 4, NULL, NULL);
INSERT INTO `user_menu` VALUES ('图片', 5, '/user/tupian', 0, 5, NULL, NULL);
INSERT INTO `user_menu` VALUES ('产品', 6, '/user/chanpin', 0, 6, NULL, NULL);
INSERT INTO `user_menu` VALUES ('资讯', 7, '/user/zixun', 2, 7, NULL, NULL);
INSERT INTO `user_menu` VALUES ('技术', 8, '/user/jishu', 2, 8, NULL, NULL);

-- ----------------------------
-- Table structure for wen_zhang
-- ----------------------------
DROP TABLE IF EXISTS `wen_zhang`;
CREATE TABLE `wen_zhang`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `biaoti` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '汉字长度25.标题',
  `zuozhe` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '汉字长度25.作者',
  `zhaiyao` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '汉字长度50.摘要',
  `suoluetu` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '为字符串,长度30.缩略图',
  `neirong` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL COMMENT '汉字长度65535/2.内容',
  `yuedushu` int(11) NULL DEFAULT 0 COMMENT '阅读数',
  `dianzanshu` int(11) NULL DEFAULT 0 COMMENT '点赞数',
  `fenleiid` int(5) NOT NULL COMMENT '分类id\r\n',
  `zhiding` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '0' COMMENT '置顶0/1.字符的1和0',
  `jinghua` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '0' COMMENT '精华0/1.字符的1和0',
  `shanchu` bit(1) NULL DEFAULT b'0' COMMENT '是否删除.1和0,mysql的bool类型',
  `created_at` datetime NULL DEFAULT NULL COMMENT '长度18,形如:2021-03-01 20:21:00\r\n固定时间,gf会自动写入',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '固定时间,gf会自动写入',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `riqi`(`created_at`, `fenleiid`) USING BTREE,
  INDEX `aa`(`fenleiid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 250 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '文章' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wen_zhang
-- ----------------------------
INSERT INTO `wen_zhang` VALUES (203, '这是第一个修改得标题', '游学', '这是第一个修改得的内容', 'http://127.0.0.1:8199/upload_file/f627ff60-3922-43c5-91fc-9e72d8a24b11.jpg', '[{\"insert\":\"这是第一个修改得的内容\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":3}}]', 999282, 1000002, 1, '1', '0', NULL, '2022-12-07 15:24:44', '2024-07-09 08:35:52');
INSERT INTO `wen_zhang` VALUES (204, '2', '2', '2', 'http://127.0.0.1:8199/upload_file/4f385ad4-e7be-43d1-bc57-7e673724026e.jpg', '[{\"insert\":\"2\"},{\"insert\":{\"image\":\"http://127.0.0.1:8199/upload_file/6c6e9e60-3000-45e1-b045-a0bbcb28d05b.jpg\"}},{\"insert\":\"\\n\",\"attributes\":{\"header\":3}}]', 9, 2, 3, '1', '0', NULL, '2022-12-07 15:25:00', '2023-12-22 11:45:46');
INSERT INTO `wen_zhang` VALUES (205, '第一个', '游学', '额娃娃认为', 'thumbnail.png', '[{\"insert\":\"1223\"},{\"insert\":{\"image\":\"http://127.0.0.1:8199/upload_file/3cc08a7f-406b-4998-9151-2f1dc2810026.jpg\"}},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 84, 15, 1, '1', '0', NULL, '2022-12-24 09:07:29', '2024-07-09 09:15:29');
INSERT INTO `wen_zhang` VALUES (226, '1', '2', '22', 'thumbnail.png', '[{\"insert\":\"2\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":3}}]', 1, 0, 1, '1', '1', NULL, '2022-12-25 17:33:27', '2023-03-09 10:11:25');
INSERT INTO `wen_zhang` VALUES (225, '1', '2', '22', 'thumbnail.png', '[{\"insert\":\"2\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":3}}]', 0, 0, 6, '0', '0', NULL, '2022-12-25 17:33:25', '2023-01-16 11:58:06');
INSERT INTO `wen_zhang` VALUES (224, '1', '2', '22', 'thumbnail.png', '[{\"insert\":\"2\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":3}}]', 3, 0, 1, '0', '0', NULL, '2022-12-25 17:33:24', '2023-12-23 16:25:53');
INSERT INTO `wen_zhang` VALUES (223, '1', '2', '22', 'thumbnail.png', '[{\"insert\":\"2\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":3}}]', 1, 0, 1, '0', '0', NULL, '2022-12-25 17:33:22', '2023-03-09 10:15:04');
INSERT INTO `wen_zhang` VALUES (222, '1', '2', '22', 'thumbnail.png', '[{\"insert\":\"2\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":3}}]', 5, 0, 1, '0', '0', NULL, '2022-12-25 17:33:20', '2023-05-31 06:06:10');
INSERT INTO `wen_zhang` VALUES (221, '1', '2', '22', 'thumbnail.png', '[{\"insert\":\"2\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":3}}]', 8, 0, 1, '0', '0', NULL, '2022-12-25 17:33:19', '2024-01-26 18:41:33');
INSERT INTO `wen_zhang` VALUES (220, '1', '2', '22', 'thumbnail.png', '[{\"insert\":\"2\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":3}}]', 41, 1, 1, '0', '1', NULL, '2022-12-25 17:33:14', '2024-04-03 14:47:57');
INSERT INTO `wen_zhang` VALUES (218, '第一个', '游学', '额娃娃认为', 'thumbnail.png', '[{\"insert\":\"企鹅\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 25, 4, 2, '1', '0', NULL, '2022-12-24 10:16:34', '2024-04-01 17:21:50');
INSERT INTO `wen_zhang` VALUES (219, '1you', '2yx', '1yx', 'thumbnail.png', '[{\"insert\":\"1yx\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 1, 0, 3, '1', '1', NULL, '2022-12-24 10:30:48', '2024-07-09 08:18:38');
INSERT INTO `wen_zhang` VALUES (228, 'new0', '2', 'new', 'thumbnail.png', '[{\"insert\":\"new\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 1, 0, 1, '0', '0', NULL, '2023-02-03 12:55:59', '2023-12-20 21:45:29');
INSERT INTO `wen_zhang` VALUES (229, 'new1', '2', 'new', 'thumbnail.png', '[{\"insert\":\"newoo\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 1, 0, 4, '1', '1', NULL, '2023-02-03 12:56:35', '2023-12-20 21:44:46');
INSERT INTO `wen_zhang` VALUES (230, 'go1', '游学', 'go', 'thumbnail.png', '[{\"insert\":\"go\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 0, 0, 1, '1', '0', NULL, '2023-02-03 13:20:20', '2023-02-11 11:51:54');
INSERT INTO `wen_zhang` VALUES (231, '3', '2', '3', 'thumbnail.png', '[{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 1, 0, 5, '0', '0', NULL, '2023-02-03 19:02:31', '2023-12-20 20:46:22');
INSERT INTO `wen_zhang` VALUES (232, '嵌入式开发1', 'youxue', '嵌入式开发1', 'http://127.0.0.1:8199/upload_file/2a202788-db4b-4553-b61e-46fac762f88b.jpg', '[{\"insert\":\"嵌入式开发1\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 0, 0, 3, '0', '0', NULL, '2023-05-30 00:22:24', '2023-05-30 00:22:24');
INSERT INTO `wen_zhang` VALUES (233, '嵌入式开发1', 'youxue', '嵌入式开发1', 'http://127.0.0.1:8199/upload_file/2a202788-db4b-4553-b61e-46fac762f88b.jpg', '[{\"insert\":\"324\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 0, 0, 3, '0', '0', NULL, '2023-05-30 00:26:06', '2023-05-30 00:26:06');
INSERT INTO `wen_zhang` VALUES (234, '嵌入式开发1', 'youxue', '嵌入式开发1', 'http://127.0.0.1:8199/upload_file/2a202788-db4b-4553-b61e-46fac762f88b.jpg', '[{\"insert\":\"324\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 0, 0, 3, '0', '0', NULL, '2023-05-30 00:29:30', '2023-05-30 00:29:30');
INSERT INTO `wen_zhang` VALUES (235, '嵌入式开发1', 'youxue', '嵌入式开发1', 'http://127.0.0.1:8199/upload_file/2a202788-db4b-4553-b61e-46fac762f88b.jpg', '[{\"insert\":\"324\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 0, 0, 3, '0', '0', NULL, '2023-05-30 00:31:59', '2023-05-30 00:31:59');
INSERT INTO `wen_zhang` VALUES (236, '嵌入式开发1', 'youxue', '嵌入式开发1', 'http://127.0.0.1:8199/upload_file/2a202788-db4b-4553-b61e-46fac762f88b.jpg', '[{\"insert\":\"324\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 1, 0, 3, '0', '0', NULL, '2023-05-30 00:33:03', '2023-06-12 17:51:34');
INSERT INTO `wen_zhang` VALUES (237, '嵌入式开发1', 'youxue', '嵌入式开发1', 'http://127.0.0.1:8199/upload_file/2a202788-db4b-4553-b61e-46fac762f88b.jpg', '[{\"insert\":\"324\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 0, 0, 3, '0', '0', NULL, '2023-05-30 00:36:03', '2023-05-30 00:36:03');
INSERT INTO `wen_zhang` VALUES (238, '嵌入式开发1', 'youxue', '嵌入式开发1', 'http://127.0.0.1:8199/upload_file/2a202788-db4b-4553-b61e-46fac762f88b.jpg', '[{\"insert\":\"123\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 1, 0, 3, '0', '0', NULL, '2023-05-30 00:43:05', '2023-05-30 09:49:35');
INSERT INTO `wen_zhang` VALUES (239, '1', 'youxue', '1', 'thumbnail.png', '[{\"insert\":\"1\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 1, 0, 3, '0', '0', NULL, '2023-05-30 00:47:40', '2023-05-30 09:49:28');
INSERT INTO `wen_zhang` VALUES (243, '1', 'youxue', '1', 'thumbnail.png', '[{\"insert\":\"1\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 0, 0, 4, '0', '0', NULL, '2023-05-30 01:21:43', '2023-05-30 01:21:43');
INSERT INTO `wen_zhang` VALUES (244, '1', 'youxue', '1', 'thumbnail.png', '[{\"insert\":\"1\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 2, 0, 2, '0', '0', NULL, '2023-05-30 01:24:50', '2023-06-10 09:54:47');
INSERT INTO `wen_zhang` VALUES (245, '1', '123', '1', 'thumbnail.png', '[{\"insert\":\"2\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 1, 1, 3, '0', '0', NULL, '2023-05-30 09:26:59', '2023-05-30 09:49:21');
INSERT INTO `wen_zhang` VALUES (246, '1', '管理员', '2', 'thumbnail.png', '[{\"insert\":\"3\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 1, 0, 1, '0', '0', NULL, '2023-12-16 10:38:11', '2023-12-20 21:45:33');
INSERT INTO `wen_zhang` VALUES (247, '1', '管理', '1', 'thumbnail.png', '[{\"insert\":\"1\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 1, 0, 1, '0', '0', NULL, '2023-12-21 10:05:07', '2023-12-21 10:08:13');
INSERT INTO `wen_zhang` VALUES (248, '1', '管理', '1', 'thumbnail.png', '[{\"insert\":{\"image\":\"http://127.0.0.1:8199/upload_file/a447a0fc-fa1a-4d70-ad62-eadbc605ad79.jpg\"}},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 1, 0, 1, '0', '0', NULL, '2023-12-21 10:26:51', '2024-02-03 13:32:43');
INSERT INTO `wen_zhang` VALUES (249, 'test', '管理', 'test323', 'thumbnail.png', '[{\"insert\":\"treterterte\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":1}}]', 0, 0, 1, '1', '1', b'0', '2024-03-19 18:38:59', '2024-06-21 13:26:13');

-- ----------------------------
-- Table structure for wen_zhang_ping_lun
-- ----------------------------
DROP TABLE IF EXISTS `wen_zhang_ping_lun`;
CREATE TABLE `wen_zhang_ping_lun`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `wen_zhang_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '文章id',
  `ping_lun_ren` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '评论人',
  `pinglunneirong` json NULL COMMENT '评论内容',
  `create_at` datetime NULL DEFAULT NULL,
  `update_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `a`(`wen_zhang_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '文章评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wen_zhang_ping_lun
-- ----------------------------

-- ----------------------------
-- Table structure for wenzhangfenlei
-- ----------------------------
DROP TABLE IF EXISTS `wenzhangfenlei`;
CREATE TABLE `wenzhangfenlei`  (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '分类名称对应的id,也作为查询文章分类的表名.分类的表名命名规则wen_zhang_fenlei_id',
  `fenlei_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '文章分类名称\r\n',
  `created_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fenlei_name`(`fenlei_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '文章分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wenzhangfenlei
-- ----------------------------
INSERT INTO `wenzhangfenlei` VALUES (1, '软件', NULL, NULL);
INSERT INTO `wenzhangfenlei` VALUES (2, '硬件', NULL, NULL);
INSERT INTO `wenzhangfenlei` VALUES (3, 'AI智能', NULL, NULL);
INSERT INTO `wenzhangfenlei` VALUES (4, '新闻', NULL, NULL);
INSERT INTO `wenzhangfenlei` VALUES (5, '分享', NULL, NULL);
INSERT INTO `wenzhangfenlei` VALUES (6, '佛教', NULL, NULL);

-- ----------------------------
-- Table structure for zhao_pin_gong_si
-- ----------------------------
DROP TABLE IF EXISTS `zhao_pin_gong_si`;
CREATE TABLE `zhao_pin_gong_si`  (
  `id` int(11) NOT NULL,
  `gongsi_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司名',
  `gongsi_fa_ren` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '法人',
  `gongsi_jian_jie` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '简介',
  `gongsi_ye_wu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业务范围',
  `gongsi_ling_yu` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所属领域',
  `gongsi_pic` json NULL COMMENT 'json图片,如{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}',
  `gongsi_xinyongdaima` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '统一社会信用代码18位',
  `gongsi_chengliriqi` date NULL DEFAULT NULL COMMENT '成立日期',
  `created_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '招聘功能中的公司简介' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zhao_pin_gong_si
-- ----------------------------
INSERT INTO `zhao_pin_gong_si` VALUES (1, '中国银行', '游学', '中国国家范围内最大的金融机构', '存钱,储蓄,放贷', '金融', '{\"pics\": [{\"id\": \"1\", \"picurl\": \"https://dgss0.bdstatic.com/5bVWsj_p_tVS5dKfpU_Y_D3/res/r/image/2017-09-27/297f5edb1e984613083a2d3cc0c5bb36.png\"}, {\"id\": \"2\", \"picurl\": \"https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png\"}, {\"id\": \"3\", \"picurl\": \"https://dgss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=467879421,222028428&fm=30&app=106&f=JPEG?w=312&h=208&s=3D24DF1452735F8A5A544DD3030080B3\"}]}', '1564545132', '2023-11-02', NULL, NULL);

-- ----------------------------
-- Table structure for zhaopin_fenlei_gangwei
-- ----------------------------
DROP TABLE IF EXISTS `zhaopin_fenlei_gangwei`;
CREATE TABLE `zhaopin_fenlei_gangwei`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fen_lei` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '招聘岗位分类.如销售分类',
  `gang_wei_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类下属的细分岗位.如销售分类的楼房销售',
  `created_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  `updated_at` datetime NULL DEFAULT NULL COMMENT '只需定义字段即可.gf自动填入',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '招聘的分类和岗位细分' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zhaopin_fenlei_gangwei
-- ----------------------------
INSERT INTO `zhaopin_fenlei_gangwei` VALUES (1, '软件', '[1,2]', NULL, NULL);
INSERT INTO `zhaopin_fenlei_gangwei` VALUES (2, '硬件', '[3]', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
