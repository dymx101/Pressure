package com.pressure.util;

/**
 * @author zhengyisheng E-mail:zhengyisheng@gmail.com
 * @version CreateTime：2013-1-26 下午05:16:39 Class Description
 */
public class UseMailSender {
	public static void main(String[] args) {
		// 这个类主要是设置邮件
		MailSenderInfo mailInfo = new MailSenderInfo();
		mailInfo.setMailServerHost("smtp.163.com");
		mailInfo.setMailServerPort("25");
		mailInfo.setValidate(true);
		mailInfo.setUserName("yunshang_734@163.com");
		mailInfo.setPassword("Qby771234");// 您的邮箱密码
		mailInfo.setFromAddress("yunshang_734@163.com");
		mailInfo.setToAddress("66157642@qq.com");
		mailInfo.setSubject("哈哈哈");
		mailInfo.setContent("哈哈哈哈哈哈");
		// 这个类主要来发送邮件
		SimpleMailSenderUtil sms = new SimpleMailSenderUtil();
		sms.sendTextMail(mailInfo);// 发送文体格式
		SimpleMailSenderUtil.sendHtmlMail(mailInfo);// 发送html格式
	}
}
