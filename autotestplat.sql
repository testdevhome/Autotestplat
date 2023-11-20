/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : autotestplat

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2023-11-20 09:01:56
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
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
INSERT INTO `auth_permission` VALUES ('65', 'Can add autotestplat product', '27', 'add_autotestplatproduct');
INSERT INTO `auth_permission` VALUES ('66', 'Can change autotestplat product', '27', 'change_autotestplatproduct');
INSERT INTO `auth_permission` VALUES ('67', 'Can delete autotestplat product', '27', 'delete_autotestplatproduct');
INSERT INTO `auth_permission` VALUES ('68', 'Can view autotestplat product', '27', 'view_autotestplatproduct');
INSERT INTO `auth_permission` VALUES ('69', 'Can add autotestplat parameter', '28', 'add_autotestplatparameter');
INSERT INTO `auth_permission` VALUES ('70', 'Can change autotestplat parameter', '28', 'change_autotestplatparameter');
INSERT INTO `auth_permission` VALUES ('71', 'Can delete autotestplat parameter', '28', 'delete_autotestplatparameter');
INSERT INTO `auth_permission` VALUES ('72', 'Can view autotestplat parameter', '28', 'view_autotestplatparameter');
INSERT INTO `auth_permission` VALUES ('73', 'Can add autotestplat interface testcase', '29', 'add_autotestplatinterfacetestcase');
INSERT INTO `auth_permission` VALUES ('74', 'Can change autotestplat interface testcase', '29', 'change_autotestplatinterfacetestcase');
INSERT INTO `auth_permission` VALUES ('75', 'Can delete autotestplat interface testcase', '29', 'delete_autotestplatinterfacetestcase');
INSERT INTO `auth_permission` VALUES ('76', 'Can view autotestplat interface testcase', '29', 'view_autotestplatinterfacetestcase');
INSERT INTO `auth_permission` VALUES ('77', 'Can add autotestplat testplan', '30', 'add_autotestplattestplan');
INSERT INTO `auth_permission` VALUES ('78', 'Can change autotestplat testplan', '30', 'change_autotestplattestplan');
INSERT INTO `auth_permission` VALUES ('79', 'Can delete autotestplat testplan', '30', 'delete_autotestplattestplan');
INSERT INTO `auth_permission` VALUES ('80', 'Can view autotestplat testplan', '30', 'view_autotestplattestplan');
INSERT INTO `auth_permission` VALUES ('81', 'Can add autotestplat testplan interface', '31', 'add_autotestplattestplaninterface');
INSERT INTO `auth_permission` VALUES ('82', 'Can change autotestplat testplan interface', '31', 'change_autotestplattestplaninterface');
INSERT INTO `auth_permission` VALUES ('83', 'Can delete autotestplat testplan interface', '31', 'delete_autotestplattestplaninterface');
INSERT INTO `auth_permission` VALUES ('84', 'Can view autotestplat testplan interface', '31', 'view_autotestplattestplaninterface');
INSERT INTO `auth_permission` VALUES ('85', 'Can add autotestplat testplan interface result', '32', 'add_autotestplattestplaninterfaceresult');
INSERT INTO `auth_permission` VALUES ('86', 'Can change autotestplat testplan interface result', '32', 'change_autotestplattestplaninterfaceresult');
INSERT INTO `auth_permission` VALUES ('87', 'Can delete autotestplat testplan interface result', '32', 'delete_autotestplattestplaninterfaceresult');
INSERT INTO `auth_permission` VALUES ('88', 'Can view autotestplat testplan interface result', '32', 'view_autotestplattestplaninterfaceresult');
INSERT INTO `auth_permission` VALUES ('89', 'Can add autotestplat testplan interface order', '33', 'add_autotestplattestplaninterfaceorder');
INSERT INTO `auth_permission` VALUES ('90', 'Can change autotestplat testplan interface order', '33', 'change_autotestplattestplaninterfaceorder');
INSERT INTO `auth_permission` VALUES ('91', 'Can delete autotestplat testplan interface order', '33', 'delete_autotestplattestplaninterfaceorder');
INSERT INTO `auth_permission` VALUES ('92', 'Can view autotestplat testplan interface order', '33', 'view_autotestplattestplaninterfaceorder');
INSERT INTO `auth_permission` VALUES ('93', 'Can add crontab', '25', 'add_crontabschedule');
INSERT INTO `auth_permission` VALUES ('94', 'Can change crontab', '25', 'change_crontabschedule');
INSERT INTO `auth_permission` VALUES ('95', 'Can delete crontab', '25', 'delete_crontabschedule');
INSERT INTO `auth_permission` VALUES ('96', 'Can view crontab', '25', 'view_crontabschedule');
INSERT INTO `auth_permission` VALUES ('97', 'Can add interval', '34', 'add_intervalschedule');
INSERT INTO `auth_permission` VALUES ('98', 'Can change interval', '34', 'change_intervalschedule');
INSERT INTO `auth_permission` VALUES ('99', 'Can delete interval', '34', 'delete_intervalschedule');
INSERT INTO `auth_permission` VALUES ('100', 'Can view interval', '34', 'view_intervalschedule');
INSERT INTO `auth_permission` VALUES ('101', 'Can add periodic task', '24', 'add_periodictask');
INSERT INTO `auth_permission` VALUES ('102', 'Can change periodic task', '24', 'change_periodictask');
INSERT INTO `auth_permission` VALUES ('103', 'Can delete periodic task', '24', 'delete_periodictask');
INSERT INTO `auth_permission` VALUES ('104', 'Can view periodic task', '24', 'view_periodictask');
INSERT INTO `auth_permission` VALUES ('105', 'Can add periodic tasks', '35', 'add_periodictasks');
INSERT INTO `auth_permission` VALUES ('106', 'Can change periodic tasks', '35', 'change_periodictasks');
INSERT INTO `auth_permission` VALUES ('107', 'Can delete periodic tasks', '35', 'delete_periodictasks');
INSERT INTO `auth_permission` VALUES ('108', 'Can view periodic tasks', '35', 'view_periodictasks');
INSERT INTO `auth_permission` VALUES ('109', 'Can add task state', '36', 'add_taskmeta');
INSERT INTO `auth_permission` VALUES ('110', 'Can change task state', '36', 'change_taskmeta');
INSERT INTO `auth_permission` VALUES ('111', 'Can delete task state', '36', 'delete_taskmeta');
INSERT INTO `auth_permission` VALUES ('112', 'Can view task state', '36', 'view_taskmeta');
INSERT INTO `auth_permission` VALUES ('113', 'Can add saved group result', '37', 'add_tasksetmeta');
INSERT INTO `auth_permission` VALUES ('114', 'Can change saved group result', '37', 'change_tasksetmeta');
INSERT INTO `auth_permission` VALUES ('115', 'Can delete saved group result', '37', 'delete_tasksetmeta');
INSERT INTO `auth_permission` VALUES ('116', 'Can view saved group result', '37', 'view_tasksetmeta');
INSERT INTO `auth_permission` VALUES ('117', 'Can add task', '38', 'add_taskstate');
INSERT INTO `auth_permission` VALUES ('118', 'Can change task', '38', 'change_taskstate');
INSERT INTO `auth_permission` VALUES ('119', 'Can delete task', '38', 'delete_taskstate');
INSERT INTO `auth_permission` VALUES ('120', 'Can view task', '38', 'view_taskstate');
INSERT INTO `auth_permission` VALUES ('121', 'Can add worker', '26', 'add_workerstate');
INSERT INTO `auth_permission` VALUES ('122', 'Can change worker', '26', 'change_workerstate');
INSERT INTO `auth_permission` VALUES ('123', 'Can delete worker', '26', 'delete_workerstate');
INSERT INTO `auth_permission` VALUES ('124', 'Can view worker', '26', 'view_workerstate');

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('2', 'pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=', '2023-11-20 00:50:05.596819', '0', 'fin', 'fin', '5', '13711112222', '1', '1', '2023-10-04 03:24:35.000000');
INSERT INTO `auth_user` VALUES ('4', 'pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=', '2023-11-10 03:06:26.754032', '0', 'test', '', '5', '13800001111', '1', '1', '2023-10-13 06:23:00.000000');
INSERT INTO `auth_user` VALUES ('7', 'pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=', '2023-11-11 23:38:23.910363', '1', 'root', '', '3', '13822223333', '1', '1', '2023-11-06 00:00:00.000000');
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
) ENGINE=InnoDB AUTO_INCREMENT=1414 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_interface_testcase
-- ----------------------------
INSERT INTO `autotestplat_interface_testcase` VALUES ('1338', '用户列表接口-断言错误校验', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'\', \'Cookie\': \'\'}', '{}', 'JSON', 'post', 'fin', null, '3', '', null, null, '1', '20012');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1351', '用户列表接口-获取前面接口返回值参数的值', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{keyres}\"}', 'JSON', 'post', 'fin', null, '3', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1363', '用户列表接口-参数中获取随机变量参数值', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{timeRandom}\"}', 'JSON', 'post', 'fin', null, '3', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1383', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1392', '用户列表接口-参数中获取随机变量参数值', '{ test_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{timeRandom}\"}', 'JSON', 'post', 'fin', null, '3', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1396', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置2', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', 'test', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1399', '用户列表接口-随机数字参数', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1400', '用户列表接口-随机数字参数2', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1401', '用户列表接口-随机数字参数3', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1402', '用户列表接口-随机数字参数4', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1403', '用户列表接口-随机数字参数5', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1404', '用户列表接口-随机数字参数6', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1405', '用户列表接口-随机数字参数7', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1406', '用户列表接口-随机数字参数8', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1407', '用户列表接口-随机数字参数9', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1408', '用户列表接口-随机数字参数10', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1409', '用户列表接口-随机数字参数11', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1410', '用户列表接口-随机数字参数12', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1411', '用户列表接口-随机数字参数13', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1412', '用户列表接口-随机数字参数14', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1413', '用户列表接口-随机数字参数15', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');

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
) ENGINE=InnoDB AUTO_INCREMENT=898 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_parameter
-- ----------------------------
INSERT INTO `autotestplat_parameter` VALUES ('616', '字符串随机数', 'charRandom', '\'\'.join(random.sample(string.ascii_letters + string.digits,10))', '', '', '', '3', '', 'var');
INSERT INTO `autotestplat_parameter` VALUES ('668', '时间戳随机数', 'timeRandom', 'int(time.time())', '', '', '', '3', null, 'var');
INSERT INTO `autotestplat_parameter` VALUES ('669', '数字随机数', 'numRandom', 'random.randint(0,99999999999)', '', '', '', '5', null, 'var');
INSERT INTO `autotestplat_parameter` VALUES ('670', 'Appid', 'Appid', '123456789011', '', '', '', '5', null, 'con');
INSERT INTO `autotestplat_parameter` VALUES ('671', '测试环境', 'test_url', 'http://127.0.0.1', '', '', '', '3', null, 'env');
INSERT INTO `autotestplat_parameter` VALUES ('869', '生产环境', 'online_url', 'http://127.0.0.1', null, null, null, '5', null, 'env');
INSERT INTO `autotestplat_parameter` VALUES ('883', '1', '1', '', '1', '1', '1', '4', '1381', 'res');
INSERT INTO `autotestplat_parameter` VALUES ('889', '1', '1', '', '1', '1', '0', '5', '1396', 'res');
INSERT INTO `autotestplat_parameter` VALUES ('891', '1', '1', '', '1', '1', '0', 'testplan', '1924', 'res');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of autotestplat_product
-- ----------------------------
INSERT INTO `autotestplat_product` VALUES ('3', 'ChatGPT', '已发布', '聊天的', 'fin', null);
INSERT INTO `autotestplat_product` VALUES ('5', 'Autotestplat', '已发布', '自动化测试软件', 'fin', null);

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
  `task_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of autotestplat_testplan
-- ----------------------------
INSERT INTO `autotestplat_testplan` VALUES ('98', 'testplan', '{ test_url }', 'testplan_interface_1907_用户列表接口-获取前面接口返回值参数的值', '用户列表接口-获取前面接口返回值参数的值', 'fin', '3', '53644');
INSERT INTO `autotestplat_testplan` VALUES ('106', '新的测试计划', '{ online_url }', 'testplan_interface_1917_用户列表接口-设置接口返回值关联参数-通过正则表达式设置,testplan_interface_1921_用户列表接口-随机数字参数,testplan_interface_1923_用户列表接口-随机数字参数,testplan_interface_1924_用户列表接口-设置接口返回值关联参数-通过正则表达式设置2', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置 ， 用户列表接口-随机数字参数 ， 用户列表接口-随机数字参数 ， 用户列表接口-设置接口返回值关联参数-通过正则表达式设置2', 'fin', '5', '53651');
INSERT INTO `autotestplat_testplan` VALUES ('114', 'plan1', '{ online_url }', 'testplan_interface_1928_用户列表接口-设置接口返回值关联参数-通过正则表达式设置,testplan_interface_1930_用户列表接口-随机数字参数,testplan_interface_1931_用户列表接口-随机数字参数2,testplan_interface_1932_用户列表接口-随机数字参数3,testplan_interface_1933_用户列表接口-随机数字参数4,testplan_interface_1934_用户列表接口-随机数字参数5,testplan_interface_1935_用户列表接口-随机数字参数,testplan_interface_1936_用户列表接口-随机数字参数', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置 ， 用户列表接口-随机数字参数 ， 用户列表接口-随机数字参数2 ， 用户列表接口-随机数字参数3 ， 用户列表接口-随机数字参数4 ， 用户列表接口-随机数字参数5 ， 用户列表接口-随机数字参数 ， 用户列表接口-随机数字参数', 'fin', '5', '53657');

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
) ENGINE=InnoDB AUTO_INCREMENT=1964 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_testplan_interface
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface` VALUES ('1907', '98', 'testplan', '用户列表接口-获取前面接口返回值参数的值', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{keyres}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1917', '106', '新的测试计划', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1921', '106', '新的测试计划', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1923', '106', '新的测试计划', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1924', '106', '新的测试计划', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置2', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1928', '114', 'plan1', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1930', '114', 'plan1', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1931', '114', 'plan1', '用户列表接口-随机数字参数2', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1932', '114', 'plan1', '用户列表接口-随机数字参数3', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1933', '114', 'plan1', '用户列表接口-随机数字参数4', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1934', '114', 'plan1', '用户列表接口-随机数字参数5', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1935', '114', 'plan1', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1936', '114', 'plan1', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);

-- ----------------------------
-- Table structure for `autotestplat_testplan_interface_order`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan_interface_order`;
CREATE TABLE `autotestplat_testplan_interface_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_id` int(11) DEFAULT NULL,
  `interface_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34720 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of autotestplat_testplan_interface_order
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34601', '98', '1907');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34648', '106', '1917');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34649', '106', '1921');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34650', '106', '1923');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34651', '106', '1924');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34676', '114', '1928');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34677', '114', '1930');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34678', '114', '1931');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34679', '114', '1932');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34680', '114', '1933');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34681', '114', '1934');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34682', '114', '1935');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34683', '114', '1936');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34699', '123', '1952');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34700', '124', '1953');

-- ----------------------------
-- Table structure for `autotestplat_testplan_interface_result`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan_interface_result`;
CREATE TABLE `autotestplat_testplan_interface_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` varchar(20) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=27334 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_testplan_interface_result
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27206', '20231111100500247210', '5', '97', '1906', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'test12345', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-11T01:29:07.061Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '1', '2023-11-11 10:05:00', '定时任务', '0.028903', '0%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27207', '20231111100519386943', '3', '98', '1907', '用户列表接口-获取前面接口返回值参数的值', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'{keyres}\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-11T01:29:07.061Z\", 0, \"fin\", \"fin\", \"ChatGPT\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-11 10:05:19', '定时任务', '0.039178', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27208', '20231111101204237351', '5', '99', '1909', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'14675807635\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-11T02:08:41.071Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T02:07:55.443Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-11 10:12:04', '定时任务', '0.026911', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27209', '20231111101204237351', '5', '99', '1910', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-11T02:08:41.071Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T02:07:55.443Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-11 10:12:04', '定时任务', '0.023925', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27210', '20231111221033970110', '5', '99', '1909', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'45443042015\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-11T14:10:01.133Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T02:07:55.443Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-11 22:10:33', '定时任务', '0.044082', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27211', '20231111221033970110', '5', '99', '1910', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-11T14:10:01.133Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T02:07:55.443Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-11 22:10:33', '定时任务', '0.049978', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27244', '20231113090707056526', '5', '106', '1917', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-13T00:26:14.325Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-13 09:07:07', '定时任务', '0.031897', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27245', '20231113090707056526', '5', '106', '1921', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'33397505678\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-13T00:26:14.325Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-13 09:07:07', '定时任务', '0.026912', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27246', '20231113090807007332', '5', '106', '1917', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-13T00:26:14.325Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-13 09:08:07', '定时任务', '0.040009', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27247', '20231113090807007332', '5', '106', '1921', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'54113247805\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-13T00:26:14.325Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-13 09:08:07', '定时任务', '0.019994', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27249', '20231113090907017565', '5', '106', '1917', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-13T00:26:14.325Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-13 09:09:07', '定时任务', '0.029953', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27250', '20231113090907017565', '5', '106', '1921', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'97684324342\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-13T00:26:14.325Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-13 09:09:07', '定时任务', '0.039989', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27320', '20231115110010877323', '5', '106', '1917', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-15T02:31:48.359Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-15 11:00:10', '定时任务', '0.02999', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27321', '20231115110010877323', '5', '106', '1921', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'59921907377\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-15T02:31:48.359Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-15 11:00:10', '定时任务', '0.029991', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27322', '20231115110010877323', '5', '106', '1923', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'57783680336\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-15T02:31:48.359Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-15 11:00:10', '定时任务', '0.02999', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27323', '20231115110010877323', '5', '106', '1924', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置2', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-15T02:31:48.359Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-15 11:00:10', '定时任务', '0.019994', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27324', '20231118093052859756', '5', '113', '1925', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-17T15:26:36.185Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-18 09:30:52', '定时任务', '0.059982', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27325', '20231118093052859756', '5', '113', '1926', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置2', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-17T15:26:36.185Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-18 09:30:52', '定时任务', '0.029963', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27326', '20231118093052859756', '5', '113', '1927', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'79109558688\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-17T15:26:36.185Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-18 09:30:52', '定时任务', '0.049983', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27327', '20231119144413031873', '5', '114', '1928', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-19T06:31:20.835Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-19 14:44:13', '定时任务', '0.027614', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27328', '20231119144413031873', '5', '114', '1929', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置2', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-19T06:31:20.835Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-19 14:44:13', '定时任务', '0.020032', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27329', '20231119144413031873', '5', '114', '1930', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'67576281745\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-19T06:31:20.835Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-19 14:44:13', '定时任务', '0.019995', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27330', '20231119144413031873', '5', '114', '1931', '用户列表接口-随机数字参数2', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'99671751541\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-19T06:31:20.835Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-19 14:44:13', '定时任务', '0.02999', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27331', '20231119144413031873', '5', '114', '1932', '用户列表接口-随机数字参数3', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'68485562193\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-19T06:31:20.835Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-19 14:44:13', '定时任务', '0.019994', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27332', '20231119144413031873', '5', '114', '1933', '用户列表接口-随机数字参数4', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'4057290524\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-19T06:31:20.835Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-19 14:44:13', '定时任务', '0.019993', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27333', '20231119144413031873', '5', '114', '1934', '用户列表接口-随机数字参数5', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'22653792872\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-19T06:31:20.835Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-19 14:44:13', '定时任务', '0.019994', '100%');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2023-10-17 08:06:52.299889', '16', 'debug: every minute', '1', '[{\"added\": {}}]', '24', '2');
INSERT INTO `django_admin_log` VALUES ('2', '2023-11-06 13:16:07.791117', '2', 'fin', '2', '[{\"changed\": {\"fields\": [\"email\", \"is_superuser\"]}}]', '4', '7');
INSERT INTO `django_admin_log` VALUES ('3', '2023-11-11 23:39:28.662607', '53646', 'test: 00 00 * 12 11 (m/h/d/dM/MY)', '1', '[{\"added\": {}}]', '24', '7');
INSERT INTO `django_admin_log` VALUES ('4', '2023-11-11 23:44:26.808504', '53645', '99: 00 00 * 12 11 (m/h/d/dM/MY)', '2', '[{\"changed\": {\"fields\": [\"task\", \"interval\"]}}]', '24', '7');
INSERT INTO `django_admin_log` VALUES ('5', '2023-11-11 23:44:35.061656', '53644', '98: 13 09 * 12 11 (m/h/d/dM/MY)', '2', '[{\"changed\": {\"fields\": [\"task\", \"interval\"]}}]', '24', '7');
INSERT INTO `django_admin_log` VALUES ('6', '2023-11-11 23:44:43.255881', '53643', '97: 03 09 * 13 11 (m/h/d/dM/MY)', '2', '[{\"changed\": {\"fields\": [\"task\", \"interval\"]}}]', '24', '7');
INSERT INTO `django_admin_log` VALUES ('7', '2023-11-11 23:56:25.582251', '53643', '97: every minute', '2', '[{\"changed\": {\"fields\": [\"interval\", \"crontab\"]}}]', '24', '7');
INSERT INTO `django_admin_log` VALUES ('8', '2023-11-12 00:06:35.269074', '53647', 'helloword: every minute', '1', '[{\"added\": {}}]', '24', '7');
INSERT INTO `django_admin_log` VALUES ('9', '2023-11-12 00:06:52.841669', '53643', '97: every 6 hours', '2', '[{\"changed\": {\"fields\": [\"interval\"]}}]', '24', '7');
INSERT INTO `django_admin_log` VALUES ('10', '2023-11-12 00:32:37.100618', '53643', '97: every 6 hours', '2', '[{\"changed\": {\"fields\": [\"args\"]}}]', '24', '7');
INSERT INTO `django_admin_log` VALUES ('11', '2023-11-12 00:33:05.240248', '53643', '97: every minute', '2', '[{\"changed\": {\"fields\": [\"interval\"]}}]', '24', '7');

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
INSERT INTO `django_content_type` VALUES ('29', 'autotest', 'autotestplatinterfacetestcase');
INSERT INTO `django_content_type` VALUES ('28', 'autotest', 'autotestplatparameter');
INSERT INTO `django_content_type` VALUES ('27', 'autotest', 'autotestplatproduct');
INSERT INTO `django_content_type` VALUES ('30', 'autotest', 'autotestplattestplan');
INSERT INTO `django_content_type` VALUES ('31', 'autotest', 'autotestplattestplaninterface');
INSERT INTO `django_content_type` VALUES ('33', 'autotest', 'autotestplattestplaninterfaceorder');
INSERT INTO `django_content_type` VALUES ('32', 'autotest', 'autotestplattestplaninterfaceresult');
INSERT INTO `django_content_type` VALUES ('13', 'autotest', 'djangoadminlog');
INSERT INTO `django_content_type` VALUES ('14', 'autotest', 'djangocontenttype');
INSERT INTO `django_content_type` VALUES ('15', 'autotest', 'djangomigrations');
INSERT INTO `django_content_type` VALUES ('16', 'autotest', 'djangosession');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('25', 'djcelery', 'crontabschedule');
INSERT INTO `django_content_type` VALUES ('34', 'djcelery', 'intervalschedule');
INSERT INTO `django_content_type` VALUES ('24', 'djcelery', 'periodictask');
INSERT INTO `django_content_type` VALUES ('35', 'djcelery', 'periodictasks');
INSERT INTO `django_content_type` VALUES ('36', 'djcelery', 'taskmeta');
INSERT INTO `django_content_type` VALUES ('37', 'djcelery', 'tasksetmeta');
INSERT INTO `django_content_type` VALUES ('38', 'djcelery', 'taskstate');
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
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2023-11-11 13:45:08.404815');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2023-11-11 13:45:08.414841');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2023-11-11 13:45:08.414841');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2023-11-11 13:45:08.424812');
INSERT INTO `django_migrations` VALUES ('5', 'contenttypes', '0002_remove_content_type_name', '2023-11-11 13:45:08.434807');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2023-11-11 13:45:08.444829');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2023-11-11 13:45:08.454801');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2023-11-11 13:45:08.464839');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2023-11-11 13:45:08.474824');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2023-11-11 13:45:08.484845');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2023-11-11 13:45:08.494826');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0008_alter_user_username_max_length', '2023-11-11 13:45:08.514824');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0009_alter_user_last_name_max_length', '2023-11-11 13:45:08.524776');
INSERT INTO `django_migrations` VALUES ('14', 'djcelery', '0001_initial', '2023-11-11 13:45:08.534774');
INSERT INTO `django_migrations` VALUES ('15', 'sessions', '0001_initial', '2023-11-11 13:45:08.544797');
INSERT INTO `django_migrations` VALUES ('16', 'admin', '0003_logentry_add_action_flag_choices', '2023-11-11 14:09:33.030366');

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
INSERT INTO `django_session` VALUES ('0ayu6sb4419rnohd2fzaayizwhgwo0hg', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 11:27:14.014237');
INSERT INTO `django_session` VALUES ('0ftmvusdrkvdktj92p21617mjxjg8jtz', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 06:51:46.840627');
INSERT INTO `django_session` VALUES ('0k7xlvc3g7ef762yhlwij3msmueexjnt', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 01:55:43.565600');
INSERT INTO `django_session` VALUES ('0uhv5nal2bhwxbjwk38esquis11b0zsx', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 06:50:14.853683');
INSERT INTO `django_session` VALUES ('0y5uwy79sxrykszd2l2ce5jzgsyp273v', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-31 04:22:04.775453');
INSERT INTO `django_session` VALUES ('1cp8vnlq0zhx255gh06ioq2eah51q4n1', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 11:29:14.836194');
INSERT INTO `django_session` VALUES ('1lb22quo4klzir2wkcivzuv3zaxwr9x9', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-20 13:45:42.115114');
INSERT INTO `django_session` VALUES ('21cne174fm7w2al4o1xqta6xjy42ziq3', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 02:32:44.662563');
INSERT INTO `django_session` VALUES ('24uk1caguplgq4x8uddleudg9hdn0uum', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 02:26:44.895537');
INSERT INTO `django_session` VALUES ('2a23igledls9l6qp7g6dpaghyk89wpvo', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:04:18.467811');
INSERT INTO `django_session` VALUES ('2g12tgs53yggwmrke49anj43e8egvnsd', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 09:57:34.954172');
INSERT INTO `django_session` VALUES ('2hdb1oy017s0gc1i0jaf87zmbj8gnpdc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 14:46:52.305122');
INSERT INTO `django_session` VALUES ('2tneomgyxp3i8fll8hq7p1do0ta4rr83', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-30 09:46:59.696832');
INSERT INTO `django_session` VALUES ('2vx2t7zstbmlk1mp4a5fm62ile3dde2d', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 13:58:43.197205');
INSERT INTO `django_session` VALUES ('2y900mpowg8cmoh766rr5fbpkte87ik6', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:40:56.555595');
INSERT INTO `django_session` VALUES ('31fc90afdlcr2il2nt6jvikm3ey52sew', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 01:45:23.358884');
INSERT INTO `django_session` VALUES ('3bowdso7x5axna4qvr9djfsk5tyuyr83', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-29 02:26:50.897898');
INSERT INTO `django_session` VALUES ('3i25rmigkbegwdlr7hfqw3t7tu5kzl55', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 07:49:45.841243');
INSERT INTO `django_session` VALUES ('3svzaaxu8gdfubcndopks0lyoux3r8vs', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:07:01.543122');
INSERT INTO `django_session` VALUES ('42q1zxpqbsl1622a0y7965tufohg066t', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 10:51:14.468600');
INSERT INTO `django_session` VALUES ('4jbopii2n7pzm1zmzkfbfw7146d07ezs', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:33:16.451046');
INSERT INTO `django_session` VALUES ('5145zdgn095daoftcifjbine3tcgarzf', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:14:20.746836');
INSERT INTO `django_session` VALUES ('54tzdcw1bmw13qas9zkow0rktlau507x', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:04:09.721257');
INSERT INTO `django_session` VALUES ('59h1cjg25a2m5y5zugc0o06hhkhuvlmc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 12:31:41.104749');
INSERT INTO `django_session` VALUES ('5p2kwaa7bpl1il6kenz3hx9xagcwiw1w', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:32:13.602598');
INSERT INTO `django_session` VALUES ('65psfl0qbqfe3p0ojy0zj2rx7lukn1bt', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:21:02.417420');
INSERT INTO `django_session` VALUES ('6b97c3jrg2b0sxup9xld5vhg5dw0d8wp', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:47:16.496954');
INSERT INTO `django_session` VALUES ('6sgvhkzrknyphgoy0ibdjvc0pvpuby38', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:43:53.878781');
INSERT INTO `django_session` VALUES ('732u0uouwpik35oqvv5c6orblth5ibex', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:49:38.845616');
INSERT INTO `django_session` VALUES ('78gtfkc3jhd9qsyot2sp5ruj2s5ibqfv', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:23:05.666163');
INSERT INTO `django_session` VALUES ('7b4bznyemwhbh85hzhoyut7slp7q78y0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:46:07.809398');
INSERT INTO `django_session` VALUES ('7ew0oei80869rp3lupjjmy8iy2hsskj1', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 03:08:53.888361');
INSERT INTO `django_session` VALUES ('7hz2y7v33deej83bbjiarfry8ylj01jt', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:15:26.111214');
INSERT INTO `django_session` VALUES ('7p40m0ria58431cqkq36wdhvxmifokes', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 11:47:28.314277');
INSERT INTO `django_session` VALUES ('87fxow9j798zswcor0cja8wi66t3j71i', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-29 08:42:05.721794');
INSERT INTO `django_session` VALUES ('8m3sf8lg0p3jux7t19q8tlztztyzfmrr', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:12:12.577915');
INSERT INTO `django_session` VALUES ('8rv0r5paqyg9r2x2wjj041umyn5am7le', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:17:57.474738');
INSERT INTO `django_session` VALUES ('8xefirnvg396q09nxhsm672md1vj6vem', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 12:06:53.672343');
INSERT INTO `django_session` VALUES ('90xe6k7u7m61ufhtx3qnifa0hckg30aw', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 15:05:21.610426');
INSERT INTO `django_session` VALUES ('997yr7nppqqx2q6atkjsam0g2o7vwavz', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:52:36.606572');
INSERT INTO `django_session` VALUES ('9fbbd2g8x2tjo62pt9sch7w0cpibsyol', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 10:36:39.182694');
INSERT INTO `django_session` VALUES ('9ovjgmokgl4gasengkih37zwyfczth51', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 07:32:31.359009');
INSERT INTO `django_session` VALUES ('9v2l9j75cs2shsdh6zjuxqbe7rstcgkc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:21:43.856271');
INSERT INTO `django_session` VALUES ('agcmegxiy48trgqnnbxjyudxjeaq3gi4', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:11:55.523518');
INSERT INTO `django_session` VALUES ('ay12c7i2h286eogi3m581fkk2o68dqar', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 09:05:05.200941');
INSERT INTO `django_session` VALUES ('baw0s320kktp0owq1s0difvqvjl5ovhk', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 13:48:33.054681');
INSERT INTO `django_session` VALUES ('bcg92r1zfilh5gvas4xt9vz32dfmo7mr', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 09:35:27.091812');
INSERT INTO `django_session` VALUES ('c8f14lynvov35xm2m4oieiz2rtee95bu', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:50:41.211354');
INSERT INTO `django_session` VALUES ('cnp1y609uzo9ykditxjza4qww0y8mc5m', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:37:00.695829');
INSERT INTO `django_session` VALUES ('cvpsgbprmgw9in7nqv9ged6mznub2nmn', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 15:13:17.905960');
INSERT INTO `django_session` VALUES ('dadkf0e7jprpcom5mlrpkqk1mm0h5xhf', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:34:39.346393');
INSERT INTO `django_session` VALUES ('dbaw8n45v29spaqu38eyibwt9bwsekeh', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:48:27.715970');
INSERT INTO `django_session` VALUES ('ddv5naf6c61mrv4iml96wab247bntxa7', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 10:32:45.700119');
INSERT INTO `django_session` VALUES ('de50jur80bjzcrditfrg2qmv20drgtcb', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 11:11:53.734060');
INSERT INTO `django_session` VALUES ('dkfrkspfasi1t283rlj4bujfkyceygwy', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:03:53.364399');
INSERT INTO `django_session` VALUES ('dnvdj25tfase4t5olmpraiig3mwbca2r', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:07:30.967084');
INSERT INTO `django_session` VALUES ('dpgxdcv1ihv06djiurpl94acpethl1ur', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 11:46:47.100937');
INSERT INTO `django_session` VALUES ('dqz4fu5jfui1bw5766zqs2ih5flozxw5', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:26:45.363761');
INSERT INTO `django_session` VALUES ('e3gckknymgyirzf1w9etwxa8l5sa5vq0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 03:05:42.862716');
INSERT INTO `django_session` VALUES ('eaad3xt3jfx6dn2x1wir9vm4d3dva25i', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-23 09:24:43.098189');
INSERT INTO `django_session` VALUES ('eb7xptg3224y72aw3voim7qasvfx7dgl', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:41:12.805112');
INSERT INTO `django_session` VALUES ('er9fn3jhmkxyldu4fr78r0jd5btk6vz1', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 13:05:59.754946');
INSERT INTO `django_session` VALUES ('euitceotqccoxki9wh8p0ajfokf7dyuz', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 07:58:27.365275');
INSERT INTO `django_session` VALUES ('eynnp5ore8acyq4y0282lb8yr1c761n7', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:07:28.361718');
INSERT INTO `django_session` VALUES ('ezcg7s33mwpelq4xttcliy1avwxp31qk', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:01:24.517152');
INSERT INTO `django_session` VALUES ('fn8ji883gaxu050uao42bxn31oe3ycjg', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 10:29:28.441223');
INSERT INTO `django_session` VALUES ('fz51uonmkvswdo99fr0zwru38ermr8ot', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 04:31:02.585282');
INSERT INTO `django_session` VALUES ('g8i4iur2bxiy6q0d7wlst2l1y39llix3', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:45:00.377517');
INSERT INTO `django_session` VALUES ('g9rgheg4uu5wm038htvardvem8kjk89f', 'MTE5NjA4YTk2MjM3YzE1OTRlNmUzZjQxYjY0YTQ0MjkxZmUyY2JiNTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYmNhNWJjYTM1YWQ1ZGJkZWEzZWVmZTg3ZGY1MTRkMTBiMTY2M2UyIiwidXNlciI6ImZpbiJ9', '2023-11-20 13:33:04.585820');
INSERT INTO `django_session` VALUES ('gghqhyacv136xkezvv1y56fk8lp56jjj', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:27:30.322790');
INSERT INTO `django_session` VALUES ('gm3i6kpii63ivwcnwk3ff3ar6evl4g6p', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:37:15.756084');
INSERT INTO `django_session` VALUES ('guxvpsuk4pax6ye7795etqtjhy3hixhg', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 01:53:03.345593');
INSERT INTO `django_session` VALUES ('ha4su71gee3j8tlz66stwylpkf4vqh8z', 'ZmJiOGU0MmVjNmIwNmIzN2RhNTUwNjYxMjM0YjViNDRjMjM1ODI3OTp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMTg4OTQ2ZWZhYWM5YmNhYjVhZmRjOWNhYjNkNzdkMGQ1NWNiN2VhIiwidXNlciI6InJvb3QifQ==', '2023-11-20 13:03:28.373926');
INSERT INTO `django_session` VALUES ('hne9fu3mwmtnwxx4w74vumu29cggz8q3', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:20:20.158741');
INSERT INTO `django_session` VALUES ('hu7u7n4c4102hyoiam4bbudxqy9db6lb', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:00:02.198860');
INSERT INTO `django_session` VALUES ('hwz0q7s8yp35q7gmvcalz4uxa5ef1csk', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 02:06:02.343121');
INSERT INTO `django_session` VALUES ('i88zdylicds9st1oszg96zk44dw0in2l', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 02:47:57.254469');
INSERT INTO `django_session` VALUES ('j55n55v0eisbsdlsi5m6l3j9be0c8sm0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 03:04:03.008776');
INSERT INTO `django_session` VALUES ('kabfl4dwteqcq0bo64v0zeyfvmy7qksl', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-27 01:54:41.319462');
INSERT INTO `django_session` VALUES ('kiuu0kga88smlwrkj60yzhitju82fck6', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 12:19:49.719807');
INSERT INTO `django_session` VALUES ('kvvptfu8i6lza506vm409m0b55nyoeni', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 11:30:26.659470');
INSERT INTO `django_session` VALUES ('loy3k4jhgd1ozgvrekfj9bpe0id33cc9', 'YmY5YzgzOTc1ZDFmYmRhMWQ4YzM5MTA3MmIwMDE0MzhkZTA5ZjY5Yzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6InRlc3QifQ==', '2023-11-24 02:53:51.321625');
INSERT INTO `django_session` VALUES ('lqc2elz0y0kql1584knn8wc8hpygc09i', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 03:04:31.975986');
INSERT INTO `django_session` VALUES ('lzene1p557zs6vqnxc4o9vyj44zygu9k', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-11-14 03:30:28.089381');
INSERT INTO `django_session` VALUES ('mhld50wcykhxqxrdmy7d1vy3knzxv23t', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:54:50.919466');
INSERT INTO `django_session` VALUES ('ms7weifjv3dqi4wshfkdz3pg2dcgwkus', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:13:42.140610');
INSERT INTO `django_session` VALUES ('n7lal90qpbl4k6cjjazzpe5vzrh4emj2', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-11-05 13:20:16.066226');
INSERT INTO `django_session` VALUES ('n8r5tam6skf9pfibxxhs8sii5nz3plky', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:35:54.370813');
INSERT INTO `django_session` VALUES ('n9aa6h2zd8z8m2hmhenkdj2rofl8l3wn', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 12:18:50.896242');
INSERT INTO `django_session` VALUES ('nepv0ytdmnxomhrauibgfatpxhk3ldry', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-25 13:38:45.925664');
INSERT INTO `django_session` VALUES ('nogkgy9inu8g05v6748wdn20qfq56iqf', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:45:39.956131');
INSERT INTO `django_session` VALUES ('nsm8tsqbvcjr69235v0chymwigqjmz5i', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:58:06.989895');
INSERT INTO `django_session` VALUES ('nwz7e2onvr9pquvehjdsqbsckd5yk18h', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 12:36:48.006247');
INSERT INTO `django_session` VALUES ('nygqsoygastlpot53adyqxw297q4v0dc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 06:47:57.342265');
INSERT INTO `django_session` VALUES ('o0k6r0k11fjurjfcg5f4op4zwjp11usz', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 01:37:54.014557');
INSERT INTO `django_session` VALUES ('o2k8nn3g58xaqfqxybeyhogq68efzoeu', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 11:19:53.045902');
INSERT INTO `django_session` VALUES ('ob0ghrlm4gsuq86ki5i3twmgvtfk68zp', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 09:00:30.704675');
INSERT INTO `django_session` VALUES ('omxzyr8wk4fh9hv7aka2pc9esd3kxqvt', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 15:06:11.146498');
INSERT INTO `django_session` VALUES ('os79cszkwyrgp7k209ddx8zfaqpkgwzc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 03:15:52.132178');
INSERT INTO `django_session` VALUES ('oxma10vcmah1v3vbqlvs8p92nzlmuwqi', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-04 00:50:05.596819');
INSERT INTO `django_session` VALUES ('pclp6ilj7cl9mxegbzh5j9b6g16h1p63', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-29 02:31:48.369440');
INSERT INTO `django_session` VALUES ('pnhsnhmt6jsukmhp8x2r6xuuevcxbfoz', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-30 09:46:59.774129');
INSERT INTO `django_session` VALUES ('pnv62ssrf2ftldog595bivekt1we5h7q', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:53:24.859076');
INSERT INTO `django_session` VALUES ('ptdy3unq1gc6y07mesagfolvoybp62cq', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-25 13:13:05.359717');
INSERT INTO `django_session` VALUES ('r2lpfqwticl09iwwy0u5gfijfgljmlbg', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 07:03:25.664463');
INSERT INTO `django_session` VALUES ('r6pz9izjlen67wboswbekryea7er03zi', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:09:16.408858');
INSERT INTO `django_session` VALUES ('rif5eoz5fkeahm30qlc238mffe89shij', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 09:11:13.508101');
INSERT INTO `django_session` VALUES ('rn52sj0k1byevrogwj9q3k3j0ygs5c56', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:21:23.455739');
INSERT INTO `django_session` VALUES ('rtl2mk68ucd6kzybp9ycem6nsxihg13y', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 07:05:45.174065');
INSERT INTO `django_session` VALUES ('s190smx0wtfmv23s0sf80ke04um8kh30', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 05:30:53.846066');
INSERT INTO `django_session` VALUES ('s1mup1mrcznc8qe3b9xr8agud6n0rn1q', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:04:38.149226');
INSERT INTO `django_session` VALUES ('s98ezk9gifrfxknng1wrnj9i994u2iif', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:06:30.996665');
INSERT INTO `django_session` VALUES ('ser5p78ychix25anl4t4tnichzeojekj', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:45:30.198617');
INSERT INTO `django_session` VALUES ('sjlcejp4ne70wwy3dizavpoxhcnfb7sq', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:24:11.488855');
INSERT INTO `django_session` VALUES ('spfbw866cm8p4hcr0zhryu0o70u6fri9', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 04:29:10.461809');
INSERT INTO `django_session` VALUES ('sqm77vpt48b3lxxck9qnka78fxmvfx63', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 10:33:35.039194');
INSERT INTO `django_session` VALUES ('t0z62m2lbk9sin8nnimlyzx4ewbcpmw0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:28:52.017867');
INSERT INTO `django_session` VALUES ('t1vpde95rq5wqofv7cezrgmxjol6kd09', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 00:36:27.069916');
INSERT INTO `django_session` VALUES ('t3sk6ed58stlojqyakc5u6pm5449riwf', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 11:04:26.046069');
INSERT INTO `django_session` VALUES ('tahtqhexmqzthywkfw13hacj3rbvte4e', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:02:51.917551');
INSERT INTO `django_session` VALUES ('tdrh53to19oppfk0bj8tm5fszfrv7llu', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 23:55:09.375945');
INSERT INTO `django_session` VALUES ('tet68yw2mezgwbri0x961nywbwuf88ab', 'MmFkZjdkODFmNGRiZTdhM2Y4YTE1ZWYxOWZiN2ZlMGIyZDhmOGI0YTp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNDUwNWE4NTQ2MjZmOGRmNTllMmY2OGEyY2VhMDg1MjdlZDBhNjljIiwidXNlciI6InRlc3QifQ==', '2023-11-20 10:56:45.297749');
INSERT INTO `django_session` VALUES ('tvx5d8saxwc1fakulahbfvmr8zb3otsj', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 14:26:43.696947');
INSERT INTO `django_session` VALUES ('tydqlrpp0ifvitea0gc1dqvrp34kitxs', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 04:27:55.167238');
INSERT INTO `django_session` VALUES ('u8v5r1wt63lksmesjbza6bjkzjoish6i', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-23 01:11:45.079881');
INSERT INTO `django_session` VALUES ('v83sf4kk66bg0azi1slz2iamjc3e2zop', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 14:15:23.020794');
INSERT INTO `django_session` VALUES ('vdwqi89hx40llxmxz9l6z9f9kimqgkf9', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:08:31.441302');
INSERT INTO `django_session` VALUES ('vp6mxnryw1ey16acyco66kb9zimbkir9', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:19:36.336412');
INSERT INTO `django_session` VALUES ('w0j12sqwscgaa1pr6wbmkxz6vmtaolff', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:55:33.356059');
INSERT INTO `django_session` VALUES ('w39lr58tqftreriepxxskhfpfez8bjru', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 01:51:24.464512');
INSERT INTO `django_session` VALUES ('w5ypux7o4plbvyk9vhz3qvqijgz58sp0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 10:35:22.876031');
INSERT INTO `django_session` VALUES ('w8m3vioz9sczo14impvijac2b6p3kh6y', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-25 02:08:41.075775');
INSERT INTO `django_session` VALUES ('wftsbx713hl8dn911fdaqp4w5p4rwd1m', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 11:28:01.865154');
INSERT INTO `django_session` VALUES ('wio5750vzlkg4kqlv8zpdgp2u565r64r', 'ZmJiOGU0MmVjNmIwNmIzN2RhNTUwNjYxMjM0YjViNDRjMjM1ODI3OTp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMTg4OTQ2ZWZhYWM5YmNhYjVhZmRjOWNhYjNkNzdkMGQ1NWNiN2VhIiwidXNlciI6InJvb3QifQ==', '2023-11-20 12:53:02.683758');
INSERT INTO `django_session` VALUES ('wmkixkjyww1ccv6dm7ec2kwhoy4tzw4n', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 09:54:01.634485');
INSERT INTO `django_session` VALUES ('wqxa0oz8r4d32067xjur7z03gebcco13', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-29 02:11:01.968316');
INSERT INTO `django_session` VALUES ('wth9d5ubipptiqilwg5d4e9i0n83jfbr', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:10:25.300372');
INSERT INTO `django_session` VALUES ('wuzkwxbkyq9iter1akcyy8tb9k4eo9e3', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 02:10:09.222347');
INSERT INTO `django_session` VALUES ('xpcr0cn70o15iz25drzy342yswodtja7', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 06:56:45.638567');
INSERT INTO `django_session` VALUES ('yexkj6t5wvv5d0fyyqif4708786ejn3d', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 07:38:43.051485');
INSERT INTO `django_session` VALUES ('yf1ic8n2lw5vd39sg9yfqbrtl0i002k1', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:08:06.618443');
INSERT INTO `django_session` VALUES ('yuhut14w2bt5nc0vvszhj0s69agodabu', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 15:12:13.260818');
INSERT INTO `django_session` VALUES ('yzq7fq38mn3r837zcsxwx10tepxl2k17', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 15:26:36.193468');
INSERT INTO `django_session` VALUES ('z2rroeonn4rteoh2avmxtm9uts5tnqo7', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 10:31:55.997476');
INSERT INTO `django_session` VALUES ('z8rrrw01bl4gt0sciuf72ic8hrtq92qj', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 06:45:39.370363');
INSERT INTO `django_session` VALUES ('zergz9kpto462qtoqeqaoqjdp1b6r3ko', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 01:53:17.757023');
INSERT INTO `django_session` VALUES ('zf4sxjuzli4dzrfo1jyz964rjdgsri3d', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-29 02:20:37.928291');
INSERT INTO `django_session` VALUES ('zsq3lyzc2up5j15p6l84giuwyzdkl96l', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:25:23.022956');
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
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_crontabschedule
-- ----------------------------
INSERT INTO `djcelery_crontabschedule` VALUES ('1', '50', '15', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('2', '30', '10', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('3', '40', '10', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('4', '0', '4', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('5', '50', '10', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('66', '13', '09', '*', '12', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('82', '00', '09', '*', '13', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('83', '00', '22', '*', '13', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('84', '16', '20', '*', '19', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('92', '47', '23', '*', '19', '11');

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
) ENGINE=InnoDB AUTO_INCREMENT=53672 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_periodictask
-- ----------------------------
INSERT INTO `djcelery_periodictask` VALUES ('53624', 'celery.backend_cleanup', 'celery.backend_cleanup', '[]', '{}', null, null, null, null, '1', null, '0', '2023-11-13 02:43:35', '', '4', null);
INSERT INTO `djcelery_periodictask` VALUES ('53644', '98', 'autotest.views_interfacetestplan.api_autotest_task', '[]', '{}', null, null, null, null, '1', null, '0', '2023-11-11 23:44:35', 'fin', '66', null);
INSERT INTO `djcelery_periodictask` VALUES ('53651', '106', 'autotest.views_interfacetestplan.api_autotest_task', '[106]', '{}', null, null, null, null, '1', '2023-11-13 01:29:01', '23', '2023-11-13 01:29:01', 'fin', '83', null);
INSERT INTO `djcelery_periodictask` VALUES ('53657', '114', 'autotest.views_interfacetestplan.api_autotest_task', '[114]', '{}', null, null, null, null, '1', null, '0', '2023-11-19 06:43:33', 'fin', '84', null);

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
INSERT INTO `djcelery_periodictasks` VALUES ('1', '2023-11-20 00:50:58');

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
