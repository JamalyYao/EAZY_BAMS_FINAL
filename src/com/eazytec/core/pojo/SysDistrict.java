package com.eazytec.core.pojo;

/**
 * 数据库表名：SYS_DISTRICT
 */
public class SysDistrict extends BaseBean implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1991071234106448950L;
	private String districtName;
	private String districtEngname;
	private String provinceCode;

	// 默认构造方法
	public SysDistrict() {
		super();
	}

	// 构造方法(手工生成)

	// get和set方法
	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String aDistrictName) {
		this.districtName = aDistrictName;
	}

	public String getDistrictEngname() {
		return districtEngname;
	}

	public void setDistrictEngname(String aDistrictEngname) {
		this.districtEngname = aDistrictEngname;
	}

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String aProvinceCode) {
		this.provinceCode = aProvinceCode;
	}

}