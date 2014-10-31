<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>checkbox</title>
<script type="text/javascript">
function getCheckboxValue(){
	var value = getCheckboxValueByName("levetype1");
	alert(value);
}


function setCheckboxValue(){
	var value = "1|3";
	setCheckboxValueByName("levetype2",value);
}

function getCheckboxValue2(){
	var value = getCheckboxValueByName("levetype3");
	alert(value);
}


function setCheckboxValue2(){
	var value = "2164|2165";
	setCheckboxValueByName("levetype4",value);
}

//通用js方法在normalutil.js文件里

</script>
</head>
<body>
<br/><br/><br/>
从枚举获取<br/>
获得checkbox的值:<%=UtilTool.getCheckboxOptionsByEnum(EnumUtil.OA_PERSONAL_LEAVE_TYPE.getSelectAndText(""),"levetype1") %>

<input type="button" onclick="getCheckboxValue()" value="获得checkbox的值"/>

<br/><br/><br/>

设置checkbox的值:<%=UtilTool.getCheckboxOptionsByEnum(EnumUtil.VOTINHSELECTTYPE.getSelectAndText(""),"levetype2") %>

<input type="button" onclick="setCheckboxValue()" value="设置checkbox的值"/>
<br/><br/><br/>
从数据字典获取<br/>
获得checkbox的值:<%=UtilTool.getCheckboxOptions(this.getServletContext(),request,null,"06","levetype3") %> 

<input type="button" onclick="getCheckboxValue2()" value="获得checkbox的值"/>

<br/><br/><br/>

设置checkbox的值:<%=UtilTool.getCheckboxOptions(this.getServletContext(),request,null,"06","levetype4") %>

<input type="button" onclick="setCheckboxValue2()" value="设置checkbox的值"/>

</body>
</html>