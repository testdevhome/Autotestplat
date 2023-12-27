/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : autotestplat

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2023-11-30 10:21:15
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('2', 'pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=', '2023-11-29 22:40:01.407915', '0', 'fin', 'fin', '5', '13711112222', '1', '1', '2023-10-04 03:24:35.000000');
INSERT INTO `auth_user` VALUES ('4', 'pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=', '2023-11-10 03:06:26.754032', '0', 'test', '', '3', '13800001111', '1', '1', '2023-10-13 06:23:00.000000');
INSERT INTO `auth_user` VALUES ('7', 'pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=', '2023-11-11 23:38:23.910363', '1', 'root', '', '5', '13822223333', '1', '1', '2023-11-06 00:00:00.000000');
INSERT INTO `auth_user` VALUES ('8', 'pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=', '2023-11-06 13:21:22.269930', '1', 'auto', '', '5', '13822223333', '1', '1', '2023-11-06 00:00:00.000000');

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
) ENGINE=InnoDB AUTO_INCREMENT=1456 DEFAULT CHARSET=utf8mb4;

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
INSERT INTO `autotestplat_interface_testcase` VALUES ('1400', '用户列表接口-随机数字参数2modify', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1401', '用户列表接口-随机数字参数3modify', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1402', '用户列表接口-随机数字参数4mod', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1403', '用户列表接口-随机数字参数5', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin1');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1404', '用户列表接口-随机数字参数6', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1405', '用户列表接口-随机数字参数7', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1406', '用户列表接口-随机数字参数8', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1407', '用户列表接口-随机数字参数9', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1408', '用户列表接口-随机数字参数10', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1409', '用户列表接口-随机数字参数11', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1410', '用户列表接口-随机数字参数12', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1411', '用户列表接口-随机数字参数13', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1412', '用户列表接口-随机数字参数14', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1414', '用户列表接口-随机数字参数15', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1415', '用户列表接口-随机数字参数16', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1416', '用户列表接口-随机数字参数17', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1417', '用户列表接口-随机数字参数18', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1418', '用户列表接口-随机数字参数19', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1419', '用户列表接口-随机数字参数20', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1420', '用户列表接口-随机数字参数21', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1421', '用户列表接口-随机数字参数22', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1422', '用户列表接口-随机数字参数23', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1423', '用户列表接口-随机数字参数24', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1424', '用户列表接口-随机数字参数25', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1425', '用户列表接口-随机数字参数26', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1426', '用户列表接口-随机数字参数27', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1427', '用户列表接口-随机数字参数28', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1428', '用户列表接口-随机数字参数29', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1429', '用户列表接口-随机数字参数30', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1430', '用户列表接口-随机数字参数31', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1431', '用户列表接口-随机数字参数32', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1432', '用户列表接口-随机数字参数33', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1433', '用户列表接口-随机数字参数34', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1434', '用户列表接口-随机数字参数35', '{ online_url }', '/autotest/user/getTableData/', '{\'t\': \'application/json; charset=utf-8\', \'o\': \'\', \'k\': \'\', \'e\': \'\'}', '{\r\n        \"username\": \"{numRandom}\"\r\n}', 'JSON', 'get', 'fin', null, '5', null, '', '', '1', 'fin1');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1435', '用户列表接口-随机数字参数36', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1436', '用户列表接口-随机数字参数37', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1437', '用户列表接口-随机数字参数38', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1438', '用户列表接口-随机数字参数39', '{ online_url }', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', 'fin', null, '5', null, '', '', '1', 'fin');
INSERT INTO `autotestplat_interface_testcase` VALUES ('1439', '用户列表接口-随机数字参数40', '{ online_url }', '/autotest/user/getTableData/', '{\'t\': \'application/json; charset=utf-8\', \'o\': \'\', \'k\': \'\', \'e\': \'\'}', '{\r\n        \"username\": \"{numRandom}\"\r\n}', 'JSON', 'get', 'fin', null, '5', null, '', '', '1', 'fin');

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
) ENGINE=InnoDB AUTO_INCREMENT=917 DEFAULT CHARSET=utf8mb4;

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
INSERT INTO `autotestplat_parameter` VALUES ('905', '1', '1', '', '1', '1', '0', 'testplan', '1980', 'res');
INSERT INTO `autotestplat_parameter` VALUES ('906', '1', '1', '', '1', '1', '0', 'testplan', '1996', 'res');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of autotestplat_product
-- ----------------------------
INSERT INTO `autotestplat_product` VALUES ('3', 'ChatGPT', '已发布', '聊天的', 'fin', 'N');
INSERT INTO `autotestplat_product` VALUES ('5', 'Autotestplat', '已发布', '自动化测试软件', 'fin', 'N');

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
  `task_progress` int(11) DEFAULT NULL,
  `interface_num` int(11) DEFAULT NULL,
  `run_time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of autotestplat_testplan
-- ----------------------------
INSERT INTO `autotestplat_testplan` VALUES ('98', 'testplan', '{ test_url }', 'testplan_interface_1907_用户列表接口-获取前面接口返回值参数的值', '用户列表接口-获取前面接口返回值参数的值', 'fin', '3', '53644', '1', '1', null);
INSERT INTO `autotestplat_testplan` VALUES ('114', '测试计划', '{ online_url }', 'testplan_interface_1928_用户列表接口-设置接口返回值关联参数-通过正则表达式设置,testplan_interface_1930_用户列表接口-随机数字参数,testplan_interface_1931_用户列表接口-随机数字参数2modify,testplan_interface_1932_用户列表接口-随机数字参数3,testplan_interface_1933_用户列表接口-随机数字参数4,testplan_interface_1934_用户列表接口-随机数字参数5,testplan_interface_1935_用户列表接口-随机数字参数,testplan_interface_1936_用户列表接口-随机数字参数', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置 ， 用户列表接口-随机数字参数 ， 用户列表接口-随机数字参数2modify ， 用户列表接口-随机数字参数3 ， 用户列表接口-随机数字参数4 ， 用户列表接口-随机数字参数5 ， 用户列表接口-随机数字参数 ， 用户列表接口-随机数字参数', 'fin', '5', '53657', null, '8', '');
INSERT INTO `autotestplat_testplan` VALUES ('128', 'plan', '{ online_url }', 'testplan_interface_1965_用户列表接口-随机数字参数,testplan_interface_1977_用户列表接口-随机数字参数,testplan_interface_2087_用户列表接口-随机数字参数', '用户列表接口-随机数字参数 ， 用户列表接口-随机数字参数 ， 用户列表接口-随机数字参数', 'fin', '5', '53673', null, '3', '');
INSERT INTO `autotestplat_testplan` VALUES ('129', '2.1版本测试任务计划', '{ online_url }', 'testplan_interface_1969_用户列表接口-随机数字参数2mod,testplan_interface_1970_用户列表接口-随机数字参数3mod,testplan_interface_1971_用户列表接口-随机数字参数4,testplan_interface_2086_用户列表接口-随机数字参数', '用户列表接口-随机数字参数2mod ， 用户列表接口-随机数字参数3mod ， 用户列表接口-随机数字参数4 ， 用户列表接口-随机数字参数', 'fin', '5', '53674', '4', '4', '2023-11-25 19:55:53');
INSERT INTO `autotestplat_testplan` VALUES ('130', '2.1testplan', '{ online_url }', 'testplan_interface_1979_用户列表接口-设置接口返回值关联参数-通过正则表达式设置,testplan_interface_1980_用户列表接口-设置接口返回值关联参数-通过正则表达式设置2,testplan_interface_1981_用户列表接口-随机数字参数,testplan_interface_1982_用户列表接口-随机数字参数2modify,testplan_interface_1983_用户列表接口-随机数字参数3modify,testplan_interface_1984_用户列表接口-随机数字参数4modify,testplan_interface_1985_用户列表接口-随机数字参数5,testplan_interface_1986_用户列表接口-随机数字参数6,testplan_interface_1987_用户列表接口-随机数字参数7,testplan_interface_1988_用户列表接口-随机数字参数8,testplan_interface_1989_用户列表接口-随机数字参数9,testplan_interface_1990_用户列表接口-随机数字参数10,testplan_interface_1991_用户列表接口-随机数字参数11,testplan_interface_1992_用户列表接口-随机数字参数12,testplan_interface_1993_用户列表接口-随机数字参数13,testplan_interface_1994_用户列表接口-随机数字参数14', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置 ， 用户列表接口-设置接口返回值关联参数-通过正则表达式设置2 ， 用户列表接口-随机数字参数 ， 用户列表接口-随机数字参数2modify ， 用户列表接口-随机数字参数3modify ， 用户列表接口-随机数字参数4modify ， 用户列表接口-随机数字参数5 ， 用户列表接口-随机数字参数6 ， 用户列表接口-随机数字参数7 ， 用户列表接口-随机数字参数8 ， 用户列表接口-随机数字参数9 ， 用户列表接口-随机数字参数10 ， 用户列表接口-随机数字参数11 ， 用户列表接口-随机数字参数12 ， 用户列表接口-随机数字参数13 ， 用户列表接口-随机数字参数14', 'fin', '5', '53675', null, '16', '');
INSERT INTO `autotestplat_testplan` VALUES ('131', '2.2版本测试计划', '{ online_url }', 'testplan_interface_1995_用户列表接口-设置接口返回值关联参数-通过正则表达式设置,testplan_interface_1996_用户列表接口-设置接口返回值关联参数-通过正则表达式设置2,testplan_interface_1997_用户列表接口-随机数字参数,testplan_interface_1998_用户列表接口-随机数字参数2mod,testplan_interface_1999_用户列表接口-随机数字参数3mod,testplan_interface_2000_用户列表接口-随机数字参数4mod,testplan_interface_2001_用户列表接口-随机数字参数5,testplan_interface_2002_用户列表接口-随机数字参数6,testplan_interface_2003_用户列表接口-随机数字参数7,testplan_interface_2004_用户列表接口-随机数字参数8,testplan_interface_2005_用户列表接口-随机数字参数9,testplan_interface_2006_用户列表接口-随机数字参数10,testplan_interface_2007_用户列表接口-随机数字参数11,testplan_interface_2008_用户列表接口-随机数字参数12,testplan_interface_2009_用户列表接口-随机数字参数13,testplan_interface_2010_用户列表接口-随机数字参数14,testplan_interface_2011_用户列表接口-随机数字参数15,testplan_interface_2012_用户列表接口-随机数字参数16,testplan_interface_2013_用户列表接口-随机数字参数17,testplan_interface_2014_用户列表接口-随机数字参数18,testplan_interface_2015_用户列表接口-随机数字参数19,testplan_interface_2016_用户列表接口-随机数字参数20,testplan_interface_2017_用户列表接口-随机数字参数21,testplan_interface_2018_用户列表接口-随机数字参数22,testplan_interface_2019_用户列表接口-随机数字参数23,testplan_interface_2020_用户列表接口-随机数字参数24,testplan_interface_2021_用户列表接口-随机数字参数25,testplan_interface_2022_用户列表接口-随机数字参数26,testplan_interface_2023_用户列表接口-随机数字参数27,testplan_interface_2024_用户列表接口-随机数字参数28,testplan_interface_2025_用户列表接口-随机数字参数29,testplan_interface_2026_用户列表接口-随机数字参数30,testplan_interface_2027_用户列表接口-随机数字参数31,testplan_interface_2028_用户列表接口-随机数字参数32,testplan_interface_2029_用户列表接口-随机数字参数33,testplan_interface_2030_用户列表接口-随机数字参数34,testplan_interface_2031_用户列表接口-随机数字参数35,testplan_interface_2032_用户列表接口-随机数字参数36,testplan_interface_2033_用户列表接口-随机数字参数37,testplan_interface_2034_用户列表接口-随机数字参数38,testplan_interface_2035_用户列表接口-随机数字参数39,testplan_interface_2036_用户列表接口-随机数字参数40', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置 ， 用户列表接口-设置接口返回值关联参数-通过正则表达式设置2 ， 用户列表接口-随机数字参数 ， 用户列表接口-随机数字参数2mod ， 用户列表接口-随机数字参数3mod ， 用户列表接口-随机数字参数4mod ， 用户列表接口-随机数字参数5 ， 用户列表接口-随机数字参数6 ， 用户列表接口-随机数字参数7 ， 用户列表接口-随机数字参数8 ， 用户列表接口-随机数字参数9 ， 用户列表接口-随机数字参数10 ， 用户列表接口-随机数字参数11 ， 用户列表接口-随机数字参数12 ， 用户列表接口-随机数字参数13 ， 用户列表接口-随机数字参数14 ， 用户列表接口-随机数字参数15 ， 用户列表接口-随机数字参数16 ， 用户列表接口-随机数字参数17 ， 用户列表接口-随机数字参数18 ， 用户列表接口-随机数字参数19 ， 用户列表接口-随机数字参数20 ， 用户列表接口-随机数字参数21 ， 用户列表接口-随机数字参数22 ， 用户列表接口-随机数字参数23 ， 用户列表接口-随机数字参数24 ， 用户列表接口-随机数字参数25 ， 用户列表接口-随机数字参数26 ， 用户列表接口-随机数字参数27 ， 用户列表接口-随机数字参数28 ， 用户列表接口-随机数字参数29 ， 用户列表接口-随机数字参数30 ， 用户列表接口-随机数字参数31 ， 用户列表接口-随机数字参数32 ， 用户列表接口-随机数字参数33 ， 用户列表接口-随机数字参数34 ， 用户列表接口-随机数字参数35 ， 用户列表接口-随机数字参数36 ， 用户列表接口-随机数字参数37 ， 用户列表接口-随机数字参数38 ， 用户列表接口-随机数字参数39 ， 用户列表接口-随机数字参数40', 'fin', '5', '53676', null, '42', '');

-- ----------------------------
-- Table structure for `autotestplat_testplan_interface`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan_interface`;
CREATE TABLE `autotestplat_testplan_interface` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_id` int(11) DEFAULT NULL,
  `suit_name` varchar(200) DEFAULT NULL,
  `interface_id` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2089 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_testplan_interface
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface` VALUES ('1907', '98', 'testplan', '1351', '用户列表接口-获取前面接口返回值参数的值', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{keyres}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1928', '114', '测试计划', '1383', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1930', '114', '测试计划', '1399', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1931', '114', '测试计划', '1400', '用户列表接口-随机数字参数2modify', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1932', '114', '测试计划', '1401', '用户列表接口-随机数字参数3', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1933', '114', '测试计划', '1402', '用户列表接口-随机数字参数4', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1934', '114', '测试计划', '1403', '用户列表接口-随机数字参数5', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin1', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1935', '114', '测试计划', '1399', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1936', '114', '测试计划', '1399', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1965', '128', 'plan', '1399', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1969', '129', '2.1版本测试任务计划', '1400', '用户列表接口-随机数字参数2mod', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1970', '129', '2.1版本测试任务计划', '1401', '用户列表接口-随机数字参数3mod', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1971', '129', '2.1版本测试任务计划', '1402', '用户列表接口-随机数字参数4', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1977', '128', 'plan', '1399', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1979', '130', '2.1testplan', '1383', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1980', '130', '2.1testplan', '1396', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置2', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1981', '130', '2.1testplan', '1399', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1982', '130', '2.1testplan', '1400', '用户列表接口-随机数字参数2modify', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1983', '130', '2.1testplan', '1401', '用户列表接口-随机数字参数3mod', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1984', '130', '2.1testplan', '1402', '用户列表接口-随机数字参数4modify', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1985', '130', '2.1testplan', '1403', '用户列表接口-随机数字参数5', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin1', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1986', '130', '2.1testplan', '1404', '用户列表接口-随机数字参数6', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1987', '130', '2.1testplan', '1405', '用户列表接口-随机数字参数7', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1988', '130', '2.1testplan', '1406', '用户列表接口-随机数字参数8', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1989', '130', '2.1testplan', '1407', '用户列表接口-随机数字参数9', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1990', '130', '2.1testplan', '1408', '用户列表接口-随机数字参数10', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1991', '130', '2.1testplan', '1409', '用户列表接口-随机数字参数11', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1992', '130', '2.1testplan', '1410', '用户列表接口-随机数字参数12', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1993', '130', '2.1testplan', '1411', '用户列表接口-随机数字参数13', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1994', '130', '2.1testplan', '1412', '用户列表接口-随机数字参数14', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1995', '131', '2.2版本测试计划', '1383', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1996', '131', '2.2版本测试计划', '1396', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置2', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1997', '131', '2.2版本测试计划', '1399', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1998', '131', '2.2版本测试计划', '1400', '用户列表接口-随机数字参数2modify', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('1999', '131', '2.2版本测试计划', '1401', '用户列表接口-随机数字参数3mod', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2000', '131', '2.2版本测试计划', '1402', '用户列表接口-随机数字参数4mod', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2001', '131', '2.2版本测试计划', '1403', '用户列表接口-随机数字参数5', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin1', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2002', '131', '2.2版本测试计划', '1404', '用户列表接口-随机数字参数6', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2003', '131', '2.2版本测试计划', '1405', '用户列表接口-随机数字参数7', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2004', '131', '2.2版本测试计划', '1406', '用户列表接口-随机数字参数8', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2005', '131', '2.2版本测试计划', '1407', '用户列表接口-随机数字参数9', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2006', '131', '2.2版本测试计划', '1408', '用户列表接口-随机数字参数10', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2007', '131', '2.2版本测试计划', '1409', '用户列表接口-随机数字参数11', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2008', '131', '2.2版本测试计划', '1410', '用户列表接口-随机数字参数12', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2009', '131', '2.2版本测试计划', '1411', '用户列表接口-随机数字参数13', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2010', '131', '2.2版本测试计划', '1412', '用户列表接口-随机数字参数14', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2011', '131', '2.2版本测试计划', '1414', '用户列表接口-随机数字参数15', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2012', '131', '2.2版本测试计划', '1415', '用户列表接口-随机数字参数16', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2013', '131', '2.2版本测试计划', '1416', '用户列表接口-随机数字参数17', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2014', '131', '2.2版本测试计划', '1417', '用户列表接口-随机数字参数18', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2015', '131', '2.2版本测试计划', '1418', '用户列表接口-随机数字参数19', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2016', '131', '2.2版本测试计划', '1419', '用户列表接口-随机数字参数20', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2017', '131', '2.2版本测试计划', '1420', '用户列表接口-随机数字参数21', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2018', '131', '2.2版本测试计划', '1421', '用户列表接口-随机数字参数22', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2019', '131', '2.2版本测试计划', '1422', '用户列表接口-随机数字参数23', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2020', '131', '2.2版本测试计划', '1423', '用户列表接口-随机数字参数24', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2021', '131', '2.2版本测试计划', '1424', '用户列表接口-随机数字参数25', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2022', '131', '2.2版本测试计划', '1425', '用户列表接口-随机数字参数26', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2023', '131', '2.2版本测试计划', '1426', '用户列表接口-随机数字参数27', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2024', '131', '2.2版本测试计划', '1427', '用户列表接口-随机数字参数28', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2025', '131', '2.2版本测试计划', '1428', '用户列表接口-随机数字参数29', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2026', '131', '2.2版本测试计划', '1429', '用户列表接口-随机数字参数30', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2027', '131', '2.2版本测试计划', '1430', '用户列表接口-随机数字参数31', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2028', '131', '2.2版本测试计划', '1431', '用户列表接口-随机数字参数32', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2029', '131', '2.2版本测试计划', '1432', '用户列表接口-随机数字参数33', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2030', '131', '2.2版本测试计划', '1433', '用户列表接口-随机数字参数34', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2031', '131', '2.2版本测试计划', '1434', '用户列表接口-随机数字参数35', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2032', '131', '2.2版本测试计划', '1435', '用户列表接口-随机数字参数36', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2033', '131', '2.2版本测试计划', '1436', '用户列表接口-随机数字参数37', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2034', '131', '2.2版本测试计划', '1437', '用户列表接口-随机数字参数38', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2035', '131', '2.2版本测试计划', '1438', '用户列表接口-随机数字参数39', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2036', '131', '2.2版本测试计划', '1439', '用户列表接口-随机数字参数40', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2086', '129', '2.1版本测试任务计划', '1399', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);
INSERT INTO `autotestplat_testplan_interface` VALUES ('2087', '128', 'plan', '1399', '用户列表接口-随机数字参数', '/autotest/user/getTableData/', '{\'Accept\': \'\', \'Content-Type\': \'application/json; charset=utf-8\', \'Cookie\': \'\'}', '{\"username\": \"{numRandom}\"}', 'JSON', 'post', null, '', null, '1', 'fin', null, null);

-- ----------------------------
-- Table structure for `autotestplat_testplan_interface_order`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan_interface_order`;
CREATE TABLE `autotestplat_testplan_interface_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_id` int(11) DEFAULT NULL,
  `interface_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35228 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of autotestplat_testplan_interface_order
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34699', '123', '1952');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34700', '124', '1953');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('34802', '98', '1907');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35015', '130', '1979');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35016', '130', '1980');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35017', '130', '1981');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35018', '130', '1982');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35019', '130', '1983');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35020', '130', '1984');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35021', '130', '1985');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35022', '130', '1986');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35023', '130', '1987');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35024', '130', '1988');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35025', '130', '1989');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35026', '130', '1990');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35027', '130', '1991');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35028', '130', '1992');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35029', '130', '1993');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35030', '130', '1994');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35037', '114', '1928');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35038', '114', '1930');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35039', '114', '1931');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35040', '114', '1932');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35041', '114', '1933');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35042', '114', '1934');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35043', '114', '1935');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35044', '114', '1936');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35178', '129', '1969');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35179', '129', '1970');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35180', '129', '1971');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35181', '129', '2086');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35182', '128', '1965');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35183', '128', '1977');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35184', '128', '2087');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35185', '131', '1995');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35186', '131', '1996');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35187', '131', '1997');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35188', '131', '1998');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35189', '131', '1999');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35190', '131', '2000');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35191', '131', '2001');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35192', '131', '2002');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35193', '131', '2003');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35194', '131', '2004');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35195', '131', '2005');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35196', '131', '2006');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35197', '131', '2007');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35198', '131', '2008');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35199', '131', '2009');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35200', '131', '2010');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35201', '131', '2011');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35202', '131', '2012');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35203', '131', '2013');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35204', '131', '2014');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35205', '131', '2015');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35206', '131', '2016');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35207', '131', '2017');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35208', '131', '2018');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35209', '131', '2019');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35210', '131', '2020');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35211', '131', '2021');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35212', '131', '2022');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35213', '131', '2023');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35214', '131', '2024');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35215', '131', '2025');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35216', '131', '2026');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35217', '131', '2027');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35218', '131', '2028');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35219', '131', '2029');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35220', '131', '2030');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35221', '131', '2031');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35222', '131', '2032');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35223', '131', '2033');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35224', '131', '2034');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35225', '131', '2035');
INSERT INTO `autotestplat_testplan_interface_order` VALUES ('35226', '131', '2036');

-- ----------------------------
-- Table structure for `autotestplat_testplan_interface_result`
-- ----------------------------
DROP TABLE IF EXISTS `autotestplat_testplan_interface_result`;
CREATE TABLE `autotestplat_testplan_interface_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` varchar(20) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `suit_id` int(11) DEFAULT NULL,
  `suit_name` varchar(100) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=29707 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of autotestplat_testplan_interface_result
-- ----------------------------
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27207', '20231111100519386943', '3', 'ChatGPT', '98', 'testplan', '1907', '用户列表接口-获取前面接口返回值参数的值', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'{keyres}\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-11T01:29:07.061Z\", 0, \"fin\", \"fin\", \"ChatGPT\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-08T12:59:16.638Z\", 1, \"root\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"\\u5c0f\\u8f89\", \"\", \"ChatGPT\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-11 10:05:19', '定时任务', '0.039178', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27343', '20231122102528329842', '5', 'Autotestplat', '114', '测试计划', '1928', '用户列表接口-设置接口返回值关联参数-通过正则表达式设置', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-22T00:17:51.883Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-22 10:25:28', '定时任务', '0.023909', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27344', '20231122102528329842', '5', 'Autotestplat', '114', '测试计划', '1930', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'91721812945\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-22T00:17:51.883Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-22 10:25:28', '定时任务', '0.021926', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27345', '20231122102528329842', '5', 'Autotestplat', '114', '测试计划', '1931', '用户列表接口-随机数字参数2', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'72700855163\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-22T00:17:51.883Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-22 10:25:28', '定时任务', '0.021929', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27346', '20231122102528329842', '5', 'Autotestplat', '114', '测试计划', '1932', '用户列表接口-随机数字参数3', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'13924471102\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-22T00:17:51.883Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-22 10:25:28', '定时任务', '0.025915', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27347', '20231122102528329842', '5', 'Autotestplat', '114', '测试计划', '1933', '用户列表接口-随机数字参数44', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'23847091966\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-22T00:17:51.883Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-22 10:25:28', '定时任务', '0.024916', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27348', '20231122102528329842', '5', 'Autotestplat', '114', '测试计划', '1934', '用户列表接口-随机数字参数55', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'4888157557\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-22T00:17:51.883Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-22 10:25:28', '定时任务', '0.019929', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27349', '20231122102528329842', '5', 'Autotestplat', '114', '测试计划', '1935', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'23814054771\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-22T00:17:51.883Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-22 10:25:28', '定时任务', '0.022923', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27350', '20231122102528329842', '5', 'Autotestplat', '114', '测试计划', '1936', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'53985725919\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-22T00:17:51.883Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"Autotestplat\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-22 10:25:28', '定时任务', '0.020928', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27432', '20231123193352033404', '5', 'Autotestplat', '128', 'plan', '1965', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'59421730785\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-23T09:15:09.655Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"ChatGPT\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-23 19:33:52', '定时任务', '0.024728', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('27433', '20231123193352033404', '5', 'Autotestplat', '128', 'plan', '1977', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'24834714070\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-23T09:15:09.655Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"ChatGPT\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-23 19:33:52', '定时任务', '0.020037', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('29618', '20231125195553181723', '5', 'Autotestplat', '129', '2.1版本测试任务计划', '1969', '用户列表接口-随机数字参数2mod', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'87768927459\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-25T01:59:52.682Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"ChatGPT\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-25 19:55:53', '定时任务', '0.015067', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('29619', '20231125195553181723', '5', 'Autotestplat', '129', '2.1版本测试任务计划', '1970', '用户列表接口-随机数字参数3mod', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'83835445383\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-25T01:59:52.682Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"ChatGPT\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-25 19:55:53', '定时任务', '0.029226', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('29620', '20231125195553181723', '5', 'Autotestplat', '129', '2.1版本测试任务计划', '1971', '用户列表接口-随机数字参数4', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'63749485843\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-25T01:59:52.682Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"ChatGPT\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-25 19:55:53', '定时任务', '0.021776', '100%');
INSERT INTO `autotestplat_testplan_interface_result` VALUES ('29621', '20231125195553181723', '5', 'Autotestplat', '129', '2.1版本测试任务计划', '2086', '用户列表接口-随机数字参数', 'http://127.0.0.1/autotest/user/getTableData/', '{\'username\': \'44001142311\'}', 'post', 'fin', '{\"data\": [[2, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-25T01:59:52.682Z\", 0, \"fin\", \"fin\", \"Autotestplat\", \"13711112222\", 1, 1, \"2023-10-04T03:24:35Z\"], [4, \"pbkdf2_sha256$120000$Bo7j96h6jq13$slzU7IA+X92nVN2HS3eCfDR72PFeQMOFO2etdUEtLGI=\", \"2023-11-10T03:06:26.754Z\", 0, \"test\", \"\", \"ChatGPT\", \"13800001111\", 1, 1, \"2023-10-13T06:23:00Z\"], [7, \"pbkdf2_sha256$120000$5gxslwxrcPYl$Dnk4wwqVsLXN0Hgcbc+W+EqECZB+THuwRcxoSfs9bzU=\", \"2023-11-11T23:38:23.910Z\", 1, \"root\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"], [8, \"pbkdf2_sha256$120000$hWrOMJTGZ9XP$7zz48zsB2k66Dehhxgna5lQiCVw9PHs7Kvb2wbgClvU=\", \"2023-11-06T13:21:22.269Z\", 1, \"auto\", \"\", \"Autotestplat\", \"13822223333\", 1, 1, \"2023-11-06T00:00:00Z\"]]}', '0', '2023-11-25 19:55:53', '定时任务', '0.022819', '100%');

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
INSERT INTO `django_session` VALUES ('1lz8oq7vrd8bq46nlj0odg1mxevte92b', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 03:05:49.641984');
INSERT INTO `django_session` VALUES ('1ujh928i6i9ftiq0bfboa00m17pbebhh', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 11:21:23.811095');
INSERT INTO `django_session` VALUES ('21cne174fm7w2al4o1xqta6xjy42ziq3', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 02:32:44.662563');
INSERT INTO `django_session` VALUES ('2447ddf69onez5e50ebt11m6yzb7w623', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 09:39:46.692754');
INSERT INTO `django_session` VALUES ('24uk1caguplgq4x8uddleudg9hdn0uum', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 02:26:44.895537');
INSERT INTO `django_session` VALUES ('2a23igledls9l6qp7g6dpaghyk89wpvo', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:04:18.467811');
INSERT INTO `django_session` VALUES ('2g12tgs53yggwmrke49anj43e8egvnsd', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 09:57:34.954172');
INSERT INTO `django_session` VALUES ('2hdb1oy017s0gc1i0jaf87zmbj8gnpdc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 14:46:52.305122');
INSERT INTO `django_session` VALUES ('2tneomgyxp3i8fll8hq7p1do0ta4rr83', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-30 09:46:59.696832');
INSERT INTO `django_session` VALUES ('2vx2t7zstbmlk1mp4a5fm62ile3dde2d', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 13:58:43.197205');
INSERT INTO `django_session` VALUES ('2y900mpowg8cmoh766rr5fbpkte87ik6', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:40:56.555595');
INSERT INTO `django_session` VALUES ('30q83wmn64so6nan41szlpir19w8ipqs', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-07 13:31:32.885368');
INSERT INTO `django_session` VALUES ('31fc90afdlcr2il2nt6jvikm3ey52sew', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 01:45:23.358884');
INSERT INTO `django_session` VALUES ('3bowdso7x5axna4qvr9djfsk5tyuyr83', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-29 02:26:50.897898');
INSERT INTO `django_session` VALUES ('3i25rmigkbegwdlr7hfqw3t7tu5kzl55', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 07:49:45.841243');
INSERT INTO `django_session` VALUES ('3svzaaxu8gdfubcndopks0lyoux3r8vs', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:07:01.543122');
INSERT INTO `django_session` VALUES ('3u0ere3gm9er58iiq7lawcbjh15wqbc5', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 01:18:57.998420');
INSERT INTO `django_session` VALUES ('3w88sugqc54zv8z9uk27wv5hh7n349fy', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-11 09:47:31.896953');
INSERT INTO `django_session` VALUES ('42q1zxpqbsl1622a0y7965tufohg066t', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 10:51:14.468600');
INSERT INTO `django_session` VALUES ('4jbopii2n7pzm1zmzkfbfw7146d07ezs', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:33:16.451046');
INSERT INTO `django_session` VALUES ('5145zdgn095daoftcifjbine3tcgarzf', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:14:20.746836');
INSERT INTO `django_session` VALUES ('54tzdcw1bmw13qas9zkow0rktlau507x', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:04:09.721257');
INSERT INTO `django_session` VALUES ('59h1cjg25a2m5y5zugc0o06hhkhuvlmc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 12:31:41.104749');
INSERT INTO `django_session` VALUES ('5p2kwaa7bpl1il6kenz3hx9xagcwiw1w', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:32:13.602598');
INSERT INTO `django_session` VALUES ('60vw8xz2uphgycd5pnj14uf22bolpzon', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 02:59:11.160421');
INSERT INTO `django_session` VALUES ('65psfl0qbqfe3p0ojy0zj2rx7lukn1bt', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:21:02.417420');
INSERT INTO `django_session` VALUES ('6b97c3jrg2b0sxup9xld5vhg5dw0d8wp', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:47:16.496954');
INSERT INTO `django_session` VALUES ('6hvy26hgctfpm8nbtpshrl3egudy91kv', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-07 14:24:22.888106');
INSERT INTO `django_session` VALUES ('6oko7ah2of2y4m81og5zkrbpj0t56y3f', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-06 00:16:53.904460');
INSERT INTO `django_session` VALUES ('6sgvhkzrknyphgoy0ibdjvc0pvpuby38', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:43:53.878781');
INSERT INTO `django_session` VALUES ('732u0uouwpik35oqvv5c6orblth5ibex', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:49:38.845616');
INSERT INTO `django_session` VALUES ('78gtfkc3jhd9qsyot2sp5ruj2s5ibqfv', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:23:05.666163');
INSERT INTO `django_session` VALUES ('7b4bznyemwhbh85hzhoyut7slp7q78y0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:46:07.809398');
INSERT INTO `django_session` VALUES ('7ew0oei80869rp3lupjjmy8iy2hsskj1', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 03:08:53.888361');
INSERT INTO `django_session` VALUES ('7hz2y7v33deej83bbjiarfry8ylj01jt', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:15:26.111214');
INSERT INTO `django_session` VALUES ('7p40m0ria58431cqkq36wdhvxmifokes', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 11:47:28.314277');
INSERT INTO `django_session` VALUES ('7rlf5kc9tc1m3fkghvuy7dkc1309ymuj', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 09:03:20.125893');
INSERT INTO `django_session` VALUES ('87fxow9j798zswcor0cja8wi66t3j71i', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-29 08:42:05.721794');
INSERT INTO `django_session` VALUES ('8lmd4ymwahr15pgshtmktm2sm5lkuelr', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-05 15:32:13.068017');
INSERT INTO `django_session` VALUES ('8m3sf8lg0p3jux7t19q8tlztztyzfmrr', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:12:12.577915');
INSERT INTO `django_session` VALUES ('8rv0r5paqyg9r2x2wjj041umyn5am7le', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:17:57.474738');
INSERT INTO `django_session` VALUES ('8xbumsy5x0wn6oklk1r5glapi5hglyw6', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-07 14:17:34.025380');
INSERT INTO `django_session` VALUES ('8xefirnvg396q09nxhsm672md1vj6vem', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 12:06:53.672343');
INSERT INTO `django_session` VALUES ('90xe6k7u7m61ufhtx3qnifa0hckg30aw', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 15:05:21.610426');
INSERT INTO `django_session` VALUES ('997yr7nppqqx2q6atkjsam0g2o7vwavz', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:52:36.606572');
INSERT INTO `django_session` VALUES ('9e014ofqlv5b0tnr00a96cfsk7f10cmm', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-06 10:15:31.352359');
INSERT INTO `django_session` VALUES ('9fbbd2g8x2tjo62pt9sch7w0cpibsyol', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 10:36:39.182694');
INSERT INTO `django_session` VALUES ('9g8c4xojmpuylnxu9f63dwm5ghhxchi4', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-04 14:54:59.111930');
INSERT INTO `django_session` VALUES ('9ovjgmokgl4gasengkih37zwyfczth51', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 07:32:31.359009');
INSERT INTO `django_session` VALUES ('9v2l9j75cs2shsdh6zjuxqbe7rstcgkc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:21:43.856271');
INSERT INTO `django_session` VALUES ('aao0xzz8r6mvwzu8ia0fd6lhe4w9didc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 09:04:15.040746');
INSERT INTO `django_session` VALUES ('agcmegxiy48trgqnnbxjyudxjeaq3gi4', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:11:55.523518');
INSERT INTO `django_session` VALUES ('amgmf42bez0ohp4d8m3z2z95q6t5y95f', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-11 09:28:16.896451');
INSERT INTO `django_session` VALUES ('ar7ganjwrcdhvdejn4py5e21em0vi0gf', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-05 15:23:27.511082');
INSERT INTO `django_session` VALUES ('ay12c7i2h286eogi3m581fkk2o68dqar', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 09:05:05.200941');
INSERT INTO `django_session` VALUES ('baw0s320kktp0owq1s0difvqvjl5ovhk', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 13:48:33.054681');
INSERT INTO `django_session` VALUES ('bcg92r1zfilh5gvas4xt9vz32dfmo7mr', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 09:35:27.091812');
INSERT INTO `django_session` VALUES ('br56y12eoovwvksic2nrk9qucp07shmj', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 10:27:57.031454');
INSERT INTO `django_session` VALUES ('brn5rlyegf4s113jfg89x4cwk2e6cecy', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-09 01:42:49.591835');
INSERT INTO `django_session` VALUES ('c5sjyts9bzg90ieioczt1h1nkvtov770', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 10:42:15.373302');
INSERT INTO `django_session` VALUES ('c8f14lynvov35xm2m4oieiz2rtee95bu', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:50:41.211354');
INSERT INTO `django_session` VALUES ('cnp1y609uzo9ykditxjza4qww0y8mc5m', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:37:00.695829');
INSERT INTO `django_session` VALUES ('cvpsgbprmgw9in7nqv9ged6mznub2nmn', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 15:13:17.905960');
INSERT INTO `django_session` VALUES ('cxdqojtfwi8zupmp3nxeis7nnqzxehf8', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-07 13:32:10.324924');
INSERT INTO `django_session` VALUES ('dadkf0e7jprpcom5mlrpkqk1mm0h5xhf', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:34:39.346393');
INSERT INTO `django_session` VALUES ('dbaw8n45v29spaqu38eyibwt9bwsekeh', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:48:27.715970');
INSERT INTO `django_session` VALUES ('ddv5naf6c61mrv4iml96wab247bntxa7', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 10:32:45.700119');
INSERT INTO `django_session` VALUES ('de50jur80bjzcrditfrg2qmv20drgtcb', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 11:11:53.734060');
INSERT INTO `django_session` VALUES ('dkfrkspfasi1t283rlj4bujfkyceygwy', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:03:53.364399');
INSERT INTO `django_session` VALUES ('dnvdj25tfase4t5olmpraiig3mwbca2r', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:07:30.967084');
INSERT INTO `django_session` VALUES ('dpgxdcv1ihv06djiurpl94acpethl1ur', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 11:46:47.100937');
INSERT INTO `django_session` VALUES ('dqz4fu5jfui1bw5766zqs2ih5flozxw5', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:26:45.363761');
INSERT INTO `django_session` VALUES ('e3gckknymgyirzf1w9etwxa8l5sa5vq0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 03:05:42.862716');
INSERT INTO `django_session` VALUES ('e7ti2oa3zg38cpynsnabpu9hh063mz99', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-11 09:21:45.469790');
INSERT INTO `django_session` VALUES ('eaad3xt3jfx6dn2x1wir9vm4d3dva25i', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-23 09:24:43.098189');
INSERT INTO `django_session` VALUES ('eb7xptg3224y72aw3voim7qasvfx7dgl', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:41:12.805112');
INSERT INTO `django_session` VALUES ('eg58s0z01e7ztzyvctlw4jhaf8gd5zdh', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-07 14:06:13.662929');
INSERT INTO `django_session` VALUES ('er9fn3jhmkxyldu4fr78r0jd5btk6vz1', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 13:05:59.754946');
INSERT INTO `django_session` VALUES ('euitceotqccoxki9wh8p0ajfokf7dyuz', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 07:58:27.365275');
INSERT INTO `django_session` VALUES ('eynnp5ore8acyq4y0282lb8yr1c761n7', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:07:28.361718');
INSERT INTO `django_session` VALUES ('ezcg7s33mwpelq4xttcliy1avwxp31qk', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:01:24.517152');
INSERT INTO `django_session` VALUES ('fgi2m2zpe90i1h5d9brap45qipchxeo4', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-05 15:17:41.853187');
INSERT INTO `django_session` VALUES ('fn8ji883gaxu050uao42bxn31oe3ycjg', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 10:29:28.441223');
INSERT INTO `django_session` VALUES ('fz51uonmkvswdo99fr0zwru38ermr8ot', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 04:31:02.585282');
INSERT INTO `django_session` VALUES ('g34qcss7eq1m4gdkas8k39ckio4kyk49', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-07 13:59:40.356767');
INSERT INTO `django_session` VALUES ('g8i4iur2bxiy6q0d7wlst2l1y39llix3', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:45:00.377517');
INSERT INTO `django_session` VALUES ('g9rgheg4uu5wm038htvardvem8kjk89f', 'MTE5NjA4YTk2MjM3YzE1OTRlNmUzZjQxYjY0YTQ0MjkxZmUyY2JiNTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYmNhNWJjYTM1YWQ1ZGJkZWEzZWVmZTg3ZGY1MTRkMTBiMTY2M2UyIiwidXNlciI6ImZpbiJ9', '2023-11-20 13:33:04.585820');
INSERT INTO `django_session` VALUES ('gghqhyacv136xkezvv1y56fk8lp56jjj', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:27:30.322790');
INSERT INTO `django_session` VALUES ('glq3h9truxm83qqb1j4zpjowzridnsvp', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 05:47:12.876181');
INSERT INTO `django_session` VALUES ('gm3i6kpii63ivwcnwk3ff3ar6evl4g6p', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:37:15.756084');
INSERT INTO `django_session` VALUES ('gn0aqp96seks5g8o6esv5y1hha5ozuir', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-07 09:15:09.655172');
INSERT INTO `django_session` VALUES ('guxvpsuk4pax6ye7795etqtjhy3hixhg', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 01:53:03.345593');
INSERT INTO `django_session` VALUES ('h88w3qryzcyhgwkrncvuy6zl2kp1r0dy', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-07 13:51:43.979204');
INSERT INTO `django_session` VALUES ('ha4su71gee3j8tlz66stwylpkf4vqh8z', 'ZmJiOGU0MmVjNmIwNmIzN2RhNTUwNjYxMjM0YjViNDRjMjM1ODI3OTp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMTg4OTQ2ZWZhYWM5YmNhYjVhZmRjOWNhYjNkNzdkMGQ1NWNiN2VhIiwidXNlciI6InJvb3QifQ==', '2023-11-20 13:03:28.373926');
INSERT INTO `django_session` VALUES ('hfgo1w79upi003l0j0m14mr7r63ky5lp', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-10 12:31:12.516292');
INSERT INTO `django_session` VALUES ('hne9fu3mwmtnwxx4w74vumu29cggz8q3', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:20:20.158741');
INSERT INTO `django_session` VALUES ('hq9b5id70ell7qc03wbz4r6wlu0bqc7z', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-13 22:40:01.417911');
INSERT INTO `django_session` VALUES ('hu7u7n4c4102hyoiam4bbudxqy9db6lb', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:00:02.198860');
INSERT INTO `django_session` VALUES ('hwz0q7s8yp35q7gmvcalz4uxa5ef1csk', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 02:06:02.343121');
INSERT INTO `django_session` VALUES ('i88zdylicds9st1oszg96zk44dw0in2l', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 02:47:57.254469');
INSERT INTO `django_session` VALUES ('iaa2q8f55l5df8h2e50a1imq8h6qmm5k', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-06 07:53:31.134171');
INSERT INTO `django_session` VALUES ('ihfhudtdkbkwa992sy87oc7f0rylv8f5', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 03:07:27.729313');
INSERT INTO `django_session` VALUES ('iipg5uw5ccv6lyngaz7ca327kr15kwj7', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-11 09:49:45.222206');
INSERT INTO `django_session` VALUES ('ik6f0mtydz5vva8ncnd9g8vo7tede9se', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-11 10:01:33.924332');
INSERT INTO `django_session` VALUES ('io8lfkkedq4olwukp4bekgh6f2vms3vp', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 11:03:28.122547');
INSERT INTO `django_session` VALUES ('j3vtrhz1z3wpng2a7vuna7gdarfydgye', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-04 09:58:46.094666');
INSERT INTO `django_session` VALUES ('j55n55v0eisbsdlsi5m6l3j9be0c8sm0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 03:04:03.008776');
INSERT INTO `django_session` VALUES ('kabfl4dwteqcq0bo64v0zeyfvmy7qksl', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-27 01:54:41.319462');
INSERT INTO `django_session` VALUES ('kfpflp1f86h9elcmt8h3zibze7jt7kmj', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 10:36:55.449805');
INSERT INTO `django_session` VALUES ('kiuu0kga88smlwrkj60yzhitju82fck6', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 12:19:49.719807');
INSERT INTO `django_session` VALUES ('kvvptfu8i6lza506vm409m0b55nyoeni', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 11:30:26.659470');
INSERT INTO `django_session` VALUES ('l9ngtbg9f0g3xqtfxdztvzui68jx8wz5', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-06 00:08:54.116549');
INSERT INTO `django_session` VALUES ('ljivrv7cbx90y41b46ghmh14zg1nsqeq', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 09:51:19.968564');
INSERT INTO `django_session` VALUES ('loy3k4jhgd1ozgvrekfj9bpe0id33cc9', 'YmY5YzgzOTc1ZDFmYmRhMWQ4YzM5MTA3MmIwMDE0MzhkZTA5ZjY5Yzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6InRlc3QifQ==', '2023-11-24 02:53:51.321625');
INSERT INTO `django_session` VALUES ('lqc2elz0y0kql1584knn8wc8hpygc09i', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 03:04:31.975986');
INSERT INTO `django_session` VALUES ('lwpxuvr7x61pum68h6p4y5os902x6jcy', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-11 09:59:05.983872');
INSERT INTO `django_session` VALUES ('lzene1p557zs6vqnxc4o9vyj44zygu9k', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-11-14 03:30:28.089381');
INSERT INTO `django_session` VALUES ('mavsgpyc7f933mejxx1u5xnhrgrxxyk2', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 01:25:01.947697');
INSERT INTO `django_session` VALUES ('mhld50wcykhxqxrdmy7d1vy3knzxv23t', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:54:50.919466');
INSERT INTO `django_session` VALUES ('mjszd7ffzdw6lq1yc3w358skn0hhx35j', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 11:37:19.300676');
INSERT INTO `django_session` VALUES ('ms7weifjv3dqi4wshfkdz3pg2dcgwkus', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:13:42.140610');
INSERT INTO `django_session` VALUES ('n7lal90qpbl4k6cjjazzpe5vzrh4emj2', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-11-05 13:20:16.066226');
INSERT INTO `django_session` VALUES ('n8r5tam6skf9pfibxxhs8sii5nz3plky', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:35:54.370813');
INSERT INTO `django_session` VALUES ('n9aa6h2zd8z8m2hmhenkdj2rofl8l3wn', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 12:18:50.896242');
INSERT INTO `django_session` VALUES ('nepv0ytdmnxomhrauibgfatpxhk3ldry', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-25 13:38:45.925664');
INSERT INTO `django_session` VALUES ('nksxi3uw3x5sl14ybdos375105masevm', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 09:56:41.311435');
INSERT INTO `django_session` VALUES ('nmbsdhiccf5utzdh7engdyjzgul90z3h', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 09:28:44.930820');
INSERT INTO `django_session` VALUES ('nogkgy9inu8g05v6748wdn20qfq56iqf', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:45:39.956131');
INSERT INTO `django_session` VALUES ('nsm8tsqbvcjr69235v0chymwigqjmz5i', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:58:06.989895');
INSERT INTO `django_session` VALUES ('ntx82n8vp9xuj4l4tajf79803vtmm8u5', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-05 15:35:54.622844');
INSERT INTO `django_session` VALUES ('nwz7e2onvr9pquvehjdsqbsckd5yk18h', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 12:36:48.006247');
INSERT INTO `django_session` VALUES ('nygqsoygastlpot53adyqxw297q4v0dc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 06:47:57.342265');
INSERT INTO `django_session` VALUES ('o0k6r0k11fjurjfcg5f4op4zwjp11usz', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 01:37:54.014557');
INSERT INTO `django_session` VALUES ('o2k8nn3g58xaqfqxybeyhogq68efzoeu', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 11:19:53.045902');
INSERT INTO `django_session` VALUES ('ob0ghrlm4gsuq86ki5i3twmgvtfk68zp', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 09:00:30.704675');
INSERT INTO `django_session` VALUES ('omxzyr8wk4fh9hv7aka2pc9esd3kxqvt', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 15:06:11.146498');
INSERT INTO `django_session` VALUES ('or68aigdxf16dvajgbl1tqgvom98d3e3', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-06 00:17:51.893205');
INSERT INTO `django_session` VALUES ('os79cszkwyrgp7k209ddx8zfaqpkgwzc', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 03:15:52.132178');
INSERT INTO `django_session` VALUES ('oxma10vcmah1v3vbqlvs8p92nzlmuwqi', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-04 00:50:05.596819');
INSERT INTO `django_session` VALUES ('p9oi4usj5krpcgobccukyc6vct4nxuz4', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-11 10:08:41.298672');
INSERT INTO `django_session` VALUES ('pclp6ilj7cl9mxegbzh5j9b6g16h1p63', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-29 02:31:48.369440');
INSERT INTO `django_session` VALUES ('pgk9tzst2epuider6txpleyhyu5b0ddr', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-07 14:28:47.303337');
INSERT INTO `django_session` VALUES ('piom4rymni8ibqueiksucfpo14kk26vb', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 09:40:28.380257');
INSERT INTO `django_session` VALUES ('pnhsnhmt6jsukmhp8x2r6xuuevcxbfoz', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-30 09:46:59.774129');
INSERT INTO `django_session` VALUES ('pnv62ssrf2ftldog595bivekt1we5h7q', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:53:24.859076');
INSERT INTO `django_session` VALUES ('ptdy3unq1gc6y07mesagfolvoybp62cq', 'ZWQ3OTA0OTlmOTc2M2FhNzdmOTdhNDY1OTkwOTA0ZGIyMTI0YjdkODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWZiOTBmNGE4ODJmZWE0MzFkMjc1MWEzMmIxNjcyOTk1M2ViYmNjIn0=', '2023-10-25 13:13:05.359717');
INSERT INTO `django_session` VALUES ('q378se30ourx4ms04i7tlnoorwo9u31o', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 09:52:00.460405');
INSERT INTO `django_session` VALUES ('qiktp91h2xkkxgl0198fzhzx69qlcere', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 10:36:01.883279');
INSERT INTO `django_session` VALUES ('qzfhx39bb9v64j2zncj6n5udwuvo7ul5', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-05 15:37:49.249633');
INSERT INTO `django_session` VALUES ('r2lpfqwticl09iwwy0u5gfijfgljmlbg', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 07:03:25.664463');
INSERT INTO `django_session` VALUES ('r6pz9izjlen67wboswbekryea7er03zi', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:09:16.408858');
INSERT INTO `django_session` VALUES ('rif5eoz5fkeahm30qlc238mffe89shij', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 09:11:13.508101');
INSERT INTO `django_session` VALUES ('rkwn6i4sbkalbyztxl36krafb2cp4mrn', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-06 00:14:03.766354');
INSERT INTO `django_session` VALUES ('rn52sj0k1byevrogwj9q3k3j0ygs5c56', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:21:23.455739');
INSERT INTO `django_session` VALUES ('rtiv4nc8qna7r6naxy0hlmxshpbv840c', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-05 15:10:22.325156');
INSERT INTO `django_session` VALUES ('rtl2mk68ucd6kzybp9ycem6nsxihg13y', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 07:05:45.174065');
INSERT INTO `django_session` VALUES ('s190smx0wtfmv23s0sf80ke04um8kh30', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 05:30:53.846066');
INSERT INTO `django_session` VALUES ('s1mup1mrcznc8qe3b9xr8agud6n0rn1q', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:04:38.149226');
INSERT INTO `django_session` VALUES ('s98ezk9gifrfxknng1wrnj9i994u2iif', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:06:30.996665');
INSERT INTO `django_session` VALUES ('ser5p78ychix25anl4t4tnichzeojekj', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 01:45:30.198617');
INSERT INTO `django_session` VALUES ('shvp3d8xdrwh0a1c6kuoyfp00w7ebzn0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-06 00:15:04.445026');
INSERT INTO `django_session` VALUES ('sjlcejp4ne70wwy3dizavpoxhcnfb7sq', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:24:11.488855');
INSERT INTO `django_session` VALUES ('spfbw866cm8p4hcr0zhryu0o70u6fri9', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 04:29:10.461809');
INSERT INTO `django_session` VALUES ('sqm77vpt48b3lxxck9qnka78fxmvfx63', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 10:33:35.039194');
INSERT INTO `django_session` VALUES ('t0z62m2lbk9sin8nnimlyzx4ewbcpmw0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:28:52.017867');
INSERT INTO `django_session` VALUES ('t1vpde95rq5wqofv7cezrgmxjol6kd09', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 00:36:27.069916');
INSERT INTO `django_session` VALUES ('t3sk6ed58stlojqyakc5u6pm5449riwf', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 11:04:26.046069');
INSERT INTO `django_session` VALUES ('t76ik4dmqzmuygz3qhlqm74qns01z503', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-11 09:26:07.042635');
INSERT INTO `django_session` VALUES ('tahtqhexmqzthywkfw13hacj3rbvte4e', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:02:51.917551');
INSERT INTO `django_session` VALUES ('tdrh53to19oppfk0bj8tm5fszfrv7llu', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 23:55:09.375945');
INSERT INTO `django_session` VALUES ('tet68yw2mezgwbri0x961nywbwuf88ab', 'MmFkZjdkODFmNGRiZTdhM2Y4YTE1ZWYxOWZiN2ZlMGIyZDhmOGI0YTp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNDUwNWE4NTQ2MjZmOGRmNTllMmY2OGEyY2VhMDg1MjdlZDBhNjljIiwidXNlciI6InRlc3QifQ==', '2023-11-20 10:56:45.297749');
INSERT INTO `django_session` VALUES ('tvx5d8saxwc1fakulahbfvmr8zb3otsj', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-01 14:26:43.696947');
INSERT INTO `django_session` VALUES ('tydqlrpp0ifvitea0gc1dqvrp34kitxs', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-03 04:27:55.167238');
INSERT INTO `django_session` VALUES ('u6cowcg0g14sy3siiejmy8fygd121l70', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-11 09:17:12.637719');
INSERT INTO `django_session` VALUES ('u8v5r1wt63lksmesjbza6bjkzjoish6i', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-23 01:11:45.079881');
INSERT INTO `django_session` VALUES ('v83sf4kk66bg0azi1slz2iamjc3e2zop', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 14:15:23.020794');
INSERT INTO `django_session` VALUES ('v9sh5uynfbrxoqo36nvd9n7f77p8ajp4', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-11 10:14:59.279728');
INSERT INTO `django_session` VALUES ('vdwqi89hx40llxmxz9l6z9f9kimqgkf9', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-21 08:08:31.441302');
INSERT INTO `django_session` VALUES ('vp6mxnryw1ey16acyco66kb9zimbkir9', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 07:19:36.336412');
INSERT INTO `django_session` VALUES ('vwobidmcezll9lygfr3kqb3dh8o22qjz', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 10:23:34.427404');
INSERT INTO `django_session` VALUES ('w0j12sqwscgaa1pr6wbmkxz6vmtaolff', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-22 08:55:33.356059');
INSERT INTO `django_session` VALUES ('w39lr58tqftreriepxxskhfpfez8bjru', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 01:51:24.464512');
INSERT INTO `django_session` VALUES ('w5ypux7o4plbvyk9vhz3qvqijgz58sp0', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 10:35:22.876031');
INSERT INTO `django_session` VALUES ('w8m3vioz9sczo14impvijac2b6p3kh6y', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-25 02:08:41.075775');
INSERT INTO `django_session` VALUES ('wftsbx713hl8dn911fdaqp4w5p4rwd1m', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-02 11:28:01.865154');
INSERT INTO `django_session` VALUES ('wheso2gu5qm5hlbpof94kn21659xmoec', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-07 14:16:23.291166');
INSERT INTO `django_session` VALUES ('wio5750vzlkg4kqlv8zpdgp2u565r64r', 'ZmJiOGU0MmVjNmIwNmIzN2RhNTUwNjYxMjM0YjViNDRjMjM1ODI3OTp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMTg4OTQ2ZWZhYWM5YmNhYjVhZmRjOWNhYjNkNzdkMGQ1NWNiN2VhIiwidXNlciI6InJvb3QifQ==', '2023-11-20 12:53:02.683758');
INSERT INTO `django_session` VALUES ('wmkixkjyww1ccv6dm7ec2kwhoy4tzw4n', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-24 09:54:01.634485');
INSERT INTO `django_session` VALUES ('wqxa0oz8r4d32067xjur7z03gebcco13', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-29 02:11:01.968316');
INSERT INTO `django_session` VALUES ('wth9d5ubipptiqilwg5d4e9i0n83jfbr', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-28 08:10:25.300372');
INSERT INTO `django_session` VALUES ('wuzkwxbkyq9iter1akcyy8tb9k4eo9e3', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-11-26 02:10:09.222347');
INSERT INTO `django_session` VALUES ('xd7vhquwek1hvyaye1qsk921db1fwbet', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-11 09:38:01.631338');
INSERT INTO `django_session` VALUES ('xjr3vehwzzfs79ubm8ooyawx2fjaigzx', 'ODU3OGJmOTQ2ZWE3YjZmZDVlNzBlNTI2MjhiN2ZlODA1NDQ3MzgzODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YWU3ZjJiMDI0Y2MyMThiYjNhYzE3MTZjMTA4YmMxN2M3NzU1NTY2IiwidXNlciI6ImZpbiJ9', '2023-12-08 00:33:25.067214');
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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

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
INSERT INTO `djcelery_crontabschedule` VALUES ('93', '56', '16', '*', '20', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('94', '45', '11', '*', '21', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('95', '25', '13', '*', '22', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('96', '25', '22', '*', '23', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('97', '02', '11', '*', '24', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('98', '00', '00', '*', '24', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('99', '04', '15', '*', '25', '11');
INSERT INTO `djcelery_crontabschedule` VALUES ('100', '13', '10', '*', '30', '11');

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
) ENGINE=InnoDB AUTO_INCREMENT=53680 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_periodictask
-- ----------------------------
INSERT INTO `djcelery_periodictask` VALUES ('53624', 'celery.backend_cleanup', 'celery.backend_cleanup', '[]', '{}', null, null, null, null, '1', null, '0', '2023-11-23 03:41:48', '', '4', null);
INSERT INTO `djcelery_periodictask` VALUES ('53644', '98', 'autotest.views_interfacetestplan.api_autotest_task', '[]', '{}', null, null, null, null, '1', null, '0', '2023-11-11 23:44:35', 'fin', '66', null);
INSERT INTO `djcelery_periodictask` VALUES ('53657', '114', 'autotest.views_interfacetestplan.api_autotest_task', '[114]', '{}', null, null, null, null, '1', null, '0', '2023-11-19 06:43:33', 'fin', '84', null);
INSERT INTO `djcelery_periodictask` VALUES ('53673', '128', 'autotest.views_interfacetestplan.api_autotest_task', '[128]', '{}', null, null, null, null, '1', null, '0', '2023-11-21 03:45:50', 'fin', '94', null);
INSERT INTO `djcelery_periodictask` VALUES ('53674', '129', 'autotest.views_interfacetestplan.api_autotest_task', '[129]', '{}', null, null, null, null, '1', null, '0', '2023-11-22 05:35:07', 'fin', '95', null);
INSERT INTO `djcelery_periodictask` VALUES ('53675', '130', 'autotest.views_interfacetestplan.api_autotest_task', '[130]', '{}', null, null, null, null, '1', null, '0', '2023-11-23 14:25:59', 'fin', '96', null);
INSERT INTO `djcelery_periodictask` VALUES ('53676', '131', 'autotest.views_interfacetestplan.api_autotest_task', '[131]', '{}', null, null, null, null, '1', null, '0', '2023-11-24 03:02:43', 'fin', '97', null);

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
INSERT INTO `djcelery_periodictasks` VALUES ('1', '2023-11-30 02:14:19');

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
