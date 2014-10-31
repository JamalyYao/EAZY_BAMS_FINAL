<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.eazytec.core.pojo.SysMethodInfo"%>
<%@page import="com.eazytec.common.util.ConstWords"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.eazytec.web.controller.dwr.DwrSysProcessService"%>
<%@page import="com.eazytec.core.pojo.SysMsg"%>
<%@page import="com.eazytec.common.util.UtilWork"%>
<%@page import="com.eazytec.common.util.EnumUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帮助中心</title>
<%
List<SysMethodInfo> methodsList = (List<SysMethodInfo>)application.getAttribute(ConstWords.ServletContext_Method);
WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
DwrSysProcessService service = (DwrSysProcessService)context.getBean("dwrSysProcessService");
List<SysMsg> msglist = service.listAllSysMsg(this.getServletContext(),request,6);
 %>
</head>
<body style="text-align: center;">
<jsp:include page="help_top.jsp" flush="true">
<jsp:param value="1" name="choose"/>
</jsp:include>
<center>
<table width="950" cellpadding="1" cellspacing="3" border="0">
<tr>
<td width="640" valign="top" align="left">
<!-- 
<div>
<img src="<%=request.getContextPath() %>/images/helpimg/" border="0">
</div>
 -->
<%
if(methodsList!=null && methodsList.size()>0){
 %>
	<table>
	<%
	String name="";
	String msg ="";
	String imgpath="";
	for(int i=0;i<methodsList.size();i++){
		SysMethodInfo sysMethod =methodsList.get(i);
		name = sysMethod.getMethodInfoName();
		msg =sysMethod.getMethodMsg();
		imgpath = sysMethod.getImageSrc();
	 %>
	 <tr>
	 	<td width="30" height="40">
	 		<img src="<%=request.getContextPath()+"/images/projectimg/"+imgpath%>"/>
	 	</td>
	 	<td>
	 		<%=name %>
	 	</td>
	 	<td>
	 		<label style="padding-left:50px;color:#808080;font-size:12px;"><%=msg %></label>
	 	</td>
	 </tr>
	<%} %>
</table>
<%} %>
</td>
<td width="310" valign="top" align="left">
	<div style="border:1px solid #E3E3E3;height:40px;line-height:45px;background-color:#F3F3F3">
	<label style="font-size:14px;font-weight:bold;color:#1F427A;float:left;padding-left:15px">系统公告</label>
	<a style="color:#666666;font-size:14px;float:right;padding-right:15px;" href="help_msg.jsp">更多>></a>
	</div>
	<div style="line-height: 30px;text-align: left;background-color:#f9f9f9;border:1px solid #E3E3E3;border-top: 0px ">
	<ul style="list-style:none;padding:0px;margin:0px;text-align:left;">
		<%
		int len = msglist.size();
		if(len==0){
		%>
		<li style="border-bottom: 1px dotted #dddddd;">
		<label style="padding-left: 5px" title="发布日期"><%=UtilWork.getToday()%></label>&nbsp;&nbsp;&nbsp;&nbsp;
		 暂无系统公告
		</li>
		<%}else{ %>
		<%for(int i=0;i<len;i++){
			String col="#336699";
			String ct ="";
			SysMsg tm = msglist.get(i);
			if(tm.getMsgIsEffective() == EnumUtil.SYS_ISACTION.No_Vaild.value){
				col ="red";
				ct = "已过期公告 : ";
			}
		%>
		<li style="border-bottom: 1px dotted #dddddd;">
			<label style="padding-left: 5px" title="发布日期"><%=tm.getMsgDate()%></label>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#" style="color:<%=col %>" title="<%=ct+tm.getMsgTitle()%>"><%=tm.getMsgTitle()%></a>
		</li>
		<%}} %>
		
		<%
		for(int i=0;i<6-len;i++){
		%>
		<li style="border-bottom:1px dotted #dddddd">&nbsp;</li>
		<%} %>
	</ul>
	</div>
	<br/>
	<div style="border: 1px solid #E3E3E3;height: 40px;line-height: 45px;background-color: #F3F3F3">
	<label style="font-size: 14px;font-weight: bold;color: #1F427A;float: left;padding-left: 15px">常见问题</label>
	<a style="color:#666666;font-size: 14px;float: right;padding-right: 15px;" href="help_error.jsp">更多>></a>
	</div>
	<div style="line-height: 30px;text-align: left;background-color:#f9f9f9;border:1px solid #E3E3E3;border-top-width: 0px ">
	<ul style="list-style:none;padding:0px;margin:0px;">
		<%
		int el = 0;
		if(el==0){
		%>
		<li style="border-bottom:1px dotted #dddddd;">
		<label style="padding-left: 5px" title="发布日期"><%=UtilWork.getToday()%></label>&nbsp;&nbsp;&nbsp;&nbsp;
		 暂无常见问题
		</li>
		<%} %>
		<%for(int i=0;i<6-el;i++){%>
		<li style="border-bottom:1px dotted #dddddd;">&nbsp;</li>
		<%} %>
	</ul>
	</div>
</td>
</tr>
<tr>
<td colspan="2">
<hr size="1" color="#e3e3e3">
</td>
</tr>
</table>
</center>
<%@ include file="../Copyright.jsp" %>
</body>
</html>