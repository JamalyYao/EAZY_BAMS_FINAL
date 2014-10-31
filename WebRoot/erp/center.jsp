<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="common.jsp" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type='text/css' rel='stylesheet'  href='<%=contextPath %>/js/movediv/movediv.css'/>
<script  type='text/javascript'   src='<%=contextPath %>/js/movediv/movediv.js'></script>
<script  type='text/javascript'   src='<%=contextPath %>/js/movediv/httpRequest.js'></script>
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrMoblieSmsService.js"></script>
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrMailService.js"></script>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
SessionUser user = (SessionUser)LoginContext.getSessionValueByLogin(request);
boolean noticeshow = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Notice.value);
boolean postsshow = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Post.value);
boolean notesshow = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Notepad.value);
boolean voteshow = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Vote.value);
boolean schshow = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Schedule.value);
boolean approveshow = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Approve.value);
boolean applyshow = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Apply.value);
boolean smsshow = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Sms.value);
boolean mailshow = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Mail.value);
boolean showweather = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Weather.value);
boolean shownotebook = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Notes.value);
boolean showRegular = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Regular.value);
boolean showTimer = UtilTool.isShowDeskTop(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Timer.value);


String isopen = SystemConfig.getParam("erp.center.weather");
boolean bl = "true".equalsIgnoreCase(isopen);
String wurl = SystemConfig.getParam("erp.weather.url");
String defaultmore = SystemConfig.getParam("erp.weather.defaultmore");
String more = SystemConfig.getParam("erp.weather.more");
if(bl){
	OaDesktopSet depset = UtilTool.getDeskTopByType(this.getServletContext(),request,EnumUtil.OA_DESKTOP_TYPE.Weather.value);
	if(depset != null && depset.getOaDesktopValue() != null && depset.getOaDesktopValue().length()>0){
		String[] tmps = depset.getOaDesktopValue().split(",");
		if(tmps.length>1){
			wurl+="?id="+tmps[1]+"T";
			more+=tmps[1]+".shtml";
		}else{
			more = defaultmore;
		}
	}else{
		more = defaultmore;
	}
}
%>
<title>办公桌面</title>
<script type="text/javascript">
window.onload = function(){
	CoolDrag.init('container','<%=user.getCompanyId()%>','<%=user.getUserInfo().getPrimaryKey()%>');
	<%if(bl && showweather){ %>
		window.setTimeout("document.getElementById('weatherfrm').src ='<%=wurl%>'",0);
	<%}%>

	window.setTimeout("loadxml()",1000);
	window.setTimeout("loadxml_task()",1000);//待办工作
	window.setTimeout("loadxml_apply('<%=EnumUtil.WORKFLOW_TYPE.LEAVE.key%>','applyLeave')",1000);//我的申请
	window.setTimeout("loadxml_other()",1500);
	window.setTimeout("loadxml_ref()",1500);
	window.setTimeout("loadxml_sms()",1500);
	window.setTimeout("loadxml_mail(1,'mailSystem')",1500);
}
function loadxml(){
	GetXmlHttp('<%=contextPath%>/erp/desktop/desktopHtml.jsp');
}

function loadxml_task(){
	GetXmlTask("<%=contextPath%>/erp/desktop/desktopHtml_approve.jsp");
}

function loadxml_other(){
	GetXmlHttpOther('<%=contextPath%>/erp/desktop/desktopHtml_other.jsp');
}

function loadxml_ref(){
	GetXmlHttpRef("<%=contextPath%>/erp/desktop/desktopHtml_refsh.jsp");
}

function loadxml_sms(){
	<%if(smsshow){%>
		GetXmlHttpSms("<%=contextPath%>/erp/desktop/desktopHtml_sms.jsp");
	<%}%>
}

function loadxml_mail(type,objid){
	document.getElementById("mailType").value = type;
	GetXmlHttpMail('<%=contextPath%>/erp/desktop/desktopHtml_mail.jsp?mailtype='+type,objid);
}

function loadxml_apply(type,objid){
	document.getElementById("applyType").value = type;
	GetXmlHttpApply('<%=contextPath%>/erp/desktop/desktopHtml_apply.jsp?applyType='+type,objid);
}

function GetXmlValueByTask(xh){
	<%if(approveshow){%>
	if(xh.readyState == 4) {
		if(xh.status == 200) {
        	var str =xh.responseXML.documentElement;
			if(str.getElementsByTagName("Approve").length>0){
				document.getElementById("approvecontent").innerHTML =  str.getElementsByTagName("Approve")[0].childNodes[0].nodeValue;
			}
        }
    }
    <%}%>
}


function GetXmlValueByTagApply(objid,xh){
	if(xh.readyState == 4) {
		if(xh.status == 200) {
        	var str =xh.responseXML.documentElement;
			<%if(applyshow){%>
			if(str.getElementsByTagName("APPLY").length>0){
				var obj = document.getElementById(objid);
				if(obj!=null){
					obj.innerHTML =  str.getElementsByTagName("APPLY")[0].childNodes[0].nodeValue;
				}
			}
			<%}%>
    	}
    }
}


function GetXmlValueByTagOther(xh){
	if(xh.readyState == 4) {
		if(xh.status == 200) {
        	var str =xh.responseXML.documentElement;
			if(str.getElementsByTagName("Vote").length>0){
				document.getElementById("votecontent").innerHTML =  str.getElementsByTagName("Vote")[0].childNodes[0].nodeValue;
			}
			if(str.getElementsByTagName("Schedule").length>0){
				document.getElementById("schcontent").innerHTML =  str.getElementsByTagName("Schedule")[0].childNodes[0].nodeValue;
			}
			if(str.getElementsByTagName("Regul").length>0){
				document.getElementById("regularContent").innerHTML = str.getElementsByTagName("Regul")[0].childNodes[0].nodeValue;
			}
    	}
    }
}

function GetXmlValueByTagRef(xh){
	if(xh.readyState == 4) {
		if(xh.status == 200) {
        	var str =xh.responseXML.documentElement;

			if(str.getElementsByTagName("Notes").length>0){
				document.getElementById("notescontent").innerHTML =  str.getElementsByTagName("Notes")[0].childNodes[0].nodeValue;
			}
			if(str.getElementsByTagName("Timer").length>0){
				document.getElementById("timercontent").innerHTML =  str.getElementsByTagName("Timer")[0].childNodes[0].nodeValue;
			}
    	}
    }
}

function GetXmlValueByTagMail(objid,xh){
	if(xh.readyState == 4) {
		if(xh.status == 200) {
        	var str =xh.responseXML.documentElement;
			<%if(mailshow){%>
			if(str.getElementsByTagName("MAIL").length>0){
				var obj = document.getElementById(objid);
				if(obj!=null){
					obj.innerHTML =  str.getElementsByTagName("MAIL")[0].childNodes[0].nodeValue;
				}
			}
			<%}%>
    	}
    }
}

function GetXmlValueByTagSms(xh){
	if(xh.readyState == 4) {
		if(xh.status == 200) {
        	var str =xh.responseXML.documentElement;
			<%if(smsshow){%>
			if(str.getElementsByTagName("SMS").length>0){
				document.getElementById("smscontent").innerHTML =  str.getElementsByTagName("SMS")[0].childNodes[0].nodeValue;
			}
			<%}%>
    	}
    }
}

function GetXmlValueByTag(xh){
	if(xh.readyState == 4) {
		if(xh.status == 200) {
        	var str =xh.responseXML.documentElement;
			if(str.getElementsByTagName("Notice").length>0){
				document.getElementById("noticediv").innerHTML =  str.getElementsByTagName("Notice")[0].childNodes[0].nodeValue;
			}
			if(str.getElementsByTagName("Posts").length>0){
				document.getElementById("postcontent").innerHTML =  str.getElementsByTagName("Posts")[0].childNodes[0].nodeValue;
			}
			if(str.getElementsByTagName("Note").length>0){
				document.getElementById("notecontent").innerHTML =  str.getElementsByTagName("Note")[0].childNodes[0].nodeValue;
			}
			if(str.getElementsByTagName("Vote").length>0){
				document.getElementById("votecontent").innerHTML =  str.getElementsByTagName("Vote")[0].childNodes[0].nodeValue;
			}
    	}
    }
}

function showVote(id){
	 var box = new Sys.msgbox('投票结果查看','<%=contextPath%>/erp/communication/vote_view_pager.jsp?voteId='+id, '800','500');
     box.msgtitle="<b>查看投票结果</b>";
     box.show();
}

function showRegular(id){
	var box = new Sys.msgbox('明细查看','<%=contextPath%>/erp/company_resources/regulations_detail.jsp?rid='+id,'800','500');
	box.msgtitle="<b>查看规章记录明细</b>";
	box.show();
}

function showOaSms(id,isread){
	if(isread == <%=EnumUtil.OA_SMS_INBOX_ISREAD.two.value%>){
		dwrMoblieSmsService.setOaSmsInboxIsread(id,getOaSmsInboxinfo);
	}
	var box = new Sys.msgbox('明细查看','<%=contextPath%>/erp/mobile_sms/inbox_detail.jsp?oaSmsInboxId='+id,'800','500');
	box.msgtitle="<b>查看短信明细</b>";
	box.show();
}
function getOaSmsInboxinfo(data){
  loadxml_sms();
} 
function showOaMail(id,isread){
	if(isread == <%=EnumUtil.OA_SMS_INBOX_ISREAD.two.value%>){
		dwrMailService.setMailinboxIsread(id,function(data){
			loadxml_mail(1,'mailSystem');
		});
	}
	var box = new Sys.msgbox('明细查看','<%=contextPath%>/erp/mobile_sms/mail_inbox_detail.jsp?mailempid='+id,'800','500');
	box.msgtitle="<b>邮件信息明细查看</b>";
	box.show();
}

function showOaNetMail(id,isread,sid){
	if(isread == <%=EnumUtil.OA_SMS_INBOX_ISREAD.two.value%>){
		var ids = new Array();
		ids[0] = id;
		dwrMailService.updateMailReadStatus(ids,function(data){
			loadxml_mail(2,'mailNet');
		});
	}
	var box = new Sys.msgbox('明细查看','<%=contextPath%>/erp/mobile_sms/netmail_inbox_detail.jsp?mid='+id+'&sid='+sid,'800','550');
	box.msgtitle="<b>邮件信息明细查看</b>";
	box.show();
}

function showNotice(id){
	var box = new Sys.msgbox('明细查看','<%=contextPath%>/erp/issue_info/notice_detail.jsp?oid='+id,'800','500');
	box.msgtitle="<b>查看通知明细</b>";
	box.show();
}

function showPosts(id){
	var box = new Sys.msgbox('明细查看','<%=contextPath%>/erp/issue_info/announcement_detail.jsp?aid='+id,'800','500');
	box.msgtitle="<b>查看公告明细</b>";
	box.show();
}

function showNotepd(id){
	var box = new Sys.msgbox('明细查看','<%=contextPath%>/erp/issue_info/adversaria_detail.jsp?did='+id,'800','500');
	box.msgtitle="<b>查看记事明细</b>";
	box.show();
}

function showProcessTrace(instanceId){
	var box = new Sys.msgbox('流程追踪','<%=contextPath %>/processTrace.do?id='+instanceId,750,500);
	box.msgtitle="<b>此对话框显示的图片是由引擎自动生成的，并用红色标记当前的节点</b>";
	box.show();
}

function moreApplyByType(){
	var type = document.getElementById("applyType").value;
	var url = "";
	if(type== '<%=EnumUtil.WORKFLOW_TYPE.LEAVE.key%>'){
		url = "<%=contextPath%>/erp/personal_work/flow_query.jsp";
	}else if(type== '<%=EnumUtil.WORKFLOW_TYPE.TRSVEL.key%>'){
		url = "<%=contextPath%>/erp/personal_work/flow_query.jsp";
	}
	openMDITab(window.parent.parent,url);
}

//邮件
function moremail(){
	var type = document.getElementById("mailType").value
	var url="";
	if(type==1){
		url="<%=contextPath %>/erp/mobile_sms/mail_manage.jsp";
	}else if(type==2){
		url="<%=request.getContextPath()%>/erp/mobile_sms/internet_mail.jsp";
	}
	openMDITab(window.parent.parent,url);
}


function toupiao(id){
	var box = new Sys.msgbox('参与投票','<%=contextPath%>/erp/communication/emp_voting_page.jsp?choose=1&voteId='+id,'800','500');
	box.msgtitle="<b>参加内部投票</b>";
	var butarray = new Array();
	butarray[0] = "ok|votingByDesk('"+box.dialogId+"')| 投 票 ";
	butarray[1] = "cancel|| 取 消 ";
	box.buttons = butarray;
	box.show();
}

function showNoteBook(id){
	var box = new Sys.msgbox('明细查看','<%=contextPath%>/erp/personal_work/oa_notebook_detail.jsp?aid='+id,'800','500');
	box.msgtitle="<b>查看便签明细</b>";
	box.show();
}

function addnotebook(){
	var box = new Sys.msgbox('添加便签','<%=contextPath%>/erp/personal_work/oa_notebook_add.jsp?type=1','700','400');
	box.msgtitle="<b>添加个人便签</b>";
	var butarray = new Array();
	butarray[0] = "ok|savedesktop('"+box.dialogId+"','undefined','loadxml_ref()');";
	butarray[1] = "cancel";
	box.buttons = butarray;
	box.show();
}

function addtimer(){
	var box = new Sys.msgbox('添加提醒','<%=contextPath%>/erp/personal_work/timed_add.jsp?type=1','800','500');
	box.msgtitle="<b>添加定时提醒</b>";
	var butarray = new Array();
	butarray[0] = "ok|savedesktop('"+box.dialogId+"','undefined','loadxml_ref()');";
	butarray[1] = "cancel";
	box.buttons = butarray;
	box.show();
}

</script>
<style type="text/css">
	button { 
		position: relative;
		border: 0; 
		padding: 0;
		cursor: pointer;
		overflow: visible; /* removes extra side padding in IE */
		margin-bottom: 10px
	}
	
	
	button span { 
		position: relative;
		display: block; 
		white-space: nowrap;
		width: 100px;
	}

	button.submitBtn { 
		padding: 0 8px 0 0; 
		margin-right:20px; 
		font-size:13px; 
		text-align: center; 
		background: transparent url(<%=contextPath%>/images/btn_desk_right.png) no-repeat right top; 
	}
		
	button.submitBtn span {
		padding-left: 18px;
		padding-right:10px;
		padding-top:12px;
		height:40px; 
		background: transparent url(<%=contextPath%>/images/btn_desk_left.png) no-repeat left top; 
		color:#054477;
	}
</style>
</head>
<body style="background-color: white">
<input type="hidden" id="applyType" value="">
<input type="hidden" id="mailType" value="">
<table width="100%" cellpadding="0" cellspacing="0">
<tr><td>
<div id="container">
	<div id="leftcontainer" class="leftcontainer">
		<%if(postsshow){ %>
		<div class="dragLayer" id="postwin">
			<div class="dragHeader">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/tab_go.png') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Post.value) %>
				</div>
				<div style="float: right;">
					<span class="min">5</span>
					<label class="more" title="更多" onclick="openMDITab(window.parent.parent,'<%=contextPath %>/erp/personal_work/company_anno.jsp')">
					</label>
				</div>
			</div>
			<div class="content" id="postcontent">
				<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0" ></p></div>
			</div>
		</div>
		<%} %>
		<%if(noticeshow){ %>
		<div class="dragLayer" id="noticewin">
			<div class="dragHeader">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/sounda.png') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Notice.value) %>
				</div>
			
				<div style="float: right;">
					<span class="min">5</span>
					<label class="more" title="更多" onclick="openMDITab(window.parent.parent,'<%=contextPath %>/erp/personal_work/company_notice.jsp')">
					</label>
				</div>
				
			</div>
			<div class="content" id="noticediv">
				<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0" ></p></div>
			</div>
		</div>
		<%} %>
		<%if(voteshow){ %>
		<div class="dragLayer" id="votewin">
			<div class="dragHeader">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/plugin.png') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Vote.value) %>
				</div>
				<div style="float: right;">
					<span class="min">5</span>
					<label class="more" title="更多" onclick="openMDITab(window.parent.parent,'<%=contextPath %>/erp/communication/vote_total_pager.jsp')">
					</label>
				</div>
			</div>
			<div class="content" id="votecontent">
				<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0" ></p></div>
			</div>
		</div>
		<%} %>
		<%if(notesshow){ %>
		<div class="dragLayer" id="notewin">
			<div class="dragHeader">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/page_component.gif') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Notepad.value) %>
				</div>
				<div style="float: right;">
					<span class="min">5</span>
					<label class="more" title="更多" onclick="openMDITab(window.parent.parent,'<%=contextPath %>/erp/personal_work/company_adver.jsp')">
					</label>
				</div>
			</div>
			<div class="content" id="notecontent">
				<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0" ></p></div>
			</div>
		</div>
		<%} %>
	</div>
	<div id="middlecontainer" class="middlecontainer">
		<%if(approveshow){ %>
		<div class="dragLayer" id="approvewin">
			<div class="dragHeader">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/computer.gif') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Approve.value) %>
				</div>
				<div style="float: right;">
					<span class="min">5</span>
					<label class="more" title="更多" onclick="openMDITab(window.parent.parent,'<%=contextPath %>/erp/personal_work/flow_todo.jsp')">
					</label>
				</div>
			</div>
			<div class="content" id="approvecontent">
				<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0" ></p></div>
			</div>
		</div>
		<%} %>
	
		<%if(applyshow){ %>
		<div class="dragLayer" id="applywin">
			<div class="dragHeader">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/apply.png') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Apply.value) %>
				</div>
				<div style="float: right;">
					<span class="min">5</span>
					<label class="more" title="更多" onclick="moreApplyByType()">
					</label>
				</div>
			</div>
			<div class="content">

				<DIV class="tabdiv" style="height: 100%;width:98%;" id="applytab">
				<UL class="tags">
					<LI><A onClick="tabapply.selectTag(this);loadxml_apply('<%=EnumUtil.WORKFLOW_TYPE.LEAVE.key%>','applyLeave');" href="javascript:void(0)">请假</A></LI>
					<LI><A onClick="tabapply.selectTag(this);loadxml_apply('<%=EnumUtil.WORKFLOW_TYPE.TRSVEL.key%>','applyPersonalOut');" href="javascript:void(0)">出差</A></LI>
				</UL>
				<DIV class="tagContentdiv">
					<DIV class="tagContent" id="applyLeave">
					<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0" ></p></div>
					</DIV>
					<DIV class="tagContent" id="applyPersonalOut">
					<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0" ></p></div>
					</DIV>
				</DIV>
				</DIV>
			</div>
		</div>
		<%} %>
		
		<%if(schshow){ %>
		<div class="dragLayer" id="schwin">
			<div class="dragHeader">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/clock.png') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Schedule.value) %>
				</div>
				<div style="float: right;">
					<span class="min">5</span>
					<label class="more" title="更多" onclick="openMDITab(window.parent.parent,'<%=contextPath %>/erp/work_arrange/workCalender.jsp')">
					</label>
				</div>
			</div>
			<div class="content" id="schcontent">
				<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0" ></p></div>
			</div>
		</div>
		<%} %>
		<%if(smsshow){ %>
		<div class="dragLayer" id="smswin">
			<div class="dragHeader">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/phone.png') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Sms.value) %>
				</div>
				<div style="float: right;">
					<span class="min">5</span>
					<label class="more" title="更多" onclick="openMDITab(window.parent.parent,'<%=contextPath %>/erp/mobile_sms/sms_manage.jsp')">
					</label>
				</div>
			</div>
			<div class="content" id="smscontent">
				<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0" ></p></div>
			</div>
		</div>
		<%} %>
		<%if(mailshow){ %>
		<div class="dragLayer" id="mailwin">
			<div class="dragHeader">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/email.png') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Mail.value) %>
				</div>
				<div style="float: right;">
					<span class="min">5</span>
					<label class="more" title="更多" onclick="moremail()">
					</label>
				</div>
			</div>
			<div class="content">
				<DIV class="tabdiv" style="height: 100%;width:98%;" id="mailtab">
				<UL class="tags">
					<LI><A onClick="tabmail.selectTag(this);loadxml_mail(1,'mailSystem');" href="javascript:void(0)">公司邮件</A></LI>
					<LI><A onClick="tabmail.selectTag(this);loadxml_mail(2,'mailNet');" href="javascript:void(0)">外网邮件</A></LI>
				</UL>
				<DIV class="tagContentdiv">
					<DIV class="tagContent" id="mailSystem">
					<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0" ></p></div>
					</DIV>
					<DIV class="tagContent" id="mailNet">
					<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0" ></p></div>
					</DIV>
				</DIV>
				</div>
			</div>
		</div>
		<%} %>
	</div>
	<div style="clear:both;"></div>
</div>
</td>
<td valign="top" width="240">
	<%if(bl && showweather){ %>
		<div class="dragLayer" id="weather">
			<div class="dragHeader2">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/weatherimg.png') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Weather.value) %>
				</div>
				<div style="width:55px;float: right;padding-top:5px;">
					<a title="更多" href="javascript:void(0);"  onclick="openMDITab(window.parent.parent,'<%=more %>')">
						<img src="<%=contextPath %>/js/movediv/move_more_.gif" border="0"></img>
					</a>
				</div>
			</div>
			<div class="content" style="height:20px;width:190px;">
				<iframe frameborder="0" height="20" width="190"  scrolling="no" marginheight="0" id="weatherfrm"></iframe>
			</div>
		</div>
		<%} %>
		
		<%if(showTimer){ %>
		<div class="dragLayer" id="timer">
			<div class="dragHeader2">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/stimer.png') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Timer.value) %>
				</div>
				<div style="width:65px;float: right;">
					<span class="add" title="添加提醒" onclick="addtimer()">+</span>
					
					<a title="更多" href="javascript:void(0);"  onclick="openMDITab(window.parent.parent,'<%=contextPath %>/erp/personal_work/timed_query_valid.jsp')">
						<img src="<%=contextPath %>/js/movediv/move_more_.gif" border="0"></img>
					</a>
				</div>
			</div>
			<div class="content" id="timercontent">
				<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0"></p></div>
			</div>
		</div>
		<%} %>
		
		
		<%if(shownotebook){ %>
		<div class="dragLayer" id="notes">
			<div class="dragHeader2">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/notebook.png') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Notes.value) %>
				</div>
				<div style="width:65px;float: right;">
					<span class="add" title="添加便签" onclick="addnotebook()">+</span>
					
					<a title="更多" href="javascript:void(0);"  onclick="openMDITab(window.parent.parent,'<%=contextPath %>/erp/personal_work/notebook.jsp')">
						<img src="<%=contextPath %>/js/movediv/move_more_.gif" border="0"></img>
					</a>
				</div>
			</div>
			<div class="content" id="notescontent">
				<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0"></p></div>
			</div>
		</div>
		<%} %>
		
		
		<%if(showRegular){ %>
		<div class="dragLayer" id="weather">
			<div class="dragHeader2">
				<div class="dragleft" style="background: url('<%=contextPath %>/images/projectimg/icon_monitor_mac.gif') 3px no-repeat;">
					<%=EnumUtil.OA_DESKTOP_TYPE.valueOf(EnumUtil.OA_DESKTOP_TYPE.Regular.value) %>
				</div>
				<div style="width:55px;float: right;padding-top:5px;">
					<a title="更多" href="javascript:void(0);"  onclick="openMDITab(window.parent.parent,'<%=contextPath %>/erp/company_resources/regulations_query.jsp')">
						<img src="<%=contextPath %>/js/movediv/move_more_.gif" border="0"></img>
					</a>
				</div>
			</div>
			<div class="content" id="regularContent">
				<div style='padding: 1px;text-align: center;'><p><img style="vertical-align: middle;" src ="<%=contextPath %>/images/loading2.gif" border="0"></p></div>
			</div>
		</div>
		<%} %>
</td>
</tr>
</table>



<script type="text/javascript">
<%if(applyshow){%>
var tabapply =new SysTab('<%=contextPath%>',1,"applytab");
<%}%>
<%if(mailshow){%>
var tabmail =new SysTab('<%=contextPath%>',1,"mailtab");
<%}%>

</script>
</body>
</html>