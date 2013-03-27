package org.jaronsource.msneg.utils;

import java.text.DecimalFormat;

public class MoneyUtils {

	public static String encode(Integer source) {
		
		if (source == null)
			return "0.00";
		
		DecimalFormat df = new DecimalFormat("#.00");
		return df.format(source / 100.0);
	}
	
	public static Integer decode(String source) {
		if (source == null)
			return 0;
		
		try {
			Integer result = Integer.parseInt(source);
			return result * 100;
		} catch (NumberFormatException e) {
			return 0;
		}
	}
	
	public static Integer decode(Integer source) {
		if (source == null)
			return 0;
		
		return source * 100;
	}
}
