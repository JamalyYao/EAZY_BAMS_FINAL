<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../common.jsp" %>
<%@include  file="../editmsgbox.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrPersonalProcessSerivce.js"></script>
<title>待办理的出差列表</title>
<script type="text/javascript">
//查询方法
function queryData() {
	startQuery();
	var oaTrsvel = getQueryParam();
	var pager = getPager();
	dwrPersonalProcessSerivce.findTodoTasksTrsvel(oaTrsvel, pager, queryCallback);
}

function queryCallback(data) {
	if (data.success == true) {
		initGridData(data.resultList, data.pager);
	} else {
		alert(data.message);
	}
	endQuery();
}


function showDetail(primaryKey, processInstanceId) {
	var url = "<%=contextPath%>/erp/personal_work/flow_detail_trsvel.jsp?pk="+primaryKey+"&processInstanceId="+processInstanceId;
	var box = new Sys.msgbox('明细查看', url, '800', '500');
	box.msgtitle = "<b>出差申请明细列表</b>";
	box.show();
}

function createProcessMethod(rowObj) {
	var str = ""
	
	if (rowObj.task.assignee == null){
		str += "<a href='javascript:void(0)' title='签收' onclick=\"claim('" + rowObj.task.id + "')\"><img src='<%=contextPath%>/images/grid_images/rowok.png' border='0'/></a>";
	} else{
		str += "<a href='javascript:void(0)' title='办理' onclick=\"handle('" + rowObj.primaryKey + "','" + rowObj.task.id + "','" + rowObj.task.taskDefinitionKey + "','" + rowObj.task.name + "')\"><img src='<%=contextPath%>/images/grid_images/layout_edit.png' border='0'/></a>";
	}
	str += "&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"showDetail('"+rowObj.primaryKey+"','"+rowObj.processInstanceId+"');\"><img src='<%=contextPath%>/images/grid_images/rowinfo.png' border='0'/></a>";
	
	return str;
}

function claim(taskId){
	dwrPersonalProcessSerivce.claimTask(taskId,claimCallback); 
}

function claimCallback(data){
	alertmsg(data, "queryData()");
}

function handle(trsvelId,taskId,taskDefinitionKey,taskName) {
	window.location = "<%=contextPath%>/erp/personal_work/flow_handle_trsvel.jsp?trsvelId="+trsvelId+"&taskId="+taskId+"&definitionKey="+taskDefinitionKey+"&name="+encodeURI(taskName) ;
}

function repleaSuspensionState(rowObj){
	var	str="";
	if(rowObj.processInstance.suspensionState == <%=EnumUtil.SUSPENSION_STATE.ACTIVE.value%>){
		str = "<font color='green'><%=EnumUtil.SUSPENSION_STATE.valueOf(EnumUtil.SUSPENSION_STATE.ACTIVE.value)%></font>";
	}else if(rowObj.processInstance.suspensionState == <%=EnumUtil.SUSPENSION_STATE.SUSPENDED.value%>){
		str = "<font color='red'><%=EnumUtil.SUSPENSION_STATE.valueOf(EnumUtil.SUSPENSION_STATE.SUSPENDED.value)%></font>";
	}
	return str;
}

function repleaTaskname(rowObj){
	var str = "<a href=\"javascript:void(0);\" title=\"点击查看流程图\" onclick=\"showProcessTrace('"+rowObj.task.processInstanceId+"');\">"+rowObj.task.name+"</a>";
	return str;
}

function showProcessTrace(instanceId){
	var box = new Sys.msgbox('流程追踪','<%=contextPath %>/processTrace.do?id='+instanceId,750,500);
	box.msgtitle="<b>此对话框显示的图片是由引擎自动生成的，并用红色标记当前的节点</b>";
	box.show();
}
	
</script>
</head>
<body>
<%
	SysGrid bg =new SysGrid(request);
	bg.setTableTitle("个人出差办理");
	//设置附加信息
	bg.setQueryFunction("queryData");	//查询的方法名
	bg.setDblFunction("dblCallback");	//双击列的方法名，又返回值，为列对象
	bg.setDblBundle("primaryKey");		//双击列的绑定的列值
	
	//放入按钮
	//ArrayList<SysGridBtnBean> btnList =new ArrayList<SysGridBtnBean>();
	//btnList.add(new SysGridBtnBean("请假申请","add()","add.png"));
	//btnList.add(new SysGridBtnBean("批量删除","deleteObject()","close.png"));
	//bg.setBtnList(btnList);
	
	ArrayList<SysColumnControl> sccList = new ArrayList<SysColumnControl>();
	sccList.add(new SysColumnControl("trsvelArea","出差地点",1,2,2,0));
	sccList.add(new SysColumnControl("applyEmployee.hrmEmployeeName","申请人",1,2,2,0));
	sccList.add(new SysColumnControl("applydata","申请时间",1,2,2,0));
	sccList.add(new SysColumnControl("trsvelBegindata","出差开始时间",1,2,2,0));
	sccList.add(new SysColumnControl("trsvelEnddata","出差结束时间",1,2,2,0));
	sccList.add(new SysColumnControl("taskname","当前节点",1,2,2,0));
	//sccList.add(new SysColumnControl("task.createTime","任务创建时间",1,2,2,0));
	//sccList.add(new SysColumnControl("suspensionState","流程状态",1,2,2,0));
	ArrayList<SysGridColumnBean> colList = UtilTool.getGridColumnList(sccList); 
	//进行高级查询显示处理
	for(int i=0;i<colList.size();i++){
		SysGridColumnBean bc =colList.get(i);
		if("suspensionState".equalsIgnoreCase(bc.getDataName())){
			bc.setColumnReplace("repleaSuspensionState");
			bc.setColumnStyle("text-align:center");
		}
		if("taskname".equalsIgnoreCase(bc.getDataName())){
			bc.setColumnReplace("repleaTaskname");
			bc.setColumnStyle("text-align:center");
		}
	}
	bg.setColumnList(colList);
	bg.setCheckboxOrNum(false);
	bg.setShowProcess(true);
	bg.setShowImg(false);
	bg.setProcessMethodName("createProcessMethod");
	//开始创建
	out.print(bg.createTable());
%>
</body>
</html>