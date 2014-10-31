<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>

<%//fckeditor组件%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>

<%//文件及图片上传组件 %>
<%@ taglib uri="http://www.eazytec.com/taglibs/filetag" prefix="file"%>

<%//按钮组件 %>
<%@ taglib uri="http://www.eazytec.com/taglibs/buttontag" prefix="btn"%>

<%//table组件 %>
<%@ taglib uri="http://www.eazytec.com/taglibs/tabletag" prefix="sys"%>

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
<%@page import="com.eazytec.common.util.office.*" %>
<%@page import="com.eazytec.common.util.standardCode.*" %>
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
%>




<!-- 打印样式引入 -->
<link rel='stylesheet' type='text/css' href='<%=contextPath%>/css/print_style.css' />

<link rel='Shortcut Icon' href='<%=contextPath%>/favicon.ico' />
<link rel='Bookmark' href='<%=contextPath%>/favicon.ico' />
<link type='text/css' rel='stylesheet' href='<%=contextPath%>/js/artDialog/skins/blue.css' />
<script type="text/javascript" src="<%=contextPath %>/js/artDialog/artDialog.source.js"></script>
<link rel='stylesheet' type='text/css' href='<%=contextPath%>/css/normal.css' />
<script  type='text/javascript'   src='<%=contextPath%>/js/normalutil.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/js/pageToservice.js'></script>
<script  type='text/javascript'>Sys.setProjectcode('<%=ConstWords.getProjectCode()%>');Sys.setProjectPath('<%=contextPath%>');</script>
<script  type='text/javascript'   src='<%=contextPath%>/js/cookie.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/dwr/engine.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/dwr/util.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/dwr/interface/dwrCommonService.js'></script>

<script  type='text/javascript'   src='<%=contextPath%>/js/dateJs/WdatePicker.js'></script>

<script  type='text/javascript'   src='<%=contextPath%>/js/tabJs/sys_tab.js'></script>

<link type='text/css' rel='stylesheet' href='<%=contextPath%>/js/sys_btn/skin/default/btnskin.css' />
<script  type='text/javascript'   src='<%=contextPath%>/js/sys_btn/sys_btn.js'></script>
		
<LINK rel='stylesheet' type='text/css' href='<%=contextPath%>/css/sysgrid.css' />
<link type='text/css' rel='stylesheet' href='<%=contextPath%>/css/formstyle.css' />
<script  type='text/javascript'   src='<%=contextPath%>/js/jquery.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/js/formjs.js'></script>
<script type='text/javascript'>formStylePath.setImagePath('<%=contextPath%>/images/');</script>

<script  type='text/javascript'   src='<%=contextPath%>/js/menujs/rightMenu.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/js/tipalert/alertWin.js'></script>
<link type='text/css' rel='stylesheet'  href='<%=contextPath%>/js/tipalert/alertwin.css'/>
<script  type='text/javascript'   src='<%=contextPath%>/js/imageloading.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/js/selectJs.js'></script>
<script  type='text/javascript'>SEL.setProjectPath('<%=contextPath%>');</script>

<!-- 左右分栏效果 -->
<script  type='text/javascript'   src='<%=contextPath%>/js/split/splitter.js'></script>
<link type='text/css' rel='stylesheet' href='<%=contextPath%>/js/split/style.css' />

<script  type='text/javascript'   src='<%=contextPath%>/js/contextmenu.js'></script>
<script  type='text/javascript'   src='<%=contextPath%>/js/jcarousellite.js'></script>

<iframe id="filedownloadfrm" style="display: none;"></iframe>
<input type="hidden" id="onlinecount" value="0"/>
<input type="hidden" id="onlinecountsessionid" value="0"/>
<script type="text/javascript">
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

window.status ="江苏卓易信息科技有限公司 Eazytec (c)2008-2014";
</script>
