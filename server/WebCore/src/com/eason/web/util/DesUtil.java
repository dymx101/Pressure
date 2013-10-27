package com.eason.web.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import org.apache.log4j.Logger;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class DesUtil {

	private static final Logger log = Logger.getLogger(DesUtil.class);

	private final byte[] desKey;

	public DesUtil(String desKey) {
		this.desKey = desKey.getBytes();
	}

	public byte[] desEncrypt(byte[] plainText) throws Exception {
		SecureRandom sr = new SecureRandom();
		byte rawKeyData[] = desKey;
		DESKeySpec dks = new DESKeySpec(rawKeyData);
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey key = keyFactory.generateSecret(dks);
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.ENCRYPT_MODE, key, sr);
		byte data[] = plainText;
		byte encryptedData[] = cipher.doFinal(data);
		return encryptedData;
	}

	public byte[] desDecrypt(byte[] encryptText) throws Exception {
		SecureRandom sr = new SecureRandom();
		byte rawKeyData[] = desKey;
		DESKeySpec dks = new DESKeySpec(rawKeyData);
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey key = keyFactory.generateSecret(dks);
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.DECRYPT_MODE, key, sr);
		byte encryptedData[] = encryptText;
		byte decryptedData[] = cipher.doFinal(encryptedData);
		return decryptedData;
	}

	public String getEncString(String input) {
		try {
			return base64Encode(desEncrypt(input.getBytes()));
		} catch (Exception e) {
			log.error("des enc error");
			return null;
		}
	}

	public String getDecString(String input) {
		try {
			byte[] result = base64Decode(input);
			return new String(desDecrypt(result));
		} catch (Exception e) {
			log.error("des dec error");
			return null;
		}
	}

	public static String base64Encode(byte[] s) {
		if (s == null)
			return null;
		BASE64Encoder b = new sun.misc.BASE64Encoder();
		String base64 = b.encode(s);
		try {
			return URLEncoder.encode(base64, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static byte[] base64Decode(String s) throws IOException {
		if (s == null) {
			return null;
		}
		String urlDecode = URLDecoder.decode(s, "utf-8");
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] b = decoder.decodeBuffer(urlDecode);
		return b;
	}

	public static void main(String[] args) throws Exception {
		String key = "jifenzhong_test";
		String input = "1123," + System.currentTimeMillis();
		DesUtil crypt = new DesUtil(key);
		String str1 = crypt.getEncString(input);
		System.out.println("Encode:" + str1);

		System.out.println("Decode:" + crypt.getDecString(str1));

		String base64str1 = base64Encode(str1.getBytes());
		System.out.println(base64str1);

		System.out.println("Decode:" + crypt.getDecString(new String(base64Decode(base64str1))));
	}
}