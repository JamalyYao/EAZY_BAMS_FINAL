package com.eazytec.common.pack;

import com.eazytec.common.util.EnumUtil;
import com.eazytec.common.util.UtilWork;
import com.eazytec.core.pojo.HrmEmployee;
import com.eazytec.core.pojo.SysCompanyInfo;
import com.eazytec.core.pojo.SysParam;

/**
 * 系统后台设置
 * @author peng.ning
 * @date   Mar 4, 2010
 */
public class SystemPack {
	
	public static String getCompanySql(SysCompanyInfo companyInfo){
		StringBuffer result = new StringBuffer();
		HqlPack.getStringLikerPack(companyInfo.getCompanyInfoName(), "companyInfoName", result);
		HqlPack.getStringLikerPack(companyInfo.getCompanyInfoShortname(), "companyInfoShortname", result);
		HqlPack.getStringLikerPack(companyInfo.getCompanyInfoEmployee(), "companyInfoEmployee", result);
		HqlPack.timeBuilder(companyInfo.getCompanyInfoRegDate(), "companyInfoRegDate", result, false, true);
		HqlPack.getStringLikerPack(companyInfo.getCompanyInfoCode(), "companyInfoCode", result);
		HqlPack.timeBuilder(companyInfo.getCompanyInfoSdate(), "companyInfoSdate",result, false, false);
		HqlPack.timeBuilder(companyInfo.getCompanyInfoEdate(), "companyInfoEdate", result, false, false);
		HqlPack.getNumEqualPack(companyInfo.getCompanyInfoStatus(), "companyInfoStatus", result);
		HqlPack.getNumEqualPack(companyInfo.getCompanyInfoType(), "companyInfoType", result);
		if ("end".equalsIgnoreCase(companyInfo.getCompanyInfoContext())) {
			result.append(" and model.companyInfoEdate<='"+UtilWork.getToday()+"'");
			HqlPack.getNumEqualPack(EnumUtil.SYS_COMPANY_STATUS.TAKE.value, "companyInfoStatus", result);
			HqlPack.getInPack(EnumUtil.SYS_COMPANY_TYPE.TRIAL.value+","+EnumUtil.SYS_COMPANY_TYPE.OFFICIAL.value, "companyInfoType", result);
		}
		return result.toString();
	}
	
	public static String getCompanySqlForParam(SysCompanyInfo companyInfo){
		StringBuffer result = new StringBuffer();
		HqlPack.getStringLikerPack(companyInfo.getCompanyInfoName(), "companyInfoName", result);
		HqlPack.getStringLikerPack(companyInfo.getCompanyInfoShortname(), "companyInfoShortname", result);
		HqlPack.getStringLikerPack(companyInfo.getCompanyInfoEmployee(), "companyInfoEmployee", result);
		HqlPack.timeBuilder(companyInfo.getCompanyInfoRegDate(), "companyInfoRegDate", result, false, true);
		HqlPack.getStringLikerPack(companyInfo.getCompanyInfoCode(), "companyInfoCode", result);
		HqlPack.timeBuilder(companyInfo.getCompanyInfoSdate(), "companyInfoSdate",result, false, false);
		HqlPack.timeBuilder(companyInfo.getCompanyInfoEdate(), "companyInfoEdate", result, false, false);
		HqlPack.getNumEqualPack(companyInfo.getCompanyInfoStatus(), "companyInfoStatus", result);
		HqlPack.getInPack(EnumUtil.SYS_COMPANY_TYPE.TRIAL.value+","+EnumUtil.SYS_COMPANY_TYPE.OFFICIAL.value + "," + EnumUtil.SYS_COMPANY_TYPE.SYSTEM.value , "companyInfoType", result);
		result.append(" and model.companyInfoEdate >= '"+UtilWork.getToday()+"'");
		return result.toString();
	}
	
	public static String getSysParamSlq(SysParam param){
		StringBuffer result = new StringBuffer();
		HqlPack.getStringLikerPack(param.getParamIndex(), "paramIndex", result);
		HqlPack.getStringLikerPack(param.getParamTitle(), "paramTitle", result);
		HqlPack.getNumEqualPack(param.getParamType(), "paramType", result);
		HqlPack.getNumEqualPack(param.getCompanyId(), "companyId", result);
		return result.toString();
	}
	
	public static String packEmployeeQuery(HrmEmployee employee) {
       StringBuffer result = new StringBuffer();
       HqlPack.getStringLikerPack(employee.getHrmEmployeeName(), "hrmEmployeeName", result);
       HqlPack.getStringLikerPack(employee.getHrmEmployeeCode(), "hrmEmployeeCode", result);
       HqlPack.getNumEqualPack(employee.getHrmEmployeeSquadId(), "hrmEmployeeSquadId", result);
       HqlPack.getNumEqualPack(employee.getHrmEmployeeDepid(), "hrmEmployeeDepid", result);
       HqlPack.getInPack(employee.getHrmEmployeeDepidTree(), "hrmEmployeeDepid", result);
       HqlPack.getNumEqualPack(EnumUtil.SYS_ISACTION.Vaild.value, "hrmEmployeeActive", result);
       HqlPack.getNumEqualPack(employee.getCompanyId(), "companyId", result);
		return result.toString();
	}
}
