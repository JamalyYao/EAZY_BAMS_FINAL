<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
   String pid=request.getParameter("pid");
 %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>添加文件</title>
<script type="text/javascript">
var tab =new SysTab('<%=contextPath%>');
window.onload = function() {
		initInput('title');
		
	}
	function seve(){
	  
	}
	function reload(){
	Sys.load('<%=contextPath%>/erp/personal_work/oa_my_netdisk.jsp');
	}
</script>

</head>
<body>
<fieldset>
	<div class="requdiv"><label id="title"></label></div>
	<legend>添加文件</legend>
	<div>
	<table class="inputtable">
	<tr>
	<td>
	<input type="text" id="photoname" style="display: none;">
	</td>
	</tr>
	<tr>
	<th><em>*</em>文件名称</th>
	<td>
	<input type="text">
	</td>
	</tr>
	<tr>
	<th><em>*</em>文件</th>
	<td colspan="3" width="90%">
		<DIV class="tabdiv" style="width: 90%">
		
	   <file:multifileupload width="90%" acceptTextId="oaMeetapplyAffix" height="120" edit=""></file:multifileupload>
		</DIV>
		<!-- </DIV>
		</DIV> -->
	</td>
	</tr>
	<tr>
	<th>文件描述</th>
	<td colspan="2">
	<textarea rows="4" cols="2"  id ="oaMeetapplyAffix"></textarea>
	</td>
	</tr>
	</table>
	</div>
</fieldset>
<br/>
<table align="center" cellpadding="0" cellspacing="0">
<tr>
<td>
	<table align="center">
	  	<tr>
	     	<td><btn:btn onclick="save()" value=" 确  定 "></btn:btn></td>
	     	<td style="width: 5px;"></td>
	     	<td><btn:btn onclick="reload()" value=" 返  回 "></btn:btn></td>
	   	</tr>
		</table>
</td>
</tr>
</table>


</body>
</html>