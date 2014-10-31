<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>明细显示示例</title>
</head>
<body>
<fieldset>
	<legend>明细1</legend>
	<div style="height: 300px;">
	<table class="detailtable" align="center">
	<tr>
	<th>上级编码</th>
	<td>11111</td>
	<td colspan="2" rowspan="4">
	<file:imgshow imageId="1" width="120" height="100"></file:imgshow>
	</td>
	</tr>
	<tr>
	<th>人员姓名</th>
	<td>张三</td>
	</tr>
	<tr>
	<th>人员性别</th>
	<td>男</td>
	</tr>
	<tr>
	<th>注册日期</th>
	<td>2009-01-01</td>
	</tr>
	<tr>
	<th>家庭住址</th>
	<td>住住蛛蛛啊嗷嗷嗷啊啊啊发达爱的发动</td>
	<th>户籍</th>
	<td>啊啊的发生的</td>
	</tr>
	<tr>
	<th>电话</th>
	<td>0101-411111544</td>
	<th>E-Mail</th>
	<td>aaaa@123.com</td>
	</tr>
	<tr>
	<th>附件</th>
	<td colspan="3">
	<file:downlaod value="附件1" fileId="1"></file:downlaod>&nbsp;&nbsp;
	<file:downlaod value="附件2" fileId="1"></file:downlaod>&nbsp;&nbsp;
	<file:downlaod value="附件3" fileId="1"></file:downlaod>&nbsp;&nbsp;
	</td>
	</tr>
	<tr>
	<th>附加信息</h>
	<td colspan="3">
	<div style="overflow: auto;height: 130px;">
	adfkadkjlasfkjaskjlasdkjlasdkjldasfkjlasdfkjlafsdkljafkjlasdfjk<br/><br/>
	sdafljsdkfajsdflkasdlfkadsklfjadlksjfdkasljfasdkfjalsdkfjaksdflasdf<br/><br/>
	adfkadkjlasfkjaskjlasdkjlasdkjldasfkjlasdfkjlafsdkljafkjlasdfjk<br/><br/>
	sdafljsdkfajsdflkasdlfkadsklfjadlksjfdkasljfasdkfjalsdkfjaksdflasdf<br/><br/>
	adfkadkjlasfkjaskjlasdkjlasdkjldasfkjlasdfkjlafsdkljafkjlasdfjk<br/><br/>
	sdafljsdkfajsdflkasdlfkadsklfjadlksjfdkasljfasdkfjalsdkfjaksdflasdf<br/><br/>
	</div>
	</td>
	</tr>
	</table>
	</div>
</fieldset>
<fieldset>
	<legend>明细2</legend>
	<div>
	<table width="98%">
<tr>
<td>

<DIV class="tabdiv">

<UL class="tags">
<LI><A onClick="tab.selectTag(this);" href="javascript:void(0)">标签一</A></LI>
<LI><A onClick="tab.selectTag(this)" href="javascript:void(0)">标签二</A> </LI>
<LI><A onClick="tab.selectTag(this)" href="javascript:void(0)">自适应宽度的标签</A> </LI>
</UL>

<DIV class="tagContentdiv">
<DIV class="tagContent" id="tag0">第一个标签的内容第一个标签的内容第一个标签的内容第一个标签的内容<br/><br/><br/><br/></DIV>
<DIV class="tagContent" id="tag1">第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容第二个标签的内容</DIV>
<DIV class="tagContent" id="tag2">第三个标签的内容<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></DIV>
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
	</div>
</fieldset>
<br/>
</body>
</html>