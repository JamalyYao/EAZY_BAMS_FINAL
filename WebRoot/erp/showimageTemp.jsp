<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="java.net.*;"%>

<%
String path = request.getParameter("path");
String pathEncode = URLEncoder.encode(path, "UTF-8");
String isShare = request.getParameter("isShare");
String isShareEncode = URLEncoder.encode(isShare, "UTF-8");
%>
 <script type="text/javascript">
<!--
	window.onload = function(){
		window.setTimeout("document.getElementById('imgshow').src = 'createMiniPic.action?path2=<%=pathEncode %>&isShare=<%=isShareEncode%>'",0);	
	}
//-->
</script>
<body style="overflow: hidden;">
<img id="imgshow" style="width:auto;height: 99%" border="0"/>
</body>