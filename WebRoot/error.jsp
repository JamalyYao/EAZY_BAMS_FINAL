<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" isErrorPage="true"%>
<%@page import="java.util.List"%>
<%@page import="com.eazytec.core.pojo.SysMethodInfo"%>
<%@page import="com.eazytec.common.util.ConstWords"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.eazytec.core.iservice.ISysProcessService"%>
<%@page import="com.eazytec.common.module.SessionUser"%>
<%@page import="com.eazytec.common.util.LoginContext"%>
<%@page import="com.eazytec.core.pojo.SysException"%>
<%@page import="com.eazytec.common.util.UtilWork"%>
<%@page import="com.eazytec.common.util.UtilTool"%>
<html xmlns:v>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>错误页面</title>
<%
if(exception != null){
WebApplicationContext webAppContext = 
		WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
ISysProcessService sysProcessService = 
		(ISysProcessService)webAppContext.getBean("sysProcessService");

SessionUser sessionUser =(SessionUser)LoginContext.getSessionValueByLogin(request);
SysException sException =new SysException();
int userId =-1;
int companyId= -1;
if(sessionUser != null){
	userId = Integer.parseInt(sessionUser.getUserInfo().getPrimaryKey()+"");
	companyId = Integer.parseInt(sessionUser.getCompanyId()+"");
}
sException.setUserId(userId);
sException.setCompanyId(companyId);
sException.setExceptionClass(exception.getClass().getName());
sException.setExceptionDate(UtilWork.getNowTime());
sException.setExceptionMsg(exception.getMessage());
StringBuffer sb =new StringBuffer(); 
for(int i=0;i<exception.getStackTrace().length;i++){
	sb.append(exception.getStackTrace()[i]);
}
sException.setExceptionContext(sb.toString());
sysProcessService.saveSysException(sException);
}
%>
<style type="text/css">
tr,td{
	font-size: 12px
}
v\:*   {behavior:   url(#default#VML);}   
</style>
<%
String path=UtilTool.getProjectPath(request);
 %>
</head>
<body topMargin="20" style="font-size: 12px;FONT-FAMILY:Tahoma, 宋体">
<table cellpadding="0" cellspacing="0" width="100%" height="100%" border="0">
<tr>
<td align="center" valign="middle">
<v:RoundRect   style="position:relative;width:700;height:420;" strokecolor="#bbbbbb" arcsize='0.02' >   
<v:shadow   on="T"   type="single"   color="#c1c1c1"   offset="5px,5px" />  
<v:textbox>
<TABLE cellSpacing="5" width="90%" align="center" border="0" cepadding="0" style="line-height: 25px;">
  <TBODY>
  <TR colspan="2">
    <TD vAlign="top" align="middle"><IMG  border="0" id="errimg" src="<%=request.getContextPath()+"/images/404.png" %>"> 
    <TD>
    <TD>
      <H1  style="color: red;FONT-SIZE:20px; FONT-FAMILY: Tahoma, 宋体">操作错误</H1>
      <label style="color: #001150">
      HTTP 错误 404/500：<br/>您正在搜索的页面可能暂时不可用,也可能您的访问权限不够, <br/>
                           或者您在系统的认证已经过期，无法继续使用系统。
      </label>
      <HR noShade SIZE="0" color="#c1c1c1">
      <P>☉ <b>请尝试以下操作：</b></P>
      <UL>
        <LI>确保登陆并且有访问该页面的权限成功。 
        <LI>确保操作条件或内容的拼写和格式正确无误。 
        <LI>如果操作出现未知错误，请与网站管理员联系。 
        <LI>建议你尝试：<A href="javascript:void(0);" onclick="window.history.go(-1);"><FONT color="green">返回</FONT></A>&nbsp;&nbsp;或&nbsp;&nbsp;<A href="javascript:void(0);" onclick="forw();"><FONT color="green">重新登录</FONT></A></LI></UL>
      <P>
      <HR noShade SIZE=0 color="#c1c1c1">
      <p>☉ 如果您对系统有任何疑问、建议，请联系管理员 : <a href="mailto:service@eazytec.com"><font color="#336699">service@eazytec.com</font></a></p>
      <BR>
      &nbsp;&nbsp;&nbsp;<BR>
      </TD></TR></TBODY>
      </TABLE>
      </v:textbox>
      </v:RoundRect>
      </td>
</tr>
</table>
      <script type="text/javascript">
      function forw(){
      	var wp= window;
      	
      	if(wp.document.getElementById("mainframe")==null){
      		wp = window.parent;
      	}
      	if(wp.document.getElementById("mainframe")==null){
      		wp = window.parent.parent;
      	}
      	if(wp.document.getElementById("mainframe")==null){
      		wp = window.parent.parent.parent;
      	}
      	wp.document.location.href="<%=path%>";
      }
	  </script>
</body>
</html>