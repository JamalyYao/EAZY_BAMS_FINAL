<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.eazytec.core.pojo.SysMethodInfo"%>
<%@page import="com.eazytec.common.util.LoginContext"%>
<%@page import="com.eazytec.common.module.SessionUser"%>
<%@page import="com.eazytec.common.util.file.FileTool"%>
<%@page import="com.eazytec.common.util.file.properties.SystemConfig"%>
<%@page import="com.eazytec.common.util.ConstWords"%>
<%
//工程切换页面
String mid =request.getParameter("mid");
SessionUser user = (SessionUser)LoginContext.getSessionValueByLogin(request);
List<SysMethodInfo> userModuleMethods = user.getUserModuleMethods();//个人功能模块
%>
<body style="background:#edf3f7;">
<form action="<%=request.getContextPath() %>/checkSession.do" name="projectfrm">
<input type="hidden" id="cumid" name="cumid" value="<%=mid %>">
<input type="hidden" id="mid" name="mid">
<%
if(userModuleMethods != null && userModuleMethods.size()>0){
 %>
<table cellspacing="0" cellpadding="4" align="center" border="0">
<%
String imgs="";
String click="";
String tit="";
String style = "";
	int row =Integer.parseInt(SystemConfig.getParam("erp.show.projectchange")==null?"3":SystemConfig.getParam("erp.show.projectchange"));
	for(int i=0;i<userModuleMethods.size();i++){
		SysMethodInfo sysMethod =userModuleMethods.get(i);
		int counttd=0;
		if(i%row==0){
		%>
		<tr>
		<%}%>
		<td nowrap="nowrap" valign="middle" align="center" width="<%=(ConstWords.IndexLeftWidth-row*8)/row %>" height="40">
		<%
		if(mid.equals(sysMethod.getPrimaryKey())){
			click = "onclick=\"projectOpen('"+sysMethod.getPrimaryKey()+"',"+i+",'"+sysMethod.getMethodInfoName()+"');\"";
			imgs = FileTool.getRepFileName(sysMethod.getImageSrc(),"_");
			tit = "当前模块:"+sysMethod.getMethodInfoName();
			style = "border: 1px solid #89B4D3;";
			%>
			<img id="img<%=i%>" src="<%=request.getContextPath()+"/images/projectimg/"+imgs %>" onmouseover="changebg(this,'#F7B20C','#F3DDA7');" onmouseout="changebg(this,'#89B4D3','#fbfbfb');" <%=click %> title="<%=tit %>"  style="<%=style %>"/>
			<%
		}else{
			click = "onclick=\"projectOpen('"+sysMethod.getPrimaryKey()+"',"+i+",'"+sysMethod.getMethodInfoName()+"');\"";
			imgs = sysMethod.getImageSrc();
			tit = "切换到:"+sysMethod.getMethodInfoName();
			style = "border: 1px solid #cccccc;background-color: #fbfbfb;cursor: pointer;";
			%>
			<img id="img<%=i%>" src="<%=request.getContextPath()+"/images/projectimg/"+imgs %>" onmouseover="changebg(this,'#F7B20C','#F3DDA7');" onmouseout="changebg(this,'#cccccc','#fbfbfb');" <%=click %>  title="<%=tit %>"  style="<%=style %>"/>
			<%
		}
		%>
		</td>
		<%
		counttd++;
		if((i%row ==0&&counttd%row==0)||i==userModuleMethods.size()-1){
		%>
		</tr>
		<%}%>
	<%} %>
</table>
<%} %>
</form>
<script type="text/javascript">
function projectOpen(id,num,title){
	var count = <%=userModuleMethods.size()%>;
	for(var i=0;i<count;i++){
		if(i != num){
			//未选中
			var img = document.getElementById("img"+i);
			var imgSrc = img.src;
			if(imgSrc.substring(imgSrc.length-5,imgSrc.length-4) == "_"){
				img.src = imgSrc.substring(0,imgSrc.length-5) + imgSrc.substring(imgSrc.length-4,imgSrc.length);
				img.style.cssText = "border: 1px solid #cccccc;background-color: #fbfbfb;cursor: pointer;";
				var t = img.title.split(":");
				img.title = "切换到:"+t[1];
			}
		}else{
			//选中
			var img = document.getElementById("img"+i);
			var imgSrc = img.src;
			if(imgSrc.substring(imgSrc.length-5,imgSrc.length-4) != "_"){
				//不是重复点击
				img.src = imgSrc.substring(0,imgSrc.length-4) + "_" + imgSrc.substring(imgSrc.length-4,imgSrc.length);
				img.style.border = "1px solid #89B4D3";
				img.onmouseover = "changebg(this,'#F7B20C','#F3DDA7');"
				img.onmouseout = "changebg(this,'#89B4D3','#fbfbfb');"
				img.title = "当前模块:"+title;
				
				window.parent.frames["methodleftfrm"].location.href = "<%=request.getContextPath() %>/erp/index_left.jsp?mid="+id;
			}
		}
	}
}

function changebg(obj,borcolor,bgcolor){
	obj.style.border ="1px solid "+borcolor;
	obj.style.backgroundColor = bgcolor;
}

function nocontextmenu() {
	event.cancelBubble = true
	event.returnValue = false;
 	return false;
}
 
function norightclick(e) {
  if (event.button == 2 || event.button == 3){
   event.cancelBubble = true
   event.returnValue = false;
   return false;
  }
}
</script>
</body>