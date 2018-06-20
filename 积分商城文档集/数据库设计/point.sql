/*
Navicat MySQL Data Transfer

Source Server         : 192.168.1.105
Source Server Version : 50718
Source Host           : 192.168.1.105:3306
Source Database       : ysy_point

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-06-20 17:08:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pt_address
-- ----------------------------
DROP TABLE IF EXISTS `pt_address`;
CREATE TABLE `pt_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '地址Id',
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员id,从app端接口获取到的Id',
  `receiver_name` varchar(255) DEFAULT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(255) DEFAULT NULL COMMENT '收货人电话',
  `province` varchar(255) DEFAULT NULL COMMENT '省份名',
  `city` varchar(255) DEFAULT NULL COMMENT '市区名',
  `region` varchar(255) DEFAULT NULL COMMENT '区名',
  `detail_address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `is_default` int(11) DEFAULT '0' COMMENT '是否是默认地址  0不是，1是',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否已删除（0:未删除;1:已删除;）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='收货地址表';

-- ----------------------------
-- Table structure for pt_banner
-- ----------------------------
DROP TABLE IF EXISTS `pt_banner`;
CREATE TABLE `pt_banner` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL COMMENT '跳转地址',
  `name` varchar(255) DEFAULT NULL COMMENT 'banner名',
  `image_url` varchar(255) DEFAULT NULL COMMENT 'banner图片存储地址',
  `type` bigint(11) DEFAULT NULL COMMENT 'banner类型(参照字典表中内容类型)',
  `content` varchar(255) DEFAULT NULL COMMENT 'banner内容',
  `state` int(11) DEFAULT '1' COMMENT '是否启用(0:不启用;1启用)',
  `create_id` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `update_id` bigint(20) DEFAULT NULL COMMENT '修改人',
  `update_time` bigint(20) DEFAULT NULL COMMENT '修改时间',
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_cart
-- ----------------------------
DROP TABLE IF EXISTS `pt_cart`;
CREATE TABLE `pt_cart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '购物车Id',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品Id,对应kn_goods的goods_id',
  `goods_num` int(11) DEFAULT '1' COMMENT '商品数量',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商家（经销商）Id,kn_user表的Id，冗余字段',
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员id,从app端接口获取到的Id',
  `mall_id` bigint(20) DEFAULT NULL COMMENT '商城id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_pot_cart_goods_id.member_id.mall_id` (`goods_id`,`member_id`,`mall_id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COMMENT='购物车表';

-- ----------------------------
-- Table structure for pt_catagory_goods
-- ----------------------------
DROP TABLE IF EXISTS `pt_catagory_goods`;
CREATE TABLE `pt_catagory_goods` (
  `catagory_id` bigint(20) NOT NULL COMMENT '参照分类表id',
  `goods_id` bigint(20) NOT NULL COMMENT '参照商品表id',
  PRIMARY KEY (`catagory_id`,`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_catagory_snapshot_goods
-- ----------------------------
DROP TABLE IF EXISTS `pt_catagory_snapshot_goods`;
CREATE TABLE `pt_catagory_snapshot_goods` (
  `catagory_id` bigint(20) NOT NULL COMMENT '参照分类表id',
  `snapshot_id` bigint(20) NOT NULL COMMENT '参照商品表id',
  PRIMARY KEY (`catagory_id`,`snapshot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_goods
-- ----------------------------
DROP TABLE IF EXISTS `pt_goods`;
CREATE TABLE `pt_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '经销商的Id,对应kn_user表的Id',
  `name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `sn` varchar(255) DEFAULT NULL COMMENT '商品编号',
  `description` varchar(255) DEFAULT NULL COMMENT '商品描述',
  `point` int(11) DEFAULT NULL COMMENT '积分价格',
  `introduce` longtext COMMENT '商品详情',
  `stock` int(8) DEFAULT NULL COMMENT '商品库存量',
  `seq` int(10) DEFAULT '100' COMMENT '商品排序',
  `grade` int(10) DEFAULT '100' COMMENT '商品评分',
  `comment` longtext COMMENT '商品评论',
  `image_url` varchar(255) DEFAULT NULL COMMENT '商品缩略图',
  `reference_price` double(20,2) DEFAULT NULL COMMENT '商品参考价',
  `audit_disable_reason` varchar(255) DEFAULT NULL COMMENT '审核未通过原因',
  `audit_state` int(8) DEFAULT '0' COMMENT '审核状态0:待审核;1:已审核;2:审核未通过',
  `market_state` int(8) DEFAULT '0' COMMENT '商品是否上架 0下架、1上架',
  `goods_type` bigint(11) DEFAULT NULL COMMENT '参照字典表中的首页分类id',
  `is_modified` int(11) DEFAULT '0' COMMENT '是否有过修改(0:未修改，1有修改)',
  `is_deleted` int(8) DEFAULT '0' COMMENT '是否被删除 0未删除，1已删除',
  `view_count` int(10) DEFAULT '0' COMMENT '商品浏览次数',
  `buy_count` int(10) DEFAULT '0' COMMENT '商品购买次数',
  `meta_keywords` varchar(1000) DEFAULT NULL COMMENT '页面关键字',
  `create_id` bigint(20) DEFAULT NULL COMMENT '创建人Id',
  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `update_id` bigint(20) DEFAULT NULL COMMENT '更新人Id',
  `update_time` bigint(20) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `ind_goods_name` (`name`),
  KEY `ind_goods_sn` (`sn`),
  KEY `ind_goods_other` (`market_state`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_goods_catagory
-- ----------------------------
DROP TABLE IF EXISTS `pt_goods_catagory`;
CREATE TABLE `pt_goods_catagory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分类主键id',
  `name` varchar(200) DEFAULT NULL COMMENT '分类名称',
  `parent_id` bigint(8) DEFAULT '0' COMMENT '父类id',
  `path` varchar(200) DEFAULT NULL COMMENT '分类id路径',
  `seq` int(5) DEFAULT '100' COMMENT '分类排序',
  `is_show` int(1) DEFAULT '1' COMMENT '是否在页面显示 0不显示，1显示',
  `image_url` varchar(255) DEFAULT NULL COMMENT '分类图片',
  `is_deleted` int(8) DEFAULT '0' COMMENT '是否被删除 0未删除，1已删除',
  PRIMARY KEY (`id`),
  KEY `ind_goods_cat_parentid` (`parent_id`),
  KEY `ind_goods_cat_order` (`seq`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_goods_gallery
-- ----------------------------
DROP TABLE IF EXISTS `pt_goods_gallery`;
CREATE TABLE `pt_goods_gallery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品相册id',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品id(参照商品主键id)',
  `image_url` varchar(255) DEFAULT NULL COMMENT '图片路径',
  `type` int(10) unsigned DEFAULT '0' COMMENT '参照相册类型枚举',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_goods_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `pt_goods_snapshot`;
CREATE TABLE `pt_goods_snapshot` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '快照id',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '经销商的Id',
  `name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `sn` varchar(255) DEFAULT NULL COMMENT '商品编号',
  `description` varchar(255) DEFAULT NULL COMMENT '商品描述',
  `point` bigint(20) DEFAULT NULL COMMENT '积分价格',
  `introduce` longtext COMMENT '商品详情',
  `stock` int(8) DEFAULT NULL COMMENT '商品库存量',
  `seq` int(10) DEFAULT '100' COMMENT '商品排序',
  `grade` int(10) DEFAULT '100' COMMENT '商品评分',
  `comment` longtext COMMENT '商品评论',
  `image_url` varchar(255) DEFAULT NULL COMMENT '商品缩略图',
  `reference_price` double(20,2) DEFAULT NULL COMMENT '商品参考价',
  `audit_disable_reason` varchar(255) DEFAULT NULL COMMENT '审核未通过原因',
  `audit_state` int(8) DEFAULT '0' COMMENT '0:待审核;1:已审核;2:审核未通过',
  `market_state` int(8) unsigned DEFAULT '0' COMMENT '商品是否上架 0下架、1上架',
  `goods_type` bigint(11) DEFAULT NULL COMMENT '参照字典表中的首页分类id',
  `is_deleted` int(8) DEFAULT '0' COMMENT '是否被删除 0未删除，1已删除',
  `view_count` int(10) DEFAULT '0' COMMENT '商品浏览次数',
  `buy_count` int(10) DEFAULT '0' COMMENT '商品购买次数',
  `meta_keywords` varchar(1000) DEFAULT NULL COMMENT '页面关键字',
  `create_id` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `update_id` bigint(20) DEFAULT NULL COMMENT '修改人',
  `update_time` bigint(20) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `ind_goods_name` (`name`),
  KEY `ind_goods_sn` (`sn`),
  KEY `ind_goods_other` (`market_state`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_goods_snapshot_gallery
-- ----------------------------
DROP TABLE IF EXISTS `pt_goods_snapshot_gallery`;
CREATE TABLE `pt_goods_snapshot_gallery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '照片编号',
  `snapshot_id` bigint(20) DEFAULT NULL COMMENT '商品快照id',
  `image_url` varchar(255) DEFAULT NULL COMMENT '商品快照原始图',
  `type` int(10) unsigned DEFAULT '0' COMMENT '参照相册类型枚举',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_mall
-- ----------------------------
DROP TABLE IF EXISTS `pt_mall`;
CREATE TABLE `pt_mall` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商城ID',
  `name` varchar(255) DEFAULT NULL COMMENT '商城名称',
  `app_name` varchar(255) DEFAULT NULL COMMENT '所属APP名称',
  `description` varchar(255) DEFAULT NULL COMMENT '商城描述',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0未删除，1已删除',
  `create_id` bigint(11) DEFAULT NULL COMMENT '创建人',
  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `update_id` bigint(11) DEFAULT NULL COMMENT '修改人',
  `update_time` bigint(20) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_mall_catagory
-- ----------------------------
DROP TABLE IF EXISTS `pt_mall_catagory`;
CREATE TABLE `pt_mall_catagory` (
  `mall_id` bigint(20) NOT NULL COMMENT '参考商城表id',
  `catagory_id` bigint(20) NOT NULL COMMENT '参考分类表id',
  PRIMARY KEY (`mall_id`,`catagory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_mall_goods
-- ----------------------------
DROP TABLE IF EXISTS `pt_mall_goods`;
CREATE TABLE `pt_mall_goods` (
  `mall_id` bigint(20) NOT NULL COMMENT '商城Id',
  `goods_id` bigint(20) NOT NULL COMMENT '商品Id',
  PRIMARY KEY (`goods_id`,`mall_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商城-商品 关联表';

-- ----------------------------
-- Table structure for pt_mall_merchant
-- ----------------------------
DROP TABLE IF EXISTS `pt_mall_merchant`;
CREATE TABLE `pt_mall_merchant` (
  `merchant_id` bigint(20) NOT NULL COMMENT '经销商Id',
  `mall_id` bigint(20) NOT NULL COMMENT '商城Id',
  PRIMARY KEY (`mall_id`,`merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商城-经销商 关联表';

-- ----------------------------
-- Table structure for pt_order
-- ----------------------------
DROP TABLE IF EXISTS `pt_order`;
CREATE TABLE `pt_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单Id',
  `mall_id` bigint(20) DEFAULT NULL COMMENT '商城Id,关联pt_mall.id',
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员id,从app端接口获取到的Id',
  `address_id` bigint(20) DEFAULT NULL COMMENT '收货地址Id',
  `merchant_id` bigint(200) DEFAULT NULL COMMENT '商家（经销商）id',
  `logi_id` bigint(20) DEFAULT NULL COMMENT '物流公司id',
  `logi_num` varchar(255) DEFAULT NULL COMMENT '物流单号',
  `order_num` varchar(255) DEFAULT NULL COMMENT '订单编号',
  `order_status` int(11) DEFAULT '0' COMMENT '订单状态(0:待发货;1:已发货;2:已完成;3:已取消)',
  `create_time` bigint(20) DEFAULT NULL COMMENT '订单创建时间',
  `create_id` bigint(11) DEFAULT NULL COMMENT '创建人Id',
  `update_time` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_id` bigint(11) DEFAULT NULL COMMENT '更新者Id',
  `ship_time` bigint(20) DEFAULT NULL COMMENT '发货日期',
  `order_goods_point` double(11,0) DEFAULT NULL COMMENT '商品订单商品总积分',
  `remark` longtext COMMENT '订单备注',
  `is_deleted` int(1) DEFAULT '0' COMMENT '是否被删除(0:否，1:是)',
  `complete_time` bigint(11) DEFAULT '0' COMMENT '完成时间',
  `cancel_reason` varchar(255) DEFAULT NULL COMMENT '取消原因',
  `cancel_time` bigint(10) DEFAULT NULL COMMENT '取消时间',
  `snapshot_id` bigint(20) DEFAULT NULL COMMENT '商品快照id',
  `is_new` int(11) DEFAULT '0' COMMENT '是否读取该条消息 0:未读 1:已读(当订单状态改变时 须要设置成0:未读)',
  `transfer_point` double DEFAULT NULL COMMENT '获转让积分',
  `rebate_point` double DEFAULT NULL COMMENT '返利积分',
  `ordinary_point` double DEFAULT NULL COMMENT '普通积分',
  `vip_point` double DEFAULT NULL COMMENT 'vip积分',
  PRIMARY KEY (`id`),
  KEY `ind_order_sn` (`order_num`),
  KEY `ind_order_state` (`order_status`),
  KEY `ind_order_memberid` (`member_id`),
  KEY `ind_order_term` (`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_order_items
-- ----------------------------
DROP TABLE IF EXISTS `pt_order_items`;
CREATE TABLE `pt_order_items` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单itemId',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单Id',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品Id',
  `num` int(10) DEFAULT NULL COMMENT '当前订单的item的数量',
  `image_url` varchar(255) DEFAULT NULL COMMENT 'item的缩略图片',
  `name` varchar(255) DEFAULT NULL COMMENT 'item的名称',
  `point` double(11,0) DEFAULT NULL COMMENT '订单的item购买积分',
  `reference_price` double(10,2) DEFAULT NULL COMMENT 'item的参考价格',
  `sn` varchar(255) DEFAULT NULL COMMENT '商品编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_redemption_record
-- ----------------------------
DROP TABLE IF EXISTS `pt_redemption_record`;
CREATE TABLE `pt_redemption_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '积分兑换记录Id',
  `mall_id` bigint(20) DEFAULT NULL COMMENT '商城Id',
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员Id',
  `member_name` varchar(255) DEFAULT NULL COMMENT '会员名',
  `member_phone` varchar(255) DEFAULT NULL COMMENT '会员手机号码',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商家（经销商）Id',
  `goods_name` varchar(255) DEFAULT NULL COMMENT '商品名',
  `goods_num` int(11) DEFAULT NULL COMMENT '商品数量',
  `goods_point` double(11,0) DEFAULT NULL COMMENT '商品兑换总积分',
  `create_time` bigint(20) DEFAULT NULL COMMENT '兑换时间',
  `order_id` bigint(20) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_sms
-- ----------------------------
DROP TABLE IF EXISTS `pt_sms`;
CREATE TABLE `pt_sms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '短信主键id',
  `mall_id` bigint(20) DEFAULT NULL COMMENT '商城id',
  `content` varchar(255) DEFAULT NULL COMMENT '短信内容',
  `sender_name` varchar(255) DEFAULT NULL COMMENT '发送者姓名',
  `sender_phone` varchar(255) DEFAULT NULL COMMENT '发送者手机',
  `receiver_name` varchar(255) DEFAULT NULL COMMENT '接收者姓名',
  `receiver_phone` varchar(255) DEFAULT NULL COMMENT '接收者手机',
  `send_time` bigint(20) DEFAULT NULL COMMENT '发送时间',
  `receive_time` bigint(20) DEFAULT NULL COMMENT '接收时间',
  `sms_status` int(11) DEFAULT NULL COMMENT '发送状态（0:未发送;1:已发送）',
  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `is_new` int(11) DEFAULT '0' COMMENT '是否读取该条消息 0:未读 1:已读',
  `item_image` varchar(255) DEFAULT NULL COMMENT '商品item的第一张图片',
  `order_num` varchar(255) DEFAULT NULL COMMENT '订单号',
  `logi_num` varchar(255) DEFAULT NULL COMMENT '物流单号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_tip
-- ----------------------------
DROP TABLE IF EXISTS `pt_tip`;
CREATE TABLE `pt_tip` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '提醒消息主键id',
  `mall_id` bigint(20) DEFAULT NULL COMMENT '商城Id',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id参考pt_order表中的id主键',
  `content` varchar(255) DEFAULT NULL COMMENT '消息内容',
  `sender_id` bigint(20) DEFAULT NULL COMMENT '发送者id',
  `sender_name` varchar(255) DEFAULT NULL COMMENT '发送者昵称',
  `receiver_id` bigint(20) DEFAULT NULL COMMENT '接收者id',
  `receiver_name` varchar(255) DEFAULT NULL COMMENT '接收者昵称',
  `send_time` bigint(20) DEFAULT NULL COMMENT '发送时间',
  `receive_time` bigint(20) DEFAULT NULL COMMENT '接收时间',
  `read_status` int(11) DEFAULT '0' COMMENT '消息读取状态 0未读，1已读',
  `item_image` varchar(255) DEFAULT NULL COMMENT '商品item的第一张图片',
  `order_num` varchar(255) DEFAULT NULL COMMENT '订单号',
  `logi_num` varchar(255) DEFAULT NULL COMMENT '物流单号',
  `is_new` int(11) DEFAULT '0' COMMENT '是否查看过该条消息 0:未读 1:已读',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否已删除（0:未删除;1:已删除;）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_tip_sms_template
-- ----------------------------
DROP TABLE IF EXISTS `pt_tip_sms_template`;
CREATE TABLE `pt_tip_sms_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '模板id',
  `name` varchar(255) DEFAULT NULL COMMENT '模板名',
  `content` varchar(255) DEFAULT NULL COMMENT '模板内容',
  `type` int(11) DEFAULT '2' COMMENT '1短息模板，2消息模板(废弃字段)',
  `is_default` int(11) DEFAULT '0' COMMENT '是否为默认模板，0否，1是',
  `create_id` bigint(11) DEFAULT NULL COMMENT '创建人',
  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `update_id` bigint(11) DEFAULT NULL COMMENT '修改人',
  `update_time` bigint(20) DEFAULT NULL COMMENT '修改时间',
  `action_type` int(11) DEFAULT NULL COMMENT '发送动作类型：1下单时，2发货时，3收货时，4取消时',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
