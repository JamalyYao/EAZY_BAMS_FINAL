<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.eazytec.common.util.file.properties.SystemConfig"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帮助top</title>
<%
String path = request.getContextPath();
String choose = request.getParameter("choose");
int c = 1;
if(choose!=null){
	c = Integer.parseInt(choose)>4?1:Integer.parseInt(choose);
}
boolean bl =Boolean.parseBoolean(SystemConfig.getParam("erp.sys.LoginIsview"));
 %>
<link rel='Shortcut Icon' href='<%=path %>/favicon.ico'/>
<link rel='Bookmark' href='<%=path %>/favicon.ico' />
<link rel='stylesheet' type='text/css' href='<%=path %>/css/normal.css' />
<link rel='stylesheet' type='text/css' href='<%=path %>/css/login.css' />
<style type="text/css">
	.topbtn{
		width: 96px;
		height:30px;
		color: #ffffff;
		font-size: 14px;
		font-weight: bold;
		background-image: url("<%=path%>/images/helpimg/helpbtn.gif");
		background-repeat:no-repeat;
		cursor: pointer;
		float: left;
		text-align: center;
		padding-bottom: 1px;
		line-height: 30px;
	}
	.btndef{
		width: 96px;
		height:  30px;
		color: #999999;
		font-size: 14px;
		font-weight: bold;
		cursor: pointer;
		float: left;
		text-align: center;
		padding-bottom: 1px;
		line-height: 30px;
	}
	.btndef:hover{
		width: 96px;
		height: 30px;
		color: #000000;
		font-size: 14px;
		font-weight: bold;
		cursor: pointer;
		float: left;
		text-align: center;
		padding-bottom: 1px;
		line-height: 30px;
	}
</style>
<script type="text/javascript">
	window.onload = function(){
		inittopbtn();
	}
	function inittopbtn(){
		var st = document.getElementById("spantd");
		var bts = st.getElementsByTagName("div");
		for(var i=0;i<bts.length;i++){
			var obj = bts[i];
			if(i==<%=c-1%>){
				obj.className = "topbtn";
				obj.onclick= function(){};
			}else{
				obj.className = "btndef";
			}
		}
	}
	function winopen(url){
		if(url.length>0){
			document.location.href = url;
		}
	}
</script>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center" height="45">
<tr height="45">
<td width="110" style="padding-left: 10px">
<img src="<%=path %>/images/login_title.png" border="0" height="45"/>
</td>
<td align="left" style="padding-left: 10px"><font face="幼圆" style="font-size:20px;"  color="#666666"><strong>帮助中心</strong></font></td>
<td align="right" style="color:#999999;padding-right: 25px;padding-top: 8px" valign="top">
<%if(bl){ %>
<a href="<%=path%>/login.jsp" class="tit" target="_blank">平台登录</a>&nbsp;&nbsp;|&nbsp;&nbsp;
<a href="<%=path%>/other/company_reg.jsp" class="tit" target="_blank">公司注册</a>
<%} %>
</td>
</tr>
</table>
<table cellpadding="0" cellspacing="0" width="100%" border="0" height="36" background="<%=path %>/images/helpimg/helpline.gif">
<tr height="100%">
<td width="20%"></td>
<td valign="bottom" id="spantd" nowrap="nowrap">
<div onclick="winopen('help_index.jsp')">首&nbsp;&nbsp;页</div>
<div onclick="winopen('help_error.jsp')">常见问题</div>
<div onclick="winopen('help_main.jsp')">使用帮助</div>
<div onclick="winopen('help_msg.jsp')">系统公告</div>
</td>
</tr>
</table>
<center>
<div style="height: 30px;width: 950px;line-height: 30px;text-align: left;">
<label style="font-family: Webdings;color: #00225A;padding-right: 5px">4</label>欢迎您来到：<label style="color: green">平台帮助中心</label>
</div>
</center>
</body>
</html>