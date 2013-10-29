CREATE TABLE TB_Profile (
UserId bigint(20) NOT NULL  AUTO_INCREMENT  COMMENT '用户id',
UserName varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
Password varchar(64) NOT NULL DEFAULT '' COMMENT '密码',
Name varchar(64) NOT NULL DEFAULT '' COMMENT '注册名字',
CreateTime bigint(20) NOT NULL default '0' COMMENT '创建时间',
PRIMARY KEY  (`UserId`)
)   DEFAULT CHARSET=UTF8 COMMENT '用户信息表';

CREATE TABLE TB_Account (
id bigint(20) NOT NULL  AUTO_INCREMENT  COMMENT 'id',
access_token varchar(64) NOT NULL DEFAULT '' COMMENT '授权token',
expires_in varchar(64) NOT NULL DEFAULT '' COMMENT '生命周期',
uid varchar(64) NOT NULL DEFAULT '' COMMENT '微博UID',
PRIMARY KEY  (`UserId`)
)   DEFAULT CHARSET=UTF8 COMMENT '微博UID表';