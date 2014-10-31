<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrPersonalProcessSerivce.js"></script>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0);
 %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>请假申请</title>
<script type="text/javascript">
window.onload = function() {
    useLoadingMassage();
	initInput("helpTitle","请假申请，申请后需要经过领导审批。");
}

function save() {
	//定义信息提示数组
	var warnArr = new Array();
	warnArr[0] = "startdatamust";
	warnArr[1] = "enddatamust";
	warnArr[2] = "leavereasonmust";
	warnArr[3] = "employeeNameMust";
	warnInit(warnArr);//清空所有信息提示
	
	var bl = validvalue('helpTitle');
	if (bl) {
		var reason = DWRUtil.getValue("leavereason");
		if(reason.length <= 0){
			setMustWarn("leavereasonmust","请假原因不能为空。");
			document.getElementById("leavereason").focus();
			return;
		}if(reason.length > 1000){
			setMustWarn("leavereasonmust","请假原因，字数不能超过1000个。");
			document.getElementById("leavereason").focus();
			return;
		}
		
		var employeeId = DWRUtil.getValue("employeeId");
		dwrPersonalProcessSerivce.addOaLeaver(employeeId, getLeaveinfo(), seveleaver);
		Btn.close();
	}
}

function seveleaver(data) {
    Btn.open();
	if(data.success){
		confirmmsgAndTitle("添加申请成功！是否想继续添加申请？","reset();","继续添加","closePage();","关闭页面");
	}else{
		alertmsg(data);
	}
}

function closePage(){
	closeMDITab(window.parent.parent);
}

function reset() {
	Sys.reload();
}

function getLeaveinfo() {
	var oaleave = new Object();
	oaleave.leavereason = DWRUtil.getValue("leavereason");
	oaleave.leavetype = DWRUtil.getValue("leavetype");
	oaleave.startdata = DWRUtil.getValue("startdata");
	oaleave.enddata = DWRUtil.getValue("enddata");
	return oaleave;
}

function getupcode(){
	var box = SEL.getEmployeeIds("radio","employeeName","employeeId");
	box.show();
}
</script>
</head>
<body class="inputcls">
<div class="formDetail">
	<div class="requdiv"><label id="helpTitle"></label></div>
	<div class="formTitle">请假申请</div>
	<table class="inputtable">
		<tr>
			<th>请假类型</th>
			<td>
			<select id="leavetype" >
				<%=UtilTool.getSelectOptions(this.getServletContext(),request,null,"23") %>
				</select>
			</td>
		</tr>
	
		<tr>
			<th><em>*</em>&nbsp;请假时间</th>
			<td><input id="startdata" type="text" readonly="readonly" class="Wdate" must="请输入开始时间" formust="startdatamust" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'enddata\')}'})">
			&nbsp;至
			<input id="enddata" type="text" readonly="readonly" class="Wdate" must="请输入结束时间" formust="enddatamust" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'startdata\')}'})">
			&nbsp;&nbsp;&nbsp;&nbsp;<label id="startdatamust"></label><label id="enddatamust"></label></td>
		</tr>
		<tr><th></th><td><label id="leavereasonmust"></label></td></tr>
		<tr>	
			<th><em>*</em>&nbsp;请假事由</th>
			<td><textarea style="height: 200px;" id ="leavereason"></textarea></td>
		</tr>
		
		<tr>
			<th>
				<em>*</em>&nbsp;部门经理
			</th>
			<td>
				<input type="text" class="takeform" id="employeeName" must="部门经理不能为空!" formust="employeeNameMust" readonly="readonly" title="点击获取人员名称" onclick="getupcode();" >
				<input type="hidden" id="employeeId">
				<label id="employeeNameMust"></label>
			</td>
		</tr>
	</table>	
</div>
<table align="center">
  	<tr>
    	<td><btn:btn onclick="save()" value="保 存 "  imgsrc="../../images/png-1718.png" title="保存申请信息"></btn:btn></td>
    	<td style="width: 10px;"></td>
    	<td><btn:btn onclick="closePage()" value="关 闭 " imgsrc="../../images/winclose.png" title="关闭当前页面"></btn:btn></td>
  	</tr>
</table>
</body>
</html>