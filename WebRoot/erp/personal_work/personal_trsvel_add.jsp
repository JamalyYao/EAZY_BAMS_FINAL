<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript"src="<%=contextPath%>/dwr/interface/dwrPersonalProcessSerivce.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>出差申请</title>
	<script type="text/javascript">
window.onload = function() {
    useLoadingMassage();
    document.getElementById("trsvelArea").focus();
	initInput('helpTitle','出差申请，需经过领导审批。');
}

function save() {
	var warnArr = new Array();
	warnArr[0] = "trsvelAreamust";
	warnArr[1] = "trsvelBegindatamust";
	warnArr[2] = "trsvelEnddatamust";
	warnArr[3] = "trsvelCausemust";
	warnArr[4] = "employeeNameMust";
	warnInit(warnArr);
	
	var bl = validvalue('helpTitle');
	if (bl) {
		if(document.getElementById("trsvelCause").value==""){
			setMustWarn("trsvelCausemust","出差事由不能为空。");
			document.getElementById("trsvelCause").focus();
			return;
		}
		if(document.getElementById("trsvelCause").value.length>1000){
			setMustWarn("trsvelCausemust","出差事由不能超过1000个字符。");
			document.getElementById("trsvelArea").focus();
			return;
		}
		
		var employeeId = DWRUtil.getValue("employeeId");
	    dwrPersonalProcessSerivce.addoaTrsvel(getTrsvelinfo(), employeeId, seveoaTrsvel);
  		Btn.close();
	   
	}
}

function seveoaTrsvel(data) {
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
	
function getTrsvelinfo() {
	var oaTrsvel = new Object();
	oaTrsvel.trsvelArea = DWRUtil.getValue("trsvelArea");
	oaTrsvel.trsvelBegindata = DWRUtil.getValue("trsvelBegindata");
	oaTrsvel.trsvelEnddata = DWRUtil.getValue("trsvelEnddata");
	oaTrsvel.trsvelCause = DWRUtil.getValue("trsvelCause");
	return oaTrsvel;
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
		<div class="formTitle">出差申请</div>
		<div>
			<table class="inputtable">
				<tr>
					<th><em>*</em>&nbsp;出差地点</th>
					<td>
					<input id="trsvelArea" type="text" must="请输入出差地点" formust="trsvelAreamust" maxlength="50">
					<label id="trsvelAreamust"></label>
					</td>
				</tr>
				<tr>
					<th><em>*</em>&nbsp;出差时间</th>
					<td>
						<input type="text" id="trsvelBegindata" must="请输入开始时间" formust="trsvelBegindatamust"
							readonly="readonly" class="Wdate"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'trsvelEnddata\')}'})">
							&nbsp;至&nbsp;
						<input type="text" id="trsvelEnddata" must="请输入结束时间" formust="trsvelEnddatamust"
							readonly="readonly" class="Wdate"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'trsvelBegindata\')}'})">
							&nbsp;&nbsp;<label id="trsvelBegindatamust"></label><label id="trsvelEnddatamust"></label>
					</td>
					
				</tr>
				
				<tr>
					<th>
						<em>*</em>&nbsp;出差事由
					</th>
					<td>
						<textarea style="height: 200px;" id="trsvelCause"></textarea>
					</td>
				</tr>
				<tr><th></th><td><label id="trsvelCausemust"></label></td></tr>
				
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
		<br>
	</div>
	<br />
	<table align="center">
		<tr>
			<td><btn:btn onclick="save()" value="保 存 " imgsrc="../../images/png-1718.png" title="保存申请信息"></btn:btn></td>
			<td style="width: 10px;"></td>
			<td><btn:btn onclick="closePage()" value="关 闭 " imgsrc="../../images/winclose.png" title="关闭当前页面"></btn:btn></td>
		</tr>
	</table>
</body>
</html>