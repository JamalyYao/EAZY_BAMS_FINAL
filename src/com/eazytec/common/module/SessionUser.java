package com.eazytec.common.module;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.eazytec.core.pojo.HrmDepartment;
import com.eazytec.core.pojo.HrmEmployee;
import com.eazytec.core.pojo.HrmPost;
import com.eazytec.core.pojo.SysCompanyInfo;
import com.eazytec.core.pojo.SysConfig;
import com.eazytec.core.pojo.SysMethodInfo;
import com.eazytec.core.pojo.SysUserInfo;
import com.eazytec.core.pojo.SysUserMethods;

/**
 * 用户登录信息封装
 * 
 * @author peng.ning
 * 
 */
public class SessionUser {

	private String userName;

	private String employeeName;

	private String employeeDeptName;

	private long companyId;

	private String companyCode;

	private String companyName;

	private String companyShortName;

	private int companyInfoWareHouseCount;

	private int companyInfoUserCount;

	private SysUserInfo userInfo;

	private SysCompanyInfo companyInfo;

	private HrmEmployee employeeInfo;

	private HrmDepartment departmentInfo;

	private Set<String> userMethodsSet = new HashSet<String>();// 个人功能

	private List<SysMethodInfo> userModuleMethods = new ArrayList<SysMethodInfo>();// 个人模块权限列表

	private List<SysMethodInfo> companyMethodsList = new ArrayList<SysMethodInfo>();// 公司功能权限

	private HrmPost mainPost;// 所在主岗位

	private List<HrmPost> partPosts = new ArrayList<HrmPost>();// 所有兼职岗位

	private List<Integer> viewdeptIds = new ArrayList<Integer>();// 所能查看的部门主键集合

	private Set<Integer> roleIds = new HashSet<Integer>();// 角色主键集合

	private SysUserMethods sysUserMethodsList;// 用户指定权限

	private SysConfig sysconfig;

	private Map<String, String> paramMap = new HashMap<String, String>();// 系统运行参数

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public String getEmployeeDeptName() {
		return employeeDeptName;
	}

	public void setEmployeeDeptName(String employeeDeptName) {
		this.employeeDeptName = employeeDeptName;
	}

	public long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyShortName() {
		return companyShortName;
	}

	public void setCompanyShortName(String companyShortName) {
		this.companyShortName = companyShortName;
	}

	public int getCompanyInfoWareHouseCount() {
		return companyInfoWareHouseCount;
	}

	public void setCompanyInfoWareHouseCount(int companyInfoWareHouseCount) {
		this.companyInfoWareHouseCount = companyInfoWareHouseCount;
	}

	public int getCompanyInfoUserCount() {
		return companyInfoUserCount;
	}

	public void setCompanyInfoUserCount(int companyInfoUserCount) {
		this.companyInfoUserCount = companyInfoUserCount;
	}

	public SysUserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(SysUserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public SysCompanyInfo getCompanyInfo() {
		return companyInfo;
	}

	public void setCompanyInfo(SysCompanyInfo companyInfo) {
		this.companyInfo = companyInfo;
	}

	public HrmEmployee getEmployeeInfo() {
		return employeeInfo;
	}

	public void setEmployeeInfo(HrmEmployee employeeInfo) {
		this.employeeInfo = employeeInfo;
	}

	public HrmDepartment getDepartmentInfo() {
		return departmentInfo;
	}

	public void setDepartmentInfo(HrmDepartment departmentInfo) {
		this.departmentInfo = departmentInfo;
	}

	public Set<String> getUserMethodsSet() {
		return userMethodsSet;
	}

	public void setUserMethodsSet(Set<String> userMethodsSet) {
		this.userMethodsSet = userMethodsSet;
	}

	public List<SysMethodInfo> getCompanyMethodsList() {
		return companyMethodsList;
	}

	public void setCompanyMethodsList(List<SysMethodInfo> companyMethodsList) {
		this.companyMethodsList = companyMethodsList;
	}

	public HrmPost getMainPost() {
		return mainPost;
	}

	public void setMainPost(HrmPost mainPost) {
		this.mainPost = mainPost;
	}

	public List<HrmPost> getPartPosts() {
		return partPosts;
	}

	public void setPartPosts(List<HrmPost> partPosts) {
		this.partPosts = partPosts;
	}

	public List<Integer> getViewdeptIds() {
		return viewdeptIds;
	}

	public void setViewdeptIds(List<Integer> viewdeptIds) {
		this.viewdeptIds = viewdeptIds;
	}

	public Set<Integer> getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(Set<Integer> roleIds) {
		this.roleIds = roleIds;
	}

	public SysUserMethods getSysUserMethodsList() {
		return sysUserMethodsList;
	}

	public void setSysUserMethodsList(SysUserMethods sysUserMethodsList) {
		this.sysUserMethodsList = sysUserMethodsList;
	}

	public SysConfig getSysconfig() {
		return sysconfig;
	}

	public void setSysconfig(SysConfig sysconfig) {
		this.sysconfig = sysconfig;
	}

	public Map<String, String> getParamMap() {
		return paramMap;
	}

	public void setParamMap(Map<String, String> paramMap) {
		this.paramMap = paramMap;
	}

	public List<SysMethodInfo> getUserModuleMethods() {
		return userModuleMethods;
	}

	public void setUserModuleMethods(List<SysMethodInfo> userModuleMethods) {
		this.userModuleMethods = userModuleMethods;
	}

}
