package com.eazytec.core.pojo;

/**
 * 数据库表名：SYS_PROVINCE
 */
public class SysProvince extends BaseStringBean implements java.io.Serializable {

	/**
	 * 省数据表
	 */
	private static final long serialVersionUID = 2222085344212095018L;
	private String provinceName; //省（州）名
	private String provinceEngname; //省（州）英文名
	private String countryCode;  //国家代码

	// 默认构造方法
	public SysProvince() {
		super();
	}

	// 构造方法(手工生成)

	// get和set方法
	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String aProvinceName) {
		this.provinceName = aProvinceName;
	}

	public String getProvinceEngname() {
		return provinceEngname;
	}

	public void setProvinceEngname(String aProvinceEngname) {
		this.provinceEngname = aProvinceEngname;
	}

	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String aCountryCode) {
		this.countryCode = aCountryCode;
	}

}