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
	//不封装对象集合（按顺序组合)
	var c =getCustomerParam();
	//alert(c);
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
	alert(obj.value);
}

function deleteObject(){
	alert(getAllRecordArray());
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
		var obj=getObjectByPk(getOneRecordArray());
		var str="employee["+obj.primaryKey+"]:\n\n\thrmEmployeeName = "+obj.hrmEmployeeName+"\n\n\thrmEmployeeInTime = "+obj.hrmEmployeeInTime+"\n\n";
		alert(str);
	}
}
function edit(id){
	var obj=getObjectByPk(id);
	var str="employee["+obj.primaryKey+"]:\n\n\thrmEmployeeName = "+obj.hrmEmployeeName+"\n\n\thrmEmployeeInTime = "+obj.hrmEmployeeInTime+"\n\n";
	alert(str);
}

function info(){
	var objs = getRowsObject();
	var str="";
	for(var i=0;i<objs.length;i++){
		str+="employee["+objs[i].primaryKey+"]:\n\n\thrmEmployeeName = "+objs[i].hrmEmployeeName+"\n\n\thrmEmployeeInTime = "+objs[i].hrmEmployeeInTime+"\n\n";
	}
	alert(str);
}
function getother(){
	var a = document.getElementById("hrmtest1").value+"-"+document.getElementById("hrmtest2").value;
	return a;
	//alert("不封装对象属性获取:"+a.value);
}

function createProcessMethod(rowObj){
	var str="";
	if(rowObj.hrmEmployeeSex ==<%=EnumUtil.HRM_EMPLOYEE_SEX.Man.value%>){
		str= "<a href='javascript:void(0)' title='编辑' onclick=\"edit('"+rowObj.primaryKey+"')\"><img src='<%=contextPath%>/images/grid_images/rowedit.png' border='0'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' title='查看'><img src='<%=contextPath%>/images/grid_images/rowinfo.png' border='0'/></a>"
	}else{
		str="<a href='javascript:void(0)' title='不可用'><img src='<%=contextPath%>/images/grid_images/rowedit.png' border='0' style='filter:gray;'/></a>&nbsp;&nbsp;<a href='javascript:void(0)' title='查看'><img src='<%=contextPath%>/images/grid_images/rowinfo.png' border='0'/></a>";
	}
	return str;
}

//列显示替换方法
function repleaSex(rowObj){
	var str="";
	if(rowObj.hrmEmployeeSex ==<%=EnumUtil.HRM_EMPLOYEE_SEX.Man.value%>){
		str= "<font style='color:blue'><%=EnumUtil.HRM_EMPLOYEE_SEX.valueOf(EnumUtil.HRM_EMPLOYEE_SEX.Man.value)%></font>"
	}else{
		str= "<font style='color:red'><%=EnumUtil.HRM_EMPLOYEE_SEX.valueOf(EnumUtil.HRM_EMPLOYEE_SEX.Woman.value)%></font>"
	}
	return str;
}


function repleahrmName(rowObj){
	var str="";
	var namelen = rowObj.hrmEmployeeName.length;
	if(namelen > 0 && namelen<=6){
		str= "<font style='color:#336699'>名字长度:"+namelen+"个字符</font>"
	}else{
		str= "名字长度:"+namelen+"个字符";
	}
	return str;
}

</script>
</head>
<body>

<%
	SysGrid bg =new SysGrid(request);

//设置高度及标题
bg.setTableHeight("80%");//可以不指定,默认为100%
bg.setTableWidth("80%");//可以不指定,默认为100%
bg.setBodyScroll("auto");//设置body页面是否显示滚动条，默认为hidden auto scroll
bg.setTableTitle("Sys表格Java调用测试");
bg.setShowImg(true);//默认为true 显示切换视图 为true必须指定图片相关信息，辅助showvie属性 
//bg.setShowView(SysGrid.SHOW_IMAGE);//视图显示定义 all 全部 table 只显示表格  img 只显示图片
//bg.setIsautoQuery(false);//默认为自动执行查询
bg.setTableRowSize(10);//默认每页显示记录数30 选择10 20 30 50 80  
//bg.setDefaultShow(SysGrid.DEFAULT_SHOWIMAGE); //如果showview为all或showimg为ture 设置该属性默认打开的视图
//设置附加信息
bg.setQueryFunction("queryData");	//查询的方法名
bg.setDblFunction("dblCallback");	//双击列的方法名，又返回值，为列对象
bg.setDblBundle("primaryKey");		//双击列的绑定的列值
//bg.setCheckboxOrNum(false);

//放入按钮
ArrayList<SysGridBtnBean> btnList =new ArrayList<SysGridBtnBean>();
btnList.add(new SysGridBtnBean("新增","add()","add.png"));
btnList.add(new SysGridBtnBean("删除","deleteObject()","close.png"));
btnList.add(new SysGridBtnBean("根据主键获取行数据对象","update()","edit.png"));
btnList.add(new SysGridBtnBean("获取被选中行数据对象","info()","info.png"));
bg.setBtnList(btnList);

//放入操作提示
ArrayList<SysGridTitleBean> titleList = new ArrayList<SysGridTitleBean>();
String imgpath = contextPath+"/images/grid_images/";
titleList.add(new SysGridTitleBean("<img src='"+imgpath+"rowedit.png' border='0'/>","操作提示1"));
titleList.add(new SysGridTitleBean("<img src='"+imgpath+"rowinfo.png' border='0'/>","操作提示2操作提示2操作提示2操作提示2操作提示2"));
bg.setHelpList(titleList);

//放入列
ArrayList<SysGridColumnBean> colList = UtilTool.getGridColumnList(UtilTool.getColumnShow(this.getServletContext(),"人员列表"));


//进行高级查询显示处理
for(int i=0;i<colList.size();i++){
	SysGridColumnBean bc =colList.get(i);
	if(bc.isShowAdvanced()||bc.isShowColumn()){
		if("hrmEmployeeInTime".equalsIgnoreCase(bc.getDataName())){
	//高级查询显示
	DateType date = new DateType();
	date.setDefaultDate(UtilWork.getToday());
	bc.setColumnTypeClass(date);
	//列样式
	bc.setColumnStyle("padding-left:15px;color:blue;");
		}
		if("hrmEmployeeSex".equalsIgnoreCase(bc.getDataName())){
	//设置高级查询显示样式
	
	SelectType select  = new SelectType(EnumUtil.HRM_EMPLOYEE_SEX.getSelectAndText("-1,-请选择人员性别-"));
	select.setCustomerFunction(new String[]{"onchange=\"queryData();\""});
	bc.setColumnTypeClass(select);
	
	bc.setColumnReplace("repleaSex");
	
	//设置列显示样式
	bc.setColumnStyle("text-align:center;");
		}
	}
}

//放入自定义生成列
colList.add(ColumnUtil.getCusterShowColumn("abc","自定义","repleahrmName",0,"text-align:center;"));

//放入自定义高级查询对象
OtherType other = new OtherType("<input type ='text' class ='niceform' id ='hrmtest1' size='5'/>&nbsp;至&nbsp;<input type ='text' class ='niceform' id ='hrmtest2' size='5'/>");//自定义对象
other.setGetValueMethod("getother()");
colList.add(ColumnUtil.getCusterAdvancedColumn("hrmtest","自定义高级",other));

//从字典表加载
//测试高级查询
SelectType sel = new SelectType(UtilTool.getLibraryInfoList(this.getServletContext(),request,"-1,-请选择婚姻状况-","02"));
colList.add(ColumnUtil.getCusterAdvancedColumn("hrmmary","婚姻状况",sel));

bg.setColumnList(colList);
//设置列操作对象
bg.setShowProcess(true);//默认为false 为true请设置processMethodName
bg.setProcessMethodName("createProcessMethod");//生成该操作图标的js方法,系统默认放入数据行对象

//设置图片显示信息
//bg.setImgShowNum(6);//不指定默认5个
bg.setImgShowUrl("hrmEmployeeImageInfoId");//显示img的属性字段，没有填写-1
bg.setImgShowText("hrmEmployeeName,hrmEmployeeImageInfoId,&不转换");
bg.setImgNoDefaultPath(absPath+"/images/noimages/other.png");//可以不指定，系统采用默认暂无图片
//bg.setImgShowCode("_Min");//如果需要显示的图片为缩略图请使用
//bg.setImgdivwidth("300");//显示详细信息的div大小，默认280;
//bg.setImgwidth("auto");//不设置为自动
bg.setImgheight("128");//不设置为自动
bg.setImgShowTextLen(0);//显示文本的最大长度,不设置为8个字符

bg.setShowImageDetail(false);//是否显示图片详细

//开始创建
out.print(bg.createTable());
%>
</body>
</html>