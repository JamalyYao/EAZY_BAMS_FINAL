<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.eazytec.core.pojo.SysMethodInfo"%>
<%@page import="com.eazytec.core.pojo.SysMethodShortcut"%>
<%@page import="com.eazytec.web.controller.dwr.DwrSysProcessService"%>
<%@page import="com.eazytec.common.util.EnumUtil"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.eazytec.web.controller.dwr.DwrPersonalProcessSerivce"%>
<%@page import="java.util.List"%>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0);
WebApplicationContext webcontext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
DwrSysProcessService service = (DwrSysProcessService)webcontext.getBean("dwrSysProcessService");
StringBuffer str = new StringBuffer();
str.append("<ul style='margin:0px;padding:0px;clear:both;'>");
List<SysMethodShortcut> list = service.listAllSysMethodShortcut(this.getServletContext(), request);
for(int i=0;i<list.size();i++){
	SysMethodShortcut shortcut = list.get(i);
    SysMethodInfo method = shortcut.getMethod();
    if(method != null){
	    String methodName = method.getMethodInfoName();
	    if(methodName.length() > 4){
	    	methodName = methodName.substring(0,4);
	    }
	    
	    String onclick = "";
	    if(StringUtils.isNotBlank(method.getMethodUri())){
	    	onclick = "onclick=\"openTabPage(\'"+request.getContextPath()+"/erp/"+method.getMethodUri()+"\')\"";
	    }
		str.append("<li id='"+shortcut.getPrimaryKey()+"' style='float:left;'>");
		str.append("<div onmouseover=\"changediv(this)\" onmouseout=\"changedivout(this);\" class=\"deskbtn\" "+onclick+">");
		str.append("<span style=\"background: url(\'"+request.getContextPath()+"/images/projectimg/"+method.getImageSrc()+"\') no-repeat 3px center;\">"+methodName+"</span>");
		str.append("</div>");
		str.append("</li>");
    }
}
str.append("</ul>");
response.setContentType("text/html; charset=UTF-8");
PrintWriter pw = response.getWriter();
pw.print(str.toString());
pw.flush();
pw.close();
%>
