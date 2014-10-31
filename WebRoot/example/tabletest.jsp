<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>普通表格</title>
</head>
<body>
<table height="100%" width="98%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td>
<sys:table tableTitle="表格标题" width="80%" id="resultTable">
<td class='tableTitle1'>标题1</td>
<td class='tableTitle1'>标题2</td>
<td class='tableTitle1'>标题3</td>
<td class='tableTitle1'>标题4</td>
<td class='tableTitle1'>标题5</td>
<td class='tableTitle1'>标题6</td>
<td class='tableTitle1'>标题7</td>
</sys:table>
</td>
</tr>
<tr><td height="10px"></td></tr>
<tr>
<td height="100%" width="100%">
<table height="100%" width="100%">
<tr>
<td align="center">
<div style="position:absolute; border:1 solid black;">
           <select   multiple="multiple" style="margin-top:-3px;margin-bottom:-7px; margin-left:-5px;margin-right:-6px; height:200px;"  >
               <option value="1">test data</option>
               <option value="1">test data</option>
               <option value="1">test data</option> 
               <option value="1">test data</option>
               <option value="1">test data</option>
               <option value="1">test data</option>
               <option value="1">test data</option>
               <option value="1">test data</option> 
               <option value="1">test data</option>
               <option value="1">test data</option>
           </select>
</div>
</td>
<td width="50">
<btn:img onclick="" imgsrc="<%=contextPath+"/images/fileclear.png" %>"></btn:img>
</td>
<td>
<select multiple="multiple" style="height: 98%;width: 100%">
</select>
</td>
</tr>
</table>

</td>
</tr>
</table>
</body>
</html>