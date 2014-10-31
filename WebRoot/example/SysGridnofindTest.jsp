<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>

<%@ include file="../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrHrmEmployeeService.js"></script>
<title>java生成grid</title>
<script>
//查询方法
function queryData(){
	startQuery();
	var employee = getQueryParam();
	var pager = getPager();
	//不封装对象集合（按顺序组合）	
	var c =getCustomerParam();
	
	dwrHrmEmployeeService.listEmployees(employee,pager,queryCallback);
}

function queryCallback(data){
	if(data.success == true){
		initGridData(data.resultList,data.pager);
	}else{
		alert(data.message);
	}
	endQuery();
}

//双击数据
function dblCallback(obj){
	var t = obj.id;
	var ids = t.split("_"); 
	alert(ids[1]);	//此处的pk为定义的pk
}

function deleteObject(){
	//针对多条记录进行操作
	if(getAllRecordArray() != false){
		var recordsPks = getAllRecordArray();
		for(var i=0;i<recordsPks.length;i++){
			alert("记录ID:"+recordsPks[i]);
		}
	}
}

function add(){
	alert("add data");
}

function update(){
	//针对一条记录进行操作
	if(getOneRecordArray() != false){
		alert("记录ID:"+getOneRecordArray());
	}
}


function info(){
	alert("view data");
}
function getother(){
	var a = document.getElementById("hrmtest");
	//alert("不封装对象属性获取:"+a.value);
}
</script>
</head>
<body>
<%
	SysGrid bg =new SysGrid(request);

//设置高度及标题
//bg.setTableHeight("100%");//可以不指定,默认为100%
//bg.setTableWidth("80%");//可以不指定,默认为100%
//bg.setBodyScroll("auto");//设置body页面是否显示滚动条，默认为hidden auto scroll
bg.setTableTitle("Sys表格Java调用测试");
bg.setShowImg(false);//默认为true 显示切换视图 为true必须指定图片相关信息
bg.setIsautoQuery(false);//默认为自动执行查询
//bg.setTableRowSize(20);//默认每页显示记录数30 选择10 20 30 50 80  
//设置附加信息
bg.setQueryFunction("queryData");	//查询的方法名
bg.setDblFunction("dblCallback");	//双击列的方法名，又返回值，为列对象
bg.setDblBundle("primaryKey");		//双击列的绑定的列值

//放入列
ArrayList tmplist = new ArrayList();
tmplist.add(new SysColumnControl("test","测试",1,2,2,0));
ArrayList<SysGridColumnBean> colList = UtilTool.getGridColumnList(tmplist);

bg.setColumnList(colList);
//开始创建
out.print(bg.createTable());
%>
</body>
</html>