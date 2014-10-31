package com.eazytec.common.util;

public class UtilCheck {
	private final static int sublen = 16;


	public static String subStringDate(String date) {
		return date.substring(0,sublen);
	}
}
