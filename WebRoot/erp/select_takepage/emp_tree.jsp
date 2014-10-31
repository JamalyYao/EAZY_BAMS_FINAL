<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0);
String contextPath = request.getContextPath();
String ischeck = request.getParameter("ischeck");
String tmp ="";
if(ischeck!=null&&ischeck.length()>0){
	tmp+="&ischeck=true";
}
%>
<title>功能树</title>
<link type='text/css' rel='stylesheet' href='<%=contextPath%>/css/xtree.css' />
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/map.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/xtree.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/xloadtree.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/checkboxTreeItem.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/xmlextras.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/checkboxXLoadTree.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/radioTreeItem.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/radioXLoadTree.js' charset='UTF-8'></script>
<script type='text/javascript'>webFXTreeConfig.setImagePath('<%=contextPath%>/js/treeJs/images/default/');</script>
<script type="text/javascript">
	function setliandong(obj){
		webFXTreeConfig.setCascadeCheck(obj.checked); 
	}
	webFXTreeConfig.setCascadeCheck(true);
	var tree = new WebFXLoadTree("部门树","<%=request.getContextPath()%>/erp/tree/departmenttree.jsp?fid=00<%=tmp%>","treeclick('');");
</script>
</head>
<body>
<div class="div_tree">
	<%
		if(ischeck!=null && ischeck.length()>0){ 
	%>
		<input type="checkbox" id="lidong" onchange="setliandong(this)" checked="checked">
		<label for="lidong" style="color: #336699">选择上级自动选中下级</label>
	<%
		} 
	%>
	<script type="text/javascript">
	  document.write(tree);
	  
	  function getCheckedIds(){
			document.getElementById("upcode").value =getCheckValues();
			queryData();
		}
	</script>
</div>
<input type="hidden" id="upcode">

</body>
</html>