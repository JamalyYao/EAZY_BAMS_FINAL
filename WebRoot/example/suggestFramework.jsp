<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%
//项目相对及绝对路径
String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>输入提示</title>
<link type='text/css' rel='stylesheet' href='<%=contextPath %>/css/SuggestFramework.css' />
<script type="text/javascript" src="<%=contextPath %>/js/SuggestFramework.js"></script>
<script type="text/javascript">window.onload = initializeSuggestFramework;</script>
</head>
<body>

<input id="example1" name="example1" type="text" action="backend.html" columns="2" capture="2" /><br />
<input id="example2" name="example2" size="50" type="text" action="backend.html" columns="3" capture="1" />

</body>
</html>