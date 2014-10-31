<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    <%@ include file="../common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String msg=request.getAttribute(ConstWords.TempStringMsg)==null?"":(String)request.getAttribute(ConstWords.TempStringMsg);
%>
<title>POJO和DAO</title>
<script type="text/javascript">

window.onload = function(){
	if('<%=msg%>'!=''){alertmsg('<%=msg%>');}
	useLoadingMassage();
	initInput('helpTitle','您可以在此处生成实体类及对应DAO、配置文件等！');
			
    //第一个输入框获取焦点
    document.getElementById("tables").focus();
}



function save(){
	var warnArr = new Array();
	warnArr[0] = "urlMust";
	warnArr[1] = "userMust";
	warnArr[2] = "passwordMust";
	warnArr[3] = "tablesMust";
	//清空所有信息提示
	warnInit(warnArr);
    var bl = validvalue('helpTitle');
    if(bl){
    	var obj = document.getElementById("createForm");
     	obj.action = "<%=contextPath + "/createPojoAndDao.do"%>";
		obj.submit();
	}
}

function closePage(){
	closeMDITab(window.parent.parent);
}
</script>
</head>
<body class="inputcls">
<form id="createForm" method="post">
<div class="formDetail">
	<div class="requdiv"><label id="helpTitle"></label></div>
    <div class="formTitle">设置数据库信息</div>
	    <table class="inputtable" border="0">
		    <tr>
				<th><em>*</em>数据库地址</th>
				<td colspan="3">
					<input type="text" name="url" must="数据库地址不能为空！" formust="urlMust" value="<%=request.getAttribute("url")%>" style="width:90%;">
					<label id="urlMust"></label>
				</td>
			</tr>
			<tr>
				<th><em>*</em>数据库用户名</th>
				<td>
					<input type="text" name="user" must="数据库用户名不能为空！" formust="userMust" value="<%=request.getAttribute("user")%>">
					<label id="userMust"></label>
				</td>
				<th><em>*</em>数据库密码</th>
				<td>
					<input type="text" name="password" must="数据库密码不能为空！" formust="passwordMust" value="<%=request.getAttribute("password")%>">
					<label id="passwordMust"></label>
				</td>
			</tr>
			 <tr>
				<th><em>*</em>涉及的数据表</th>
				<td colspan="3">
					<input type="text" id="tables" name="tables" must="数据表不能为空！" formust="tablesMust" value="<%=request.getAttribute("tables")==null?"":request.getAttribute("tables")%>" style="width:90%;">
				</td>
			</tr>
			 <tr>
				<th></th>
				<td colspan="3">
					<label id="tablesMust"><font color="#808080">填写数据库表名，多张表用“,”英文逗号隔开</font></label>
				</td>
			</tr>
	    </table>
	    
	    <div class="formTitle">设置java代码及配置文件相关信息</div>
	    <table class="inputtable" border="0">
			<tr>
				<th>实体类包名</th>
				<td>
					<input type="text" name="pojoPack" value="<%=request.getAttribute("pojoPack")==null?"com.eazytec.core.pojo":request.getAttribute("pojoPack")%>">
				</td>
				<th>dao接口包名</th>
				<td>
					<input type="text" name="daoPack" value="<%=request.getAttribute("daoPack")==null?"com.eazytec.core.dao":request.getAttribute("daoPack")%>">
				</td>
			</tr>
			 <tr>
				<th>dao接口实现包名</th>
				<td>
					<input type="text" name="daoImplPack" value="<%=request.getAttribute("daoImplPack")==null?"com.eazytec.core.daoimpl":request.getAttribute("daoImplPack")%>">
				</td>
				<th>生成代码位置</th>
				<td>
					<input type="text" name="filePath" value="<%=request.getAttribute("filePath")==null?"c:/userfiles/":request.getAttribute("filePath")%>">
				</td>
			</tr>
	    </table>
	</div>
</form>
<table align="center">
	<tr>
		<td><btn:btn onclick="save();" value=" 生 成 "/></td>
		<td style="width: 20px;"></td>
		<td id="btncancel"><btn:btn onclick="closePage()" value=" 关 闭 " title="关闭当前页面"/></td>
	</tr>
</table>
</body>
</html>