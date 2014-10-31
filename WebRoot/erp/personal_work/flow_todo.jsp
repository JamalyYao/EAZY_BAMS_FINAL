<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>待办工作</title>
<script type='text/javascript'   src='<%=contextPath%>/js/leftMethod.js'></script>
<script type="text/javascript">
var loadarray = new Array();
loadarray[0] = "<%=contextPath %>/erp/personal_work/flow_todo_leave.jsp";
loadarray[1] = "<%=contextPath %>/erp/personal_work/flow_todo_trsvel.jsp";
function rightload(index){
	var url = loadarray[index];
	Sys.load(url,"flowfrm");
}

window.onload = function(){
	rightload(0);
}
</script>
</head>
<body style="overflow: hidden;">
<div id="splitterContainer">
<div id="leftPane"> 
<div class="div_title1_img">选择操作</div>
<div class="div_leftmethod">
	<div class="leftbut" onclick="rightload(0)" title="请假办理">
	<img src="<%=contextPath %>/images/pagemethodimg/10031_9.png"/>
	<div>请假办理</div>
	</div>
	
	<div class="leftbut" onclick="rightload(1)" title="出差办理">
	<img src="<%=contextPath %>/images/pagemethodimg/10031_9.png"/>
	<div>出差办理</div>
	</div>
</div>
</div>
<div id="rightPane">	
<iframe  frameborder="0"  height="100%" scrolling="auto" marginheight="0" id="flowfrm" width="100%"></iframe>
</div>
</div>
</body>
</html>