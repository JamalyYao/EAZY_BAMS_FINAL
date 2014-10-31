<%@ page pageEncoding="UTF-8" language="java"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.eazytec.web.controller.dwr.DwrSysProcessService"%>
<%@page import="com.eazytec.core.pojo.SysMethodInfo"%>
<%@page import="com.eazytec.common.util.UtilTool"%>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0);
String methodcode = request.getParameter("code");
String methodjs = request.getParameter("method");
if(methodcode == null||methodcode.length()==0){
	return;
}else{
	WebApplicationContext webAppContext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
	DwrSysProcessService sysService = (DwrSysProcessService)webAppContext.getBean("dwrSysProcessService");
	List<SysMethodInfo> methodlist = sysService.getSysMethodInfoByUpCode(methodcode);
	if(methodlist!=null&& methodlist.size()>0){
		StringBuffer sb = new StringBuffer();
		sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
		sb.append("<tree>\n");
		for(int i=0;i<methodlist.size();i++){
			SysMethodInfo md = methodlist.get(i);
			String tmp = "";
			String action ="";
			int row = sysService.getSysMethodInfoByUpCodeCount(md.getPrimaryKey());
			if(row>0){
				tmp ="src=\""+request.getContextPath()+"/erp/tree/sysmethods.jsp?code="+md.getPrimaryKey()+"&method="+methodjs+"\"";
			}
			if(methodjs!=null&&methodjs.length()>0){
				action = "action=\""+methodjs+"("+"'"+md.getPrimaryKey()+"'"+",'"+md.getMethodInfoName()+"');\"";
			}
			//输出树节点
			sb.append("<tree id =\""+md.getPrimaryKey()+"\" text=\""+md.getMethodInfoName()+"\" value=\""+md.getPrimaryKey()+"\" "+tmp+" "+action+"/>\n");
		}
		sb.append("</tree>");
		UtilTool.writeTextXml(response,sb.toString());
	}
}
%>
