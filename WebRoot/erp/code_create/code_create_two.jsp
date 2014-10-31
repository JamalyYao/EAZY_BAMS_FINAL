<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    <%@ include file="../common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String msg=request.getAttribute(ConstWords.TempStringMsg)==null?"":(String)request.getAttribute(ConstWords.TempStringMsg);
%>
<title>DWR和SERVICE</title>
<script type="text/javascript">

window.onload = function(){
	if('<%=msg%>'!=''){alertmsg('<%=msg%>');}
	useLoadingMassage();
	initInput('helpTitle','您可以在此处生成Dwr控制层及Service业务逻辑层代码、配置文件等！');
			
    //第一个输入框获取焦点
    document.getElementById("moduleName").focus();
}

function save(){
	var warnArr = new Array();
	warnArr[0] = "moduleNameMust";
	warnArr[1] = "pojoClassMust";
	//清空所有信息提示
	warnInit(warnArr);
    var bl = validvalue('helpTitle');
    if(bl){
    	var obj = document.getElementById("createForm");
     	obj.action = "<%=contextPath + "/createDwrAndService.do"%>";
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
	<div class="formTitle">设置java代码及配置文件相关信息</div>
	    <table class="inputtable" border="0">
			<tr>
				<th>pojo包名</th>
				<td>
					<input type="text" style="width:220px;" name="pojoPack" value="<%=request.getAttribute("pojoPack")==null?"com.eazytec.core.pojo":request.getAttribute("pojoPack")%>">
				</td>
				<th>dao接口包名</th>
				<td>
					<input type="text" style="width:220px;" name="daoPack" value="<%=request.getAttribute("daoPack")==null?"com.eazytec.core.dao":request.getAttribute("daoPack")%>">
				</td>
			</tr>
			<tr>
				<th>dwr包名</th>
				<td>
					<input type="text" style="width:220px;" name="dwrPack" value="<%=request.getAttribute("dwrPack")==null?"com.eazytec.web.controller.dwr":request.getAttribute("dwrPack")%>">
				</td>
				<th>service接口包名</th>
				<td>
					<input type="text" style="width:220px;" name="servicePack" value="<%=request.getAttribute("servicePack")==null?"com.eazytec.core.iservice":request.getAttribute("servicePack")%>">
				</td>
			</tr>
			 <tr>
				<th>service接口实现包名</th>
				<td>
					<input type="text" style="width:220px;" name="serviceImplPack" value="<%=request.getAttribute("serviceImplPack")==null?"com.eazytec.core.service":request.getAttribute("serviceImplPack")%>">
				</td>
				<th>生成代码位置</th>
				<td>
					<input type="text" style="width:220px;" name="filePath" value="<%=request.getAttribute("filePath")==null?"c:/userfiles/":request.getAttribute("filePath")%>">
				</td>
			</tr>
			 <tr>
				<th><em>*</em>功能块名称</th>
				<td colspan="3">
					<input type="text" style="width:220px;" name="moduleName" must="功能块名称不能为空！" formust="moduleNameMust" value="<%=request.getAttribute("moduleName")==null?"":request.getAttribute("moduleName")%>">
					<label id="moduleNameMust"><font color="#808080">大写开头的英文单词，例如：Project、Hrm、Process等等</font></label>
				</td>
			</tr>
			<tr>
				<th><em>*</em>pojo类名</th>
				<td colspan="3">
					<input type="text" name="pojoClass" must="pojo类名不能为空！" formust="pojoClassMust" value="<%=request.getAttribute("pojoClass")==null?"":request.getAttribute("pojoClass")%>" style="width:90%;">
				</td>
				<tr>
				<th></th>
				<td colspan="3">
					<label id="pojoClassMust"><font color="#808080">填写功能块相关的pojo实体类名（通过数据表自动生成的那些文件），多个用“,”英文逗号隔开</font></label>
				</td>
			</tr>
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