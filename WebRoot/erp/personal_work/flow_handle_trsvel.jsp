<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../common.jsp" %>
<%@page import="java.net.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出差办理</title>
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrPersonalProcessSerivce.js"></script>
<%
    String trsvelId =request.getParameter("trsvelId");
    String taskId =request.getParameter("taskId");
    String definitionKey =request.getParameter("definitionKey");
    String taskName =request.getParameter("name");
%>

<script type="text/javascript">
	window.onload = function() {
	initInput('helpTitle','出差流程办理 [ <%=URLDecoder.decode(taskName,"UTF-8") %> ] ');
	initPageAndButton();
}

//根据流程步骤初始化办理页面
function initPageAndButton(){
	var definitionKey = '<%=definitionKey%>';
	var deptLeaderAudit = '<%=EnumUtil.TRSVEL_TASK_ID.DEPT_LEADER_AUDIT.id%>';
	var modifyApply = '<%=EnumUtil.TRSVEL_TASK_ID.MODIFY_APPLY.id%>';
	var hrAudit = '<%=EnumUtil.TRSVEL_TASK_ID.HR_AUDIT.id%>';
	
	if(definitionKey == deptLeaderAudit){
		$("#deptLeaderAudit").show();
		setTrsvelDetail();
		Btn.show("btnagree");
		Btn.show("btnback");
	}else if(definitionKey == modifyApply){
		$("#leaveDetail").hide();
		$("#modifyApply").show();
		setTrsvelDetailForModify();
		Btn.show("btnsubmit");
	}else if(definitionKey == hrAudit){
		setTrsvelDetail();
		Btn.show("btnhragree");
	}
}


function setTrsvelDetail(){
	dwrPersonalProcessSerivce.getOaTrsvelByPk(<%=trsvelId%>,setTrsvel);
}

function setTrsvelDetailForModify(){
	dwrPersonalProcessSerivce.getOaTrsvelByPk(<%=trsvelId%>,setTrsvelForModify);
}

function setTrsvel(data) {
	if (data != null) {
		if (data.resultList.length > 0) {
			var tmp = data.resultList[0];
			var appname="";
			if(tmp.applyEmployee!=null){
				appname =tmp.applyEmployee.hrmEmployeeName;
			}
			DWRUtil.setValue("trsvelAppalyuser", appname);
			DWRUtil.setValue("trsvelBegindata", tmp.trsvelBegindata);
			DWRUtil.setValue("trsvelEnddata", tmp.trsvelEnddata);
			DWRUtil.setValue("trsvelArea", tmp.trsvelArea);
			DWRUtil.setValue("trsvelCause", tmp.trsvelCause);
		}
	}
}

function setTrsvelForModify(data) {
	if (data != null) {
		if (data.resultList.length > 0) {
			var tmp = data.resultList[0];
			DWRUtil.setValue("trsvelBegindataForModify", tmp.trsvelBegindata);
			DWRUtil.setValue("trsvelEnddataForModify", tmp.trsvelEnddata);
			DWRUtil.setValue("trsvelAreaForModify", tmp.trsvelArea);
			DWRUtil.setValue("trsvelCauseForModify", tmp.trsvelCause);
		}
	}
}

function backToList(){
	window.location = "<%=contextPath%>/erp/personal_work/flow_todo_trsvel.jsp";
}

function leaderCheck(isPass){
	var deptLeaderTxt = DWRUtil.getValue("leaderTxt");
	if(deptLeaderTxt == ""){
		setMustWarn("leaderTxtMust","请输入审批意见!");
   		return;
	}else{
		var warnArr = new Array();
		warnArr[0] = "leaderTxtMust";
		warnInit(warnArr);
		dwrPersonalProcessSerivce.completeTrsvelTaskForDeptLeader(<%=taskId%>,isPass,deptLeaderTxt,callback);
	}
}

function hrAgree(){
	confirmmsg("确定结束该出差流程吗?","hrAgreeok()");
}

function hrAgreeok(){
	dwrPersonalProcessSerivce.completeTrsvelTaskForHr(<%=taskId%>,callback);
}

function submit() {
	//定义信息提示数组
	var warnArr = new Array();
	warnArr[0] = "trsvelAreamust";
	warnArr[1] = "trsvelBegindatamust";
	warnArr[2] = "trsvelEnddatamust";
	warnArr[3] = "trsvelCausemust";
	
	warnInit(warnArr);//清空所有信息提示
	
	if(trsvelArea == ""){
		setMustWarn("trsvelAreamust","请输入出差地区!");
		return;
	}
	
	if(trsvelBegindata == ""){
		setMustWarn("trsvelBegindatamust","请输入开始时间!");
		return;
	}
	if(trsvelEnddata == ""){
		setMustWarn("trsvelEnddatamust","请输入结束时间!");
		return;
	}
	
	if(trsvelCause == ""){
		setMustWarn("trsvelCausemust","请假原因不能为空。");
		return;
	}
	if(trsvelCause.length > 1000){
		setMustWarn("trsvelCausemust","请假原因，字数不能超过1000个。");
		return;
	}
	
	dwrPersonalProcessSerivce.completeTrsvelTaskForApplyer(<%=taskId%>,getTrsvelinfo(),callback);
}

function callback(data){
	if(data.success){
		alertmsg(data,"backToList();");
	}else{
		alertmsg(data);
	}
}

function getTrsvelinfo() {
	var oaTrsvel = new Object();
	oaTrsvel.primaryKey = <%=trsvelId %>;
	oaTrsvel.trsvelArea = DWRUtil.getValue("trsvelAreaForModify");
	oaTrsvel.trsvelBegindata = DWRUtil.getValue("trsvelBegindataForModify");
	oaTrsvel.trsvelEnddata = DWRUtil.getValue("trsvelEnddataForModify");
	oaTrsvel.trsvelCause = DWRUtil.getValue("trsvelCauseForModify");
	return oaTrsvel;
}

</script>
</head>
<body class="inputcls">
<div class="formDetail">
	<div class="requdiv"><label id="helpTitle"></label></div>
	
	<div id="leaveDetail">
	<div class="formTitle">出差详情</div>
	<table class="detailtable" align="center" style="width: 90%;">
		<tr>
			<th width="15%">申请人</th>
			<td id="trsvelAppalyuser" class="detailtabletd"></td>
		</tr>
		<tr>
			<th>出差地点</th>
			<td id="trsvelArea" class="detailtabletd"></td>
		</tr>
		<tr>
			<th>开始时间</th>
			<td id="trsvelBegindata" class="detailtabletd"></td>
		</tr>
		<tr>
			<th>结束时间</th>
			<td id="trsvelEnddata" class="detailtabletd"></td>
		</tr>
		<tr>
		<th>出差事由</th>
		<td id="trsvelCause" class="detailtabletd"></td>
		</tr>
	</table>
	</div>
	
	
	<!-- 部门领导审批 -->
	<div id="deptLeaderAudit" style="display:none;">
	<div class="formTitle">审批意见</div>	
	<table class="inputtable">
	<tr>
		<th></th>
		<td colspan="3">
			<textarea id='leaderTxt'></textarea>
		</td>
	</tr>
	<tr>
		<th></th>
		<td colspan="3"><label id='leaderTxtMust'></label></td>
	</tr>
	</table>
	</div>
	
	<!-- 调整申请 -->
	<div id="modifyApply" style="display: none">
	<div class="formTitle">调整申请</div>
	<table class="inputtable">
		<tr>
			<th><em>*</em>&nbsp;出差地点</th>
			<td>
			<input id="trsvelAreaForModify" type="text" must="请输入出差地点" formust="trsvelAreamust" maxlength="50">
			<label id="trsvelAreamust"></label>
			</td>
		</tr>
		<tr>
			<th><em>*</em>&nbsp;出差时间</th>
			<td>
				<input type="text" id="trsvelBegindataForModify" must="请输入开始时间" formust="trsvelBegindatamust"
					readonly="readonly" class="Wdate"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'trsvelEnddataForModify\')}'})">
					&nbsp;至&nbsp;
				<input type="text" id="trsvelEnddataForModify" must="请输入结束时间" formust="trsvelEnddatamust"
					readonly="readonly" class="Wdate"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'trsvelBegindataForModify\')}'})">
					&nbsp;&nbsp;<label id="trsvelBegindatamust"></label><label id="trsvelEnddatamust"></label>
			</td>
		</tr>
		
		<tr>
			<th>
				<em>*</em>&nbsp;出差事由
			</th>
			<td>
				<textarea style="height: 100px;" id="trsvelCauseForModify"></textarea>
			</td>
		</tr>
		<tr><th></th><td><label id="trsvelCausemust"></label></td></tr>
	</table>
	</div>
	
</div>

<table align="center">
	<tr>
		<td style="display:none;padding:10px;" id="btnsubmit"><btn:btn onclick="submit();" value="提 交 " imgsrc="../../images/fileokico.png" title="提交" /></td>
		<td style="display:none;padding:10px;" id="btnagree"><btn:btn onclick="leaderCheck('true');" value="同 意 " imgsrc="../../images/png-1718.png" title="同意" /></td>
		<td style="display:none;padding:10px;" id="btnback"><btn:btn onclick="leaderCheck('false');" value="驳 回 " imgsrc="../../images/winclose.png" title="驳回"/></td>
		<td style="display:none;padding:10px;" id="btnhragree"><btn:btn onclick="hrAgree();" value="结 束 " imgsrc="../../images/png-1718.png" title="同意" /></td>
		<td style="padding:10px;" id="backToList"><btn:btn onclick="backToList()" value="返回列表 " imgsrc="../../images/clear.png" title="返回待办任务列表"/></td>
	</tr>
</table>

</body>
</html>