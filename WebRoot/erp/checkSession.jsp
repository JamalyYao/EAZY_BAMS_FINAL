<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.eazytec.common.util.ConstWords"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业综合管理平台</title>
</head>
<body>
<%
if(request.getAttribute(ConstWords.TempCheckSession) == null){
	return;
}
Object[] obj=(Object[])request.getAttribute(ConstWords.TempCheckSession);
String path ="";
boolean bl =Boolean.parseBoolean(obj[0].toString());
if(bl == false){
	path=request.getContextPath()+"/login.jsp";
}else{
	path =obj[1].toString();
}
%>
<script type="text/javascript">
	window.onload =function(){
		if(<%=bl%>==false){
			alert("用户登录超时，请重新登录...");
		}
		window.parent.location="<%=path%>";
	}
</script>
</body>
</html>