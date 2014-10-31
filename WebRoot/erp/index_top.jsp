<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.eazytec.common.util.ConstWords"%>
<%@page import="com.eazytec.core.pojo.SysConfig"%>
<%@page import="com.eazytec.common.module.SessionUser"%>
<%@page import="com.eazytec.common.util.LoginContext"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="com.eazytec.web.controller.dwr.DwrOADesktopService"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.eazytec.common.util.file.properties.SystemConfig"%>
<%@page import="java.util.List"%>
<%@page import="com.eazytec.core.pojo.OaNotice"%>
<%@page import="com.eazytec.core.pojo.OaAnnouncement"%>
<%@page import="com.eazytec.common.util.EnumUtil"%>
<%@page import="com.eazytec.common.util.security.Base64"%>
<%@page import="com.eazytec.core.pojo.SysCompanyInfo"%>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业综合平台top</title>
<%
String path = request.getContextPath();
SessionUser usermsg = (SessionUser)LoginContext.getSessionValueByLogin(request);
String titname="";
String titenname="";
SysConfig sysconfig =usermsg.getSysconfig();
if(sysconfig==null){
	out.print("不能加载配置系统信息..");
	return;
}else{
	titname = sysconfig.getProjectName();
	titenname = sysconfig.getProjectEgName();
}
int clogin = -1;
SysCompanyInfo company = usermsg.getCompanyInfo();
if(company!=null){
	if(company.getCompanyInfoLogin()!=null&&company.getCompanyInfoLogin()>0){
		clogin = company.getCompanyInfoLogin();
	}
	if(company.getCompanyInfoTitle()!=null&&company.getCompanyInfoTitle().trim().length()>0){
		titname = company.getCompanyInfoTitle();
	}
	if(company.getCompanyInfoEnTitle()!=null&&company.getCompanyInfoEnTitle().trim().length()>0){
		titenname = company.getCompanyInfoEnTitle();
	}
}
 %>
<script type="text/javascript" src="<%=path %>/dwr/interface/dwrSysProcessService.js"></script>
<script type="text/javascript">
	function changediv(obj){
		obj.className = "deskbtn_hover";
	}
	function changedivout(obj){
		obj.className ="deskbtn";
	}
	function addShortcut(){
		var box = SEL.getUserSysMethodInfoIds("radio","showShortcut();");
	    box.show();
	}
	
	function showShortcut(){
		$.ajax({
	        url: '<%=path %>/erp/desktop/desktopHtml_shortcut.jsp',
	        type: 'get',
	        success: function (responseText){
	            $("#jCarouselLite").html(responseText);
	            addShortcutEffect();
	        }
	    });
	}
	
	function addShortcutEffect(){
		var l = $("#jCarouselLite").find("li").length;
        if(l>6){
	    	$("#next").show();
	    	$("#prev").show();
 		    $(".shortcut #jCarouselLite").jCarouselLite({
 			    btnNext:".shortcut #next",
 			    btnPrev:".shortcut #prev",
 			    scroll:5,
 			    visible:6
 			});
	    }else{
	    	$("#next").hide();
	    	$("#prev").hide();
	    }
        $('#jCarouselLite li').contextMenu('attachMenu',{
		    bindings: {
		    	'del':function(t){deleteShortcut(t.id)},
		    	'add':function() {addShortcut();}
		    },
		  	menuStyle:{width:'60px'}
		});
	}
	
	function deleteShortcut(pk){
		var pks = new Array();
	    pks[0] = pk;
		dwrSysProcessService.deleteSysMethodShortcutByPks(pks,function(data){showShortcut();});
	}
</script>
<style type="text/css">
	.deskbtn_hover{
		border-top:1px solid #7DBFFF;		
		border-left:1px solid #7DBFFF;.
		border-right:1px solid #226fba;
		border-bottom:1px solid #226fba;
		cursor: pointer;
		background-color: #2D9AD4;
		width:80px;
		height:17px;
		padding-top:5px;
		padding-bottom:2px;
	}
	.deskbtn_hover span{
		color: #ffffbe;
		height:22px;
		padding-left:25px;
		padding-top:6px;
		padding-right:5px;
		font-size: 1em;
	}
	
	.deskbtn{
		cursor: pointer;
		width:80px;
		height:17px;
		padding-top:5px;
		padding-bottom:2px;
	}
	.deskbtn span{
		color: #ffffff;
		height:22px;
		padding-left:25px;
		padding-top:6px;
		padding-right:5px;
		font-size: 1em;
	}
	.mya{
		color: #ffffff;
		padding-right: 10px;
		font-size: 1em;
		font-weight: bold;
		font-family: 宋体
	}
	.mya span{
		font-size: 10px;
		font-family: Webdings;
		color: #fdcb89;
		padding-right: 2px;
	}
	.mya:hover{
		color:#ffffbe;
		font-size: 1em;
		font-weight: bold;
		font-family: 宋体
	}
	.marspan{
		padding-left:10px;
		padding-right:5px;
		color:#F9E96F;
		font-weight: bold;
	}
</style>
</head>
<body style="cursor: default;">
<table width="100%" cellpadding="0" cellspacing="0" border="0" height="100%">
<tr>
<td style="margin-bottom: 10px;padding-left:5px;padding-right:5px">
<%if(clogin>0){ %>
<img border="0" alt="公司logo" src="<%=path %>/showimg.do?imgId=<%=clogin %>&noImgPath=<%=Base64.getBase64FromString(this.getServletContext().getRealPath("/images/syslogin.png"))%>" style="height: 48px;width: auto">
<%}else{ %>
<img border="0" alt="公司logo" src="<%=path %>/images/syslogin.png" style="height: 48px;width: auto">
<%} %>
</td>
<td style="margin-bottom: 10px;" align="right" valign="top" width="380">
	<table cellpadding="0" cellspacing="0" border="0" height="98%" width="100%">
		<tr height="50%">
		<td align="left" nowrap="nowrap" valign="top">
		<div  class="index_title" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width: 380px;"><%=titname %></div>
		</td>
		</tr>
		<tr>
		<td align="left" nowrap="nowrap"  valign="top">
		<div class="index_title_en" style="overflow:hidden;	white-space:nowrap;	text-overflow:ellipsis;width: 380px;" title="<%=titenname %>"><%=titenname %></div>
		</td>
		</tr>
	</table>
</td>
<td valign="top" style="padding-right: 5px" width="100%" align="right">
	<table cellpadding="0" cellspacing="0" border="0">
		<tr>
		<td align="right" nowrap="nowrap" valign="middle" height="21" style="background: url('<%=path%>/images/wpa_left.png')  no-repeat left center;padding-left:10px" >
			<div style="padding-right: 10px;margin-top: 10px">
			<span class="index_msg">欢迎您：<%=usermsg.getEmployeeName() %></span>&nbsp;&nbsp;
			<span class="index_msg">[ 部门:<%=usermsg.getEmployeeDeptName() %></span>&nbsp;&nbsp;
			<span class="index_msg">岗位:<%=usermsg.getMainPost() == null ? "系统管理员" : usermsg.getMainPost().getHrmPostName() %> ]</span>
			</div>
		</td>
		<td nowrap="nowrap" valign="middle" width="10px" height="21" style="background: url('<%=path%>/images/wpa_right.png')  no-repeat right center;">
		</td>
		</tr>
</table>
</td>
</tr>
<tr>
<td colspan="3">
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-right: 5px" height="100%">
<tr>
<%if(usermsg.getUserInfo().getUserType() == EnumUtil.SYS_USER_TYPE.DEFAULT.value){%>
<td style="padding-left: 8px;width: 80px;" valign="top">
	<div onmouseover="changediv(this)" onmouseout="changedivout(this);"  class="deskbtn" onclick="openTabPage('<%=request.getContextPath()+sysconfig.getProjectView() %>')">
	<span style="background: url('<%=path %>/images/mydesktop.png') no-repeat 3px center;">办公桌面</span>
	</div>
</td>

<td style="width:80px;" valign="top">
	<div onmouseover="changediv(this)" onmouseout="changedivout(this);"   class="deskbtn" onclick="openTabPage('<%=path %>/erp/desktop/desktop_set.jsp')">
	<span style="background: url('<%=path %>/images/mydesktopset.png') no-repeat 3px center;">桌面设置</span>
	</div>
</td>

<td style="padding-left:10px;" valign="top">
<div class="shortcut">
	<table cellSpacing="0" cellPadding="0">
		<tr>
			<td style="cursor: pointer;width:30px;" title="点击添加快捷按钮" align="left" onclick="addShortcut();">
				<img src="<%=path %>/images/shortcut_add.png" width="16"/>
			</td>
			<td>
				<div id="jCarouselLite"></div>
			</td>
			<td style="cursor: pointer;width:20px;" title="点击向上查看其他快捷按钮" align="left">
				<img id="prev" style="display:none;" src="<%=path %>/images/approveprocess/arrow_up_16.png"/>
			</td>
			<td style="cursor: pointer;width:20px;" title="点击向下查看其他快捷按钮" align="left">
				<img id="next" style="display:none;" src="<%=path %>/images/approveprocess/arrow_down_16.png"/>
			</td>
		</tr>
	</table>
	</div> 
</td>
<%} %>
<td width="380px" valign="top" align="right">
<iframe src="<%=request.getContextPath() %>/projectTopMenu.jsp?mid=<%=ConstWords.getProjectCode() %>" id="topfrm"
	 frameborder="0" height="25px" scrolling="no" allowTransparency="true" marginheight="0" width="100%">
</iframe>
</td>
</tr>
</table>
</td>
</tr>
</table>
<script type="text/javascript">
	showShortcut();
	function openTabPage(url){
		openMDITab(window.parent,url);
	}
</script>

<div style='display:none;' id='attachMenu'>
<ul>
<li id='add'><img src="<%=path%>/images/grid_images/add.png"> 添加</li>
<li id='del'><img src="<%=path%>/images/grid_images/close.png"> 删除</li>
</ul>
</div>
</body>
</html>