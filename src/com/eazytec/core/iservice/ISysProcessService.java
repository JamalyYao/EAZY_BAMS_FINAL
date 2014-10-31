package com.eazytec.core.iservice;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import com.eazytec.common.module.OnlineHrmEmployeeBean;
import com.eazytec.common.module.UserMethodsInfo;
import com.eazytec.common.pages.Pager;
import com.eazytec.core.pojo.HrmDepartment;
import com.eazytec.core.pojo.HrmEmployee;
import com.eazytec.core.pojo.HrmPost;
import com.eazytec.core.pojo.SysAttachmentInfo;
import com.eazytec.core.pojo.SysColumnControl;
import com.eazytec.core.pojo.SysCompanyInfo;
import com.eazytec.core.pojo.SysConfig;
import com.eazytec.core.pojo.SysException;
import com.eazytec.core.pojo.SysHelp;
import com.eazytec.core.pojo.SysImageInfo;
import com.eazytec.core.pojo.SysLibraryInfo;
import com.eazytec.core.pojo.SysLibraryStandard;
import com.eazytec.core.pojo.SysLog;
import com.eazytec.core.pojo.SysMethodHelp;
import com.eazytec.core.pojo.SysMethodInfo;
import com.eazytec.core.pojo.SysMethodShortcut;
import com.eazytec.core.pojo.SysMsg;
import com.eazytec.core.pojo.SysParam;
import com.eazytec.core.pojo.SysRole;
import com.eazytec.core.pojo.SysRoleBind;
import com.eazytec.core.pojo.SysRoleDetail;
import com.eazytec.core.pojo.SysUserGroup;
import com.eazytec.core.pojo.SysUserGroupDetail;
import com.eazytec.core.pojo.SysUserInfo;
import com.eazytec.core.pojo.SysUserMethods;

public interface ISysProcessService {
	public SysLog saveSysLog(SysLog sysLog);

	public SysException saveSysException(SysException sysException);

	public SysConfig getSysconfigByCode(String code);

	public List<SysMethodInfo> getSysMethodInfoList(ArrayList<String> ids);

	public SysLog saveMethodLog(SysLog syslog);

	public List<SysMethodInfo> getMethodInfoListByUpCode(String code); // 获取功能列表

	public int getMethodInfoListByUpCodeCount(String code); // 统计功能数量

	public List<SysMethodInfo> listAllSysMethodInfoPager(SysMethodInfo sysMethodInfo, Pager pager);

	public int listAllSysMethodInfoCount(SysMethodInfo sysMethodInfo);

	public void delectMethodByids(String[] ids); // 删除功能菜单

	public void setMethodStatus(String[] ids); // 启用、禁用功能菜单

	public List<SysLibraryInfo> getSysLibraryInfoByInfo(SysLibraryInfo libraryInfo);

	public int getSysLibraryInfoCountByInfo(SysLibraryInfo libraryInfo);
	
	public SysLibraryInfo getSysLibraryInfoByCodAndCompanyId(SysLibraryInfo libraryInfo);

	public List<SysLibraryInfo> getSysLibraryInfoByInfoPager(SysLibraryInfo libraryInfo, Pager pager);

	public SysLibraryInfo saveSysLibraryInfo(SysLibraryInfo libraryInfo);
	
	public String getCode(String upcode, String table, String colname, String upcol, int companyId);

	public List<SysLibraryInfo> getSysLibraryInfoByCode(String code, int companyId);

	public SysLibraryInfo getSysLibraryInfoByCodeAndCompanyId(String code, int companyId);

	public SysLibraryInfo getSysLibraryInfoByPk(long pk);
	
	public List<SysLibraryInfo> getSysLibraryInfoByName(String name,int companyId);

	public SysLibraryInfo setLibraryInfoStatusByPk(long pk, int status, int type);

	public void setLibraryInfoBatchByPks(long[] pks, int type);

	public void deleteLibraryInfoBatchByPks(long[] pks);

	public List<SysAttachmentInfo> saveAttachmentInfo(String fileNames, String empid, int companyid);

	public List<SysImageInfo> saveImageInfo(String fileNames, String empid, int companyid);

	public List<SysAttachmentInfo> getAttachmentInfoListByIds(String ids);

	public List<SysImageInfo> getImageInfoListByIds(String ids);

	public void deleteAttachmentInfoListByIds(String ids, boolean bl);

	public void deleteImageInfoListByIds(String ids, boolean bl);

	public List<String> getEmployeeNamesByids(String ids);

	public List<String> getDeptNamesByIds(String ids);

	public SysUserInfo saveSysUserInfo(SysUserInfo user);

	public int getSysUserInfoByEmpId(String empid, int companyId);
	
	public SysUserInfo getSysUserInfoByEmpId(String empid);

	public int getSysUserInfoByUserName(String username, int companyId);

	public SysUserInfo getSysUserInfoByPk(long pk, boolean bl);

	public int getSysUserInfoCountByCompanyId(int companyId);

	public int getCompanyUserMaxCount(long companyId);

	public int getSysUserInfoByUserNameEdit(String newusername, long userid, int companyId);

	public ArrayList<SysUserInfo> saveSysUserInfo(ArrayList<SysUserInfo> list);

	public int getSysUserInfoListCount(SysUserInfo userinfo);

	public List<SysUserInfo> getSysUserInfoListByPager(SysUserInfo userinfo, Pager pager);

	public void updateSysUserInfoIsaction(long[] ids, int isaction, String empid);

	public List<SysUserGroupDetail> getSysUserGroupDetailList(int userId);

	public SysUserGroup saveSysUsergroupAndDetail(SysUserGroup group, String[] userIds);

	public List<SysUserGroup> listSysUserGroupBypager(SysUserGroup usergroup, Pager pager);

	public int listSysUserGroupCount(SysUserGroup usergroup);

	public SysUserGroup getSysUserGroupByPk(long pk);

	public void deleteSysUserGroupByIds(long[] ids);

	public List<Object[]> getEmployeeNameByuserIds(String userIds, int companyId);

	public void updateSysUsergroupAndDetail(SysUserGroup group, String[] userIds, String empid, String nowtime);

	public List<SysMethodInfo> getSysMethodInfoListByCode(String code, int level);

	public SysRole saveRoleAndDetailBind(int companyId, String empId, SysRole role, SysRoleBind[] binds, String[] methodIds);

	public int getSysRoleCount(SysRole role);

	public List<SysRole> getSysRoleByPager(SysRole role, Pager pager);

	public void deleteSysRoleByIds(long[] ids);

	public List<SysRoleDetail> getSysRoleDetailList(int roleId);

	public SysRole getSysRoleById(long id);

	public List<SysRoleBind> getSysRoleBindList(int roleId);

	public List<String> getEmployeeNamesByUserIds(String ids);

	public List<String> getGroupNamesByIds(String ids);

	public List<String> getPostNamesByIds(String ids);

	public List<UserMethodsInfo> getUserMethodsInfoByPager(UserMethodsInfo info, Pager pager);

	public int getUserMethodsInfoCount(UserMethodsInfo info);

	public SysUserMethods getSysUserMethodsByUid(int uid, int companyId);

	public void saveSysUserMethods(ArrayList<SysUserMethods> list);

	public UserMethodsInfo getUserMethodsInfoByUid(int uid, int companyId);

	public SysCompanyInfo saveCompanyInfo(SysCompanyInfo company, String[] methods);

	public int getSysCompanyInfoCount(SysCompanyInfo companyInfo);

	public List<SysCompanyInfo> getSysCompanyInfoByPager(SysCompanyInfo companyInfo, Pager pager);
	
	public int getSysCompanyInfoCountForParam(SysCompanyInfo companyInfo);

	public List<SysCompanyInfo> getSysCompanyInfoByPagerForParam(SysCompanyInfo companyInfo, Pager pager);

	public List<SysMethodInfo> getSysCompanyMethodsByPk(long companyid);

	public SysCompanyInfo getSysCompanyInfoByPk(long pk);

	// 系统公告
	public List<SysMsg> getAllSystemMsg(SysMsg msg, Pager pager);

	public SysMsg getSystemMsgByid(long id);

	public int getSystemMsgCount(SysMsg msg);

	public SysMsg saveSystemMsg(SysMsg msg);

	public void delectSystemMsgByid(long[] id);

	// 系统帮助

	public List<SysHelp> getAllSystemHelp(SysHelp help, Pager pager);

	public SysHelp getSystemHelpByid(long id);

	public int getSystemHelpCount(SysHelp help);

	public SysHelp saveSystemHelp(SysHelp help);

	public void delectSystemHelpByid(long[] id);

	public List<SysCompanyInfo> getSysCompanyInfoByCode(String code, Long companyId);

	public List<SysCompanyInfo> getSysCompanyInfoByType(int type);

	public void updateSysCompanyInfo(SysCompanyInfo companyInfo, SysCompanyInfo systemInfo);

	public SysUserInfo getSysUserInfoByCompanyId(int cid);

	public void deleteSysCompanyInfoByPk(ServletContext context, long pk) throws Exception;

	public SysCompanyInfo editSysCompanyInfo(SysCompanyInfo info, String[] methods);

	public int getSysParamCount(SysParam param);

	public List<SysParam> getSysParamByPager(SysParam param, Pager pager);

	public SysParam saveSysParam(SysParam param);

	public SysParam getSysParamByPk(long pk);

	public void deleteSysParamByPk(long pk);

	public SysParam getSysParamByIndex(String index, int companyId);

	public List<SysParam> getAllSysParamByCompanyId(int companyId);

	public void updateSysparams(ArrayList<SysParam> list);

	public List<SysMsg> listAllSystemMsg();

	public int listLogCount(SysLog sysLog);

	public List<SysLog> getAllLog(SysLog sysLog, Pager pager);

	public HrmEmployee getEmployeeByPK(String employeePK);

	public List<SysParam> getSysparmByIdex(String task_name);

	public List<HrmEmployee> getEmployeeBycompanyId(Integer companyId);

	public int listSysExceptionCount(SysException sysException);

	public List<SysException> listAllSysException(SysException sysException, Pager pager);

	public SysException getSysExceptionByid(long id);

	public void delectSysExceptionsByid(long[] id);

	public void updateSysException(SysException sysException);

	public List<SysParam> getSysparmByIdexAndcompanyid(int companyId, String task_name);

	public void deleteSysLogByCommpanyid(long commpanyid);

	public int listEmployeeCount(HrmEmployee employee, long companyId);

	public List<HrmEmployee> getAllEmployee(HrmEmployee employee, long companyId, Pager pager);

	public HrmDepartment getDepartmentByID(Integer hrmEmployeeDepid);

	public HrmPost getEmployeeByPK(Integer hrmEmployeePostId);

	public List<SysConfig> listSysConfig();

	public void addSysConfig(SysConfig[] cons);
	
	public List<OnlineHrmEmployeeBean> getOnlineEmployee(HrmEmployee employee,long companyId, Pager pager);
	
	public int getOnlineEmployeeCount(HrmEmployee employee,long companyId);
	
	public List<SysMsg> listSystemMsgOrderBy(Pager pager);
	
	public SysCompanyInfo updateCompanyInfo(SysCompanyInfo company);
	
	//功能菜单
	public SysMethodInfo getSysMethodInfoByPK(String sid);
	public SysMethodInfo getSysMethodInfoByUri(String uri);
	public SysMethodInfo saveSysMethodInfo(SysMethodInfo info);
	public int getSysMethodInfoByLevelUnit(String levelUnit);
	public void deleteSysMethodInfoById(String sid);
	public boolean getCountBySysMethodInfoPK(String pk);//判断功能目录主键是否重复
	public int getSysMethodInfoByNameAndLevelUnit(String name,String levelunit,String PK);//根据上级目录和目录名称统计功能目录数量
	public List<SysMethodInfo> getSysMethodInfoListByPK(String pk);//根据节点查询下级信息

	//控制列名和显示
	public void deleteColumnControlById(long[] pks);
	public SysColumnControl saveColumnControl(SysColumnControl column);
	public SysColumnControl saveSysColumnControl(SysColumnControl sysColumnControl);
	public List<SysColumnControl> listAllSysColumnControl(SysColumnControl sysColumnControl);
	public List<SysColumnControl> listAllSysColumnControlPager(SysColumnControl sysColumnControl, Pager pager);
	public int listAllSysColumnControlCount(SysColumnControl sysColumnControl);
	public SysColumnControl getSysColumnControl(long pk);
	
	//标准代码
	public SysLibraryStandard getSysLibraryStandardByPk(long pk);
	public SysLibraryStandard getSysLibraryStandardByCode(String code);
	public SysLibraryStandard getSysLibraryStandardByCode(String code, Integer value);
	public List<SysLibraryStandard> getSysLibraryStandardInfo(SysLibraryStandard libraryInfo);
	public List<SysLibraryStandard> getSysLibraryStandardInfoPager(SysLibraryStandard libraryInfo, Pager pager);
	public int getSysLibraryStandardCount(SysLibraryStandard libraryInfo);
	public SysLibraryStandard saveSysLibraryStandard(SysLibraryStandard libraryInfo);
	public void deleteSysLibraryStandardByPks(long[] pks);
	public List<SysLibraryStandard> getDownSysLibraryStandardByCode(String libraryCode);
	public List<SysLibraryStandard> getDownSysLibraryStandardByCodeAll(String libraryCode);
	public int getDownSysLibraryStandardByCodeCount(String libraryCode);

	//帮助
	public int listSysMethodHelpCount(SysMethodHelp methodHelp);
	public List<SysMethodHelp> listSysMethodHelpByPager(SysMethodHelp methodHelp, Pager pager);
	public void deleteMethodHelpByIds(long[] pks);
	public SysMethodHelp saveSysMethodHelp(SysMethodHelp methodHelp);
	public SysMethodHelp getSysMethodHelpByPk(long pk);
	public List<SysMethodHelp> listSysMethodHelpByMethodId(String methodId);
	
	//快捷菜单
	public int listSysMethodShortcutCount(SysMethodShortcut sysMethodShortcut);
    public List<SysMethodShortcut> listSysMethodShortcut(SysMethodShortcut sysMethodShortcut, Pager pager);
    public List<SysMethodShortcut> listAllSysMethodShortcut(String employeeId);
    public SysMethodShortcut saveSysMethodShortcut(SysMethodShortcut sysMethodShortcut);
    public SysMethodShortcut getSysMethodShortcutByPk(long pk);
    public void deleteSysMethodShortcutByPks(long[] pks);
	public int checkSysMethodShortcut(String empId, String methodId);

	
}
