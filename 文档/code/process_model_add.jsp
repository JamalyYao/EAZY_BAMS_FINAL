<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    <%@ include file="../common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>创建流程模型</title>
<script type="text/javascript">

window.onload = function(){
	useLoadingMassage();
	initInput('helpTitle','您可以在此处创建流程模型！');

    //第一个输入框获取焦点
    document.getElementById("name").focus();
}

function save(){
	var warnArr = new Array();
	warnArr[0] = "nameMust";
	warnArr[1] = "keyMust";
	//清空所有信息提示
	warnInit(warnArr);
     var bl = validvalue('helpTitle');
     if(bl){
     	  document.frmname.action = "<%=request.getContextPath()+"/modelCreate.do"%>";
		  document.frmname.submit();
          Btn.close();
          setTimeout("backList()", 100);
	 }
}

function backList(){
	window.location = "<%=contextPath %>/erp/system_set/process_model.jsp";
}

function closePage(){
	closeMDITab(window.parent.parent);
}
</script>
</head>
<body class="inputcls">
<div class="formDetail">
	<div class="requdiv"><label id="helpTitle"></label></div>
    <div class="formTitle">创建/编辑流程模型</div>
    	<form method="post" id="frmname" name="frmname" target="_blank">
	    <table class="inputtable" border="0">
		    <tr>
				<th>名称</th>
				<td>
					<input type="text" id="name" name="name" must="名称不能为空！" formust="nameMust">
					<label id="nameMust"></label>
				</td>
			</tr>
			<tr>
				<th>KEY</th>
				<td>
					<input type="text" id="key" name="key" must="KEY不能为空！" formust="keyMust">
					<label id="keyMust"></label>
					<label style="padding-left: 10px; color: #808080">
						该值会用来作为导出XML文件的文件名。
					</label>
				</td>
			</tr>
			<tr>
			     <th>描述</th>
			     <td><textarea id="description" name="description" style="height: 100px"></textarea></td>
			</tr>
	    </table>
	    </form>
	</div>
<table align="center">
	<tr>
		<td><btn:btn onclick="save();" value="保 存 " imgsrc="../../images/png-1718.png" title="保存部门信息" /></td>
		<td style="width: 20px;"></td>
		<td id ="backToList"><btn:btn onclick="closePage();" value="关 闭 " imgsrc="../../images/winclose.png" title="关闭当前页面"/></td>
	</tr>
</table>
</body>
</html>