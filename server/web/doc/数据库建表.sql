CREATE TABLE TB_Profile (
UserId bigint(20) NOT NULL  AUTO_INCREMENT  COMMENT '�û�id',
UserName varchar(64) NOT NULL DEFAULT '' COMMENT '�û���',
Password varchar(64) NOT NULL DEFAULT '' COMMENT '����',
Name varchar(64) NOT NULL DEFAULT '' COMMENT 'ע������',
CreateTime bigint(20) NOT NULL default '0' COMMENT '����ʱ��',
PRIMARY KEY  (`UserId`)
)   DEFAULT CHARSET=UTF8 COMMENT '�û���Ϣ��';

CREATE TABLE TB_Account (
id bigint(20) NOT NULL  AUTO_INCREMENT  COMMENT 'id',
access_token varchar(64) NOT NULL DEFAULT '' COMMENT '��Ȩtoken',
expires_in varchar(64) NOT NULL DEFAULT '' COMMENT '��������',
uid varchar(64) NOT NULL DEFAULT '' COMMENT '΢��UID',
PRIMARY KEY  (`UserId`)
)   DEFAULT CHARSET=UTF8 COMMENT '΢��UID��';