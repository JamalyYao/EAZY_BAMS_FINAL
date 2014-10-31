<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    <%@ include file="../common.jsp" %>
<%@page import="java.net.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>请假办理</title>
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrPersonalProcessSerivce.js"></script>
<%
    String leaveId =request.getParameter("leaveId");
    String taskId =request.getParameter("taskId");
    String definitionKey =request.getParameter("definitionKey");
    String taskName = request.getParameter("name");
%>

<script type="text/javascript">

window.onload = function(){
	useLoadingMassage();
	initInput('helpTitle','请假流程办理 [ <%=URLDecoder.decode(taskName,"UTF-8") %> ] ');
	initPageAndButton();
}

//根据流程步骤初始化办理页面
function initPageAndButton(){
	var definitionKey = '<%=definitionKey%>';
	var deptLeaderAudit = '<%=EnumUtil.LEAVE_TASK_ID.DEPT_LEADER_AUDIT.id%>';
	var modifyApply = '<%=EnumUtil.LEAVE_TASK_ID.MODIFY_APPLY.id%>';
	var hrAudit = '<%=EnumUtil.LEAVE_TASK_ID.HR_AUDIT.id%>';
	
	if(definitionKey == deptLeaderAudit){
		setLeaveDetail();
		Btn.show("btnagree");
		Btn.show("btnback");
		$("#audit").show();
	}else if(definitionKey == modifyApply){
		$("#leaveDetail").hide();
		$("#modifyApply").show();
		setLeaveDetailForModify();
		Btn.show("btnsubmit");
		Btn.show("btnfinish");
	}else if(definitionKey == hrAudit){
		setLeaveDetail();
		Btn.show("btnhragree");
		Btn.show("btnhrback");
		$("#audit").show();
	}
}

function setLeaveDetail(){
	dwrPersonalProcessSerivce.getOaLeaverByPk(<%=leaveId%>,setLeave);
}

function setLeaveDetailForModify(){
	dwrPersonalProcessSerivce.getOaLeaverByPk(<%=leaveId%>,setLeaveinfo);
}

function setLeave(data){
    if(data.success == true){
 		if(data.resultList.length > 0){
 			var leave = data.resultList[0];
 			DWRUtil.setValue("applyuser",leave.applyEmployee.hrmEmployeeName);
 			DWRUtil.setValue("leavetype",leave.library.libraryInfoName);
 			DWRUtil.setValue("applydata",leave.applydata);
 			DWRUtil.setValue("startdata",leave.startdata);
 			DWRUtil.setValue("enddata", leave.enddata);
 			DWRUtil.setValue("leavereason",leave.leavereason);
 		}else{
 			alert(data.message);
 		}
 	}else{
 		alert(data.message);
 	}
}

function setLeaveinfo(data){
    if(data.success == true){
 		if(data.resultList.length > 0){
 			var leave = data.resultList[0];
 			setSelectValue("leavetypeForModify",leave.leavetype);
 			DWRUtil.setValue("startdataForModify",leave.startdata);
 			DWRUtil.setValue("enddataForModify", leave.enddata);
 			DWRUtil.setValue("leavereasonForModify",leave.leavereason);
 		}else{
 			alert(data.message);
 		}
 	}else{
 		alert(data.message);
 	}
}

function submit(isContinue) {
	//定义信息提示数组
	var warnArr = new Array();
	warnArr[0] = "startdatamust";
	warnArr[1] = "enddatamust";
	warnArr[2] = "leavereasonmust";
	warnInit(warnArr);//清空所有信息提示
	
	if(isContinue){
		if(leavereason == ""){
			setMustWarn("leavereasonmust","请假原因不能为空。");
			return;
		}
		if(leavereason.length > 1000){
			setMustWarn("leavereasonmust","请假原因，字数不能超过1000个。");
			return;
		}
		if(startdata == ""){
			setMustWarn("startdatamust","请输入开始时间!");
			return;
		}
		if(enddata == ""){
			setMustWarn("enddatamust","请输入结束时间!");
			return;
		}
	}
	
	dwrPersonalProcessSerivce.completeLeaveTaskForApplyer(<%=taskId%>,isContinue,getLeaveinfo(),callback);
}

function getLeaveinfo() {
	var oaleave = new Object();
	oaleave.primaryKey = <%=leaveId %>;
	oaleave.leavetype = DWRUtil.getValue("leavetypeForModify");
	oaleave.startdata = DWRUtil.getValue("startdataForModify");
	oaleave.enddata = DWRUtil.getValue("enddataForModify");
	oaleave.leavereason = DWRUtil.getValue("leavereasonForModify");
	return oaleave;
}

function callback(data){
	if(data.success){
		alertmsg(data,"backToList();");
	}else{
		alertmsg(data);
	}
}

function backToList(){
	window.location = "<%=contextPath%>/erp/personal_work/flow_todo_leave.jsp";
}

function leaderCheck(isPass){
	var deptLeaderTxt = DWRUtil.getValue("txt");
	if(deptLeaderTxt == ""){
		setMustWarn("txtMust","请输入审批意见!");
   		return;
	}else{
		var warnArr = new Array();
		warnArr[0] = "txtMust";
		warnInit(warnArr);
		dwrPersonalProcessSerivce.completeLeaveTaskForDeptLeader(<%=taskId%>,isPass,deptLeaderTxt,callback);
	}
}

function hrCheck(isPass){
	var hrTxt = DWRUtil.getValue("txt");
	if(hrTxt == ""){
		setMustWarn("txtMust","请输入审批意见!");
   		return;
	}else{
		var warnArr = new Array();
		warnArr[0] = "txtMust";
		warnInit(warnArr);
		dwrPersonalProcessSerivce.completeLeaveTaskForHr(<%=taskId%>,isPass,hrTxt,callback);
	}
}

function callback(data){
	if(data.success){
		alertmsg(data,"backToList();");
	}else{
		alertmsg(data);
	}
}

</script>
</head>
<body class="inputcls">
<div class="formDetail">
	<div class="requdiv"><label id="helpTitle"></label></div>
	
	<div id="leaveDetail">
    <div class="formTitle">请假详情</div>
	    <table class="detailtable" style="width:90%;">
			<tr>
				<th>请假人</th>
				<td id="applyuser" class="detailtabletd" ></td>
				<th>请假类型</th>
				<td id="leavetype" class="detailtabletd" ></td>
			</tr>
			<tr>
				<th>申请时间</th>
				<td id="applydata" class="detailtabletd"></td>
				<th></th>
				<td></td>
			</tr>
			<tr>
				<th>开始时间</th>
				<td id="startdata" class="detailtabletd"></td>
				<th>结束时间</th>
				<td id="enddata" class="detailtabletd" ></td>
			</tr>
			<tr>
				<th>请假事由</th>
				<td colspan="3"  id="leavereason" class="detailtabletd"></td>
			</tr>
		</table>
	</div>	
		
	<!-- 调整申请 -->
	<div id="modifyApply" style="display: none">
	<div class="formTitle">调整申请</div>
	<table class="inputtable">
		<tr>
			<th>请假类型</th>
			<td>
			<select id="leavetypeForModify" >
				<%=UtilTool.getSelectOptions(this.getServletContext(),request,null,"23") %>
			</select>
			</td>
		</tr>
	
		<tr>
			<th><em>*</em>&nbsp;请假时间</th>
			<td><input id="startdataForModify" type="text" readonly="readonly" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'enddataForModify\')}'})">
			&nbsp;至
			<input id="enddataForModify" type="text" readonly="readonly" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'startdataForModify\')}'})">
			&nbsp;&nbsp;&nbsp;&nbsp;<label id="startdatamust"></label><label id="enddatamust"></label></td>
		</tr>
		
		<tr>	
			<th><em>*</em>&nbsp;请假事由</th>
			<td colspan="3"><textarea style="height: 100px;" id ="leavereasonForModify"></textarea></td>
		</tr>
		<tr><th></th><td><label id="leavereasonmust"></label></td></tr>
	</table>
	</div>
	
	<!-- 审批意见区域 -->
	<div id="audit" style="display: none">
		<div class="formTitle">审批意见</div>	
		<table class="inputtable">
		<tr>
			<th></th>
			<td colspan="3">
				<textarea id='txt'></textarea>
			</td>
		</tr>
		<tr>
			<th></th>
			<td colspan="3"><label id='txtMust'></label></td>
		</tr>
		</table>
	</div>
</div>
	
	
<table align="center">
	<tr>
		<td style="display:none;padding:10px;" id="btnsubmit"><btn:btn onclick="submit('true');" value="提 交 " imgsrc="../../images/fileokico.png" title="提交" /></td>
		<td style="display:none;padding:10px;" id="btnfinish"><btn:btn onclick="submit('false');" value="结 束 " imgsrc="../../images/winclose.png" title="结束" /></td>
		<td style="display:none;padding:10px;" id="btnagree"><btn:btn onclick="leaderCheck('true');" value="同 意 " imgsrc="../../images/png-1718.png" title="同意" /></td>
		<td style="display:none;padding:10px;" id="btnhragree"><btn:btn onclick="hrCheck('true');" value="同 意 " imgsrc="../../images/png-1718.png" title="同意" /></td>
		<td style="display:none;padding:10px;" id="btnback"><btn:btn onclick="leaderCheck('false');" value="驳 回 " imgsrc="../../images/winclose.png" title="驳回"/></td>
		<td style="display:none;padding:10px;" id="btnhrback"><btn:btn onclick="hrCheck('false');" value="驳 回 " imgsrc="../../images/winclose.png" title="驳回"/></td>
		<td style="padding:10px;" id="backToList"><btn:btn onclick="backToList()" value="返回列表 " imgsrc="../../images/clear.png" title="返回待办任务列表"/></td>
	</tr>
</table>
</body>
</html>