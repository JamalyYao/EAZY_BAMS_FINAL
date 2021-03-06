<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0);
String contextPath = request.getContextPath();
%>
<title>岗位树</title>
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
    var tree = new WebFXLoadTree("岗位树","<%=request.getContextPath()%>/erp/tree/posttree_xml.jsp?fid=00","posttreeclick('');");
</script>
</head>
<body>
<div class="div_tree">
	<script type="text/javascript">
		document.write(tree);
		
		//岗位选择
		function posttreeclick(code){
			document.getElementById("postcode").value =code;
			queryData();
		}
	</script>
</div>
<input type="hidden" id="postcode">
</body>
</html>