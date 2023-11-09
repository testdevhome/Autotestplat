/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : autotestplat

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2023-11-09 09:49:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`) USING BTREE,
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can view log entry', '1', 'view_logentry');
INSERT INTO `auth_permission` VALUES ('5', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can view permission', '2', 'view_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can view group', '3', 'view_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('14', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('16', 'Can view user', '4', 'view_user');
INSERT INTO `auth_permission` VALUES ('17', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('18', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('19', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('20', 'Can view content type', '5', 'view_contenttype');
INSERT INTO `auth_permission` VALUES ('21', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('22', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('23', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('24', 'Can view session', '6', 'view_session');
INSERT INTO `auth_permission` VALUES ('25', 'Can add auth group', '7', 'add_authgroup');
INSERT INTO `auth_permission` VALUES ('26', 'Can change auth group', '7', 'change_authgroup');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete auth group', '7', 'delete_authgroup');
INSERT INTO `auth_permission` VALUES ('28', 'Can view auth group', '7', 'view_authgroup');
INSERT INTO `auth_permission` VALUES ('29', 'Can add auth group permissions', '8', 'add_authgrouppermissions');
INSERT INTO `auth_permission` VALUES ('30', 'Can change auth group permissions', '8', 'change_authgrouppermissions');
INSERT INTO `auth_permission` VALUES ('31', 'Can delete auth group permissions', '8', 'delete_authgrouppermissions');
INSERT INTO `auth_permission` VALUES ('32', 'Can view auth group permissions', '8', 'view_authgrouppermissions');
INSERT INTO `auth_permission` VALUES ('33', 'Can add auth permission', '9', 'add_authpermission');
INSERT INTO `auth_permission` VALUES ('34', 'Can change auth permission', '9', 'change_authpermission');
INSERT INTO `auth_permission` VALUES ('35', 'Can delete auth permission', '9', 'delete_authpermission');
INSERT INTO `auth_permission` VALUES ('36', 'Can view auth permission', '9', 'view_authpermission');
INSERT INTO `auth_permission` VALUES ('37', 'Can add auth user', '10', 'add_authuser');
INSERT INTO `auth_permission` VALUES ('38', 'Can change auth user', '10', 'change_authuser');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete auth user', '10', 'delete_authuser');
INSERT INTO `auth_permission` VALUES ('40', 'Can view auth user', '10', 'view_authuser');
INSERT INTO `auth_permission` VALUES ('41', 'Can add auth user groups', '11', 'add_authusergroups');
INSERT INTO `auth_permission` VALUES ('42', 'Can change auth user groups', '11', 'change_authusergroups');
INSERT INTO `auth_permission` VALUES ('43', 'Can delete auth user groups', '11', 'delete_authusergroups');
INSERT INTO `auth_permission` VALUES ('44', 'Can view auth user groups', '11', 'view_authusergroups');
INSERT INTO `auth_permission` VALUES ('45', 'Can add auth user user permissions', '12', 'add_authuseruserpermissions');
INSERT INTO `auth_permission` VALUES ('46', 'Can change auth user user permissions', '12', 'change_authuseruserpermissions');
INSERT INTO `auth_permission` VALUES ('47', 'Can delete auth user user permissions', '12', 'delete_authuseruserpermissions');
INSERT INTO `auth_permission` VALUES ('48', 'Can view auth user user permissions', '12', 'view_authuseruserpermissions');
INSERT INTO `auth_permission` VALUES ('49', 'Can add django admin log', '13', 'add_djangoadminlog');
INSERT INTO `auth_permission` VALUES ('50', 'Can change django admin log', '13', 'change_djangoadminlog');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete django admin log', '13', 'delete_djangoadminlog');
INSERT INTO `auth_permission` VALUES ('52', 'Can view django admin log', '13', 'view_djangoadminlog');
INSERT INTO `auth_permission` VALUES ('53', 'Can add django content type', '14', 'add_djangocontenttype');
INSERT INTO `auth_permission` VALUES ('54', 'Can change django content type', '14', 'change_djangocontenttype');
INSERT INTO `auth_permission` VALUES ('55', 'Can delete django content type', '14', 'delete_djangocontenttype');
INSERT INTO `auth_permission` VALUES ('56', 'Can view django content type', '14', 'view_djangocontenttype');
INSERT INTO `auth_permission` VALUES ('57', 'Can add django migrations', '15', 'add_djangomigrations');
INSERT INTO `auth_permission` VALUES ('58', 'Can change django migrations', '15', 'change_djangomigrations');
INSERT INTO `auth_permission` VALUES ('59', 'Can delete django migrations', '15', 'delete_djangomigrations');
INSERT INTO `auth_permission` VALUES ('60', 'Can view django migrations', '15', 'view_djangomigrations');
INSERT INTO `auth_permission` VALUES ('61', 'Can add django session', '16', 'add_djangosession');
INSERT INTO `auth_permission` VALUES ('62', 'Can change django session', '16', 'change_djangosession');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete django session', '16', 'delete_djangosession');
INSERT INTO `auth_permission` VALUES ('64', 'Can view django session', '16', 'view_djangosession');

-- ----------------------------
-- Table structure for `auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('2', 'pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=', '2023-11-09 01:35:20.343929', '0', 'fin', 'fin', '5', '13711112222', '1', '1', '2023-10-04 03:24:35.000000');
INSERT INTO `auth_user` VALUES ('4', 'pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=', '2023-11-06 13:44:31.261781', '0', 'test', '', '5', '13800001111', '1', '1', '2023-10-13 06:23:00.000000');
INSERT INTO `auth_user` VALUES ('7', 'pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=', '2023-11-08 12:59:16.638189', '1', 'root', '', '3', '13822223333', '1', '1', '2023-11-06 00:00:00.000000');
INSERT INTO `auth_user` VALUES ('8', 'pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=', '2023-11-06 13:21:22.269930', '1', '小辉', '', '3', '13822223333', '1', '1', '2023-11-06 00:00:00.000000');

-- ----------------------------
-- Table structure for `auth_user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`) USING BTREE,
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_user_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`) USING BTREE,
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `autotestplat_interface_testcase`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_interface_testcase`;
CREATE TABLE `autotestplat_interface_testcase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `url_host` varchar(100) DEFAULT NULL,
  `url` longtext,
  `head` longtext,
  `body` longtext,
  `body_format` varchar(20) DEFAULT NULL,
  `mode` varchar(30) DEFAULT NULL,
  `charger` varchar(20) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `product_id` varchar(30) DEFAULT NULL,
  `update_cookie` varchar(10) DEFAULT NULL,
  `assert_use_new` varchar(10) DEFAULT NULL,
  `assert_keywords` longtext,
  `assert_keywords_is_contain` varchar(10) DEFAULT NULL,
  `assert_keywords_old` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1393 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_interface_testcase
-- ----------------------------
INSERT INTO `autotestplat_interface_testcase` VALUES ('1338', '用户列表接口-断言错误校验', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'\', \'Cookie\': \'\'}', '{}', 'JSON', 'post', 'fin', null, '3', '', null, null, '1', '20012');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1351', '用户列表接口-获取前面接口返回值参数的值', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{keyres}\"}', 'JSON', 'post', 'fin', null, '3', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1363', '用户列表接口-参数中获取随机变量参数值', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{timeRandom}\"}', 'JSON', 'post', 'fin', null, '3', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1383', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'test12345');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1384', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'test12345');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1385', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'test12345');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1386', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'test12345');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1387', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'test12345');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1388', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'test12345');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1389', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', 'fin', null, '1', null, '', '', '1', 'test12345');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1390', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'test12345');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1392', '用户列表接口-参数中获取随机变量参数值', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{timeRandom}\"}', 'JSON', 'post', 'fin', null, '3', null, '', '', '1', 'fin');

-- ----------------------------
-- Table structure for `autotestplat_parameter`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_parameter`;
CREATE TABLE `autotestplat_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `keywords` varchar(100) NOT NULL,
  `value` longtext,
  `left` longtext,
  `right` longtext,
  `index` varchar(20) DEFAULT NULL,
  `product_id` varchar(20) DEFAULT NULL,
  `module_id` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`keywords`)
) ENGINE=InnoDB AUTO_INCREMENT=885 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_parameter
-- ----------------------------
INSERT INTO `autotestplat_parameter` VALUES ('616', '字符串随机数', 'charRandom', '\'\'.join(random.sample(string.ascii_letters + string.digits,10))', '', '', '', '3', '', 'var');
INSERT INTO `autotestplat_parameter` VALUES ('668', '时间戳随机数', 'timeRandom', 'int(time.time())', '', '', '', '3', null, 'var');
INSERT INTO `autotestplat_parameter` VALUES ('669', '数字随机数', 'numRandom', 'random.randint(0,99999999999)', '', '', '', '5', null, 'var');
INSERT INTO `autotestplat_parameter` VALUES ('670', 'Appid', 'Appid', '123456789011', '', '', '', '5', null, 'con');
INSERT INTO `autotestplat_parameter` VALUES ('671', '测试环境', 'test_url', 'http://127.0.0.1', '', '', '', '3', null, 'env');
INSERT INTO `autotestplat_parameter` VALUES ('869', '生产环境', 'online_url', 'http://127.0.0.1', null, null, null, '5', null, 'env');
INSERT INTO `autotestplat_parameter` VALUES ('876', '参数关联', 'keyres', '', 'd', 'a', '0', 'testplan', '1890', 'res');
INSERT INTO `autotestplat_parameter` VALUES ('883', '1', '1', '', '1', '1', '1', '4', '1381', 'res');

-- ----------------------------
-- Table structure for `autotestplat_product`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_product`;
CREATE TABLE `autotestplat_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `product_introduction` varchar(255) DEFAULT NULL,
  `charger` varchar(255) DEFAULT NULL,
  `delete_flag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of autotestplat_product
-- ----------------------------
INSERT INTO `autotestplat_product` VALUES ('1', '扫地机器人', '未发布', '扫地的', 'fff', null);
INSERT INTO `autotestplat_product` VALUES ('2', '炒菜机器人', '未发布', '炒菜的', 'fin', null);
INSERT INTO `autotestplat_product` VALUES ('3', 'ChatGPT', '已发布', '聊天的', 'fin', null);
INSERT INTO `autotestplat_product` VALUES ('4', '停车机器人', '未发布', '停车收费的', 'fin', null);
INSERT INTO `autotestplat_product` VALUES ('5', 'Autotestplat', '未发布', '自动化测试软件', 'fin', null);

-- ----------------------------
-- Table structure for `autotestplat_testplan`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan`;
CREATE TABLE `autotestplat_testplan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_name` varchar(100) DEFAULT NULL,
  `url_host` varchar(100) DEFAULT NULL,
  `interface_name` longtext,
  `interface_name_display` longtext,
  `charger` varchar(20) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of autotestplat_testplan
-- ----------------------------
INSERT INTO `autotestplat_testplan` VALUES ('25', '新的测试计划', '{ online_url }', 'testplan_interface_1890_用户列表接口-设置接口返回值关联参数-通过正则表达式设置,testplan_interface_1891_用户列表接口-获取前面接口返回值参数的值', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置 ， 用户列表接口-获取前面接口返回值参数的值', 'fin', '5');
INSERT INTO `autotestplat_testplan` VALUES ('65', 'testplan', '{ online_url }', 'testplan_interface_1889_用户列表接口-断言正确校验,testplan_interface_1892_用户列表接口-断言错误校验,testplan_interface_1894_用户列表接口-参数中获取随机变量参数值', '用户列表接口-参数中获取随机变量参数值 ， 用户列表接口-断言正确校验 ， 用户列表接口-断言错误校验', 'fin', '5');
INSERT INTO `autotestplat_testplan` VALUES ('87', 'plan', '{ test_url }', 'testplan_interface_1900_用户列表接口-获取前面接口返回值参数的值', '用户列表接口-获取前面接口返回值参数的值', 'fin', '3');

-- ----------------------------
-- Table structure for `autotestplat_testplan_interface`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan_interface`;
CREATE TABLE `autotestplat_testplan_interface` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_id` int(11) DEFAULT NULL,
  `suit_name` varchar(200) DEFAULT NULL,
  `interface_name` varchar(100) DEFAULT NULL,
  `url` longtext,
  `head` longtext,
  `body` longtext,
  `body_format` varchar(20) DEFAULT NULL,
  `mode` varchar(10) DEFAULT NULL,
  `update_cookie` varchar(10) DEFAULT NULL,
  `assert_use_new` varchar(10) DEFAULT NULL,
  `assert_keywords` longtext,
  `assert_keywords_is_contain` varchar(10) DEFAULT NULL,
  `assert_keywords_old` longtext,
  `interface_testresult` int(11) DEFAULT NULL,
  `interface_response` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1901 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_testplan_interface
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface` VALUES ('1889', '65', 'testplan', '用户列表接口-断言正确校验', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"“username\": \"\"}', 'JSON', 'post', '', '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1890', '25', '新的测试计划', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', '', '', null, '1', 'test12345', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1891', '25', '新的测试计划', '用户列表接口-获取前面接口返回值参数的值', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{keyres}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1892', '65', 'testplan', '用户列表接口-断言错误校验', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'\', \'Cookie\': \'\'}', '{}', 'JSON', 'post', '', null, null, '1', '200', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1894', '65', 'testplan', '用户列表接口-参数中获取随机变量参数值', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{charRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1900', '87', 'plan', '用户列表接口-获取前面接口返回值参数的值', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{keyres}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);

-- ----------------------------
-- Table structure for `autotestplat_testplan_interface_order`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan_interface_order`;
CREATE TABLE `autotestplat_testplan_interface_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_id` int(11) DEFAULT NULL,
  `interface_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34581 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of autotestplat_testplan_interface_order
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34545', '25', '1890');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34546', '25', '1891');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34577', '87', '1900');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34578', '65', '1894');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34579', '65', '1889');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34580', '65', '1892');

-- ----------------------------
-- Table structure for `autotestplat_testplan_interface_result`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan_interface_result`;
CREATE TABLE `autotestplat_testplan_interface_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` varchar(20) DEFAULT NULL,
  `task_id` int(11) DEFAULT NULL,
  `suit_id` int(11) DEFAULT NULL,
  `suit_interface_id` int(11) DEFAULT NULL,
  `interface_name` varchar(200) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `body` varchar(200) DEFAULT NULL,
  `mode` varchar(20) DEFAULT NULL,
  `assert_keywords_old` varchar(20) DEFAULT NULL,
  `response` longtext,
  `result` varchar(20) DEFAULT NULL,
  `date_time` varchar(20) DEFAULT NULL,
  `task_mode` varchar(20) DEFAULT NULL,
  `response_time` longtext,
  `pass_pers` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27192 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_testplan_interface_result
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27183', '20231109093305008207', '53632', '25', '1890', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'test12345', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-09T01:11:45.075Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-06T13:44:31.261Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '1', '2023-11-09 09:33:05', '定时任务', '0.034882', '50%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27184', '20231109093305008207', '53632', '25', '1891', '用户列表接口-获取前面接口返回值参数的值', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'at\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-09T01:11:45.075Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-06T13:44:31.261Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-09 09:33:05', '定时任务', '0.024919', '50%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27185', '20231109093754818381', '53629', '65', '1894', '用户列表接口-参数中获取随机变量参数值', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'Smayc4JXKu\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-09T01:35:20.343Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-06T13:44:31.261Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-09 09:37:54', '定时任务', '0.031893', '33%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27186', '20231109093754818381', '53629', '65', '1889', '用户列表接口-断言正确校验', 'http://127.0.0.1/autotest/user/getTableData/', '{\'“username\': \'\'}', 'post', 'test123456', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-09T01:35:20.343Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-06T13:44:31.261Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '1', '2023-11-09 09:37:54', '定时任务', '0.034887', '33%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27187', '20231109093754818381', '53629', '65', '1892', '用户列表接口-断言错误校验', 'http://127.0.0.1/autotest/user/getTableData/', '{}', 'post', '20012', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-09T01:35:20.343Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-06T13:44:31.261Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '1', '2023-11-09 09:37:54', '定时任务', '0.026923', '33%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27188', '20231109094636009818', '53636', '87', '1900', '用户列表接口-获取前面接口返回值参数的值', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'at\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-09T01:35:20.343Z\", 0, \"fin\", \"fin\", \"ChatGPT\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-06T13:44:31.261Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-09 09:46:36', '定时任务', '0.026383', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27189', '20231109094751246121', '53629', '65', '1894', '用户列表接口-参数中获取随机变量参数值', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'swg7WAMlCT\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-09T01:35:20.343Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-06T13:44:31.261Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-09 09:47:51', '定时任务', '0.027494', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27190', '20231109094751246121', '53629', '65', '1889', '用户列表接口-断言正确校验', 'http://127.0.0.1/autotest/user/getTableData/', '{\'“username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-09T01:35:20.343Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-06T13:44:31.261Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-09 09:47:51', '定时任务', '0.026909', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27191', '20231109094751246121', '53629', '65', '1892', '用户列表接口-断言错误校验', 'http://127.0.0.1/autotest/user/getTableData/', '{}', 'post', '200', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-09T01:35:20.343Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-06T13:44:31.261Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-09 09:47:51', '定时任务', '0.025496', '100%');

-- ----------------------------
-- Table structure for `django_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`) USING BTREE,
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2023-10-17 08:06:52.299889', '16', 'debug: every minute', '1', '[{\"added\": {}}]', '24', '2');
INSERT INTO `django_admin_log` VALUES ('2', '2023-11-06 13:16:07.791117', '2', 'fin', '2', '[{\"changed\": {\"fields\": [\"email\", \"is_superuser\"]}}]', '4', '7');

-- ----------------------------
-- Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('7', 'autotest', 'authgroup');
INSERT INTO `django_content_type` VALUES ('8', 'autotest', 'authgrouppermissions');
INSERT INTO `django_content_type` VALUES ('9', 'autotest', 'authpermission');
INSERT INTO `django_content_type` VALUES ('10', 'autotest', 'authuser');
INSERT INTO `django_content_type` VALUES ('11', 'autotest', 'authusergroups');
INSERT INTO `django_content_type` VALUES ('12', 'autotest', 'authuseruserpermissions');
INSERT INTO `django_content_type` VALUES ('13', 'autotest', 'djangoadminlog');
INSERT INTO `django_content_type` VALUES ('14', 'autotest', 'djangocontenttype');
INSERT INTO `django_content_type` VALUES ('15', 'autotest', 'djangomigrations');
INSERT INTO `django_content_type` VALUES ('16', 'autotest', 'djangosession');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('25', 'djcelery', 'crontabschedule');
INSERT INTO `django_content_type` VALUES ('24', 'djcelery', 'periodictask');
INSERT INTO `django_content_type` VALUES ('26', 'djcelery', 'workerstate');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for `django_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------

-- ----------------------------
-- Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  KEY `django_session_expire_date_a5c62663` (`expire_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0k7xlvc3g7ef762yhlwij3msmueexjnt', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 01:55:43.565600');
INSERT INTO `django_session` VALUES ('0y5uwy79sxrykszd2l2ce5jzgsyp273v', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-31 04:22:04.775453');
INSERT INTO `django_session` VALUES ('1lb22quo4klzir2wkcivzuv3zaxwr9x9', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-20 13:45:42.115114');
INSERT INTO `django_session` VALUES ('2a23igledls9l6qp7g6dpaghyk89wpvo', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:04:18.467811');
INSERT INTO `django_session` VALUES ('2tneomgyxp3i8fll8hq7p1do0ta4rr83', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-30 09:46:59.696832');
INSERT INTO `django_session` VALUES ('31fc90afdlcr2il2nt6jvikm3ey52sew', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 01:45:23.358884');
INSERT INTO `django_session` VALUES ('3i25rmigkbegwdlr7hfqw3t7tu5kzl55', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 07:49:45.841243');
INSERT INTO `django_session` VALUES ('3svzaaxu8gdfubcndopks0lyoux3r8vs', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:07:01.543122');
INSERT INTO `django_session` VALUES ('4jbopii2n7pzm1zmzkfbfw7146d07ezs', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:33:16.451046');
INSERT INTO `django_session` VALUES ('6b97c3jrg2b0sxup9xld5vhg5dw0d8wp', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:47:16.496954');
INSERT INTO `django_session` VALUES ('732u0uouwpik35oqvv5c6orblth5ibex', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:49:38.845616');
INSERT INTO `django_session` VALUES ('7p40m0ria58431cqkq36wdhvxmifokes', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 11:47:28.314277');
INSERT INTO `django_session` VALUES ('87fxow9j798zswcor0cja8wi66t3j71i', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-29 08:42:05.721794');
INSERT INTO `django_session` VALUES ('8xefirnvg396q09nxhsm672md1vj6vem', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 12:06:53.672343');
INSERT INTO `django_session` VALUES ('997yr7nppqqx2q6atkjsam0g2o7vwavz', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:52:36.606572');
INSERT INTO `django_session` VALUES ('9fbbd2g8x2tjo62pt9sch7w0cpibsyol', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 10:36:39.182694');
INSERT INTO `django_session` VALUES ('9ovjgmokgl4gasengkih37zwyfczth51', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 07:32:31.359009');
INSERT INTO `django_session` VALUES ('9v2l9j75cs2shsdh6zjuxqbe7rstcgkc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:21:43.856271');
INSERT INTO `django_session` VALUES ('agcmegxiy48trgqnnbxjyudxjeaq3gi4', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:11:55.523518');
INSERT INTO `django_session` VALUES ('baw0s320kktp0owq1s0difvqvjl5ovhk', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 13:48:33.054681');
INSERT INTO `django_session` VALUES ('bcg92r1zfilh5gvas4xt9vz32dfmo7mr', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 09:35:27.091812');
INSERT INTO `django_session` VALUES ('dbaw8n45v29spaqu38eyibwt9bwsekeh', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:48:27.715970');
INSERT INTO `django_session` VALUES ('dpgxdcv1ihv06djiurpl94acpethl1ur', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 11:46:47.100937');
INSERT INTO `django_session` VALUES ('dqz4fu5jfui1bw5766zqs2ih5flozxw5', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:26:45.363761');
INSERT INTO `django_session` VALUES ('eaad3xt3jfx6dn2x1wir9vm4d3dva25i', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-23 01:35:20.346431');
INSERT INTO `django_session` VALUES ('euitceotqccoxki9wh8p0ajfokf7dyuz', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 07:58:27.365275');
INSERT INTO `django_session` VALUES ('eynnp5ore8acyq4y0282lb8yr1c761n7', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:07:28.361718');
INSERT INTO `django_session` VALUES ('fz51uonmkvswdo99fr0zwru38ermr8ot', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 04:31:02.585282');
INSERT INTO `django_session` VALUES ('g9rgheg4uu5wm038htvardvem8kjk89f', 'MTE5NjA4YTk2MjM3YzE1OTRlNmUzZjQxYjY0YTQ0MjkxZmUyY2JiNTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYmNhNWJjYTM1YWQ1ZGJkZWEzZWVmZTg3ZGY1MTRkMTBiMTY2M2UyIiwidXNlciI6ImZpbiJ9', '2023-11-20 13:33:04.585820');
INSERT INTO `django_session` VALUES ('gm3i6kpii63ivwcnwk3ff3ar6evl4g6p', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:37:15.756084');
INSERT INTO `django_session` VALUES ('guxvpsuk4pax6ye7795etqtjhy3hixhg', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 01:53:03.345593');
INSERT INTO `django_session` VALUES ('ha4su71gee3j8tlz66stwylpkf4vqh8z', 'ZmJiOGU0MmVjNmIwNmIzN2RhNTUwNjYxMjM0YjViNDRjMjM1ODI3OTp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMTg4OTQ2ZWZhYWM5YmNhYjVhZmRjOWNhYjNkNzdkMGQ1NWNiN2VhIiwidXNlciI6InJvb3QifQ==', '2023-11-20 13:03:28.373926');
INSERT INTO `django_session` VALUES ('hwz0q7s8yp35q7gmvcalz4uxa5ef1csk', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 02:06:02.343121');
INSERT INTO `django_session` VALUES ('lzene1p557zs6vqnxc4o9vyj44zygu9k', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-11-14 03:30:28.089381');
INSERT INTO `django_session` VALUES ('mhld50wcykhxqxrdmy7d1vy3knzxv23t', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:54:50.919466');
INSERT INTO `django_session` VALUES ('ms7weifjv3dqi4wshfkdz3pg2dcgwkus', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:13:42.140610');
INSERT INTO `django_session` VALUES ('n7lal90qpbl4k6cjjazzpe5vzrh4emj2', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-11-05 13:20:16.066226');
INSERT INTO `django_session` VALUES ('n8r5tam6skf9pfibxxhs8sii5nz3plky', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:35:54.370813');
INSERT INTO `django_session` VALUES ('nepv0ytdmnxomhrauibgfatpxhk3ldry', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-25 13:38:45.925664');
INSERT INTO `django_session` VALUES ('nogkgy9inu8g05v6748wdn20qfq56iqf', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:45:39.956131');
INSERT INTO `django_session` VALUES ('nsm8tsqbvcjr69235v0chymwigqjmz5i', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:58:06.989895');
INSERT INTO `django_session` VALUES ('ob0ghrlm4gsuq86ki5i3twmgvtfk68zp', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 09:00:30.704675');
INSERT INTO `django_session` VALUES ('os79cszkwyrgp7k209ddx8zfaqpkgwzc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 03:15:52.132178');
INSERT INTO `django_session` VALUES ('pnhsnhmt6jsukmhp8x2r6xuuevcxbfoz', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-30 09:46:59.774129');
INSERT INTO `django_session` VALUES ('pnv62ssrf2ftldog595bivekt1we5h7q', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:53:24.859076');
INSERT INTO `django_session` VALUES ('ptdy3unq1gc6y07mesagfolvoybp62cq', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-25 13:13:05.359717');
INSERT INTO `django_session` VALUES ('r6pz9izjlen67wboswbekryea7er03zi', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:09:16.408858');
INSERT INTO `django_session` VALUES ('s1mup1mrcznc8qe3b9xr8agud6n0rn1q', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:04:38.149226');
INSERT INTO `django_session` VALUES ('s98ezk9gifrfxknng1wrnj9i994u2iif', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:06:30.996665');
INSERT INTO `django_session` VALUES ('sjlcejp4ne70wwy3dizavpoxhcnfb7sq', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:24:11.488855');
INSERT INTO `django_session` VALUES ('spfbw866cm8p4hcr0zhryu0o70u6fri9', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 04:29:10.461809');
INSERT INTO `django_session` VALUES ('t0z62m2lbk9sin8nnimlyzx4ewbcpmw0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:28:52.017867');
INSERT INTO `django_session` VALUES ('tet68yw2mezgwbri0x961nywbwuf88ab', 'MmFkZjdkODFmNGRiZTdhM2Y4YTE1ZWYxOWZiN2ZlMGIyZDhmOGI0YTp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNDUwNWE4NTQ2MjZmOGRmNTllMmY2OGEyY2VhMDg1MjdlZDBhNjljIiwidXNlciI6InRlc3QifQ==', '2023-11-20 10:56:45.297749');
INSERT INTO `django_session` VALUES ('u8v5r1wt63lksmesjbza6bjkzjoish6i', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-23 01:11:45.079881');
INSERT INTO `django_session` VALUES ('v83sf4kk66bg0azi1slz2iamjc3e2zop', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 14:15:23.020794');
INSERT INTO `django_session` VALUES ('vdwqi89hx40llxmxz9l6z9f9kimqgkf9', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:08:31.441302');
INSERT INTO `django_session` VALUES ('w0j12sqwscgaa1pr6wbmkxz6vmtaolff', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:55:33.356059');
INSERT INTO `django_session` VALUES ('wio5750vzlkg4kqlv8zpdgp2u565r64r', 'ZmJiOGU0MmVjNmIwNmIzN2RhNTUwNjYxMjM0YjViNDRjMjM1ODI3OTp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMTg4OTQ2ZWZhYWM5YmNhYjVhZmRjOWNhYjNkNzdkMGQ1NWNiN2VhIiwidXNlciI6InJvb3QifQ==', '2023-11-20 12:53:02.683758');
INSERT INTO `django_session` VALUES ('yexkj6t5wvv5d0fyyqif4708786ejn3d', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 07:38:43.051485');
INSERT INTO `django_session` VALUES ('yf1ic8n2lw5vd39sg9yfqbrtl0i002k1', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:08:06.618443');
INSERT INTO `django_session` VALUES ('z2rroeonn4rteoh2avmxtm9uts5tnqo7', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 10:31:55.997476');
INSERT INTO `django_session` VALUES ('zzz6jhn8d6qknter3199h9nfkvq8sy4l', 'MTE5NjA4YTk2MjM3YzE1OTRlNmUzZjQxYjY0YTQ0MjkxZmUyY2JiNTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYmNhNWJjYTM1YWQ1ZGJkZWEzZWVmZTg3ZGY1MTRkMTBiMTY2M2UyIiwidXNlciI6ImZpbiJ9', '2023-11-20 13:32:03.700069');

-- ----------------------------
-- Table structure for `djcelery_crontabschedule`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_crontabschedule`;
CREATE TABLE `djcelery_crontabschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minute` varchar(64) NOT NULL,
  `hour` varchar(64) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  `day_of_month` varchar(64) NOT NULL,
  `month_of_year` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_crontabschedule
-- ----------------------------
INSERT INTO `djcelery_crontabschedule` VALUES ('1', '50', '15', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('2', '30', '10', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('3', '40', '10', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('4', '0', '4', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('5', '50', '10', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('40', '03', '21', '*', '02', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('41', '38', '11', '*', '07', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('42', '39', '11', '*', '07', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('43', '35', '11', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('44', '40', '11', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('45', '41', '11', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('46', '33', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('47', '33', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('48', '33', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('49', '33', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('50', '33', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('51', '33', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('52', '33', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('53', '33', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('54', '33', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('55', '33', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('56', '35', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('57', '35', '20', '*', '08', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('58', '37', '20', '*', '08', '11');

-- ----------------------------
-- Table structure for `djcelery_intervalschedule`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_intervalschedule`;
CREATE TABLE `djcelery_intervalschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_intervalschedule
-- ----------------------------
INSERT INTO `djcelery_intervalschedule` VALUES ('1', '4', 'days');
INSERT INTO `djcelery_intervalschedule` VALUES ('2', '10', 'days');
INSERT INTO `djcelery_intervalschedule` VALUES ('3', '1', 'days');
INSERT INTO `djcelery_intervalschedule` VALUES ('4', '6', 'hours');
INSERT INTO `djcelery_intervalschedule` VALUES ('5', '1', 'minutes');

-- ----------------------------
-- Table structure for `djcelery_periodictask`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_periodictask`;
CREATE TABLE `djcelery_periodictask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `args` longtext,
  `kwargs` longtext,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `last_run_at` datetime DEFAULT NULL,
  `total_run_count` int(10) unsigned DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `description` longtext,
  `crontab_id` int(11) DEFAULT NULL,
  `interval_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `djcelery_peri_crontab_id_75609bab_fk_djcelery_crontabschedule_id` (`crontab_id`),
  KEY `djcelery_pe_interval_id_b426ab02_fk_djcelery_intervalschedule_id` (`interval_id`),
  CONSTRAINT `djcelery_periodictask_ibfk_1` FOREIGN KEY (`interval_id`) REFERENCES `djcelery_intervalschedule` (`id`),
  CONSTRAINT `djcelery_periodictask_ibfk_2` FOREIGN KEY (`crontab_id`) REFERENCES `djcelery_crontabschedule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53637 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_periodictask
-- ----------------------------
INSERT INTO `djcelery_periodictask` VALUES ('53624', 'celery.backend_cleanup', 'celery.backend_cleanup', '[]', '{}', null, null, null, null, '1', null, '0', '2023-10-31 03:09:28', '', '4', null);
INSERT INTO `djcelery_periodictask` VALUES ('53629', 'testtask', 'api_autotest_task', '65-testplan', '{}', null, null, null, null, '1', null, '0', '2023-11-02 13:03:46', 'fin', '40', '3');
INSERT INTO `djcelery_periodictask` VALUES ('53631', 'task3', 'api_autotest_task', '87-plan', '{}', null, null, null, null, '1', null, '0', '2023-11-07 03:39:51', 'fin', '42', '3');
INSERT INTO `djcelery_periodictask` VALUES ('53632', 'task', 'api_autotest_task', '25-新的测试计划', '{}', null, null, null, null, '1', null, '0', '2023-11-08 03:35:15', 'fin', '43', '3');
INSERT INTO `djcelery_periodictask` VALUES ('53635', 'task4', 'api_autotest_task', '87-plan', '{}', null, null, null, null, '1', null, '0', '2023-11-08 12:35:31', 'fin', '54', '3');
INSERT INTO `djcelery_periodictask` VALUES ('53636', 'task6', 'api_autotest_task', '87-plan', '{}', null, null, null, null, '1', null, '0', '2023-11-08 12:35:45', 'fin', '56', '3');

-- ----------------------------
-- Table structure for `djcelery_periodictasks`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_periodictasks`;
CREATE TABLE `djcelery_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_periodictasks
-- ----------------------------
INSERT INTO `djcelery_periodictasks` VALUES ('1', '2023-11-09 01:04:56');

-- ----------------------------
-- Table structure for `djcelery_taskstate`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_taskstate`;
CREATE TABLE `djcelery_taskstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(64) NOT NULL,
  `task_id` varchar(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `tstamp` datetime NOT NULL,
  `args` longtext,
  `kwargs` longtext,
  `eta` datetime DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `result` longtext,
  `traceback` longtext,
  `runtime` double DEFAULT NULL,
  `retries` int(11) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  `worker_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `djcelery_taskstate_9ed39e2e` (`state`),
  KEY `djcelery_taskstate_b068931c` (`name`),
  KEY `djcelery_taskstate_863bb2ee` (`tstamp`),
  KEY `djcelery_taskstate_662f707d` (`hidden`),
  KEY `djcelery_taskstate_ce77e6ef` (`worker_id`),
  CONSTRAINT `djcelery_taskstate_ibfk_1` FOREIGN KEY (`worker_id`) REFERENCES `djcelery_workerstate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_taskstate
-- ----------------------------

-- ----------------------------
-- Table structure for `djcelery_workerstate`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_workerstate`;
CREATE TABLE `djcelery_workerstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) NOT NULL,
  `last_heartbeat` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `djcelery_workerstate_f129901a` (`last_heartbeat`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_workerstate
-- ----------------------------
INSERT INTO `djcelery_workerstate` VALUES ('1', 'Peter+Winter', null);

-- ----------------------------
-- Table structure for `djkombu_message`
-- ----------------------------
DROP TABLE IF EXISTS `djkombu_message`;
CREATE TABLE `djkombu_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visible` tinyint(1) NOT NULL,
  `sent_at` datetime DEFAULT NULL,
  `payload` longtext NOT NULL,
  `queue_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `djkombu_message_46cf0e59` (`visible`),
  KEY `djkombu_message_df2f2974` (`sent_at`),
  KEY `djkombu_message_75249aa1` (`queue_id`),
  CONSTRAINT `djkombu_message_ibfk_1` FOREIGN KEY (`queue_id`) REFERENCES `djkombu_queue` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38840 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djkombu_message
-- ----------------------------
INSERT INTO `djkombu_message` VALUES ('38839', '0', '2023-10-03 03:56:33', '{\"body\": \"gAJ9cQEoVQdleHBpcmVzcQJOVQN1dGNxA4hVBGFyZ3NxBF1xBVUFY2hvcmRxBk5VCWNhbGxiYWNrc3EHTlUIZXJyYmFja3NxCE5VB3Rhc2tzZXRxCU5VAmlkcQpVJDA2ZWFjM2Y3LWY3OWMtNGFkOS1hMTdmLTZlZDM1ZDIwYzZlYnELVQdyZXRyaWVzcQxLAFUEdGFza3ENVTRhdXRvdGVzdF9wbGF0Zm9ybS5hcHAxLnRhc2tzLmluc2VydF9zcWxfcGVyZm9ybWFuY2VzcQ5VCXRpbWVsaW1pdHEPTk6GVQNldGFxEE5VBmt3YXJnc3ERfXESdS4=\", \"headers\": {}, \"content-type\": \"application/x-python-serialize\", \"properties\": {\"body_encoding\": \"base64\", \"correlation_id\": \"06eac3f7-f79c-4ad9-a17f-6ed35d20c6eb\", \"reply_to\": \"5695f912-3031-3f30-9147-b8f9a97e77c4\", \"delivery_info\": {\"priority\": 0, \"routing_key\": \"celery\", \"exchange\": \"celery\"}, \"delivery_mode\": 2, \"delivery_tag\": \"6bb5b908-1079-488b-913f-871a410c97da\"}, \"content-encoding\": \"binary\"}', '1');

-- ----------------------------
-- Table structure for `djkombu_queue`
-- ----------------------------
DROP TABLE IF EXISTS `djkombu_queue`;
CREATE TABLE `djkombu_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djkombu_queue
-- ----------------------------
INSERT INTO `djkombu_queue` VALUES ('1', 'celery');
INSERT INTO `djkombu_queue` VALUES ('2', 'celery@XXY-20161030QNI.celery.pidbox');
