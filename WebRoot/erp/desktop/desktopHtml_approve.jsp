<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.eazytec.web.controller.dwr.DwrPersonalProcessSerivce"%>
<%@page import="com.eazytec.common.util.UtilTool"%>
<%@page import="com.eazytec.core.pojo.OaDesktopSet"%>
<%@page import="java.util.List"%>
<%@page import="com.eazytec.common.module.TaskTodoBean"%>
<%@page import="com.eazytec.common.util.file.properties.SystemConfig"%>
<%@page import="com.eazytec.common.util.EnumUtil"%>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0);
boolean showapprove = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Approve.value);
WebApplicationContext webcontext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
DwrPersonalProcessSerivce service = (DwrPersonalProcessSerivce)webcontext.getBean("dwrPersonalProcessSerivce");
String min = SystemConfig.getParam("erp.desktop.showMinRow");
String max = SystemConfig.getParam("erp.desktop.showMaxRow");
StringBuffer str = new StringBuffer();
Integer row = Integer.parseInt(min);

str.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
str.append("<DESKTOP>\n");
if(showapprove){
	str.append("<Approve><![CDATA[");
	str.append("<ul class='ulcss'>");
	OaDesktopSet depset = UtilTool.getDeskTopByType(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Approve.value);
	
	int tmpsize = 0;
	if(depset!=null){
		row = Integer.parseInt(depset.getOaDesktopValue()==null?min:depset.getOaDesktopValue());
		if(row<Integer.parseInt(min)){
			row = Integer.parseInt(min);
		}else if(row>Integer.parseInt(max)){
			row = Integer.parseInt(max);
		}
	}
	
	List<TaskTodoBean> list = service.listTaskTodo(this.getServletContext(),request,row);
	for(int i=0;i<list.size();i++){
		tmpsize++;
		TaskTodoBean bean = list.get(i);
		str.append("<li class='ullicss' style='text-indent: 3px;'>");
		str.append("<table width='100%'><tr>");
		str.append("<td>"+bean.getProcessDefinition().getName()+"</td>");
		str.append("<td>PID:"+bean.getTask().getProcessInstanceId()+"</td>");
		str.append("<td style='background:yellow;'>"+bean.getTask().getName()+"</td>");
		str.append("<td><span title=流程定义版本：" +bean.getProcessDefinition().getVersion()+ "><b>V:</b>"+bean.getProcessDefinition().getVersion()+"</span></td>");
		str.append("<td><a href=\"javascript:void(0);\" title=\"点击查看流程图\" onclick=\"showProcessTrace('"+bean.getTask().getProcessInstanceId()+"');\">跟踪</a></td>");
		
		if(bean.getStatus() == EnumUtil.TASK_TODO_STATUS.CLAIM.value){
			str.append("<td>"+EnumUtil.TASK_TODO_STATUS.valueOf(EnumUtil.TASK_TODO_STATUS.CLAIM.value)+"</td>");
		}
		
		str.append("</tr></table>");
		str.append("</li>");
	}
	
	if(tmpsize<Integer.parseInt(min)){
		int tp=Integer.parseInt(min)-tmpsize;
		for(int j=0;j<tp;j++){
			str.append("<li class='ullicss'><br/></li>");
		}
	}
	
	str.append("</ul>");
	str.append("]]></Approve>\n");
}
str.append("</DESKTOP>");
UtilTool.writeTextXml(response,str.toString());
%>