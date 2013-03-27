package org.jaronsource.msneg.utils;

public class PhoneUtils {

	public static String decode (String areaCode, String phone) {
		return String.format("%s-%s", areaCode, phone);
	}
	
}
