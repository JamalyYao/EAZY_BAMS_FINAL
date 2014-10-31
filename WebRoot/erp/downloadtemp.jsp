<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="common.jsp" %>
<%
String fileids = request.getParameter("fileids");
 %>
 <script type="text/javascript">
 	window.onload =function(){
 		Sys.showDownload('<%=fileids%>',"filedown");
 	}
 </script>
<label id="filedown"></label>