package com.eason.web.util;

import java.io.File;

import javapns.Push;

public class TestApns {
	public static void main(String[] args) throws Exception {
		File resourceFile = new File("/Users/zhengeason/Desktop/key.p12");
		Push.alert("123", resourceFile, "123456", false, "d25eeeee469139fea5aead38aa98811a1ba5154b637589fb118fa0cf0b15ea0e");
		
		
		// try {
		//
		// PayLoad payLoad = new PayLoad();
		// payLoad.addAlert("123");
		// payLoad.addSound("default");
		//
		//
		// PushNotificationManager pushManager =
		// PushNotificationManager.getInstance();
		// pushManager.addDevice("123",
		// "2ce256228477b6b16864730ec2b17065b00e597ba543858ecc2f409b88659e6c");
		// File resourceFile = new File("/Users/zhengeason/Desktop/key.p12");
		//
		// pushManager.initializeConnection("gateway.sandbox.push.apple.com",
		// 2195, resourceFile.getPath(), "123456",
		// SSLConnectionHelper.KEYSTORE_TYPE_PKCS12);
		//
		// // Send Push
		// Device client = pushManager.getDevice("123");
		// pushManager.sendNotification(client, payLoad);
		// pushManager.stopConnection();
		//
		// //pushManager.removeDevice(String.valueOf(device.getUserId()));
		//
		// } catch (Exception e) {
		// e.printStackTrace();
		// }
	}
}
