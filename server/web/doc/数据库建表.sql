CREATE TABLE TB_Profile (
UserId bigint(20) NOT NULL  AUTO_INCREMENT  COMMENT '�û�id',
UserName varchar(64) NOT NULL DEFAULT '' COMMENT '�û���',
NickName varchar(64) NOT NULL DEFAULT '' COMMENT '�ǳ�',
CreateTime bigint(20) NOT NULL default '0' COMMENT '����ʱ��',
LastUpdateTime bigint(20) NOT NULL default '0' COMMENT '�ϴ�����ʱ��',
AvatorUrl varchar(128) NOT NULL DEFAULT ' ' COMMENT '�û�ͷ��',
level int(11) NOT NULL DEFAULT '0' COMMENT '�û��ȼ�' ,
PRIMARY KEY  (`UserId`)
)   DEFAULT CHARSET=UTF8 COMMENT '�û���Ϣ��';

CREATE TABLE TB_Source_Account (
Id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id,������',
UserId bigint(20) NOT NULL  DEFAULT '0'  COMMENT  '�û�id',
AccessUserId bigint(20) NOT NULL DEFAULT  '0' COMMENT '��Դ�û�id',
AccessUserName varchar(64) NOT NULL DEFAULT '' COMMENT '��Դ�û���',
AccessToken varchar(128) NOT NULL DEFAULT '' COMMENT '�û���ӦToken',
ExpiresIn varchar(64) NOT NULL DEFAULT '' COMMENT 'Tokenʱ��',
SourceType tinyint(4) NOT NULL COMMENT '�ⲿ��Դ����,1Ϊ����΢��',
CreateTime bigint(20) NOT NULL default '0' COMMENT '����ʱ��',
PRIMARY KEY  (`Id`)
)   DEFAULT CHARSET=UTF8 COMMENT '�ⲿ��Դ�˻���';

CREATE TABLE TB_Account (
UserId bigint(20) NOT NULL  DEFAULT '0' COMMENT '�û�id,������',
UserName varchar(64) NOT NULL DEFAULT '' COMMENT '�û���',
PassWord varchar(64) NOT NULL DEFAULT '' COMMENT '����',
CreateTime bigint(20) NOT NULL default '0' COMMENT '����ʱ��',
PRIMARY KEY  (`UserId`)
)   DEFAULT CHARSET=UTF8 COMMENT '�û��ʻ���';