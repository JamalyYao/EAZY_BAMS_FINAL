<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帮助中心</title>
</head>
<body>
<jsp:include page="help_top.jsp" flush="true">
	<jsp:param value="2" name="choose"/>
</jsp:include>
<br/>
<center>
<table width="950" cellpadding="1" cellspacing="3" style="line-height: 24px" height="400">
<tr>
<td>
<img src="<%=request.getContextPath() %>/images/helpimg/weihu.png" border="0"> <font style="font-size: 13px;color: red;padding-left: 10px;padding-bottom: 15px">页面升级维护中...</font>
</td>
</tr>
</table>
</center>
<%@ include file="../Copyright.jsp" %>
</body>
</html>