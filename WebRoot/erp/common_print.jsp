<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.eazytec.common.exception.*" %>
<%@page import="com.eazytec.common.module.*" %>
<%@page import="com.eazytec.common.pack.*" %>
<%@page import="com.eazytec.common.pages.*" %>
<%@page import="com.eazytec.common.util.*" %>
<%@page import="com.eazytec.common.util.file.*" %>
<%@page import="com.eazytec.common.util.net.*" %>
<%@page import="com.eazytec.common.util.os.command.*" %>
<%@page import="com.eazytec.common.util.path.*" %>
<%@page import="com.eazytec.common.util.security.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.text.*" %>
<%@page import="com.eazytec.core.iservice.*" %>
<%@page import="com.eazytec.core.pojo.*" %>
<%@page import="com.eazytec.core.iservice.*" %>
<%@page import="com.eazytec.web.controller.dwr.*" %>
<%@page import="com.eazytec.web.taglib.*" %>
<%@page import="com.eazytec.web.taglib.table.*" %>
<%@page import="com.eazytec.web.taglib.table.cloumntype.*" %>
<%@page import="com.eazytec.common.util.file.properties.*" %>

<%
//项目相对及绝对路径
String contextPath = request.getContextPath();
String absPath = this.getServletContext().getRealPath("");
String timeauto = SystemConfig.getParam("erp.desktop.autoimg")==null?"0":SystemConfig.getParam("erp.desktop.autoimg");
int tam = Integer.parseInt(timeauto)*60;
%>
<link rel='stylesheet' type='text/css' href='<%=contextPath%>/css/print_style.css' />

<link rel='Shortcut Icon' href='<%=contextPath%>/favicon.ico' />
<link rel='Bookmark' href='<%=contextPath%>/favicon.ico' />
<script  type='text/javascript'   src='<%=contextPath%>/js/normalutil.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/js/pageToservice.js'></script>
<script  type='text/javascript'>Sys.setProjectcode('<%=ConstWords.getProjectCode()%>');Sys.setProjectPath('<%=contextPath%>');</script>
<script  type='text/javascript'   src='<%=contextPath%>/js/cookie.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/dwr/engine.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/dwr/util.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/dwr/interface/dwrCommonService.js'></script>

<script  type='text/javascript'   src='<%=contextPath%>/js/dateJs/WdatePicker.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/js/tabJs/sys_tab.js'></script>
<link type='text/css' rel='stylesheet' href='<%=contextPath%>/js/split/images/skin.css' />
<script  type='text/javascript'   src='<%=contextPath%>/js/split/sys_split.js'></script>
<script  type='text/javascript'>var splitImage ='<%=contextPath%>/js/split/images';var t=new ViewModel(null);</script>
		
<script  type='text/javascript'   src='<%=contextPath%>/js/jquery.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/js/formjs.js'></script>
<script type='text/javascript'>formStylePath.setImagePath('<%=contextPath%>/images/');</script>

<script  type='text/javascript'   src='<%=contextPath%>/js/menujs/rightMenu.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/js/tipalert/alertWin.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/js/imageloading.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/js/approveProcessJs.js'></script>
<script  type='text/javascript'>Approve.setProjectPath('<%=contextPath%>');</script>
<script  type='text/javascript'   src='<%=contextPath%>/js/selectJs.js'></script>
<script  type='text/javascript'>SEL.setProjectPath('<%=contextPath%>');</script>

<iframe id="filedownloadfrm" style="display: none;"></iframe>
<input type="hidden" id="onlinecount" value="0"/>
<input type="hidden" id="onlinecountsessionid" value="0"/>
<script type="text/javascript">
<!--
<%if(tam>0){ %>
var tm = document.getElementById("ismoveandkeydown");
if(tm==null){
	tm = window.parent.document.getElementById("ismoveandkeydown");
	if(tm==null){
		tm = window.parent.parent.document.getElementById("ismoveandkeydown");
		if(tm==null){
			tm = window.parent.parent.parent.document.getElementById("ismoveandkeydown");
			if(tm==null){
				tm = window.parent.parent.parent.parent.document.getElementById("ismoveandkeydown");
			}
		}
	}
}
document.onmousemove = function(){
	tm.value = "0";
}
window.onfocus = function(){
	tm.value = "0";
}
document.onmousedown = function(){
	tm.value = "0";
}
document.onkeydown = function(){
	tm.value = "0";
}
<%}else{%>
	var tm = null;
<%}%>

function loginOut(){
	var vl = document.getElementById("onlinecount").value;
	if(vl=="0"){
		document.getElementById("onlinecount").value ="1";
		var frm = document.getElementById("mainframe");
		if(frm==null||frm == "undefined" || frm == undefined){
			frm = window.parent.document.getElementById("mainframe");
		}
		if(frm==null||frm == "undefined" || frm == undefined){
			frm = window.parent.parent.document.getElementById("mainframe");
		}
		if(frm==null||frm == "undefined" || frm == undefined){
			frm = window.parent.parent.parent.document.getElementById("mainframe");
		}
		if(frm!=null && frm != "undefined" && frm != undefined){
			frm.src  = "<%=contextPath%>/centerSend.jsp";
		}else{
			window.document.location.href = "<%=contextPath%>/centerSend.jsp";	
		}
	}
}

function warningmsg(){
	var vl = document.getElementById("onlinecountsessionid").value;
	if(vl=="0"){
		document.getElementById("onlinecountsessionid").value ="1";
		Sys.alert("当前用户在其他地方登录或者未正常退出,点击确定返回登录！\n如有其它疑问，请联系管理员。",reloadlogin);
	}
}
function reloadlogin(){
	window.parent.parent.parent.document.location.href = "<%=contextPath%>/login.jsp"
}

window.status ="江苏卓易信息科技有限公司 Eazytec (c)2008-2013";
//-->
</script>
