<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../erp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	body {
	margin: 10px;
}
</style>
</head>
<body>
tab标签<br/><br/>
<table width="100%">
<tr>
<td width="90%">

<DIV class="tabdiv">

<UL class="tags">
<LI><A onClick="tab.selectTag(this);alert(111);" href="javascript:void(0)">标签一</A></LI>
<LI><A onClick="tab.selectTag(this)" href="javascript:void(0)">标签二</A> </LI>
<LI><A onClick="tab.selectTag(this)" href="javascript:void(0)">自适应宽度的标签</A> </LI>
</UL>

<DIV class="tagContentdiv">
<DIV class="tagContent" id="tag0">第一个标签的内容第一个标签的内容第一个标签的内容第一个标签的内容<br/><br/><br/><br/></DIV>
<DIV class="tagContent" id="tag1">第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容</DIV>
<DIV class="tagContent" id="tag2">第三个标签的内容</DIV>
</DIV>


</DIV>
</td>
<td>&nbsp;</td>
</tr>
</table>
<script type="text/javascript">
	var tab =new SysTab('<%=contextPath%>',2);
	//第二个参数默认为1，可以不输入,初始化选项
</script>
</body>
</html>