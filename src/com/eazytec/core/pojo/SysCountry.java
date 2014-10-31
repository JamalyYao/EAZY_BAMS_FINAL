package com.eazytec.core.pojo;

/**
 * 数据库表名：SYS_COUNTRY
 */
public class SysCountry extends BaseStringBean implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1405594297016452547L;
	private String countryName;
	private String countryEngname;

	// 默认构造方法
	public SysCountry() {
		super();
	}

	// 构造方法(手工生成)

	// get和set方法
	public String getCountryName() {
		return countryName;
	}

	public void setCountryName(String aCountryName) {
		this.countryName = aCountryName;
	}

	public String getCountryEngname() {
		return countryEngname;
	}

	public void setCountryEngname(String aCountryEngname) {
		this.countryEngname = aCountryEngname;
	}

}