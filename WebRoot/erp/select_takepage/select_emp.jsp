<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    <%@ include file="../common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统功能菜单管理</title>
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrHrmEmployeeService.js"></script>
<%
String textid = request.getParameter("textid");
String valueid = request.getParameter("valueid");
String treetype = request.getParameter("treetype");
%>
<script type="text/javascript">
//查询方法
function queryData(){
	startQuery();
	var employee = getQueryParam();
    employee.hrmEmployeeDepidTree = document.getElementById("upcode").value;
	var pager = getPager();
	dwrHrmEmployeeService.listEmployees(employee,pager,queryCallback);
}

function queryCallback(data){
	if(data.success == true){
		initGridData(data.resultList,data.pager);
	}else{
		alertmsg(data,null,null,window);
	}
	endQuery();
}

//双击数据
function dblCallback(obj){
	var box = new Sys.msgbox('明细查看','<%=contextPath%>/erp/hrm/employee_detail.jsp?employeepk='+obj.value,'800','500');
	box.msgtitle="<b>查看人员信息明细</b>";
	box.show();
}


//部门树选择
function treeclick(code){
    
	document.getElementById("upcode").value =code;
	queryData();
}

function employeeclick(myfrmname){
    var win = Sys.getfrm();//获取index页面iframe window对象
    if(myfrmname!=null&&myfrmname != "undefined" && myfrmname != undefined){
    	var myfrmnames = myfrmname.split("@@");
    	if(myfrmnames.length>1){
    		for(var i=0;i<myfrmnames.length;i++){
    			win = win.document.getElementById(myfrmnames[i]).contentWindow;
    		}
    	}else{
    		win = win.document.getElementById(myfrmname).contentWindow;
    	}
    }
     var textid=win.document.getElementById("<%=textid%>"); 
     var valueid = win.document.getElementById("<%=valueid%>");
  
     var treetype= '<%=treetype%>';
     if (treetype == "radio"){
       if(getOneRecordArray() != false){
		var obj=getObjectByPk(getOneRecordArray());
		textid.value = obj.hrmEmployeeName;
		valueid.value = obj.primaryKey;
	   }else{
			alertmsg("请选择相应数据记录...");
			return;
	   }
     
     }else{
        var objs = getRowsObject();
        var value="";
	    var text="";
	    if(objs.length==0){
			alertmsg("请选择相应数据记录...");
			return;
		}
        for(var i=0;i<objs.length;i++){
           value+=objs[i].primaryKey+",";
           text+=objs[i].hrmEmployeeName+",";
	    } 
	   if(valueid.value == "" ||valueid.value == null){
        valueid.value = value;
        textid.value = text;
        }else{
       		var tmps = removerepeat(valueid.value+value,textid.value+text);
        	textid.value = tmps[1];
        	valueid.value = tmps[0];
        }
     }
}

function employeeclickcustomer(dialogId,myfrmname,method){
	employeeclick(myfrmname);
	if(method != null && method.length > 0){
		var win = Sys.getfrm();//获取index页面iframe window对象	
	    if(myfrmname!=null&&myfrmname != "undefined" && myfrmname != undefined){
	    	var myfrmnames = myfrmname.split("@@");
	    	if(myfrmnames.length>1){
	    		for(var i=0;i<myfrmnames.length;i++){
	    			win = win.document.getElementById(myfrmnames[i]).contentWindow;
	    		}
	    	}else{
	    		win = win.document.getElementById(myfrmname).contentWindow;
	    	}
    	}
		eval("win."+method);
	}
	Sys.close(dialogId);
}

</script>
</head>
<body>
<div id="splitterContainer">
<div id="leftPane">
<div class="div_title1_img">选择部门</div>
<jsp:include page="emp_tree.jsp" flush="false">
	<jsp:param name="ischeck" value="true"/>
</jsp:include>
</div>
<div id="rightPane">
<%
	SysGrid bg =new SysGrid(request);

//设置高度及标题
bg.setTableHeight("100%");//可以不指定,默认为100%
bg.setTableTitle("部门人员");
//设置附加信息
bg.setQueryFunction("queryData");	//查询的方法名
bg.setDblFunction("dblCallback");	//双击列的方法名，又返回值，为列对象
bg.setDblBundle("primaryKey");		//双击列的绑定的列值
bg.setShowImg(false);
if (treetype.equals("radio")){
  bg.setCheckboxOrNum(false);
}

    ArrayList<SysColumnControl> sccList = new ArrayList<SysColumnControl>();
    sccList.add(new SysColumnControl("hrmEmployeeName","姓名",1,1,1,0));
    sccList.add(new SysColumnControl("hrmEmployeeCode","工号",1,2,2,0));
    sccList.add(new SysColumnControl("hrmDepartment.hrmDepName","部门",1,2,2,0));
    ArrayList<SysGridColumnBean> colList = UtilTool.getGridColumnList(sccList);

bg.setColumnList(colList);
//开始创建
out.print(bg.createTable());
%>
</div>
</div>
<input type="hidden" id="upcode">
</body>
</html>