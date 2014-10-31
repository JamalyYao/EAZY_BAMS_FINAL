<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ include file="../common.jsp"%>
  <%@ include file="../editmsgbox.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="<%=contextPath %>/js/functionjs/calenderjs.js"></script>
<link rel='stylesheet' type="text/css"
	href="<%=contextPath%>/js/functionjs/calendercss.css" />
<script type="text/javascript"
	src="<%=contextPath%>/dwr/interface/dwrPersonalOfficeSerivce.js"></script>
<title>常用工具</title>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0);
	WebApplicationContext webContext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
	DwrPersonalOfficeSerivce perService = (DwrPersonalOfficeSerivce) webContext.getBean("dwrPersonalOfficeSerivce");
	Map<SysLibraryInfo, ArrayList<OaTools>> toolmap = perService.listOaTools(this.getServletContext(), request, new OaTools());
%>
<script type="text/javascript">
function go(url){
	window.parent.parent.parent.MDIOpen(url);
}

function tooladd(pk,type){
	MoveDiv.show(type,'<%=contextPath%>/erp/personal_work/tool_add.jsp?typePk='+pk);
}

function edit(typePk,toolid){
	MoveDiv.show("修改常用工具",'<%=contextPath%>/erp/personal_work/tool_add.jsp?typePk='+typePk+'&toolid='+toolid);
}

function deleteTool(toolid){
	confirmmsg("确定要删除工具吗?","delok("+toolid+")");
}	

function delok(toolid){
    var id;
	id = toolid;
    dwrPersonalOfficeSerivce.deleteOatoolByPk(id,deleteCallback);
}
function deleteCallback(data){
	alertmsg(data,"reback()");
}
function reback(){
	Sys.href('<%=contextPath%>/erp/personal_work/commentools.jsp');
}

function showmenu(pk,type){
	var e = window.event || event;
    if (e.button == 2){
		var divid ="functiondiv";
		var div = document.getElementById(divid);
		var nodes = div.getElementsByTagName("div");
		nodes[0].onclick = function(){
		  	edit(type,pk);
		}
		nodes[1].onclick = function(){
		   deleteTool(pk);
		}
		nodes[2].onclick = function(){
		   window.location.reload();
		}
		var tp = e.clientY;
		var lf = e.clientX;
		div.style.top = tp+document.body.scrollTop;
	    div.style.left = lf+document.body.scrollLeft;
		div.style.display = "";
    }
}

function rightmenuhidden(){
	var divid ="functiondiv";
	var div = document.getElementById(divid);
	div.style.display = "none";
}
</script>
	</head>
	<body oncontextmenu="return false;" onclick="rightmenuhidden();" style="overflow: hidden;">
		<div id="functiondiv" style="display: none;">
			<div onmouseover="childover(this);"
				onmouseout="childout(this,'functiondiv');" onclick=""
				style="background-repeat: no-repeat; background-position: 3px 1px; background-image: url('<%=contextPath%>/images/grid_images/edit.png');">
				编辑
			</div>
			<div onmouseover="childover(this);"
				onmouseout="childout(this,'functiondiv');" onclick=""
				style="background-repeat: no-repeat; background-position: 3px 1px; background-image: url('<%=contextPath%>/images/grid_images/close.png');">
				删除
			</div>
			<div onmouseover="childover(this);"
				onmouseout="childout(this,'functiondiv');" onclick=""
				style="background-repeat: no-repeat; background-position: 3px 1px; background-image: url('<%=contextPath%>/images/grid_images/refresh.png');">
				刷新
			</div>
		</div>
		<div style="overflow: auto;height: 100%">
		<%
			if (toolmap != null && toolmap.size() > 0) {
				Set<SysLibraryInfo> keys = toolmap.keySet();
				Iterator<SysLibraryInfo> it = keys.iterator();
		%>
		<table width="99%" border="0" align="center" cellpadding="3"
			cellspacing="1">
			<%
				while (it.hasNext()) {
						SysLibraryInfo lib = it.next();
						ArrayList<OaTools> list = new ArrayList<OaTools>();
						if (toolmap.containsKey(lib)) {
							list = toolmap.get(lib);
						}
			%>
			<tr>
				<td height="24px" colspan="7"
					style="line-height: 24px; background-image: url('<%=contextPath %>/images/toolsbg.png')" align="left">
					<label style="padding-left: 10px;"><%=lib.getLibraryInfoName()%></label>
					<a href="javascript:void(0)" onclick="tooladd(<%=lib.getPrimaryKey()%>,'<%=lib.getLibraryInfoName()%>')" title="添加工具" style="padding-left: 5px">
					<img	src="<%=contextPath%>/images/grid_images/add.png" border="0" alt=添加<%=lib.getLibraryInfoName()%> style="vertical-align: bottom;" /></a>
				</td>
			</tr>
			<%
				int td = 0;
						if (list.size() > 0) {
							for (int i = 0; i < list.size(); i++) {
								OaTools tl = list.get(i);
								if (td % 5 == 0) {
			%>
			<tr>
				<%
					}
				%>

				<td width="20%" class="show_table_detail">
					<%
						if (tl.getOaToolImageId() != null && tl.getOaToolImageId() > 0) {
					%>
					<img
						src="<%=contextPath%>/showimg.do?type=img&imgId=<%=tl.getOaToolImageId()%>"
						width="64" height="64" style="cursor: pointer;"
						onclick="go('<%=tl.getOaToolPath()%>');"
						onmousedown="showmenu(<%=tl.getPrimaryKey()%>,<%=tl.getOaToolType()%>);"
						title="右击修改，删除,刷新" />
					<br /><%=tl.getOaToolText()%>
					<%
						} else {
					%>
					<img
						src="<%=contextPath%>/images/commentoolsimage/<%=tl.getOaToolImage()%>"
						style="cursor: pointer;" onclick="go('<%=tl.getOaToolPath()%>')"
						width="64" height="64"
						onmousedown="showmenu(<%=tl.getPrimaryKey()%>,<%=tl.getOaToolType()%>);"
						title="右击修改，删除,刷新" />
					<br /><%=tl.getOaToolText()%>
					<%
						}
					%>
				</td>
				<%
					td++;
									if (td > 0 && td % 5 == 0) {
				%>
			</tr>
			<%
				}
			%>
			<%
				}
						}
			%>
			<%
				}
			%>
		</table>
		<%
			}
		%>
		</div>
	</body>
</html>