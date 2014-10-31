<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../common.jsp" %>
<%@include  file="../editmsgbox.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrPersonalOfficeSerivce.js"></script>
<title>出差查询</title>
<script type="text/javascript">
//查询方法
function queryData() {
	startQuery();
	var key = '<%= EnumUtil.WORKFLOW_TYPE.TRSVEL.key%>';
	var pager = getPager();
	dwrPersonalOfficeSerivce.findHistoryTasks(key, pager, queryCallback);
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

function repleaProcessState(rowObj){
	var	str="";
	if(rowObj.instanceEndTime == null){
		str = "<font color='red'><%=EnumUtil.PROCESS_STATUS.valueOf(EnumUtil.PROCESS_STATUS.DOING.value)%></font>";
	}else{
		str = "<font color='green'><%=EnumUtil.PROCESS_STATUS.valueOf(EnumUtil.PROCESS_STATUS.FINISH.value)%></font>";
	}
	return str;
}
	
</script>
</head>
<body>
<%
	SysGrid bg =new SysGrid(request);
	bg.setTableTitle("个人出差查询");
	//设置附加信息
	bg.setQueryFunction("queryData");	//查询的方法名
	bg.setDblFunction("dblCallback");	//双击列的方法名，又返回值，为列对象
	bg.setDblBundle("primaryKey");		//双击列的绑定的列值
	
	//放入按钮
	//ArrayList<SysGridBtnBean> btnList =new ArrayList<SysGridBtnBean>();
	//btnList.add(new SysGridBtnBean("请假申请","add()","add.png"));
	//btnList.add(new SysGridBtnBean("批量删除","deleteObject()","close.png"));
	//bg.setBtnList(btnList);
	//放入列
	//ArrayList<SysGridColumnBean> colList = UtilTool.getGridColumnList(UtilTool.getColumnShow(this.getServletContext(),"人员列表"));
	ArrayList<SysColumnControl> sccList = new ArrayList<SysColumnControl>();
	sccList.add(new SysColumnControl("processDefinition.name","流程名称",1,2,2,0));
	sccList.add(new SysColumnControl("employee.hrmEmployeeName","发起人",1,2,2,0));
	sccList.add(new SysColumnControl("instanceStartTime","流程开始时间",1,2,2,0));
	sccList.add(new SysColumnControl("instanceEndTime","流程结束时间",1,2,2,0));
	//sccList.add(new SysColumnControl("enddata","结束时间",1,2,2,0));
	//sccList.add(new SysColumnControl("task.name","当前节点",1,2,2,0));
	//sccList.add(new SysColumnControl("task.createTime","任务创建时间",1,2,2,0));
	sccList.add(new SysColumnControl("processState","流程状态",1,2,2,0));
	ArrayList<SysGridColumnBean> colList = UtilTool.getGridColumnList(sccList); 
	//进行高级查询显示处理
	for(int i=0;i<colList.size();i++){
		SysGridColumnBean bc =colList.get(i);
		if("processState".equalsIgnoreCase(bc.getDataName())){
			bc.setColumnReplace("repleaProcessState");
			bc.setColumnStyle("text-align:center");
		}
	}
	bg.setColumnList(colList);
	bg.setShowProcess(false);
	bg.setShowImg(false);
	bg.setProcessMethodName("createProcessMethod");
	//开始创建
	out.print(bg.createTable());
%>
</body>
</html>