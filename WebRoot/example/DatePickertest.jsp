<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../erp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>测试日历</title>
<style type="text/css">
	body {
	margin: 10px;
	
}
</style>
<script type="text/javascript">
	function setColor(){
		var cl ="#336699";
		document.getElementById("colordiv").style.backgroundColor =cl;
		document.getElementById("rgb2").value =cl;
	}
	function showColor(obj,inputId){
		var a=document.getElementById(inputId);
		showColorPicker(obj,a);
	}
</script>
</head>
<body>
标准模式：<input id="d11" type="text" onClick="WdatePicker()" readonly="readonly"/><br/>

双 月 历： <input class="Wdate" type="text" onfocus="WdatePicker({doubleCalendar:true,dateFmt:'yyyy-MM-dd',skin:'simple'})" readonly="readonly"/><br/>

文本外日历：<input id="d12" type="text"/><img onclick="WdatePicker({el:'d12'})" src="../js/dateJs/skin/datePicker.gif" width="16" height="22" align="absmiddle" readonly="readonly"><br/>

 日期和时间： <input class="Wdate" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/><br/>

 标准模式2：<input id="d11" type="text" onClick="WdatePicker()" readonly="readonly"/><br/>

 时 分 秒：<input type="text" id="d242" onfocus="WdatePicker({dateFmt:'H:mm:ss'})" class="Wtime" readonly="readonly"/><br/>

 特殊应用：<input type="text" id="d245" onfocus="WdatePicker({dateFmt:'yyyy年MM月dd日',vel:'d244_2',skin:'simple'})" class="Wdate" size=25 readonly="readonly"/>真是值<input id="d244_2" type="text" />

<br/><br/><br/><br/>
颜色拾取
<input type="text" id="rgb2">
<div style='border:1px solid #cccccc; width:15px; height:15px;cursor: pointer;' onclick="showColor(this,'rgb2');" id="colordiv"></div>
初始化赋值
<input type="button" value="设置颜色" onclick="setColor();">

</body>
</html>