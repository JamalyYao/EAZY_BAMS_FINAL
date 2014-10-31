<!-- 分布式集群版 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.eazytec.core.pojo.SysMethodInfo"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.eazytec.core.iservice.IUserLoginService"%>
<%@page import="com.eazytec.common.util.LoginContext"%>
<%@page import="com.eazytec.common.module.SessionUser"%>
<%@page import="com.eazytec.core.pojo.SysCompanyInfo"%>
<%@page import="com.eazytec.common.util.file.FileTool"%>
<%@page import="com.eazytec.common.util.file.properties.SystemConfig"%>
<%@page import="com.eazytec.common.util.ConstWords"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<style type="text/css">
<!--
body{
	font-size:12px; 
	color:#252525;
	font-family: Verdana, Arial,Vrinda,Tahoma;
	scrollbar-face-color:#D3EBFC;
	scrollbar-base-color:#90D4F7;
	scrollbar-arrow-color:#77B2DD;
	scrollbar-track-color:#BDDDF2;
	scrollbar-shadow-color:#EBF5FF;
	scrollbar-highlight-color:#BDDDF2;
	scrollbar-3dlight-color:#77B2DD;
	scrollbar-darkshadow-Color:#77B2DD;
 	margin: 0px;
 	overflow:auto;
 	background-color:#fff;
} 

tr,td{
	font-size:12px;
}
-->
</style>
<body style="background-color:transparent;cursor: default;">
<%
//工程切换时request 对象消失，导致需重新加载用户功能模块
String mid =request.getParameter("mid");
String userId =request.getParameter("uid");
Set<String> methodsSet = null;//个人功能菜单
List<SysMethodInfo> companyMethods = null;//公司功能菜单
if(LoginContext.getSessionValueByLogin(request)==null){
	long uid =Long.parseLong(userId);
	WebApplicationContext webAppContext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
	IUserLoginService sysProcessService = (IUserLoginService)webAppContext.getBean("userLoginService");
	SysCompanyInfo company = sysProcessService.getCompanyInfoByUserId(uid);
	if(company!=null){
		companyMethods = sysProcessService.getCompanyMethodsByCPk((int)company.getPrimaryKey());
	}else{
		out.print("不能加载功能列表...");
		return;
	}
	methodsSet =sysProcessService.getUserCompanyMethods(uid,company.getCompanyInfoType().intValue());
}else{
	SessionUser user = (SessionUser)LoginContext.getSessionValueByLogin(request);
	companyMethods = user.getCompanyMethodsList();
	methodsSet = user.getUserMethodsSet();
}
%>
<form action="<%=request.getContextPath() %>/checkSession.do" name="projectfrm">
<input type="hidden" id="cumid" name="cumid" value="<%=mid %>">
<input type="hidden" id="mid" name="mid">
<%
if(companyMethods!=null&&companyMethods.size()>0){
 %>
<table cellspacing="0" cellpadding="4" align="center" border="0">
<%
String imgs="";
String click="";
String tit="";
int row =Integer.parseInt(SystemConfig.getParam("erp.show.projectchange")==null?"2":SystemConfig.getParam("erp.show.projectchange"));
	for(int i=0;i<companyMethods.size();i++){
		SysMethodInfo sysMethod =companyMethods.get(i);
		int counttd=0;
		if(i%row==0){
%>
<tr>
<%		}
		boolean bl =false;
		if(methodsSet!=null && methodsSet.size()>0){
			Iterator<String> it = methodsSet.iterator();
			while(it.hasNext()){
				String id = it.next();
				if(sysMethod.getPrimaryKey().equals(id)){
					bl=true;
					break;
				}
			}
		}
		if(bl){
			imgs=sysMethod.getImageSrc();
			click = "onclick=\"projectOpen('"+sysMethod.getPrimaryKey()+"');\"";
			tit = "切换到:"+sysMethod.getMethodInfoName();
			if(mid.equals(sysMethod.getPrimaryKey())){
				imgs = FileTool.getRepFileName(sysMethod.getImageSrc(),"_");
				tit = "当前项目:"+sysMethod.getMethodInfoName();
			}
		}else{
			click ="";
			imgs = FileTool.getRepFileName(sysMethod.getImageSrc(),"_black");
			tit = "没有权限:"+sysMethod.getMethodInfoName();
		}
%>
<td nowrap="nowrap" valign="middle" align="center" width="<%=(ConstWords.IndexLeftWidth-row*8)/row %>" height="40">
<img src="<%=request.getContextPath()+"/images/projectimg/"+imgs %>" onmouseover="changebg(this,'#F7B20C','#F3DDA7');" onmouseout="changebg(this,'#89B4D3','#fbfbfb');" <%=click %>  title="<%=tit %>"  style="border: 1px solid #cccccc;background-color: #fbfbfb;cursor: pointer;"/>
</td>
<%
counttd++;
if((i%row ==0&&counttd%row==0)||i==companyMethods.size()-1){
%>
</tr>
<%}%>
<%} %>
</table>
<%} %>
</form>
<script type="text/javascript">
	function projectOpen(id){
		if(id == '<%=mid%>'){
			return;
		}
		document.getElementById("mid").value = id;
		document.projectfrm.submit();
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

  if (event.button == 2 || event.button == 3)
  {
   event.cancelBubble = true
   event.returnValue = false;
   return false;
  }
}


document.oncontextmenu = nocontextmenu;  // for IE5+
document.onmousedown = norightclick;  // for all others
</script>
</body>