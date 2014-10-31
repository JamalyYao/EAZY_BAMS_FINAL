<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帮助中心</title>
<%
String ch = request.getParameter("choose");
String type = request.getParameter("type");
String id = request.getParameter("id");
%>
</head>
<body>
<jsp:include page="help_top.jsp?choose=<%=ch %>" flush="true"></jsp:include>
<br/>
<center>
<div style="width: 950px;height:500px;border: 1px solid #333333">
帮助首页内容区域
</div>
</center>
<%@ include file="../Copyright.jsp" %>
</body>
</html>