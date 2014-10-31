<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	body {
	margin: 0px;
}
</style>
</head>
<body>


<div class="panel" paneltitle ="测试panel效果显示【默认宽度100%】" panelheight ="200px" panelwidth  ="800">
<p>
<input type="text">
</p>


<select> 
<%=StandardCodeTool.getSelectOptions(this.getServletContext(),request,null,"04") %>
</select>
<select> 
<%=StandardCodeTool.getSelectOptions(this.getServletContext(),request,null,"02") %>
</select>

<table id="">
<tr><td><select>     
<option>所有分类</option>
<option value="1">图书</option>     
<option value="2">音像</option>
</select> </td></tr>
<tr><td><select>     
<option>所有分类</option>
<option value="1">图书</option>     
<option value="2">音像</option>
</select> </td></tr>
</table>
<br/><br/>
测试关闭层
<btn:cancel imgshow="true"></btn:cancel>
<br/><br/>
<div id="tst">      
      <input type="radio" name="sex" value="boy" checked="checked" id="sex_boy" /><label  for="sex_boy">男</label>
      <input type="radio" name="sex" value="girl" id="sex_girl" /><label for="sex_girl">女</label>
</div>
<br/><br/>
<div id="tst">      
      <input type="radio" name="sex2" value="boy2" checked="checked" id="sex_boy2" /><label  for="sex_boy2">111</label>
      <input type="radio" name="sex2" value="girl2" id="sex_girl2" /><label for="sex_girl2">222</label>
</div>
<br/><br/>

<div>
   <input type="checkbox" name="hobby" checked="checked" id="hobby9" onclick="alert(111);" value="1"/><label for="hobby9">了解</label>
   <input type="checkbox" name="hobby" id="hobby10" value="2"/><label for="hobby10">一般</label>
   <input type="checkbox" name="hobby" id="hobby11"  value="3"/><label for="hobby11">熟练</label>
   <input type="checkbox" name="hobby" id="hobby12"  value="4"/><label for="hobby12">精通</label>
   <input type="checkbox" name="hobby" id="hobby13"  value="5"/><label for="hobby13">资深专家</label>
</div>

<br/><br/>
<table>
<tr>
<td><btn:btn onclick="alert(getRadioValueByName('sex')+' '+getRadioValueByName('sex2'));" value="取得radio选中值"></btn:btn></td>
<td>&nbsp;</td>
<td><btn:btn onclick="alert(getCheckedValues('hobby'));" value="取得checkbox选中值"></btn:btn></td>
</tr>
</table>

</div>


<div class="panel" paneltitle ="测试" panelbgcolor ='#cccccc'>
12312
</div>
</body>
</html>