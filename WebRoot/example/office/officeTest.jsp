<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在线office</title>
<script  type='text/javascript'   src='ntkoofficecontrol.js'></script>
<script type="text/javascript">

var TANGER_OCX_OBJ; //控件对象

window.onload = function() {
	TANGER_OCX_OBJ = document.getElementById("TANGER_OCX");
}

function test(){
	
	if (typeof(TANGER_OCX_OBJ.ActiveDocument) == "undefined")
	{	alert("undefined");	}
	else if (TANGER_OCX_OBJ.ActiveDocument == null)
	{	alert("null");	}
	else
	{	alert("ok");	}

}
function test2(){
	TANGER_OCX_OBJ.OpenFromURL ("<%=contextPath%>/downloadfile/announce.doc");
}
function test3(){
	TANGER_OCX_OBJ.Close();;
}
</script>
</head>
<body>
<object id="TANGER_OCX" classid="clsid:A39F1330-3322-4a1d-9BF0-0BA2BB90E970" 
codebase="OfficeControl.cab#version=5,0,1,1" width="100%" height="80%">

<param name="MakerCaption" value="江苏卓易信息科技有限公司">
<param name="MakerKey" value="4C9E348B445A345421ECC653572BFB6EA2D6FEEC">
<param name="ProductCaption" value="社区信息化平台">
<param name="ProductKey" value="6E6705830920F9E2C1C1871EF368CA28D0D2388B">
<SPAN STYLE="color:red">该网页需要控件浏览.浏览器无法装载所需要的文档控件.请检查浏览器选项中的安全设置.</SPAN>
</object>
<input type="button" onclick="test()" value="测试">
<input type="button" onclick="test2()" value="打开">
<input type="button" onclick="test3()" value="关闭">
<button onclick="TANGER_OCX_OBJ.Menubar=!TANGER_OCX_OBJ.Menubar;">切换菜单</button>
<button onclick="TANGER_OCX_OBJ.Titlebar=!TANGER_OCX_OBJ.Titlebar;">切换标题栏</button>
<button onclick="TANGER_OCX_OBJ.Toolbars=!TANGER_OCX_OBJ.Toolbars;">切换工具栏</button>
<button onclick="TANGER_OCX_OBJ.Statusbar=!TANGER_OCX_OBJ.Statusbar;">切换状态栏</button>
<button onclick="TANGER_OCX_OBJ.IsShowToolMenu=!TANGER_OCX_OBJ.IsShowToolMenu;">切换工具菜单</button>
</body>
</html>