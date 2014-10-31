package com.eazytec.common.pack;

import com.eazytec.common.util.ConstWords;
import com.eazytec.common.util.EnumUtil;
import com.eazytec.common.util.UtilWork;
import com.eazytec.core.pojo.HrmDepartment;
import com.eazytec.core.pojo.HrmEmployee;
import com.eazytec.core.pojo.HrmPost;
import com.eazytec.core.pojo.HrmWorkarea;
import com.eazytec.core.pojo.OaAdversaria;
import com.eazytec.core.pojo.OaAnnouncement;
import com.eazytec.core.pojo.OaNetdiskConfig;
import com.eazytec.core.pojo.OaNetdiskShare;
import com.eazytec.core.pojo.OaNotice;
import com.eazytec.core.pojo.SysColumnControl;
import com.eazytec.core.pojo.SysHelp;
import com.eazytec.core.pojo.SysLibraryInfo;
import com.eazytec.core.pojo.SysLibraryStandard;
import com.eazytec.core.pojo.SysMethodHelp;
import com.eazytec.core.pojo.SysMethodInfo;
import com.eazytec.core.pojo.SysMethodShortcut;
import com.eazytec.core.pojo.SysMsg;

public class HqlPack {
	
	/**
	 * 封装日期
	 * @param date 开始日期和结束日期，以逗号分隔（分为开始时间和结束时间）
	 * @param columnName HQL里对应的时间字段
	 * @param result 封装的HQL
	 * @param showTaday 如果没有开始时间和结束时间，是否查询当天时间，还是查询所有时间。true:查询当天时间，false:查询所有
	 * @param isShowTime 是否包含时分秒
	 */
	public static void timeBuilder( String date, String columnName, StringBuffer result, Boolean showTaday,boolean isShowTime) {
		if(date != null && date.trim().length() > 0){
			String[] time = date.split(",");
			if(time.length == 1){
				//只有开始日期，没有结束日期
				result.append(" and model." + columnName + " like '%" + time[0] + "%'");
			}else if (time.length == 2 && ((time[0] != null && time[0].trim().length() > 0) || (time[1] != null & time[1].trim().length() > 0))) {
				if (time[0] == null || time[0].trim().length() == 0) {
					time[0] = "1900-01-01";
				} else {
					time[0] = time[0].trim();
				}
				if (isShowTime && time[0].trim().length()<=11) {
					time[0]+= " 00:00:00";
				}
				if (time[1] == null || time[1].trim().length() == 0) {
					time[1] = "2100-01-01";
				} else {
					time[1] = time[1].trim();
				}
				if (isShowTime&& time[1].trim().length()<=11) {
					time[1]+= " 23:59:59";
				}
				result.append(" and model." + columnName + " between '" + time[0] + "' and '" + time[1] + "'");
			} else {
				if (showTaday) {
					if (isShowTime) {
						result.append(" and model." + columnName + " between '" + UtilWork.getToday() + " 00:00:00' and '" + UtilWork.getToday() + " 23:59:59'");
					}else{
						result.append(" and model." + columnName + " between '" + UtilWork.getToday() + "' and '" + UtilWork.getToday() + "'");
					}
					
				}
			}
		}
	}
	

	/**
	 * 封装String对象成like语句
	 * @param str 对象值
	 * @param columnName 列名
	 * @param result 
	 */
	public static void getStringLikerPack(String str,String columnName, StringBuffer result) {
		if (str != null && str.trim().length() > 0) {
			result.append(" and model."+columnName+" like '%" + str + "%'");
		}
	}
	
	/**
	 * 封装String对象成like语句(右侧模糊)
	 * @param str 对象值
	 * @param columnName 列名
	 * @param result 
	 */
	public static void getStringRightLikerPack(String str,String columnName, StringBuffer result) {
		if (str != null && str.trim().length() > 0) {
			result.append(" and model."+columnName+" like '" + str + "%'");
		}
	}
	
	/**
	 * 封装String对象成like语句(左侧模糊)
	 * @param str 对象值
	 * @param columnName 列名
	 * @param result 
	 */
	public static void getStringLeftLikerPack(String str,String columnName, StringBuffer result) {
		if (str != null && str.trim().length() > 0) {
			result.append(" and model."+columnName+" like '%" + str + "'");
		}
	}
	
	/**
	 * 封装String对象成equal语句
	 * @param str 对象值
	 * @param columnName 列名
	 * @param result 
	 */
	public static void getStringEqualPack(String data,String columnName, StringBuffer result) {
		if(data != null && data.trim().length() > 0){
			result.append(" and model."+columnName+" = '" + data + "'");
		}
	}
	
	/**
	 * 封装long或者int的整数对象成equal语句
	 * @param str 对象值
	 * @param columnName 列名
	 * @param result 
	 */
	public static void getNumEqualPack(Object data,String columnName, StringBuffer result) {
		if(data!=null&&Long.parseLong(data.toString()) > 0){
			result.append(" and model."+columnName+" = " + data + "");
		}
	}
	
	/**
	 * 封装long或者int的整数对象成equal语句
	 * @param str 对象值
	 * @param columnName 列名
	 * @param result 
	 */
	public static void getNumEqualPack(Object data,String columnName, StringBuffer result,Integer expvalue) {
		if(data!=null&&Long.parseLong(data.toString()) > (long)expvalue){
			result.append(" and model."+columnName+" = " + data + "");
		}
	}
	
	/**
	 * 封装long或者int的整数对象成equal语句(不等于)
	 * @param str 对象值
	 * @param columnName 列名
	 * @param result 
	 */
	public static void getNumNOEqualPack(Object data,String columnName, StringBuffer result) {
		if(data!=null){
			result.append(" and model."+columnName+" <> " + data + "");
		}
	}
	
	/**
	 * 封装in查询语句
	 * @param data
	 * @param columnName
	 * @param result
	 */
	public static void getInPack(String data,String columnName, StringBuffer result){
		if (data!=null&&data.trim().length()>0) {
			result.append(" and model."+columnName+" in ( "+ data+ " )");
		}
	}
	
	/**
	 * 封装in String查询语句
	 * @param data
	 * @param columnName
	 * @param result
	 */
	public static void getInPackString(String data,String columnName, StringBuffer result){
		if (data!=null&&data.trim().length()>0) {
		String[] dataArray = data.substring(0, data.length()-1).split(",");
		data="";
		for (int i = 0 ; i < dataArray.length ;i++) {
			if(i ==  dataArray.length -1){
				data += "'" + dataArray[i] + "'";
			}else{
				data += "'" + dataArray[i] + "',";
			}
		}
		result.append(" and model."+columnName+" in ( "+ data+ " )");
		}
	}
	
	/**
	 * 封装not in查询语句
	 * @param data
	 * @param columnName
	 * @param result
	 */
	public static void getNotInPack(String data,String columnName, StringBuffer result){
		if (data!=null&&data.trim().length()>0) {
			result.append(" and model."+columnName+" not in ( "+ data+ " )");
		}
	}
	
	public static void getCheckStrInArr(String data,String columnName,StringBuffer result){
		if (data!=null&&data.trim().length()>0) {
//			result.append(" and CheckStrInArr('"+data+"',model."+columnName+")>0 ");
			result.append(" and INSTR(model."+columnName+",'"+data+"')>0 ");
		}
	}
	
	/**
	 * 查询人员信息
	 * @param employee 
	 * @param l   公司主键
	 * @return
	 */
	public static String packEmployeeQuery(HrmEmployee employee, long l) {
		StringBuffer result = new StringBuffer();
		
		getStringEqualPack(employee.getPrimaryKey(),"primaryKey", result);
		getStringLikerPack(employee.getHrmEmployeeName(),"hrmEmployeeName", result);
		getStringLikerPack(employee.getHrmEmployeeCode(),"hrmEmployeeCode", result);
		timeBuilder(employee.getHrmEmployeeBirthday(),"hrmEmployeeBirthday",result,false,false);
		timeBuilder(employee.getHrmEmployeeInTime(),"hrmEmployeeInTime",result,false,false);
		getNumEqualPack(employee.getHrmEmployeeSex(), "hrmEmployeeSex", result);
		getNumEqualPack(employee.getHrmEmployeeDepid(), "hrmEmployeeDepid", result);
		getNumEqualPack(employee.getHrmEmployeeActive(), "hrmEmployeeActive", result);
		getNumEqualPack(l, "companyId", result);
		getInPackString(employee.getEmployeeIds(), "primaryKey", result);
		getInPack(employee.getHrmEmployeeDepidTree(), "hrmEmployeeDepid", result);
		return result.toString();
	}
	
	/**
	 * 在线人员
	 * @param employee
	 * @param l
	 * @return
	 */
	public static String packOnLineEmployeeQuery(HrmEmployee employee, long l){
		StringBuffer result = new StringBuffer();
		result.append("select emp.hrm_employee_id,emp.hrm_employee_code,emp.hrm_employee_name,dept.hrm_dep_name,emp.hrm_employee_sex,emp.hrm_employee_image_info_id from hrm_employee emp,hrm_department dept where emp.hrm_employee_depid = dept.dep_id");
		SqlPack.getNumEqualPack(l, "emp.company_id", result);
		SqlPack.getInPack(employee.getHrmEmployeeDepidTree(), "dept.dep_id", result);
		SqlPack.getStringLikerPack(employee.getHrmEmployeeName(), "emp.hrm_employee_name", result);
		SqlPack.getStringLikerPack(employee.getHrmEmployeeCode(), "emp.hrm_employee_code", result);
		SqlPack.getNumEqualPack(employee.getHrmEmployeeSex(), "emp.hrm_employee_sex", result);
		SqlPack.getInPack(employee.getEmployeeIds(), "emp.hrm_employee_id", result);
		SqlPack.getNumNOEqualPack(employee.getHrmEmployeeStatus(), "emp.hrm_employee_status", result);
		SqlPack.getNumEqualPack(employee.getHrmEmployeeActive(), "emp.hrm_employee_active", result);
		if (employee.getPrimaryKey()!=null&&employee.getPrimaryKey().length()>0) {
			result.append(" and emp.hrm_employee_id <>'"+employee.getPrimaryKey()+"'");
		}
		return result.toString();
	}
	
	/**
	 *  查询部门信息
	 * @param department
	 * @param c 公司主键
	 * @return
	 */
	public static String packDepartmentQuery(HrmDepartment department,long c) {
		StringBuffer result = new StringBuffer();
		getStringLikerPack(department.getHrmDepCode(),"hrmDepCode", result);
		getStringLikerPack(department.getHrmDepName(),"hrmDepName", result);
		getStringLikerPack(department.getHrmDepEngname(),"hrmDepEngname", result);
		getStringEqualPack(department.getHrmDepUpid(), "hrmDepUpid", result);
		getNumEqualPack(department.getHrmEmpId(), "hrmEmpId", result);
		getNumEqualPack(c, "companyId", result);
		return result.toString();
	}
	
	
	/**
	 * 查询页面显示列查询
	 * @param sysColumnControl
	 * @return
	 */
	public static String packSysColumnControlQuery(SysColumnControl sysColumnControl) {
		StringBuffer result = new StringBuffer();
		
		getNumEqualPack(sysColumnControl.getPrimaryKey(),"primaryKey",result);
		getNumEqualPack(sysColumnControl.getIsShow(),"isShow",result);
		getStringLikerPack(sysColumnControl.getTableName(),"tableName",result);
		getStringLikerPack(sysColumnControl.getColumnName(),"columnName",result);
		getStringLikerPack(sysColumnControl.getColumnCode(),"columnCode",result);
		result.append(" order by model.tableName,model.priority asc");
		return result.toString();
	}
	
	/**
	 * 查询页面显示列查询
	 * @param sysColumnControl
	 * @return
	 */
	public static String packSysColumn(SysColumnControl sysColumnControl) {
		StringBuffer result = new StringBuffer();

		getNumEqualPack(sysColumnControl.getPrimaryKey(),"primaryKey",result);
		getNumEqualPack(sysColumnControl.getIsShow(),"isShow",result);
		getStringEqualPack(sysColumnControl.getTableName(),"tableName",result);
		getStringEqualPack(sysColumnControl.getColumnName(),"columnName",result);
		getStringEqualPack(sysColumnControl.getColumnCode(),"columnCode",result);
		result.append(" order by model.priority asc");	
		return result.toString();
	}
	
	/**
	 * 系统目录管理
	 * @param sysMethodInfo
	 * @return
	 */
	public static String packSysMethodInfo(SysMethodInfo info) {
		StringBuffer result = new StringBuffer();
		HqlPack.getStringLikerPack(info.getPrimaryKey(), "primaryKey", result);
		HqlPack.getStringLikerPack(info.getMethodInfoName(), "methodInfoName", result);
		HqlPack.getStringLikerPack(info.getMethodInfoEngname(), "methodInfoEngname", result);
		getNumEqualPack(info.getMethodLevel(), "methodLevel", result, -2);
		HqlPack.getNumEqualPack(info.getIsAction(), "isAction", result);
		HqlPack.getNumEqualPack(info.getIsDefault(), "isDefault", result);
		HqlPack.getNumEqualPack(info.getMethodNo(), "methodNo", result);
		HqlPack.getStringRightLikerPack(info.getLevelUnit(), "levelUnit", result);
		return result.toString();
	}

	
	
	/**
	 * 取得下级菜单
	 * @param code 上级编码
	 * @param level 等级
	 * @param bl 是否取得系统菜单
	 * @return
	 */
	public static String packSysMethodInfoByTree(String code,boolean bl){
		StringBuffer result = new StringBuffer();
		getStringEqualPack(code, "levelUnit", result);
		if (bl) {
			getStringRightLikerPack(ConstWords.SystemMethodInfoSign, "primaryKey", result);
		}else{
			result.append(" and model.primaryKey not like '"+ConstWords.SystemMethodInfoSign+"%' ");			
		}
		getNumNOEqualPack(-1, "methodNo", result);
		getNumEqualPack(EnumUtil.SYS_ISACTION.Vaild.value, "isAction", result);
		return result.toString();
	}
	
	/**
	 * 业务字典表查询
	 * @param library
	 * @return
	 */
	public static String packSysLibraryInfo(SysLibraryInfo library){
		StringBuffer result = new StringBuffer();
		getStringEqualPack(library.getLibraryInfoCode(), "libraryInfoCode", result);
		getStringLikerPack(library.getLibraryInfoName(), "libraryInfoName", result);
		getStringEqualPack(library.getLibraryInfoUpcode(), "libraryInfoUpcode", result);
		getNumEqualPack(library.getLibraryInfoIsedit(), "libraryInfoIsedit",result);
		getNumEqualPack(library.getLibraryInfoIsvalid(), "libraryInfoIsvalid",result);
		getNumEqualPack(library.getCompanyId(), "companyId",result);
		return result.toString();
	}
	
	/**
	 * 标准代码表查询
	 * @param library
	 * @return
	 */
	public static String packSysLibraryStandardInfo(SysLibraryStandard library){
		StringBuffer result = new StringBuffer();
		getStringEqualPack(library.getLibraryCode(), "libraryCode", result);
		getStringLikerPack(library.getLibraryName(), "libraryName", result);
		getStringEqualPack(library.getLibraryUpcode(), "libraryUpcode", result);
		getStringLikerPack(library.getLibraryDesc(), "libraryDesc", result);
		result.append(" order by model.libraryCode asc");
		return result.toString();
	}
	
    /**
     * 岗位查询条件
     * @param hrmPost
     * @param companyId      公司主键
     * @return
     */
	public static String packPostQuery(HrmPost hrmPost, int companyId) {
		StringBuffer result = new StringBuffer();
		getStringEqualPack(hrmPost.getHrmPostId(), "hrmPostId", result);
		getStringLikerPack(hrmPost.getHrmPostName(), "hrmPostName", result);
		getStringLikerPack(hrmPost.getHrmPostEngname(), "hrmPostEngname", result);
		getStringEqualPack(hrmPost.getHrmPostUpid(), "hrmPostUpid", result);
		getNumEqualPack(hrmPost.getCompanyId(), "companyId",result);
		return result.toString();
	}
    
	/**
	 * 查询公告条件
	 * @param announcement
	 * @param companyId      公司主键
	 * @return 
	 */
	public static String packAnnouncementQuery(OaAnnouncement announcement, long companyId) {
		StringBuffer result = new StringBuffer();
		result.append("select announcement.* from OA_ANNOUNCEMENT announcement,hrm_employee emp where announcement.oa_anno_emp = emp.hrm_employee_id and announcement.company_id = emp.company_id");
		
		SqlPack.getStringLikerPack(announcement.getOaAnnoName(), "announcement.oa_anno_name", result);
		SqlPack.getNumEqualPack(announcement.getOaAnnoType(), "announcement.oa_anno_type", result);
		if(announcement.getEmployee() != null){
			SqlPack.getStringLikerPack(announcement.getEmployee().getHrmEmployeeName(), "emp.hrm_employee_name", result);
		}
		if(announcement.getOaAnnoEmp() != null && announcement.getOaAnnoEmp().length() > 0){
			SqlPack.getStringEqualPack(announcement.getOaAnnoEmp(), "announcement.oa_anno_emp", result);
		}
		SqlPack.timeBuilder(announcement.getOaAnnoTime(),"announcement.oa_anno_time",result,false,false);
		SqlPack.getNumEqualPack(announcement.getOaAnnoType(), "announcement.oa_anno_type",result);
		SqlPack.getNumEqualPack(announcement.getOaAnnoStatus(), "announcement.oa_anno_status",result);
		SqlPack.getNumEqualPack(announcement.getOaAnnoLevel(), "announcement.oa_anno_level",result);
		SqlPack.getNumEqualPack(companyId, "announcement.company_id",result);
		return result.toString();
	}
	
	/**
	 * 查询通知条件
	 * @param notice
	 * @param companyId   公司主键
	 * @return
	 */
	public static String packNoticeQuery(OaNotice notice, long companyId) {
		StringBuffer result = new StringBuffer();
		result.append("select notice.* from OA_NOTICE notice,hrm_employee emp where notice.oa_noti_emp = emp.hrm_employee_id and notice.company_id = emp.company_id");
		
		SqlPack.getStringLikerPack(notice.getOaNotiName(), "notice.oa_noti_name", result);
		SqlPack.getNumEqualPack(notice.getOaNotiType(), "notice.oa_noti_type", result);
		
		if(notice.getEmployee() != null){
			SqlPack.getStringLikerPack(notice.getEmployee().getHrmEmployeeName(), "emp.hrm_employee_name", result);
		}
		if(notice.getOaNotiEmp() != null && notice.getOaNotiEmp().length() > 0){
			SqlPack.getStringEqualPack(notice.getOaNotiEmp(), "notice.oa_noti_emp", result);
		}
		
		if(notice.getOaObjDep() != null || notice.getOaObjEmp() != null){
//			result.append(" and (CheckStrInArr('"+notice.getOaObjDep()+"',notice.oa_obj_dep)>0 or notice.oa_obj_emp like '%"+notice.getOaObjEmp()+"%')");
			result.append(" and (INSTR(notice.oa_obj_dep,'"+notice.getOaObjDep()+"')>0 or notice.oa_obj_emp like '%"+notice.getOaObjEmp()+"%')");
	
		}
		
		SqlPack.timeBuilder(notice.getOaNotiTime(),"notice.oa_noti_time",result,false,false);
		SqlPack.getNumEqualPack(notice.getOaNotiStatus(), "notice.oa_noti_status",result);
		SqlPack.getNumEqualPack(companyId, "notice.company_id",result);
		return result.toString();
	}
	
	/**
	 * 查询公司记事条件
	 * @param adversaria
	 * @param companyId   公司主键
	 * @return
	 */
	public static String packAdversariaQuery(OaAdversaria adversaria, long companyId) {
		StringBuffer result = new StringBuffer();
		result.append("select adversaria.* from OA_ADVERSARIA adversaria,hrm_employee emp where adversaria.oa_adver_emp = emp.hrm_employee_id and adversaria.company_id = emp.company_id");
		
		SqlPack.getStringLikerPack(adversaria.getOaAdverTitle(), "adversaria.oa_adver_title", result);
		SqlPack.getNumEqualPack(adversaria.getOaAdverLevel(), "adversaria.oa_adver_level", result);
		if(adversaria.getEmployee() != null){
		        SqlPack.getStringLikerPack(adversaria.getEmployee().getHrmEmployeeName(), "emp.hrm_employee_name", result);
		}
		if(adversaria.getOaAdverEmp() != null && adversaria.getOaAdverEmp().length()>0){
			SqlPack.getStringEqualPack(adversaria.getOaAdverEmp(), "adversaria.oa_adver_emp", result);
		}
		SqlPack.timeBuilder(adversaria.getOaAdverTime(),"adversaria.oa_adver_time",result,false,false);
		SqlPack.getNumEqualPack(adversaria.getOaAdverStatus(), "adversaria.oa_adver_status",result);
		SqlPack.getNumEqualPack(companyId, "adversaria.company_id",result);
		return result.toString();
	}

    /**
     * 查询工作区域
     * @param workarea
     * @return
     */
	public static String packWorkareaQuery(HrmWorkarea workarea) {
        StringBuffer result = new StringBuffer();
		getStringLikerPack(workarea.getHrmAreaName(), "hrmAreaName", result);
		getStringLikerPack(workarea.getHrmAreaEngname(), "hrmAreaEngname", result);
		getNumEqualPack(workarea.getCompanyId(), "companyId", result);
		
		return result.toString();
	}

    /**
     * 查询人员（sql查询）
     * @param employee
     * @return
     */
	public static String getEmployeeSql(HrmEmployee employee) {
		StringBuffer result = new StringBuffer();
		result.append("select emp.* from hrm_employee emp ");
		if(employee.getHrmEmployeeDepidTree() != null && employee.getHrmEmployeeDepidTree().length()>0){
			  result.append(" , hrm_department dep");
           if(employee.getHrmEmployeePostId() != null && employee.getHrmEmployeePostId()>0){
        	   result.append(" , hrm_post post"); 
        	   result.append(" where emp.hrm_employee_depid = dep.dep_id and dep.dep_id in ("+employee.getHrmEmployeeDepidTree()+") ");
        	   result.append(" and post.post_id = emp.hrm_employee_post_id and emp.hrm_employee_post_id ="+employee.getHrmEmployeePostId());  
        	   if (employee.getHrmPartPost()!=null&&employee.getHrmPartPost().length()>0) {
        		   result.append(" or emp.hrm_part_post like '%"+employee.getHrmPartPost()+"%' ");
        		   SqlPack.getCheckStrInArr(employee.getHrmPartPost(), "emp.hrm_part_post", result);
        	   }
        	   
           }else{
        	   result.append(" where emp.hrm_employee_depid = dep.dep_id and dep.dep_id  in ("+employee.getHrmEmployeeDepidTree()+") ");
           }
		
		}else{
			if(employee.getHrmEmployeePostId() != null && employee.getHrmEmployeePostId()>0 ){
        	   result.append(" , hrm_post post"); 
        	   result.append(" where post.post_id = emp.hrm_employee_post_id and emp.hrm_employee_post_id ="+employee.getHrmEmployeePostId()); 
        	   if (employee.getHrmPartPost()!=null&&employee.getHrmPartPost().length()>0) {
        		   result.append(" or emp.hrm_part_post like '%"+employee.getHrmPartPost()+"%' ");
        		   SqlPack.getCheckStrInArr(employee.getHrmPartPost(), "emp.hrm_part_post", result);
        	   }
			}else{
        	   result.append(" where 1=1 ");
           }
		}
		
		if(employee.getHrmEmployeeName() != null && employee.getHrmEmployeeName().length()>0){
			result.append(" and emp.hrm_employee_name like '%"+employee.getHrmEmployeeName()+"%' ");
		}
		if(employee.getHrmEmployeeCode() != null && employee.getHrmEmployeeCode().length()>0){
			result.append(" and emp.hrm_employee_code like '%"+employee.getHrmEmployeeCode()+"%' ");
		}
		if (employee.getCompanyId()!=null && employee.getCompanyId()>0) {
			result.append(" and emp.company_id = "+employee.getCompanyId()+"");
		}
		result.append(" and emp.hrm_employee_active ="+EnumUtil.SYS_ISACTION.Vaild.value);
		return result.toString();
	}
	
	/**
	 * 查询系统公告
	 * @param msg   
	 * @return
	 */
	public static String packSysMsgQuery(SysMsg msg) {
		StringBuffer result = new StringBuffer();
		
		getStringLikerPack(msg.getMsgTitle(), "msgTitle", result);
		timeBuilder(msg.getMsgDate(), "msgDate", result, false, false);
		timeBuilder(msg.getMsgVsdate(), "msgVsdate", result, false, false);
		timeBuilder(msg.getMsgVedate(), "msgVedate", result, false, false);
		return result.toString();
	}
	
	/**
	 * 查询系统帮助
	 * @param msg   
	 * @return
	 */
	public static String packSysHelpQuery(SysHelp help) {
		StringBuffer result = new StringBuffer();
		
		getStringLikerPack(help.getHelpKeyword(), "helpKeyword", result);
		getStringLikerPack(help.getHelpTitle(), "helpTitle", result);
		getStringLikerPack(help.getFindSign(), "findSign", result);
		getStringRightLikerPack(help.getMethodCode(), "methodCode", result);
		return result.toString();
	}
	
	/**
	 * 查询网络磁盘共享
	 * @param msg   
	 * @return
	 */
	public static String packNetdiskShare(OaNetdiskShare oaNetdiskShare,String empid,String deptid) {
		StringBuffer result = new StringBuffer();
		getNumEqualPack(oaNetdiskShare.getCompanyId(), "companyId", result);
		getStringEqualPack(oaNetdiskShare.getFolderPath(), "folderPath", result);
		getStringEqualPack(oaNetdiskShare.getHrmEmployeeId(), "hrmEmployeeId", result);
//		result.append(" and model.folderPath like '"+oaNetdiskShare.getFolderPath()+"%'");
//		result.append(" and ( model.netdiskEmps like '%"+empid+"%' or CheckStrInArr('"+deptid+"', model.netdiskDeps)>0) ");
		result.append(" and ( model.netdiskEmps like '%"+empid+"%' or INSTR(model.netdiskDeps,'"+deptid+"')>0) ");

		return result.toString();
	}
	
	/**
	 * 查询网络磁盘共享, by folder path
	 * @param msg   
	 * @return
	 */
	public static String packNetdiskShareByFolderPath(OaNetdiskShare oaNetdiskShare) {
		StringBuffer result = new StringBuffer();
		getNumEqualPack(oaNetdiskShare.getCompanyId(), "companyId", result);
		getStringEqualPack(oaNetdiskShare.getHrmEmployeeId(), "hrmEmployeeId", result);
		result.append(" and model.folderPath like '"+oaNetdiskShare.getFolderPath()+"%'");
		return result.toString();
	}
	
	/**
	 *  查询磁盘使用人
	 * @param OaNetdisk
	 * @return
	 */
	public static String packOaNetdiskQuery(OaNetdiskConfig OaNetdisk) {
		StringBuffer result = new StringBuffer();
		result.append("select  distinct hrm_employee_id from hrm_employee where hrm_employee_id not in(select hrm_employee_id from OA_NETDISK_CONFIG)");
		SqlPack.getNumEqualPack(OaNetdisk.getCompanyId(), "company_id", result);
		return result.toString();
	}

	/**
	 * 网络磁盘
	 * @param OaNetdisk
	 * @return
	 */
	public static String packNetdisksQuery(OaNetdiskConfig OaNetdisk) {
		StringBuffer result = new StringBuffer();
		result.append("select distinct employee.hrm_employee_code,netdisk.* from hrm_employee employee,OA_NETDISK_CONFIG netdisk,HRM_DEPARTMENT department where netdisk.hrm_employee_id=employee.hrm_employee_id and employee.hrm_employee_depid =department.dep_id");
		if (OaNetdisk.getHrmEmployee()!=null) {
			SqlPack.getInPack(OaNetdisk.getHrmEmployee().getHrmEmployeeDepidTree(), "department.dep_id", result);
			SqlPack.getStringLikerPack(OaNetdisk.getHrmEmployee().getHrmEmployeeName(), "employee.hrm_employee_name", result);
			SqlPack.getStringLikerPack(OaNetdisk.getHrmEmployee().getHrmEmployeeCode(), "employee.hrm_employee_code", result);
		}
		SqlPack.getNumEqualPack(OaNetdisk.getCompanyId(),"netdisk.company_id",result);
		
		return result.toString();
	}
	
	/**
	 * 网络磁盘配置
	 * @param oaNetdisk
	 * @return
	 */
	public static String packNetdiskConfigQuery(OaNetdiskConfig oaNetdisk) {
		StringBuffer result = new StringBuffer();
		result
				.append("select distinct model.* from  OA_NETDISK_CONFIG model where model.hrm_employee_id='"
						+ oaNetdisk.getHrmEmployeeId()
						+ "' and model.company_id='" + oaNetdisk.getCompanyId()+"'");
		return result.toString();
	}

	public static String packSysMethodHelp(SysMethodHelp methodHelp) {
		
		StringBuffer result = new StringBuffer();
		result.append("select help.* from sys_method_help help,sys_method_info info where help.method_id = info.method_info_id ");
		SqlPack.getStringLikerPack(methodHelp.getMethodName(), "info.method_info_name", result);
		
		return result.toString();
	}
	
	public static String packSysMethodShortcutQuery(SysMethodShortcut sysMethodShortcut){
      StringBuffer result = new StringBuffer();
      return result.toString();
   }
}