<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function showdiv(){
		Sys.winshow("测试弹出层",'formtest.jsp');
	}
</script>
<style type="text/css">
</style>
</head>
<body>
按钮<br/><br/>
<table>
<tr>
<td><btn:btn onclick="showdiv();" value="弹出层" imgsrc="../images/addfile_.png"></btn:btn></td>
<td style="width: 10px;"></td>
<td><btn:cancel imgshow="true"></btn:cancel></td>
<td style="width: 10px;"></td>
<td><btn:img onclick="alert('图片按钮');" imgsrc="../images/1.png" title="图片测试按钮"></btn:img></td>
<td><btn:btn onclick="alert(123)" value="测 试测 试测 试测 试测 试测 试测 试测 试" imgsrc="../images/addfile_.png"></btn:btn> </td>
<td><btn:cancel onclick="alert('取消');"></btn:cancel> </td>
<td><btn:img onclick="alert('图片按钮')" imgsrc="../images/addfile_.png"></btn:img> </td>
</tr>
</table>
</body>
</html>