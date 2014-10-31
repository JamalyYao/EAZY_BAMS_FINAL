package com.eazytec.core.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.eazytec.common.module.SessionUser;
import com.eazytec.common.pack.HqlPack;
import com.eazytec.common.util.EnumUtil;
import com.eazytec.common.util.LoginContext;
import com.eazytec.common.util.UtilWork;
import com.eazytec.common.util.security.Base64;
import com.eazytec.core.dao.IHrmDepartmentDao;
import com.eazytec.core.dao.IHrmEmployeeDao;
import com.eazytec.core.dao.IHrmPostDao;
import com.eazytec.core.dao.ISysCompanyInfoDao;
import com.eazytec.core.dao.ISysCompanyMethodsDao;
import com.eazytec.core.dao.ISysConfigDao;
import com.eazytec.core.dao.ISysHelpDao;
import com.eazytec.core.dao.ISysLogDao;
import com.eazytec.core.dao.ISysMethodInfoDao;
import com.eazytec.core.dao.ISysMsgDao;
import com.eazytec.core.dao.ISysParamDao;
import com.eazytec.core.dao.ISysRoleBindDao;
import com.eazytec.core.dao.ISysRoleDao;
import com.eazytec.core.dao.ISysRoleDetailDao;
import com.eazytec.core.dao.ISysUserGroupDao;
import com.eazytec.core.dao.ISysUserGroupDetailDao;
import com.eazytec.core.dao.ISysUserInfoDao;
import com.eazytec.core.dao.ISysUserMethodsDao;
import com.eazytec.core.dao.ISysUserViewDao;
import com.eazytec.core.iservice.IUserLoginService;
import com.eazytec.core.pojo.HrmDepartment;
import com.eazytec.core.pojo.HrmEmployee;
import com.eazytec.core.pojo.HrmPost;
import com.eazytec.core.pojo.SysCompanyInfo;
import com.eazytec.core.pojo.SysCompanyMethods;
import com.eazytec.core.pojo.SysConfig;
import com.eazytec.core.pojo.SysMethodInfo;
import com.eazytec.core.pojo.SysParam;
import com.eazytec.core.pojo.SysRoleBind;
import com.eazytec.core.pojo.SysRoleDetail;
import com.eazytec.core.pojo.SysUserGroupDetail;
import com.eazytec.core.pojo.SysUserInfo;
import com.eazytec.core.pojo.SysUserMethods;

public class UserLoginService implements IUserLoginService {
	private Logger log = Logger.getLogger(this.getClass());

	private ISysUserInfoDao sysUserInfoDao;

	private ISysLogDao sysLogDao;

	private IHrmEmployeeDao hrmEmployeeDao;

	private IHrmDepartmentDao hrmDepartmentDao;

	private ISysCompanyInfoDao sysCompanyInfoDao;

	private ISysCompanyMethodsDao sysCompanyMethodsDao;

	private ISysMethodInfoDao sysMethodInfoDao;

	private ISysUserMethodsDao sysUserMethodsDao;

	private ISysMsgDao msgDao;

	private ISysHelpDao helpDao;

	private ISysRoleBindDao rolebindDao;

	private ISysRoleDao roleDao;

	private ISysRoleDetailDao roledetailDao;

	private ISysUserGroupDao usergroupDao;

	private ISysUserGroupDetailDao usergroupdetailDao;

	private ISysUserViewDao userviewDao;

	private IHrmPostDao hrmPostDao;
	
	private ISysConfigDao sysConfigDao;
	
	private ISysParamDao sysParamDao;
	
	
	

	public void setSysParamDao(ISysParamDao sysParamDao) {
		this.sysParamDao = sysParamDao;
	}


	public void setSysConfigDao(ISysConfigDao sysConfigDao) {
		this.sysConfigDao = sysConfigDao;
	}


	public void setSysUserInfoDao(ISysUserInfoDao sysUserInfoDao) {
		this.sysUserInfoDao = sysUserInfoDao;
	}

	public void setSysLogDao(ISysLogDao sysLogDao) {
		this.sysLogDao = sysLogDao;
	}

	public void setHrmEmployeeDao(IHrmEmployeeDao hrmEmployeeDao) {
		this.hrmEmployeeDao = hrmEmployeeDao;
	}

	public void setHrmDepartmentDao(IHrmDepartmentDao hrmDepartmentDao) {
		this.hrmDepartmentDao = hrmDepartmentDao;
	}

	public void setSysCompanyInfoDao(ISysCompanyInfoDao sysCompanyInfoDao) {
		this.sysCompanyInfoDao = sysCompanyInfoDao;
	}

	public void setSysCompanyMethodsDao(ISysCompanyMethodsDao sysCompanyMethodsDao) {
		this.sysCompanyMethodsDao = sysCompanyMethodsDao;
	}

	public void setSysMethodInfoDao(ISysMethodInfoDao sysMethodInfoDao) {
		this.sysMethodInfoDao = sysMethodInfoDao;
	}

	public void setSysUserMethodsDao(ISysUserMethodsDao sysUserMethodsDao) {
		this.sysUserMethodsDao = sysUserMethodsDao;
	}

	public void setMsgDao(ISysMsgDao msgDao) {
		this.msgDao = msgDao;
	}

	public void setHelpDao(ISysHelpDao helpDao) {
		this.helpDao = helpDao;
	}

	public void setRolebindDao(ISysRoleBindDao rolebindDao) {
		this.rolebindDao = rolebindDao;
	}

	public void setRoleDao(ISysRoleDao roleDao) {
		this.roleDao = roleDao;
	}

	public void setRoledetailDao(ISysRoleDetailDao roledetailDao) {
		this.roledetailDao = roledetailDao;
	}

	public void setUsergroupDao(ISysUserGroupDao usergroupDao) {
		this.usergroupDao = usergroupDao;
	}

	public void setUsergroupdetailDao(ISysUserGroupDetailDao usergroupdetailDao) {
		this.usergroupdetailDao = usergroupdetailDao;
	}

	public void setUserviewDao(ISysUserViewDao userviewDao) {
		this.userviewDao = userviewDao;
	}

	public void setHrmPostDao(IHrmPostDao hrmPostDao) {
		this.hrmPostDao = hrmPostDao;
	}

	/**
	 * 获取所有顶级功能
	 * 
	 * @return
	 */
	public List<SysMethodInfo> getAllMethodInfoByLevel() {
		List<SysMethodInfo> sysMethodInfoList = sysMethodInfoDao.findByHqlWhere(" and model.methodLevel=-1 and model.methodNo<>-1 order by model.methodNo");
		return sysMethodInfoList;
	}

	/**
	 * 通过主键获取功能对象
	 * 
	 * @param pk
	 * @return
	 */
	public SysMethodInfo getMethodInfoByPk(String pk) {
		SysMethodInfo sysmethodInfo = sysMethodInfoDao.getByPK(pk);
		return sysmethodInfo;
	}

	/**
	 * 通过公司主键获取公司信息
	 * 
	 * @param id
	 * @return
	 */
	public SysCompanyInfo getCompanyInfoByPk(long id) {
		SysCompanyInfo companyInfo = sysCompanyInfoDao.getByPK(id);
		return companyInfo;
	}

	/**
	 * 通过公司主键获取所有用户
	 * 
	 * @param cid
	 * @return
	 */
	public List<SysUserInfo> getUserByCompanyPk(int cid) {
		List<SysUserInfo> sysUserList = sysUserInfoDao.findByProperty("companyId", cid);
		return sysUserList;
	}

	/**
	 * 根据公司编码和用户名查询用户信息
	 * 
	 * @param userName
	 * @param cid
	 * @return
	 */
	public SysUserInfo getUserInfoByCompanyIdAndUserName(String userName, int cid) {
		SysUserInfo userTemp = null;
		List<SysUserInfo> sysUserList = sysUserInfoDao.findByHqlWhere(" and model.companyId=" + cid + " and model.userName ='" + userName + "'");
		if (sysUserList.size() == 1) {
			userTemp = sysUserList.get(0);
		}
		return userTemp;
	}

	/**
	 * 根据公司编码获取公司信息
	 * 
	 * @param companyCode
	 * @return
	 */
	public SysCompanyInfo getCompanyInfoByCode(String companyCode) {
		SysCompanyInfo companyInfo = null;
		List<SysCompanyInfo> companyInfoList = sysCompanyInfoDao.findByProperty("companyInfoCode", companyCode);
		if (companyInfoList.size() == 1) {
			companyInfo = companyInfoList.get(0);
		}
		return companyInfo;
	}

	/**
	 * 对公司有效期进行验证，是否在开始和结束日期之间
	 * 
	 * @param companyCode
	 * @return
	 */
	public SysCompanyInfo vaildityCompany(String companyCode) {
		SysCompanyInfo temp = null;
		String nowDate = UtilWork.getToday();
		if (companyCode != null && companyCode.trim().length() > 0) {
			SysCompanyInfo companyInfo = this.getCompanyInfoByCode(companyCode);
			if (companyInfo != null) {
				if (companyInfo.getCompanyInfoType() == EnumUtil.SYS_COMPANY_TYPE.SYSTEM.value) {//系统管理账户不做操作
					return companyInfo;
				}
				boolean sbl = UtilWork.checkDay(nowDate, companyInfo.getCompanyInfoSdate()) || nowDate.equals(companyInfo.getCompanyInfoSdate());
				boolean ebl = UtilWork.checkDay(companyInfo.getCompanyInfoEdate(), nowDate) || nowDate.equals(companyInfo.getCompanyInfoEdate());
				if (sbl && ebl) {
					temp = companyInfo;
				}
			}
		}
		return temp;
	}

	/**
	 * 验证登陆用户
	 * 
	 * @param companyCode
	 * @param userName
	 * @param userPwd
	 * @return
	 */
	public SysUserInfo vaildityUserInfo(SysCompanyInfo companyInfo, String userName, String userPwd) {
		SysUserInfo temp = null;
		SysUserInfo userInfoTmp = this.getUserInfoByCompanyIdAndUserName(userName, (int) companyInfo.getPrimaryKey());
		if (userInfoTmp != null && userInfoTmp.getUserAction() == EnumUtil.SYS_ISACTION.Vaild.value) {
			// 加密密码比对
			String parsePwd = Base64.getBase64FromString(userPwd);
			if (userPwd != null && userPwd.trim().length() > 0 && parsePwd.equals(userInfoTmp.getUserpassword())) {
				temp = userInfoTmp;
			}
		}
		return temp;
	}

	/**
	 * 获取公司功能菜单
	 * 
	 * @param cpk
	 * @return
	 */
	public List<SysMethodInfo> getCompanyMethodsByCPk(int cpk) {
		List<SysMethodInfo> sysmethodlist = this.getAllMethodInfoByLevel();
		List<SysMethodInfo> list = new ArrayList<SysMethodInfo>();
		SysCompanyInfo companyInfo = sysCompanyInfoDao.getByPK((long)cpk);
		if (companyInfo.getCompanyInfoType() == EnumUtil.SYS_COMPANY_TYPE.SYSTEM.value) {
			for (SysMethodInfo sm : sysmethodlist) {
				if (sm.getIsAction() == EnumUtil.SYS_ISACTION.Vaild.value) {
					list.add(sm);
				}
			}
			return list;
		}
		List<SysCompanyMethods> companyMethodsList = sysCompanyMethodsDao.findByProperty("companyId", cpk);
		
		for (SysCompanyMethods sysCompanyMethod : companyMethodsList) {
			for (SysMethodInfo sysMethodInfo : sysmethodlist) {
				if (sysMethodInfo.getPrimaryKey().equals(sysCompanyMethod.getMethodInfoId())&&sysMethodInfo.getIsAction() == EnumUtil.SYS_ISACTION.Vaild.value) {
					list.add(sysMethodInfo);
				}
			}
		}
		return list;
	}
	
	public Map<String, String> getSysParamToMap(long companyId){
		List<SysParam> list = sysParamDao.findByHqlWhere(" and model.companyId = "+companyId);
		Map<String, String> parMap = new HashMap<String, String>();
		for (SysParam sysParam : list) {
			parMap.put(sysParam.getParamIndex(), sysParam.getParamValue());
		}
		return parMap;
	}
	
	/**
	 * 对登录用户的封装
	 * 
	 * @param companyCode
	 * @param userName
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public SessionUser packageUserInfo(String companyCode, String userName, String projectCode) {
		SessionUser suser = new SessionUser();
		// 1.公司信息
		SysCompanyInfo companyInfo = this.getCompanyInfoByCode(companyCode);
		suser.setCompanyId(companyInfo.getPrimaryKey());
		suser.setCompanyCode(companyCode);
		suser.setCompanyInfoWareHouseCount(companyInfo.getCompanyInfoWarehousecount());
		suser.setCompanyInfoUserCount(companyInfo.getCompanyInfoUsercount());
		suser.setCompanyInfo(companyInfo);
		suser.setCompanyName(companyInfo.getCompanyInfoName());
		suser.setCompanyShortName(companyInfo.getCompanyInfoShortname());
		
		//1.2依据公司码加载参数为map
		Map<String, String> paramMap = this.getSysParamToMap(companyInfo.getPrimaryKey());
		suser.setParamMap(paramMap);
		//公司功能菜单
		List<SysMethodInfo> sysCompanyMethodList = this.getCompanyMethodsByCPk(Integer.parseInt(companyInfo.getPrimaryKey() + ""));
		suser.setCompanyMethodsList(sysCompanyMethodList);
		// 2.用户信息
		SysUserInfo userInfoTmp = this.getUserInfoByCompanyIdAndUserName(userName, (int) companyInfo.getPrimaryKey());
		suser.setUserName(userName);
		suser.setUserInfo(userInfoTmp);
		
		if (companyInfo.getCompanyInfoType() == EnumUtil.SYS_COMPANY_TYPE.SYSTEM.value) {
			// 人员信息
			HrmEmployee employee = new HrmEmployee();
			employee.setPrimaryKey(String.valueOf(userInfoTmp.getPrimaryKey()));
			// 人员部门信息
			HrmDepartment dept = new HrmDepartment();
			dept.setPrimaryKey(-1);
			// 功能合集
			Set<String> userMethods =new HashSet<String>();
			if(userInfoTmp.getUserType() == EnumUtil.SYS_USER_TYPE.TSET.value) {
				employee.setHrmEmployeeName("系统测试账户");
				dept.setHrmDepName("测试部");
				suser.setEmployeeName("系统测试账户");
				suser.setEmployeeDeptName("测试部");
				List<SysMethodInfo> tmplist = this.getAllMethodInfoByLevel();
				for (SysMethodInfo sysMethodInfo : tmplist) {
					userMethods.add(sysMethodInfo.getPrimaryKey());
				}
			}else if(userInfoTmp.getUserType() == EnumUtil.SYS_USER_TYPE.SYSTEM.value){
				employee.setHrmEmployeeName("系统管理账户");
				dept.setHrmDepName("系统管理部");
				suser.setEmployeeName("系统管理账户");
				suser.setEmployeeDeptName("系统管理部");
				SysMethodInfo methodinfotmp = sysMethodInfoDao.getByPK(projectCode);
				userMethods.add(methodinfotmp.getPrimaryKey());
			}
			suser.setEmployeeInfo(employee);
			suser.setDepartmentInfo(dept);
			suser.setUserMethodsSet(userMethods);
		}else{
			//2010-1-15添加注册公司管理员账户
			if(userInfoTmp.getUserType() == EnumUtil.SYS_USER_TYPE.SYSTEM.value){
				//开启所有公司允许功能
				// 人员信息
				HrmEmployee employee = new HrmEmployee();
				employee.setPrimaryKey(String.valueOf(userInfoTmp.getPrimaryKey()));
				employee.setHrmEmployeeName("公司系统管理员");
				
				// 人员部门信息
				HrmDepartment dept = new HrmDepartment();
				dept.setPrimaryKey(-1);
				dept.setHrmDepName("系统管理");
				// 功能合集
				Set<String> userMethods =new HashSet<String>();
				for (SysMethodInfo sysMethodInfo : sysCompanyMethodList) {
					userMethods.add(sysMethodInfo.getPrimaryKey());
				}
				suser.setEmployeeName("公司系统管理员");
				suser.setEmployeeDeptName("系统管理");
				suser.setEmployeeInfo(employee);
				suser.setDepartmentInfo(dept);
				suser.setUserMethodsSet(userMethods);
				
				//公司的系统管理员也需要 操作功能模块 2014-04-04 JC
				//个人可操作功能模块
				List<SysMethodInfo> userModuleMethods = new ArrayList<SysMethodInfo>();
				
				for(SysMethodInfo sysMethod : suser.getCompanyMethodsList()){
					boolean bl =false;
					if(suser.getUserMethodsSet()!=null && suser.getUserMethodsSet().size()>0){
						Iterator<String> it = suser.getUserMethodsSet().iterator();
						while(it.hasNext()){
							String id = it.next();
							if(sysMethod.getPrimaryKey().equals(id)){
								bl = true;
								break;
							}
						}
					}
					if(bl){
						userModuleMethods.add(sysMethod);
					}
				}
				
				//个人可操作功能模块排序
				CaseInsensitiveComparator comp =new CaseInsensitiveComparator();
				Collections.sort(userModuleMethods,comp);
				suser.setUserModuleMethods(userModuleMethods);
				
			}else{
				// 3.人员信息
				HrmEmployee employee = hrmEmployeeDao.getByPK(userInfoTmp.getHrmEmployeeId());
				suser.setEmployeeName(employee.getHrmEmployeeName());
				suser.setEmployeeInfo(employee);
	
				// 4.人员部门信息
				HrmDepartment dept = hrmDepartmentDao.getByPK(employee.getHrmEmployeeDepid().longValue());
				suser.setEmployeeDeptName(dept.getHrmDepName());
				suser.setDepartmentInfo(dept);
	
				// 5.主岗位信息
				if (employee.getHrmEmployeePostId() != null && employee.getHrmEmployeePostId().intValue() > 0) {
					HrmPost mainPost = hrmPostDao.getByPK((long) employee.getHrmEmployeePostId());
					suser.setMainPost(mainPost);
				}
				// 6.兼职岗位信息
				if (employee.getHrmPartPost() != null && employee.getHrmPartPost().length() > 0) {
					String[] pids = employee.getHrmPartPost().split(",");
					suser.setPartPosts(this.getPartPostsByPostIds(pids));
				}
				//6.1角色主键合集
				Set<Integer> roleSet = this.getRoleIdsByUser(suser);
				suser.setRoleIds(roleSet);
				//6.2用户权限
				SysUserMethods userMethodsList =  this.getSysUserMethodsByUid(userInfoTmp.getPrimaryKey());
				suser.setSysUserMethodsList(userMethodsList);
				
				// 7.个人业务模块
				suser.setUserMethodsSet(this.getUserCompanyMethods(suser));
				
				// 8.个人可操作功能模块
				List<SysMethodInfo> userModuleMethods = new ArrayList<SysMethodInfo>();
				
				for(SysMethodInfo sysMethod : suser.getCompanyMethodsList()){
					boolean bl =false;
					if(suser.getUserMethodsSet()!=null && suser.getUserMethodsSet().size()>0){
						Iterator<String> it = suser.getUserMethodsSet().iterator();
						while(it.hasNext()){
							String id = it.next();
							if(sysMethod.getPrimaryKey().equals(id)){
								bl = true;
								break;
							}
						}
					}
					if(bl){
						userModuleMethods.add(sysMethod);
					}
				}
				
				//个人可操作功能模块排序
				CaseInsensitiveComparator comp =new CaseInsensitiveComparator();
				Collections.sort(userModuleMethods,comp);
				suser.setUserModuleMethods(userModuleMethods);
			}
		}
		//8.系统配置信息
		SysConfig sysconfig = getSysconfigByCode(projectCode);
		suser.setSysconfig(sysconfig);
		return suser;
	}

	public SysConfig getSysconfigByCode(String code){
		List<SysConfig> list = sysConfigDao.findByHqlWhere(" and methodId ='"+code+"'");
		SysConfig sysconfig = null;
		if (list.size()>0) {
			sysconfig = list.get(0);
		}
		return sysconfig;
	}
	
	
	/**
	 * 根据兼职id获取所有兼职信息
	 */
	public List<HrmPost> getPartPostsByPostIds(String[] postIds) {
		List<HrmPost> postsList = new ArrayList<HrmPost>();
		for (String pid : postIds) {
			if (pid.length()>0) {
				postsList.add(hrmPostDao.getByPK(Long.parseLong(pid)));
			}
		}
		return postsList;
	}

	/**
	 * 获取个人业务模块主键
	 * 
	 * @param userId
	 * @return
	 */
	public Set<String> getUserCompanyMethods(SessionUser user) {
		// 组装角色权限
		Set<String> methodIds = this.getMethodIdsByRoleIds(user.getRoleIds(), user.getSysUserMethodsList());
		return methodIds;
	}
	
	public SysCompanyInfo getCompanyInfoByUserId(long userId){
		SysUserInfo user = sysUserInfoDao.getByPK(userId);
		SysCompanyInfo company =null;
		if (user!=null) {
			company = sysCompanyInfoDao.getByPK((long)user.getCompanyId());
		}
		return company;
	}
	
	
	/**
	 * 获取个人业务模块(工程切换时使用)
	 * 
	 * @param userId
	 * @return
	 */
	public Set<String> getUserCompanyMethods(long userId,int companyType) {
		Set<String> ids = new HashSet<String>(); 
		if (companyType== EnumUtil.SYS_COMPANY_TYPE.SYSTEM.value) {
			List<SysMethodInfo> sysMethodInfoList =this.getAllMethodInfoByLevel();
			for (SysMethodInfo sysMethodInfo : sysMethodInfoList) {
				ids.add(sysMethodInfo.getPrimaryKey());
			}
		}else{
			
			SessionUser suser = new SessionUser();
			// 2.用户信息
			SysUserInfo userInfoTmp = sysUserInfoDao.getByPK(userId);
			suser.setUserInfo(userInfoTmp);
			//公司功能菜单
			List<SysMethodInfo> sysCompanyMethodList = this.getCompanyMethodsByCPk(userInfoTmp.getCompanyId());
			suser.setCompanyMethodsList(sysCompanyMethodList);
			//2010-1-15添加注册公司管理员账户
			if(userInfoTmp.getUserType() == EnumUtil.SYS_USER_TYPE.SYSTEM.value){
				//开启所有公司允许功能
				// 人员信息
				HrmEmployee employee = new HrmEmployee();
				employee.setPrimaryKey(String.valueOf(userInfoTmp.getPrimaryKey()));
				employee.setHrmEmployeeName("公司系统管理员");
				
				// 人员部门信息
				HrmDepartment dept = new HrmDepartment();
				dept.setPrimaryKey(-1);
				dept.setHrmDepName("系统管理");
				// 功能合集
				Set<String> userMethods =new HashSet<String>();
				for (SysMethodInfo sysMethodInfo : sysCompanyMethodList) {
					userMethods.add(sysMethodInfo.getPrimaryKey());
				}
				suser.setEmployeeName("公司系统管理员");
				suser.setEmployeeDeptName("系统管理");
				suser.setEmployeeInfo(employee);
				suser.setDepartmentInfo(dept);
				suser.setUserMethodsSet(userMethods);
			}else{
				// 3.人员信息
				HrmEmployee employee = hrmEmployeeDao.getByPK(userInfoTmp.getHrmEmployeeId());
				suser.setEmployeeInfo(employee);
		
				// 4.人员部门信息
				HrmDepartment dept = hrmDepartmentDao.getByPK(employee.getHrmEmployeeDepid().longValue());
				suser.setDepartmentInfo(dept);
		
				// 5.主岗位信息
				if (employee.getHrmEmployeePostId() != null && employee.getHrmEmployeePostId().intValue() > 0) {
					HrmPost mainPost = hrmPostDao.getByPK((long) employee.getHrmEmployeePostId());
					suser.setMainPost(mainPost);
				}
				// 6.兼职岗位信息
				if (employee.getHrmPartPost() != null && employee.getHrmPartPost().length() > 0) {
					String[] pids = employee.getHrmPartPost().split(",");
					suser.setPartPosts(this.getPartPostsByPostIds(pids));
				}
				//6.1角色主键合集
				Set<Integer> roleSet = this.getRoleIdsByUser(suser);
				suser.setRoleIds(roleSet);
				//6.2用户权限
				SysUserMethods userMethodsList =  this.getSysUserMethodsByUid(userInfoTmp.getPrimaryKey());
				suser.setSysUserMethodsList(userMethodsList);
				
				// 组装角色权限
				ids = this.getMethodIdsByRoleIds(roleSet, userMethodsList);
			}
		}
		return ids;
	}

	// 功能菜单ids转为对象集合
	public List<SysMethodInfo> getSysmethodInfoListByIds(Set<String> methodIds) {
		List<SysMethodInfo> list = new ArrayList<SysMethodInfo>();
		Iterator<String> it = methodIds.iterator();
		String ids = "";
		while (it.hasNext()) {
			String elem = (String) it.next();
			ids += "'" + elem + "',";
		}
		if (ids != null && ids.length() > 0) {
			list = sysMethodInfoDao.findByHqlWhere(" and model.primaryKey in ( " + ids.substring(0, ids.length() - 1) + " ) and model.isAction = " + EnumUtil.SYS_ISACTION.Vaild.value);
		}
		return list;
	}

	/**
	 * 根据角色主键集合、用户权限明细获取功能主键集合
	 * 
	 * @param roleSet
	 *            角色主键set集合
	 * @param userMethodDetail
	 *            用户权限明细
	 * @param type
	 *            取值范围 2代表只取得顶级菜单 为空或0代表取得全部
	 * @return
	 */
	public Set<String> getMethodIdsByRoleIds(Set<Integer> roleSet, SysUserMethods userMethodDetail) {
		Set<String> methodIds = new HashSet<String>();
		Iterator<Integer> roleIt = roleSet.iterator();
		String roleIds = "";
		while (roleIt.hasNext()) {
			Integer elem = (Integer) roleIt.next();
			roleIds += elem + ",";
		}
		if (roleIds != null && roleIds.length() > 0) {
			String tmpstr = " and model.roleId in ( " + roleIds.substring(0, roleIds.length() - 1) + " )";
			List<SysRoleDetail> roleDetailList = roledetailDao.findByHqlWhere(tmpstr);
			if (roleDetailList.size() > 0) {
				for (SysRoleDetail sysRoleDetail : roleDetailList) {
					methodIds.add(sysRoleDetail.getMethodId());
				}
			}
		}
		if (userMethodDetail != null && userMethodDetail.getUserMethodDetail()!=null&&userMethodDetail.getUserMethodDetail().length()>0) {
			String[] tmps = userMethodDetail.getUserMethodDetail().trim().split(",");
			for (String str : tmps) {
				if (str!=null&&str.length() > 0) {
					methodIds.add(str);
				}
			}
		}
		return methodIds;
	}

	// 用户所在组集合
	public List<SysUserGroupDetail> getGroupListByUserId(int userId) {
		List<SysUserGroupDetail> list = usergroupdetailDao.findByHqlWhere(" and model.userId = " + userId);
		return list;
	}

	// 用户所绑定角色主键集合
	public Set<Integer> getRoleIdsByUser(SessionUser user) {
		Set<Integer> roleIdSet = new HashSet<Integer>();
		// 用户角色
		List<SysRoleBind> roleList_User = this.getRoleBingListByType("'" + user.getUserInfo().getPrimaryKey() + "'", EnumUtil.SYS_ROLE_BIND_TYPE.BIND_USER.value);
		for (SysRoleBind sysRoleBinduser : roleList_User) {
			roleIdSet.add(sysRoleBinduser.getRoleId());
		}
		// 部门角色
		List<SysRoleBind> roleList_Dept = this.getRoleBingListByType("'" + user.getDepartmentInfo().getPrimaryKey() + "'", EnumUtil.SYS_ROLE_BIND_TYPE.BIND_DEPT.value);
		for (SysRoleBind sysRoleBinddept : roleList_Dept) {
			roleIdSet.add(sysRoleBinddept.getRoleId());
		}
		// 岗位角色
		String postIds = "";
		if (user.getMainPost() != null) {
			postIds += "'" + user.getMainPost().getPrimaryKey() + "',";
		}
		if (user.getPartPosts() != null && user.getPartPosts().size() > 0) {
			for (int i = 0; i < user.getPartPosts().size(); i++) {
				HrmPost tmp = user.getPartPosts().get(i);
				if (tmp!=null) {
					postIds += "'" + tmp.getPrimaryKey() + "',";
				}
				
			}
		}
		if (postIds != null && postIds.length() > 0) {
			List<SysRoleBind> roleList_Post = this.getRoleBingListByType(postIds.substring(0, postIds.length() - 1), EnumUtil.SYS_ROLE_BIND_TYPE.BIND_POST.value);
			for (SysRoleBind sysRoleBindpost : roleList_Post) {
				roleIdSet.add(sysRoleBindpost.getRoleId());
			}
		}
		// 用户组角色
		List<SysUserGroupDetail> groupDetailList = this.getGroupListByUserId((int) user.getUserInfo().getPrimaryKey());
		String gIds = "";
		if (groupDetailList != null && groupDetailList.size() > 0) {
			for (int i = 0; i < groupDetailList.size(); i++) {
				SysUserGroupDetail detail = groupDetailList.get(i);
				gIds += "'" + detail.getGroupId() + "',";
			}
			if (gIds != null && gIds.length() > 0) {
				List<SysRoleBind> roleList_Group = this.getRoleBingListByType(gIds.substring(0, gIds.length() - 1), EnumUtil.SYS_ROLE_BIND_TYPE.BIND_GROUP.value);
				for (SysRoleBind sysRoleBindgroup : roleList_Group) {
					roleIdSet.add(sysRoleBindgroup.getRoleId());
				}
			}
		}
		return roleIdSet;
	}

	public List<SysRoleBind> getRoleBingListByType(String values, int type) {
		List<SysRoleBind> roleList = new ArrayList<SysRoleBind>();
		if (values.length()>0) {
			roleList = rolebindDao.findByHqlWhere(" and model.bindValue in ( " + values + " ) and model.bindType =" + type);
		}
		return roleList;
	}

	/**
	 * 获取用户权限信息
	 */
	public SysUserMethods getSysUserMethodsByUid(long uid) {
		SysUserMethods methods=null;
		List<SysUserMethods> sysUserMethodsList = sysUserMethodsDao.findByProperty("userId", (int) uid);
		if (sysUserMethodsList.size()==1) {
			methods = sysUserMethodsList.get(0);
		}
		return methods;
	}
	/**
	 * 获取功能菜单下级(管理公司使用)
	 */
	public List<SysMethodInfo> getSysMethodInfoByCodeUnit(String upCode,boolean bl) {
		List<SysMethodInfo> sysMethodInfoList = sysMethodInfoDao.findByHqlWhere(HqlPack.packSysMethodInfoByTree(upCode, bl));
		return sysMethodInfoList;
	}
	
	public int getSysMethodInfoByCodeUnitCount(String upCode,boolean bl) {
		 return sysMethodInfoDao.findByHqlWhereCount(HqlPack.packSysMethodInfoByTree(upCode, bl));
	}

	
	/**
	 * 根据编号及用户类型获取下级菜单
	 * @param code
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SysMethodInfo> getSysMethodInfoListByCode(String code,HttpServletRequest request){
		SessionUser user = (SessionUser) LoginContext.getSessionValueByLogin(request);
		List<SysMethodInfo> methodList = new ArrayList<SysMethodInfo>();
		if (user.getCompanyInfo().getCompanyInfoType() == EnumUtil.SYS_COMPANY_TYPE.SYSTEM.value) {//管理公司
			if (user.getUserInfo().getUserType() == EnumUtil.SYS_USER_TYPE.SYSTEM.value) {//系统管理员
				methodList = this.getSysMethodInfoByCodeUnit(code, true);//只加载系统级
			}else{//系统测试人员
				methodList = this.getSysMethodInfoByCodeUnit(code, false);//除系统级以外全部加载
			}
		}else{//注册公司
			//公司系统管理员
			
			if (user.getUserInfo().getUserType() == EnumUtil.SYS_USER_TYPE.SYSTEM.value) {
				methodList = this.getSysMethodInfoByCodeUnit(code, false);//只加载系统级
			}else{
				//用户权限过滤
				Set<String> ids = user.getUserMethodsSet();
				Iterator<String> it = ids.iterator();
				List<SysMethodInfo> tmplist = this.getSysMethodInfoByCodeUnit(code, false);//除系统级以外全部加载
				while (it.hasNext()) {
					String str = (String) it.next();
					for (SysMethodInfo sysMethodInfo : tmplist) {
						if (sysMethodInfo.getPrimaryKey().equalsIgnoreCase(str)) {
							methodList.add(sysMethodInfo);
							break;
						}
					}
				}
			}
		}
		CaseInsensitiveComparator comp =new CaseInsensitiveComparator();
		Collections.sort(methodList,comp);
		return methodList;
	}
	
	public int getSysMethodInfoListByCodeCount(String code,HttpServletRequest request){
		SessionUser user = (SessionUser) LoginContext.getSessionValueByLogin(request);
		int count =0;
		if (user.getCompanyInfo().getCompanyInfoType() == EnumUtil.SYS_COMPANY_TYPE.SYSTEM.value) {//管理公司
			if (user.getUserInfo().getUserType() == EnumUtil.SYS_USER_TYPE.SYSTEM.value) {//系统管理员
				count = this.getSysMethodInfoByCodeUnitCount(code, true);
			}else{//系统测试人员
				count = this.getSysMethodInfoByCodeUnitCount(code, false);
			}
		}else{//注册公司
			if (user.getUserInfo().getUserType() == EnumUtil.SYS_USER_TYPE.SYSTEM.value) {
				count = this.getSysMethodInfoByCodeUnitCount(code, false);
			}else{
				//用户权限过滤
				boolean bl = false;
				Set<String> ids = user.getUserMethodsSet();
				Iterator<String> it = ids.iterator();
				List<SysMethodInfo> tmplist = this.getSysMethodInfoByCodeUnit(code, false);//除系统级以外全部加载
				while (it.hasNext()) {
					String str = (String) it.next();
					for (SysMethodInfo sysMethodInfo : tmplist) {
						if (sysMethodInfo.getPrimaryKey().equalsIgnoreCase(str)) {
							bl = true;
							count =1;
							break;
						}
					}
					if (bl) {
						break;
					}
				}
			}
		}
		return count;
	}
	
	// 功能菜单显示排序
	@SuppressWarnings("unchecked")
	class CaseInsensitiveComparator implements Comparator {

		public int compare(Object arg0, Object arg1) {
			SysMethodInfo method1 = (SysMethodInfo) arg0;
			SysMethodInfo method2 = (SysMethodInfo) arg1;
			if (method1.getMethodNo()!= null &&method2.getMethodNo()!= null&& method1.getMethodNo()!=method2.getMethodNo()) {
				int m1 = method1.getMethodNo();
				int m2 = method2.getMethodNo();
				if (m1 < m2) {
					return -1;
				} else {
					return 1;
				}
			} else {
				return 0;
			}
		}
	}
	
}
