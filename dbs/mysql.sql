/*
SQLyog Trial v11.33 (64 bit)
MySQL - 5.5.37-0ubuntu0.14.04.1 : Database - auto
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`auto` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `auto`;

/*Table structure for table `auto` */

DROP TABLE IF EXISTS `auto`;

CREATE TABLE `auto` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(500) DEFAULT NULL COMMENT '内容说明',
  `img` varchar(200) DEFAULT NULL COMMENT '图片',
  `link` varchar(200) DEFAULT NULL COMMENT '链接',
  `brand` int(10) DEFAULT NULL COMMENT '品牌',
  `swept_volume` float DEFAULT NULL COMMENT '排量值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='车型';

/*Data for the table `auto` */

insert  into `auto`(`id`,`content`,`img`,`link`,`brand`,`swept_volume`) values (1,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `auto_brand` */

DROP TABLE IF EXISTS `auto_brand`;

CREATE TABLE `auto_brand` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '品牌名字',
  `country_id` int(10) DEFAULT NULL COMMENT '国家',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='汽车品牌';

/*Data for the table `auto_brand` */

/*Table structure for table `auto_fault` */

DROP TABLE IF EXISTS `auto_fault`;

CREATE TABLE `auto_fault` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(500) DEFAULT NULL COMMENT '故障内容',
  `img` varchar(200) DEFAULT NULL COMMENT '图片地址',
  `type` int(10) DEFAULT NULL COMMENT '故障类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auto_fault` */

/*Table structure for table `auto_fault_type` */

DROP TABLE IF EXISTS `auto_fault_type`;

CREATE TABLE `auto_fault_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `is_changjian` int(1) NOT NULL DEFAULT '0' COMMENT '是否常见',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auto_fault_type` */

/*Table structure for table `auto_quantity` */

DROP TABLE IF EXISTS `auto_quantity`;

CREATE TABLE `auto_quantity` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '排量说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auto_quantity` */

/*Table structure for table `auto_type` */

DROP TABLE IF EXISTS `auto_type`;

CREATE TABLE `auto_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '汽车分类说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='车类型';

/*Data for the table `auto_type` */

/*Table structure for table `auto_widget` */

DROP TABLE IF EXISTS `auto_widget`;

CREATE TABLE `auto_widget` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '配件名称',
  `price` float DEFAULT NULL COMMENT '价格',
  `user_id` int(10) DEFAULT NULL COMMENT '属于哪个会员的',
  `type` int(10) DEFAULT NULL COMMENT '配件类型',
  `img` varchar(200) DEFAULT NULL COMMENT '图片地址',
  `link` varchar(200) DEFAULT NULL COMMENT '详情地址',
  `auto_id` int(10) DEFAULT NULL COMMENT '车型',
  `quantity` int(10) DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='配件';

/*Data for the table `auto_widget` */

insert  into `auto_widget`(`id`,`name`,`price`,`user_id`,`type`,`img`,`link`,`auto_id`,`quantity`) values (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `auto_widget_type` */

DROP TABLE IF EXISTS `auto_widget_type`;

CREATE TABLE `auto_widget_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL COMMENT '分类说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配件分类\r\n';

/*Data for the table `auto_widget_type` */

/*Table structure for table `country` */

DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
  `id` int(10) unsigned DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='国家';

/*Data for the table `country` */

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL,
  `series_id` varchar(120) NOT NULL COMMENT '序列号（日期+产品编号+客户ID+ID）',
  `c_id` int(10) NOT NULL COMMENT '客户ID',
  `time` datetime NOT NULL COMMENT '时间',
  `status` int(10) NOT NULL COMMENT '状态',
  `desc` varchar(200) DEFAULT NULL COMMENT '订单简单说明',
  `ship_time` datetime DEFAULT NULL COMMENT '发货说明',
  `ship_id` int(10) DEFAULT NULL COMMENT '物流id',
  `total_price` float DEFAULT NULL COMMENT '合计',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order` */

/*Table structure for table `order_item` */

DROP TABLE IF EXISTS `order_item`;

CREATE TABLE `order_item` (
  `id` int(10) unsigned NOT NULL,
  `o_id` int(10) unsigned NOT NULL COMMENT '所属订单',
  `p_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `p_quantity` int(10) unsigned NOT NULL COMMENT '产品数量',
  `p_price` float NOT NULL COMMENT '产品价格',
  `p_name` varchar(50) NOT NULL COMMENT '产品名字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order_item` */

/*Table structure for table `ui_adver` */

DROP TABLE IF EXISTS `ui_adver`;

CREATE TABLE `ui_adver` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link` varchar(500) DEFAULT NULL COMMENT '广告链接',
  `desc` varchar(500) DEFAULT NULL COMMENT '广告说明',
  `img` varchar(500) DEFAULT NULL COMMENT '广告图片',
  `sort` int(10) unsigned DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='汽车广告';

/*Data for the table `ui_adver` */

/*Table structure for table `ui_corp_desc` */

DROP TABLE IF EXISTS `ui_corp_desc`;

CREATE TABLE `ui_corp_desc` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `intro` text COMMENT '介绍',
  `big_events` text COMMENT '大事记',
  `leader_says` text COMMENT '领导致辞',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='界面数据表';

/*Data for the table `ui_corp_desc` */

insert  into `ui_corp_desc`(`id`,`intro`,`big_events`,`leader_says`) values (1,'123\r\n','22','33');

/*Table structure for table `ui_knowledge` */

DROP TABLE IF EXISTS `ui_knowledge`;

CREATE TABLE `ui_knowledge` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `desc` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='汽车知识';

/*Data for the table `ui_knowledge` */

/*Table structure for table `ui_link` */

DROP TABLE IF EXISTS `ui_link`;

CREATE TABLE `ui_link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link` varchar(500) DEFAULT NULL,
  `desc` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情连接';

/*Data for the table `ui_link` */

/*Table structure for table `ui_news` */

DROP TABLE IF EXISTS `ui_news`;

CREATE TABLE `ui_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `author` varchar(50) DEFAULT NULL COMMENT '作者',
  `time` datetime DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司新闻';

/*Data for the table `ui_news` */

/*Table structure for table `ui_quick_sales` */

DROP TABLE IF EXISTS `ui_quick_sales`;

CREATE TABLE `ui_quick_sales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配件促销';

/*Data for the table `ui_quick_sales` */

/*Table structure for table `ui_video` */

DROP TABLE IF EXISTS `ui_video`;

CREATE TABLE `ui_video` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `desc` varchar(500) DEFAULT NULL COMMENT '描述',
  `link` varchar(500) DEFAULT NULL COMMENT '链接',
  `sort` int(5) unsigned DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='汽车视频';

/*Data for the table `ui_video` */

/*Table structure for table `ui_web_desc` */

DROP TABLE IF EXISTS `ui_web_desc`;

CREATE TABLE `ui_web_desc` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网站介绍';

/*Data for the table `ui_web_desc` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned DEFAULT NULL COMMENT '角色id',
  `nick` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `open_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='登陆用户信息';

/*Data for the table `user` */

insert  into `user`(`id`,`role_id`,`nick`,`name`,`email`,`phone`,`password`,`time`,`open_id`) values (1,1,'管理员高杰','gaojie',NULL,'18910221510','123','2014-04-27 20:33:27',NULL);

/*Table structure for table `user_open_id` */

DROP TABLE IF EXISTS `user_open_id`;

CREATE TABLE `user_open_id` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `open_id` varchar(64) NOT NULL,
  `vendor` varchar(100) DEFAULT NULL,
  `meta` varchar(100) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='open id';

/*Data for the table `user_open_id` */

/*Table structure for table `user_operate` */

DROP TABLE IF EXISTS `user_operate`;

CREATE TABLE `user_operate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) NOT NULL COMMENT '操作名字',
  `group` int(10) DEFAULT NULL COMMENT '操作组',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户操作表';

/*Data for the table `user_operate` */

/*Table structure for table `user_operate_group` */

DROP TABLE IF EXISTS `user_operate_group`;

CREATE TABLE `user_operate_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '组说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作组表';

/*Data for the table `user_operate_group` */

/*Table structure for table `user_role` */

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='角色';

/*Data for the table `user_role` */

insert  into `user_role`(`id`,`name`,`type`) values (1,'系统管理员',0),(2,'个人会员',1),(3,'企业会员',2),(4,'运营管理员',3);

/*Table structure for table `user_status` */

DROP TABLE IF EXISTS `user_status`;

CREATE TABLE `user_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '用户状态',
  `level` int(10) DEFAULT NULL COMMENT '用户等级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_status` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
