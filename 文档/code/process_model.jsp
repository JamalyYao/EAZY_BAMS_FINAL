<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrApproveProcessService.js"></script>
<title>流程模型</title>
<script type="text/javascript">
function queryData(){
	startQuery();
	var pager = getPager();
	dwrApproveProcessService.listProcessModelByPager(pager,queryCallback);
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
	//alert(obj.value);
}

function createMethod(rowObj){
	var	str="";
	var exportUrl = "<%=contextPath %>/modelExport.do?id="+rowObj.model.id;
	
	str ="<a href='"+exportUrl+"' title='导出'><img src='<%=contextPath%>/images/grid_images/rowinfo.png' border='0'/></a>";
	str+="&nbsp;&nbsp;<a href='javascript:void(0)' title='部署' onclick=\"deploy('"+rowObj.model.id+"')\"><img src='<%=contextPath%>/images/grid_images/valid1_.png' border='0'/></a>";
	str+="&nbsp;&nbsp;<a href='javascript:void(0)' title='删除' onclick=\"del('"+rowObj.model.id+"')\"><img src='<%=contextPath%>/images/grid_images/rowdel.png' border='0'/></a>";
	
	return str;
}

function deploy(id){
	confirmmsg("确定进行此操作吗?","deployok('"+id+"')");
}

function deployok(id){
	dwrApproveProcessService.deployProcessModelById(id,callback);
}

function callback(data){
	alertmsg(data,"queryData()");
}

function del(id){
	confirmmsg("确定要删除此模型吗?","delok('"+id+"')");
}

function delok(id){
	dwrApproveProcessService.deleteProcessModelById(id,callback);
}

function create(){
	window.location = '<%=contextPath %>/erp/system_set/process_model_add.jsp';
}

</script>
</head>
<body>
<%
SysGrid bg =new SysGrid(request);
bg.setTableTitle("流程模型列表");

//放入按钮
ArrayList<SysGridBtnBean> btnList =new ArrayList<SysGridBtnBean>();
btnList.add(new SysGridBtnBean("创建模型","create()","add.png"));
bg.setBtnList(btnList);

//设置附加信息
bg.setQueryFunction("queryData");	//查询的方法名
bg.setDblFunction("dblCallback");	//双击列的方法名，又返回值，为列对象
bg.setDblBundle("id");		//双击列的绑定的列值

//放入列
ArrayList<SysColumnControl> sccList = new ArrayList<SysColumnControl>();
sccList.add(new SysColumnControl("model.id", "模型ID",1, 2, 2, 0));
sccList.add(new SysColumnControl("model.name", "模型名称",1, 2, 2, 0));
sccList.add(new SysColumnControl("model.key", "模型KEY值",1, 2, 2, 0));
sccList.add(new SysColumnControl("model.version", "版本",1, 2, 2, 0));
sccList.add(new SysColumnControl("createTime", "创建时间",1, 2, 2, 0));
sccList.add(new SysColumnControl("lastUpdateTime", "最后更新时间",1, 2, 2, 0));
//sccList.add(new SysColumnControl("model.metaInfo", "元数据",1, 2, 2, 0));

ArrayList<SysGridColumnBean> colList = UtilTool.getGridColumnList(sccList);

for(int i=0;i<colList.size();i++){
	
}
bg.setColumnList(colList);


bg.setShowImg(false);
bg.setCheckboxOrNum(false);
bg.setShowProcess(true);
bg.setProcessMethodName("createMethod");

//开始创建
out.print(bg.createTable());
%>
</body>
</html>