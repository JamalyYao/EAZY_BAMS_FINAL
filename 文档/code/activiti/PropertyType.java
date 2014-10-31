package com.eazytec.common.activiti;

import java.util.Date;

/**
 * 属性数据类型
 *
 * @author HenryYan
 */
public enum PropertyType {
	
	S(String.class), I(Integer.class), L(Long.class), F(Float.class), 
	N(Double.class), D(Date.class), SD(java.sql.Date.class), B(Boolean.class);

	/**
	_S(String.class), _I(Integer.class), _L(Long.class), _F(Float.class), 
	_N(Double.class), _D(Date.class), _SD(java.sql.Date.class), _B(Boolean.class);
	
	public static final String S = "_S";
	public static final String I = "_I";
	public static final String L = "_L";
	public static final String F = "_F";
	public static final String N = "_N";
	public static final String D = "_D";
	public static final String SD = "_SD";
	public static final String B = "_B";
	**/
	
	private Class<?> clazz;

	private PropertyType(Class<?> clazz) {
		this.clazz = clazz;
	}

	public Class<?> getValue() {
		return clazz;
	}
}