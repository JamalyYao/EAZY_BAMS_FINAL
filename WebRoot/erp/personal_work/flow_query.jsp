<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../common.jsp" %>
<%@include  file="../editmsgbox.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrPersonalProcessSerivce.js"></script>
<title>工作流程查询</title>
<script type="text/javascript">
//查询方法
function queryData() {
	startQuery();
	var bean = getQueryParam();
	var pager = getPager();
	dwrPersonalProcessSerivce.findHistoryTasks(bean, pager, queryCallback);
}

function queryCallback(data) {
	if (data.success == true) {
		initGridData(data.resultList, data.pager);
	} else {
		alert(data.message);
	}
	endQuery();
}

function dblCallback(obj) {
	
}

function createProcessMethod(rowObj) {
	//var str = "<a href='javascript:void(0)' title='流程图' onclick=\"show('" + rowObj.historicProcessInstance.id + "')\"><img src='<%=contextPath%>/images/grid_images/rowinfo.png' border='0'/></a>";
	var str = "<a href=\"javascript:void(0);\" onclick=\"showDetail('"+rowObj.processDefinition.key+"','"+rowObj.historicProcessInstance.businessKey+"','"+rowObj.historicProcessInstance.id+"');\"><img src='<%=contextPath%>/images/grid_images/rowinfo.png' border='0'/></a>";
	return str;
}

function show(id){
	var box = new Sys.msgbox('查看流程图', '<%=contextPath%>/erp/personal_work/flow_detail.jsp?id=' + id, '800', '500');
	box.msgtitle = "<b></b>";
	box.show();
}

function repProcessStatus(rowObj){
	var	str="";
	if(rowObj.instanceEndTime == null){
		str = "<font color='red'><%=EnumUtil.PROCESS_STATUS.valueOf(EnumUtil.PROCESS_STATUS.DOING.value)%></font>";
	}else{
		str = "<font color='green'><%=EnumUtil.PROCESS_STATUS.valueOf(EnumUtil.PROCESS_STATUS.FINISH.value)%></font>";
	}
	return str;
}

function showDetail(key, id, processInstanceId){
	var url;
	if(key == "<%= EnumUtil.WORKFLOW_TYPE.LEAVE.key%>"){
		url = "<%=contextPath%>/erp/personal_work/flow_detail_leave.jsp?pk="+id+"&processInstanceId="+processInstanceId;
	}else if(key == "<%= EnumUtil.WORKFLOW_TYPE.TRSVEL.key%>"){
		url = "<%=contextPath%>/erp/personal_work/flow_detail_trsvel.jsp?pk="+id+"&processInstanceId="+processInstanceId;
	}
	var box = box = new Sys.msgbox('明细查看', url, '800', '500');
	box.msgtitle = "<b></b>";
	box.show();
}
	
</script>
</head>
<body>
<%
	SysGrid bg =new SysGrid(request);
	bg.setTableTitle("工作流程查询");
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
	sccList.add(new SysColumnControl("historicProcessInstance.id","流水号",1,2,2,0));
	sccList.add(new SysColumnControl("id","流水号",2,1,2,0));
	sccList.add(new SysColumnControl("key","流程类型",2,2,1,0));
	sccList.add(new SysColumnControl("scope","流程范围",2,2,1,0));
	sccList.add(new SysColumnControl("processDefinition.name","流程名称",1,2,2,0));
	sccList.add(new SysColumnControl("employee.hrmEmployeeName","发起人",1,2,2,0));
	sccList.add(new SysColumnControl("instanceStartTime","流程开始时间",1,2,2,0));
	sccList.add(new SysColumnControl("instanceEndTime","流程结束时间",1,2,2,0));
	sccList.add(new SysColumnControl("processStatus","流程状态",1,2,1,0));
	ArrayList<SysGridColumnBean> colList = UtilTool.getGridColumnList(sccList); 
	//进行高级查询显示处理
	for(int i=0;i<colList.size();i++){
		SysGridColumnBean bc =colList.get(i);
		if("processStatus".equalsIgnoreCase(bc.getDataName())){
			SelectType select = new SelectType(EnumUtil.PROCESS_STATUS.getSelectAndText("-1,请选择流程状态"));
			select.setCustomerFunction(new String[] { "onchange=\"queryData();\"" });
			bc.setColumnTypeClass(select);
			bc.setColumnReplace("repProcessStatus");
			bc.setColumnStyle("text-align:center");
		}
		
		if("key".equalsIgnoreCase(bc.getDataName())){
			SelectType select = new SelectType(EnumUtil.WORKFLOW_TYPE.getSelectAndText("-1,请选择流程类型"));
			select.setCustomerFunction(new String[] { "onchange=\"queryData();\"" });
			bc.setColumnTypeClass(select);
		}
		
		if("scope".equalsIgnoreCase(bc.getDataName())){
			SelectType select = new SelectType(EnumUtil.WORKFLOW_SCOPE.getSelectAndText("-1,请选择流程范围"));
			select.setCustomerFunction(new String[] { "onchange=\"queryData();\"" });
			bc.setColumnTypeClass(select);
		}
	}
	bg.setColumnList(colList);
	bg.setShowProcess(true);
	bg.setShowImg(false);
	bg.setCheckboxOrNum(false);
	bg.setProcessMethodName("createProcessMethod");
	//开始创建
	out.print(bg.createTable());
%>
</body>
</html>