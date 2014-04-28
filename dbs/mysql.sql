-- --------------------------------------------------------
-- 主机:                           192.168.28.105
-- 服务器版本:                        5.5.37-0ubuntu0.14.04.1 - (Ubuntu)
-- 服务器操作系统:                      debian-linux-gnu
-- HeidiSQL 版本:                  8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 auto 的数据库结构
DROP DATABASE IF EXISTS `auto`;
CREATE DATABASE IF NOT EXISTS `auto` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `auto`;


-- 导出  表 auto.auto 结构
DROP TABLE IF EXISTS `auto`;
CREATE TABLE IF NOT EXISTS `auto` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(500) DEFAULT NULL COMMENT '内容说明',
  `img` varchar(200) DEFAULT NULL COMMENT '图片',
  `link` varchar(200) DEFAULT NULL COMMENT '链接',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 auto.auto_fault 结构
DROP TABLE IF EXISTS `auto_fault`;
CREATE TABLE IF NOT EXISTS `auto_fault` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(500) DEFAULT NULL COMMENT '故障内容',
  `img` varchar(200) DEFAULT NULL COMMENT '图片地址',
  `type` int(10) DEFAULT NULL COMMENT '故障类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 auto.auto_fault_type 结构
DROP TABLE IF EXISTS `auto_fault_type`;
CREATE TABLE IF NOT EXISTS `auto_fault_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 auto.auto_type 结构
DROP TABLE IF EXISTS `auto_type`;
CREATE TABLE IF NOT EXISTS `auto_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '汽车分类说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 auto.auto_widget 结构
DROP TABLE IF EXISTS `auto_widget`;
CREATE TABLE IF NOT EXISTS `auto_widget` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '配件名称',
  `price` float DEFAULT NULL COMMENT '价格',
  `user_id` int(10) DEFAULT NULL COMMENT '属于哪个会员的',
  `type` int(10) DEFAULT NULL COMMENT '配件类型',
  `img` varchar(200) DEFAULT NULL COMMENT '图片地址',
  `link` varchar(200) DEFAULT NULL COMMENT '详情地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 auto.auto_widget_type 结构
DROP TABLE IF EXISTS `auto_widget_type`;
CREATE TABLE IF NOT EXISTS `auto_widget_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL COMMENT '分类说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。


-- 导出  表 auto.ui_adver 结构
DROP TABLE IF EXISTS `ui_adver`;
CREATE TABLE IF NOT EXISTS `ui_adver` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link` varchar(500) DEFAULT NULL COMMENT '广告链接',
  `desc` varchar(500) DEFAULT NULL COMMENT '广告说明',
  `img` varchar(500) DEFAULT NULL COMMENT '广告图片',
  `sort` int(10) unsigned DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='汽车广告';

-- 数据导出被取消选择。


-- 导出  表 auto.ui_corp_desc 结构
DROP TABLE IF EXISTS `ui_corp_desc`;
CREATE TABLE IF NOT EXISTS `ui_corp_desc` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `intro` text COMMENT '介绍',
  `big_events` text COMMENT '大事记',
  `leader_says` text COMMENT '领导致辞',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='界面数据表';

-- 数据导出被取消选择。


-- 导出  表 auto.ui_knowledge 结构
DROP TABLE IF EXISTS `ui_knowledge`;
CREATE TABLE IF NOT EXISTS `ui_knowledge` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `desc` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='汽车知识';

-- 数据导出被取消选择。


-- 导出  表 auto.ui_link 结构
DROP TABLE IF EXISTS `ui_link`;
CREATE TABLE IF NOT EXISTS `ui_link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link` varchar(500) DEFAULT NULL,
  `desc` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情连接';

-- 数据导出被取消选择。


-- 导出  表 auto.ui_news 结构
DROP TABLE IF EXISTS `ui_news`;
CREATE TABLE IF NOT EXISTS `ui_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `author` varchar(50) DEFAULT NULL COMMENT '作者',
  `time` datetime DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司新闻';

-- 数据导出被取消选择。


-- 导出  表 auto.ui_quick_sales 结构
DROP TABLE IF EXISTS `ui_quick_sales`;
CREATE TABLE IF NOT EXISTS `ui_quick_sales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配件促销';

-- 数据导出被取消选择。


-- 导出  表 auto.ui_video 结构
DROP TABLE IF EXISTS `ui_video`;
CREATE TABLE IF NOT EXISTS `ui_video` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `desc` varchar(500) DEFAULT NULL COMMENT '描述',
  `link` varchar(500) DEFAULT NULL COMMENT '链接',
  `sort` int(5) unsigned DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='汽车视频';

-- 数据导出被取消选择。


-- 导出  表 auto.ui_web_desc 结构
DROP TABLE IF EXISTS `ui_web_desc`;
CREATE TABLE IF NOT EXISTS `ui_web_desc` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网站介绍';

-- 数据导出被取消选择。


-- 导出  表 auto.user 结构
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登陆用户信息';

-- 数据导出被取消选择。


-- 导出  表 auto.user_open_id 结构
DROP TABLE IF EXISTS `user_open_id`;
CREATE TABLE IF NOT EXISTS `user_open_id` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `open_id` varchar(64) NOT NULL,
  `vendor` varchar(100) DEFAULT NULL,
  `meta` varchar(100) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='open id';

-- 数据导出被取消选择。


-- 导出  表 auto.user_operate 结构
DROP TABLE IF EXISTS `user_operate`;
CREATE TABLE IF NOT EXISTS `user_operate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) NOT NULL COMMENT '操作名字',
  `group` int(10) DEFAULT NULL COMMENT '操作组',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户操作表';

-- 数据导出被取消选择。


-- 导出  表 auto.user_operate_group 结构
DROP TABLE IF EXISTS `user_operate_group`;
CREATE TABLE IF NOT EXISTS `user_operate_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '组说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作组表';

-- 数据导出被取消选择。


-- 导出  表 auto.user_role 结构
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE IF NOT EXISTS `user_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色';

-- 数据导出被取消选择。


-- 导出  表 auto.user_status 结构
DROP TABLE IF EXISTS `user_status`;
CREATE TABLE IF NOT EXISTS `user_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '用户状态',
  `level` int(10) DEFAULT NULL COMMENT '用户等级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择。
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
