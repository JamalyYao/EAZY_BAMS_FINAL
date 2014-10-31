<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%
		response.setHeader("Cache-Control","no-cache"); 
		response.setHeader("Pragma","no-cache"); 
		response.setDateHeader("Expires",0);
		 %>
		<title>企业综合信息平台left </title>
		<%
		String mid = request.getParameter("mid");	//跳转项目代码
		if(mid == null){
			mid = ConstWords.getProjectCode();
		}
		
		SysMethodInfo method = UtilTool.getSysMethodInfoByPk(this.getServletContext(),mid);
		if(method==null){
			out.print("不能加载用户功能菜单...");
			return;
		}
		 %>
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
			var action = "";
			<% if (method.getMethodUri() != null && method.getMethodUri().length() > 0){%>
				action = "treeclick('<%=method.getPrimaryKey()%>','<%=contextPath+"/erp/"+method.getMethodUri()%>');";
			<%}%>
			
			//每个页面值支持一个树 默认采用该目录图片生成树
			var tree = new WebFXLoadTree("<%=method.getMethodInfoName()%>","<%=contextPath%>/erp/tree/usermethods.jsp?code=<%=method.getPrimaryKey()%>" ,action,"","<%=contextPath%>/images/projectimg/<%=method.getImageSrc()%>");
			
			function treeclick(code,url){
				//Sys.open(code,url);
				parent.MDIOpen(url+"?mid="+code);
			}
			
			//重新刷新页面加载功能树
			function goto(path){
				window.location.reload(path);
			}
		</script>
	</head>
	<body>
	<div class="div_tree" style="height:100%;">
	<script type="text/javascript">
	  document.write(tree);
	</script>
	</div>
	
   </body>
</html>