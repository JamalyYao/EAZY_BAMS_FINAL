<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.eazytec.common.util.ConstWords"%>
<%@page import="com.eazytec.core.pojo.SysMethodInfo"%>
<%@page import="java.util.List"%>
<html xmlns:v>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String path = request.getContextPath();
 %>
<title>登录跳转</title>
<link rel='stylesheet' type='text/css' href='<%=path %>/css/normal.css' />
<script  type='text/javascript'   src='<%=path %>/js/normalutil.js'></script>
<style type="text/css">
v\:*   {behavior:   url(#default#VML);}   
</style>
</head>
<body style="overflow: hidden;">
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="middle">
<td align="center" width="100%" height="100%">
<v:RoundRect   style="position:relative;width:500;height:300;" strokecolor="#aaaaaa" arcsize='0.02' >   
<v:shadow   on="T"   type="single"   color="#CAD1DE"   offset="5px,5px" />  
<v:textbox>
<table border="0" cellpadding="0" cellspacing="5" width="680" align="center" style="padding: 10px;margin: 0px" height="78%">
	<tr>
		<td align="center" valign="top" width="80">
			<img src="<%=path %>/images/systemmsg.png" border="0" style="margin-right:  10px">
		</td>
		<td align="left">
		<label  style="color: green;font-size:18px;font-weight: normal;vertical-align:bottom;margin-top: 7px;margin-bottom: 4px;font-family: Microsoft YaHei, 宋体, Segoe UI, verdana, arial;">系统提示</label>
		<ul style="color:#4465A2;line-height: 30px;font-size:14px;font-family: 宋体, Segoe UI, verdana, arial;list-style: square">
			<li>系统尚未登录，不能访问。</li>
			<li>系统运行中长时间未操作。</li>
		</ul>
		<HR style="width: 80%;color: #d1d1d1;margin-left: 15px" size="0" noshade="noshade">
		<p style="padding-left: 15px;color: #666666">
		系统将在：<label style="color: #F38405;padding-left: 5px;padding-right: 5px;" id="second"></label>秒后跳转到登录页面!<br/><br/>或者点击快速跳转进入登录页面。
		</p> 
		</td>
	</tr>
</table>
<div style="margin: 10px;text-align: right;padding-right: 20px;width: 450px">
	<input type="button" value=" 快速跳转 " onclick="reload()" style="line-height: 20px"/>
</div>
</v:textbox>   
</v:RoundRect> 
</td>
</tr>
</table>
<script type="text/javascript">
	var s =10;
	document.getElementById("second").innerHTML = s;
	var t = window.setInterval(function(){
		s--;
		if(s<=0){
			reload();
			return;
		}
		document.getElementById("second").innerHTML = s;
	},1000);
	window.onunload =function(){
		if(t!=null){
			window.clearInterval(t);
		}
	}
	function reload(){
		window.parent.parent.parent.location.href ="<%=path%>/login.jsp";
	}
</script>
</body>
</html>