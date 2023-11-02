/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : autotestplat

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2023-11-02 21:30:52
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('2', 'pbkdf2_sha256$120000$GnkeKPGmNjXu$ApsNh5+kweRtFe/K9O67gXm7ngQBrnXT4hUMgJ2A7lY=', '2023-10-31 03:30:28.089381', '1', 'fin', 'fin', '', '', '1', '1', '2023-10-04 03:24:35.000000');
INSERT INTO `auth_user` VALUES ('4', 'pbkdf2_sha256$120000$gDk8W7xORHWV$uFTlw0wTMf6qWTaHHyfExFN/erwshktNBTFkLt06XsU=', '2023-10-04 03:24:15.716012', '1', 'test', '', '', '', '1', '1', '2023-07-13 06:19:00.000000');

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
  `product_name` varchar(30) DEFAULT NULL,
  `update_cookie` varchar(10) DEFAULT NULL,
  `assert_use_new` varchar(10) DEFAULT NULL,
  `assert_keywords` longtext,
  `assert_keywords_is_contain` varchar(10) DEFAULT NULL,
  `assert_keywords_old` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1364 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_interface_testcase
-- ----------------------------
INSERT INTO `autotestplat_interface_testcase` VALUES ('1338', '登录接口错误断言验证', '{ test_url }', '/autotest/login/last/', '{\'Accept\': \'\', \'Content-Type\': \'\', \'Cookie\': \'\'}', '{\"username\": \"fin\"}', 'JSON', 'post', 'fin', null, 'ChatGPT', '', null, null, '1', '20012');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1351', '登录接口异常入参验证', '{ test_url }', '/autotest/login/last/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{keyres}\"}', 'JSON', 'post', 'fin', null, 'ChatGPT', null, '', '', '1', '2002');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1352', '用户数据', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', 'fin', null, '扫地机器人', '', '', '', '1', 'test12345');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1353', 'get用户', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"“username\": \"\"}', 'JSON', 'post', '邹先生', null, 'Autotestplat', '', '', '', '1', 'test123456');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1363', '登录接口随机变量', '{ test_url }', '/autotest/login/last/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{TimeRandom}\"}', 'JSON', 'post', 'fin', null, 'ChatGPT', null, '', '', '1', '200');

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
  `product_name` varchar(20) DEFAULT NULL,
  `module_id` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`keywords`)
) ENGINE=InnoDB AUTO_INCREMENT=869 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_parameter
-- ----------------------------
INSERT INTO `autotestplat_parameter` VALUES ('616', '字符串随机数', 'CharRandom', '\'\'.join(random.sample([\'z\',\'c\',\'b\',\'a\'], 5))', '', '', '', 'ChatGPT', '', 'con');
INSERT INTO `autotestplat_parameter` VALUES ('667', '生产环境', 'test2_url', 'http://127.0.0.1', '', '', '', 'Autotestplat', null, 'env');
INSERT INTO `autotestplat_parameter` VALUES ('668', '时间戳随机数', 'TimeRandom', 'int(time.time())', '', '', '', 'ChatGPT', null, 'var');
INSERT INTO `autotestplat_parameter` VALUES ('669', '数字随机数', 'NumRandom', 'random.randint(0,99999999999)', '', '', '', '扫地机器人', null, 'var');
INSERT INTO `autotestplat_parameter` VALUES ('670', 'Appid', 'Appid', '123456789011', '', '', '', '扫地机器人', null, 'con');
INSERT INTO `autotestplat_parameter` VALUES ('671', '测试环境1', 'test_url', 'http://127.0.0.1', '', '', '', 'ChatGPT', null, 'env');
INSERT INTO `autotestplat_parameter` VALUES ('862', 'keyres1', 'keyres', '', 'da', 'a', '0', 'testplan', '1878', 'res');
INSERT INTO `autotestplat_parameter` VALUES ('863', 'keyres2', 'keyres2', '', 'd', 'a', '0', 'testplan', '1878', 'res');
INSERT INTO `autotestplat_parameter` VALUES ('864', 'd', 'testkey', '', 'd', 'a', '0', 'testplan', '1879', 'res');
INSERT INTO `autotestplat_parameter` VALUES ('867', 'd', 'testkey', '', 'd', 'a', '0', 'testplan', '1882', 'res');
INSERT INTO `autotestplat_parameter` VALUES ('868', '22', '22', '', '22', '22', '2', 'testplan', '1883', 'res');

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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of autotestplat_testplan
-- ----------------------------
INSERT INTO `autotestplat_testplan` VALUES ('25', '新的测试计划', '{ test_url }', 'testplan_interface_1882_get用户,testplan_interface_1883_登录接口错误断言验证', 'get用户 ， 登录接口错误断言验证', 'fin', '1');
INSERT INTO `autotestplat_testplan` VALUES ('65', 'testplan', '{ test_url }', 'testplan_interface_1878_用户数据,testplan_interface_1879_get用户', '用户数据 ， get用户', '2', '5');

-- ----------------------------
-- Table structure for `autotestplat_testplan_interface`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan_interface`;
CREATE TABLE `autotestplat_testplan_interface` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_id` int(11) DEFAULT NULL,
  `suit_name` varchar(100) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=1884 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_testplan_interface
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface` VALUES ('1878', '65', 'testplan', '用户数据', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', '', '', null, '1', 'test12345', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1879', '65', 'testplan', 'get用户', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"“username\": \"\"}', 'JSON', 'post', null, '', null, '1', 'test123456', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1882', '25', '新的测试计划', 'get用户', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"“username\": \"\"}', 'JSON', 'post', null, '', null, '1', 'test123456', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1883', '25', '新的测试计划', '登录接口错误断言验证', '/autotest/login/last/', '{\'Accept\': \'\', \'Content-Type\': \'\', \'Cookie\': \'\'}', '{\"username\": \"fin\"}', 'JSON', 'post', null, null, null, '1', '20012', null, null);

-- ----------------------------
-- Table structure for `autotestplat_testplan_interface_order`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan_interface_order`;
CREATE TABLE `autotestplat_testplan_interface_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_id` int(11) DEFAULT NULL,
  `interface_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34514 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of autotestplat_testplan_interface_order
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34508', '65', '1878');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34509', '65', '1879');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34512', '25', '1882');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34513', '25', '1883');

-- ----------------------------
-- Table structure for `autotestplat_testplan_interface_result`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan_interface_result`;
CREATE TABLE `autotestplat_testplan_interface_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_id` int(11) DEFAULT NULL,
  `suit_interface_id` int(11) DEFAULT NULL,
  `response` longtext,
  `result` varchar(20) DEFAULT NULL,
  `date_time` varchar(20) DEFAULT NULL,
  `mode` varchar(20) DEFAULT NULL,
  `response_time` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27094 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_testplan_interface_result
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27089', '25', '1882', '{\"data\": [[1, \"\\u5c0f\\u98de\", \"test123456\", \"13000000000\", \"\\u81ea\\u52a8\\u5316\\u6d4b\\u8bd5\\u5de5\\u7a0b\\u5e08\", null, null, \"2023-01-04\"], [2, \"\\u5c0f\\u8f89\", \"test123456\", \"137000011112\", \"\\u6d4b\\u8bd5\\u5f00\\u53d1\\u5de5\\u7a0b\\u5e08\", null, null, \"2023-01-04\"], [4, \"finer\", \"test123456\", \"13711112222\", \"\\u6d4b\\u8bd5\\u7ecf\\u7406\", null, null, \"2023-10-23\"], [5, \"fin\", \"test123456\", \"13711111111\", \"\\u6d4b\\u8bd5\\u7ecf\\u7406\", null, null, \"2023-10-24\"]]}', '0', '2023-11-02 21:02:43', '手工执行', '0.044206');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27090', '25', '1883', '200', '1', '2023-11-02 21:02:43', '手工执行', '0.029724');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27091', '65', '1878', '{\"data\": [[1, \"\\u5c0f\\u98de\", \"test123456\", \"13000000000\", \"\\u81ea\\u52a8\\u5316\\u6d4b\\u8bd5\\u5de5\\u7a0b\\u5e08\", null, null, \"2023-01-04\"], [2, \"\\u5c0f\\u8f89\", \"test123456\", \"137000011112\", \"\\u6d4b\\u8bd5\\u5f00\\u53d1\\u5de5\\u7a0b\\u5e08\", null, null, \"2023-01-04\"], [4, \"finer\", \"test123456\", \"13711112222\", \"\\u6d4b\\u8bd5\\u7ecf\\u7406\", null, null, \"2023-10-23\"], [5, \"fin\", \"test123456\", \"13711111111\", \"\\u6d4b\\u8bd5\\u7ecf\\u7406\", null, null, \"2023-10-24\"]]}', '0', '2023-11-02 21:03:50', '定时任务', '0.020017');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27092', '65', '1879', '{\"data\": [[1, \"\\u5c0f\\u98de\", \"test123456\", \"13000000000\", \"\\u81ea\\u52a8\\u5316\\u6d4b\\u8bd5\\u5de5\\u7a0b\\u5e08\", null, null, \"2023-01-04\"], [2, \"\\u5c0f\\u8f89\", \"test123456\", \"137000011112\", \"\\u6d4b\\u8bd5\\u5f00\\u53d1\\u5de5\\u7a0b\\u5e08\", null, null, \"2023-01-04\"], [4, \"finer\", \"test123456\", \"13711112222\", \"\\u6d4b\\u8bd5\\u7ecf\\u7406\", null, null, \"2023-10-23\"], [5, \"fin\", \"test123456\", \"13711111111\", \"\\u6d4b\\u8bd5\\u7ecf\\u7406\", null, null, \"2023-10-24\"]]}', '0', '2023-11-02 21:03:50', '定时任务', '0.01999');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27093', '65', '1879', '{\"data\": [[1, \"\\u5c0f\\u98de\", \"test123456\", \"13000000000\", \"\\u81ea\\u52a8\\u5316\\u6d4b\\u8bd5\\u5de5\\u7a0b\\u5e08\", null, null, \"2023-01-04\"], [2, \"\\u5c0f\\u8f89\", \"test123456\", \"137000011112\", \"\\u6d4b\\u8bd5\\u5f00\\u53d1\\u5de5\\u7a0b\\u5e08\", null, null, \"2023-01-04\"], [4, \"finer\", \"test123456\", \"13711112222\", \"\\u6d4b\\u8bd5\\u7ecf\\u7406\", null, null, \"2023-10-23\"], [5, \"fin\", \"test123456\", \"13711111111\", \"\\u6d4b\\u8bd5\\u7ecf\\u7406\", null, null, \"2023-10-24\"]]}', '0', '2023-11-02 21:28:10', '手工执行', '0.09416');

-- ----------------------------
-- Table structure for `autotestplat_user`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_user`;
CREATE TABLE `autotestplat_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `user_pwd` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `is_login` varchar(255) DEFAULT NULL,
  `login_time` varchar(255) DEFAULT NULL,
  `create_date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of autotestplat_user
-- ----------------------------
INSERT INTO `autotestplat_user` VALUES ('1', '小飞', 'test123456', '13000000000', '自动化测试工程师', null, null, '2023-01-04');
INSERT INTO `autotestplat_user` VALUES ('2', '小辉', 'test123456', '137000011112', '测试开发工程师', null, null, '2023-01-04');
INSERT INTO `autotestplat_user` VALUES ('4', 'finer', 'test123456', '13711112222', '测试经理', null, null, '2023-10-23');
INSERT INTO `autotestplat_user` VALUES ('5', 'fin', 'test123456', '13711111111', '测试经理', null, null, '2023-10-24');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2023-10-17 08:06:52.299889', '16', 'debug: every minute', '1', '[{\"added\": {}}]', '24', '2');

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
INSERT INTO `django_session` VALUES ('0y5uwy79sxrykszd2l2ce5jzgsyp273v', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-31 04:22:04.775453');
INSERT INTO `django_session` VALUES ('2tneomgyxp3i8fll8hq7p1do0ta4rr83', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-30 09:46:59.696832');
INSERT INTO `django_session` VALUES ('87fxow9j798zswcor0cja8wi66t3j71i', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-29 08:42:05.721794');
INSERT INTO `django_session` VALUES ('lzene1p557zs6vqnxc4o9vyj44zygu9k', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-11-14 03:30:28.089381');
INSERT INTO `django_session` VALUES ('n7lal90qpbl4k6cjjazzpe5vzrh4emj2', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-11-05 13:20:16.066226');
INSERT INTO `django_session` VALUES ('nepv0ytdmnxomhrauibgfatpxhk3ldry', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-25 13:38:45.925664');
INSERT INTO `django_session` VALUES ('pnhsnhmt6jsukmhp8x2r6xuuevcxbfoz', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-30 09:46:59.774129');
INSERT INTO `django_session` VALUES ('ptdy3unq1gc6y07mesagfolvoybp62cq', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-25 13:13:05.359717');

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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_crontabschedule
-- ----------------------------
INSERT INTO `djcelery_crontabschedule` VALUES ('1', '50', '15', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('2', '30', '10', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('3', '40', '10', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('4', '0', '4', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('5', '50', '10', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('40', '03', '21', '*', '02', '11');

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
) ENGINE=InnoDB AUTO_INCREMENT=53630 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_periodictask
-- ----------------------------
INSERT INTO `djcelery_periodictask` VALUES ('53624', 'celery.backend_cleanup', 'celery.backend_cleanup', '[]', '{}', null, null, null, null, '1', null, '0', '2023-10-31 03:09:28', '', '4', null);
INSERT INTO `djcelery_periodictask` VALUES ('53629', 'testtask', 'api_autotest_task', '65-testplan', '{}', null, null, null, null, '1', null, '0', '2023-11-02 13:03:46', 'fin', '40', '3');

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
INSERT INTO `djcelery_periodictasks` VALUES ('1', '2023-11-02 13:03:46');

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
