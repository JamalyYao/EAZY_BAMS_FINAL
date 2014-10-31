<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/dwrMoblieSmsService.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/dwr/interface/dwrMailService.js"></script>
<title>bottom</title>
</head>
<script type="text/javascript">
function gotoPage(type){
	var url = "";
	if(type == 1){
		url = "<%=request.getContextPath()%>/erp/mobile_sms/sms_manage.jsp";
	}else if(type == 2){
		url = "<%=request.getContextPath()%>/erp/mobile_sms/mail_manage.jsp";
	}else if(type == 3){
		url = "<%=request.getContextPath()%>/erp/personal_work/flow_todo.jsp";
	}else if(type == 4){
		url = "<%=request.getContextPath()%>/erp/personal_work/timed_manager.jsp";
	}else{
		url = "<%=request.getContextPath()%>/erp/center.jsp";
	}
	
	openMDITab(window.parent,url);
}
</script>
<body>
<table cellpadding="0" cellspacing="0" border="0" height="20">
<tr>
<td width="25" valign="bottom"><img src="<%=request.getContextPath() %>/images/bottom_online.png" title='在线人员' onmouseout="hiddenmsgbox();" onmouseover="selectcmsgbox('online',this);" id="onlineimg" style="cursor: pointer;">
</td>
<td width="25"  valign="bottom"><img src="<%=request.getContextPath() %>/images/bottom_sms.png"  id="smsimg" title="即时短信" style="cursor: pointer;" ondblclick="gotoPage(1)">
<a id="smsaudio" href="<%=request.getContextPath() %>/audio/sms.wav"></a>
</td>
<td width="25"  valign="bottom"><img src="<%=request.getContextPath() %>/images/bottom_mail.png" id="mailimg" title="邮件(E-Mail)" style="cursor: pointer;" ondblclick="gotoPage(2)">
<a id="mailaudio" href="<%=request.getContextPath() %>/audio/mail.wav"></a>
</td>
<td width="25"  valign="bottom"><img src="<%=request.getContextPath() %>/images/bottom_approve.png" id="approveimg" title="待办工作" style="cursor: pointer;" ondblclick="gotoPage(3)">
<a id="approveaudio" href="<%=request.getContextPath() %>/audio/approve.wav"></a>
</td>
<td width="25"  valign="bottom"><img src="<%=request.getContextPath() %>/images/bottom_timer.png" id="timerimg" title="定时提醒" style="cursor: pointer;" ondblclick="gotoPage(4)">
<a id="timeraudio" href="<%=request.getContextPath() %>/audio/timer.wav"></a>
</td>
</tr>
</table>
<%@include file="tooltips.jsp" %>
</body>
</html>