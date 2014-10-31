<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%
//项目相对及绝对路径
String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择颜色</title>
<link type='text/css' rel='stylesheet' href='<%=contextPath %>/css/js_color_picker_v2.css' />
<script type="text/javascript" src="<%=contextPath %>/js/colorJs/color_functions.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/colorJs/js_color_picker_v2.js"></script>
<script type="text/javascript">
colorPickerPath.setImagePath('<%=contextPath %>/images/selectColor/')
</script>
</head>
<body>
<input type="text" style="border:1px solid #EEEEEE;" onfocus="showColorPicker(this,document.getElementById('rgb2'))" id="rgb2">
<input type="button" value="Color picker" onclick="showColorPicker(this,document.getElementById('rgb2'))">
</body>
</html>