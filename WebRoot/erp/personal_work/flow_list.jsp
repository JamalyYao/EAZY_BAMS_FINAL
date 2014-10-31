<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>日常工作流程</title>
<%
WebApplicationContext webContext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
DwrApproveProcessService perService = (DwrApproveProcessService) webContext.getBean("dwrApproveProcessService");
List<ApproveProcessBean> processList = perService.listSysApproveProcessAll(this.getServletContext(), request);
%>
<script type="text/javascript">
function showResource(processDefinitionId,resourceType){
	var box = new Sys.msgbox('流程图查看','<%=contextPath %>/processResource.do?type=image&pid='+processDefinitionId,750,500);
	box.show();
}

function transactFlow(flowKey){
	var url = "";
	if(flowKey == "<%= EnumUtil.WORKFLOW_TYPE.LEAVE.key %>"){
		url = "<%=contextPath%>/erp/personal_work/personal_leave_add.jsp"; 
	}else if(flowKey == "<%= EnumUtil.WORKFLOW_TYPE.TRSVEL.key %>"){
		url = "<%=contextPath%>/erp/personal_work/personal_trsvel_add.jsp"; 
	}
	Sys.MDIOpen(url);
}
</script>
</head>
<body style="overflow: hidden;">
	<div style="padding-left:10px;line-height:28px;background: url('<%=contextPath%>/images/toolsbg.png')">
	共有 <%=processList.size() %> 个流程，点击图片开始办理，点击文字查看流程图。
	</div>
	<%
	if (processList.size() > 0) {
		for (int i = 0; i < processList.size(); i++) {
			ApproveProcessBean bean = processList.get(i);
	%>
			<div style="padding:30px;float:left;">
			<a href="javascript:void(0);" title="点击开始办理" onclick="transactFlow('<%= bean.getProcessDefinition().getKey() %>');">
				<img src="<%=contextPath%>/images/workflowimg/evl_fkjc_.png" border="0"/>
			</a>
			
			<p style="text-align:center;">
			<a href="javascript:void(0);" title="点击查看流程图" onclick="showResource('<%= bean.getProcessDefinition().getId() %>');">
				<%= bean.getProcessDefinition().getName() %>
			</a>
			</p>
			</div>
	
	<%
		}}
	%>
</body>
</html>