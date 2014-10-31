package com.eazytec.core.pojo;

/**
 * 数据库表名：SYS_ERROR
 */
public class SysError extends BaseBean implements java.io.Serializable {

	/**
	 * 系统错误信息表
	 */
	private static final long serialVersionUID = -5753424412755496727L;
	private String errorCode;	//错误编码
	private String errorName;	//错误名称
	private String errorInfo;	//错误描述
	private String errorMsg;	//异常信息

	// 默认构造方法
	public SysError() {
		super();
	}

	// get和set方法
	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String aErrorCode) {
		this.errorCode = aErrorCode;
	}

	public String getErrorName() {
		return errorName;
	}

	public void setErrorName(String aErrorName) {
		this.errorName = aErrorName;
	}

	public String getErrorInfo() {
		return errorInfo;
	}

	public void setErrorInfo(String aErrorInfo) {
		this.errorInfo = aErrorInfo;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String aErrorMsg) {
		this.errorMsg = aErrorMsg;
	}

}