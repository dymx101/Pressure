CREATE TABLE TB_Profile (
UserId bigint(20) NOT NULL  AUTO_INCREMENT  COMMENT '用户id',
UserName varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
NickName varchar(64) NOT NULL DEFAULT '' COMMENT '昵称',
CreateTime bigint(20) NOT NULL default '0' COMMENT '创建时间',
LastUpdateTime bigint(20) NOT NULL default '0' COMMENT '上次上线时间',
AvatorUrl varchar(128) NOT NULL DEFAULT ' ' COMMENT '用户头像',
level int(11) NOT NULL DEFAULT '0' COMMENT '用户等级' ,
PRIMARY KEY  (`UserId`)
)   DEFAULT CHARSET=UTF8 COMMENT '用户信息表';

CREATE TABLE TB_Source_Account (
Id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id,自增长',
UserId bigint(20) NOT NULL  DEFAULT '0'  COMMENT  '用户id',
AccessUserId bigint(20) NOT NULL DEFAULT  '0' COMMENT '资源用户id',
AccessUserName varchar(64) NOT NULL DEFAULT '' COMMENT '资源用户名',
AccessToken varchar(128) NOT NULL DEFAULT '' COMMENT '用户对应Token',
ExpiresIn varchar(64) NOT NULL DEFAULT '' COMMENT 'Token时长',
SourceType tinyint(4) NOT NULL COMMENT '外部资源类型,1为新浪微博',
CreateTime bigint(20) NOT NULL default '0' COMMENT '创建时间',
PRIMARY KEY  (`Id`)
)   DEFAULT CHARSET=UTF8 COMMENT '外部资源账户表';

CREATE TABLE TB_Account (
UserId bigint(20) NOT NULL  DEFAULT '0' COMMENT '用户id,自增长',
UserName varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
PassWord varchar(64) NOT NULL DEFAULT '' COMMENT '密码',
CreateTime bigint(20) NOT NULL default '0' COMMENT '创建时间',
PRIMARY KEY  (`UserId`)
)   DEFAULT CHARSET=UTF8 COMMENT '用户帐户表';