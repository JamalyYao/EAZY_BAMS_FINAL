<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加编辑页面</title>

</head>
<body>

<fieldset>
	<div class="requdiv"><label id="aaac"></label></div>
	<legend>panel框</legend>
	<div>
	<table class="inputtable">
	<tr>
	<th width="10%"><em>*</em>拾取文本框</th>
	<td><input type="text" id="methodname" readonly="readonly" must="上级编码不能为空" value="111" class="takeform" linkclear="methodid">
	<input type="hidden" id="methodid" value="111">
	</td>
	<th  rowspan="4" width="10%">图片</th>
	<td  rowspan="4"><file:imgupload width="80" acceptTextId="methodimg" height="100"></file:imgupload></td>
	</tr>
	<tr>
	<th><em>*</em>数字文本框</th><td ><input type="text" id="methodname" must="功能名称不能为空" class="numform"></td>
	</tr>
	
	<tr>
	<th><em>*</em>性别</th>
	<td >
	<input type="radio" name="abc" id="abc1" must="请选择性别"><label for="abc1">男</label>
	<input type="radio" name="abc" id="abc2"><label for="abc2">女</label>
	</td>
	</tr>
	<tr>
	<th>日期与时间文本框</th>
	<td >
	<input type="text" readonly="readonly" class="Wdate" onClick="WdatePicker()" value="<%=UtilWork.getToday() %>">
	
	<input type="text" readonly="readonly" class="Wtime" onClick="WdatePicker({dateFmt:'H:mm:ss'})" value="<%=UtilWork.getToday() %>">
	
	<input type="text" readonly="readonly" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss'})" value="<%=UtilWork.getToday() %>">
	</td>
	<th><em>*</em>复选框</th>
	<td>
	<input type="checkbox" id="c1c" name="ccc" must="请选择复选框"><label for="c1">复选1</label>
	<input type="checkbox" id="c2c" name="ccc"><label for="c2">复选1</label>
	<input type="checkbox" id="c3c" name="ccc"><label for="c3">复选1</label>
	<input type="checkbox" id="c4c" name="ccc"><label for="c4">复选1</label>
	</td>
	</tr>
	<tr>
	<th>金额文本框</th>
	<td>
	<input type="text" class="rmbform">
	</td>
	<th>普通文本框</th>
	<td>
	<input type="text">
	</td>
	</tr>
	<tr>
	<th>textarea</th>
	<td  colspan="3">
	<textarea readonly="readonly" linkclear="aadced">1111</textarea>
	<input type="hidden" id='aadced' value="1111"/>
	</td>
	</tr>
	
	<tr>
	<th>附件</th>
	<td  colspan="3">
	<file:multifileupload width="100%" acceptTextId="aabc" height="100"></file:multifileupload>
	</td>
	</tr>
	
	<tr>
	<th>描述</th>
	<td  colspan="3">
	<FCK:editor instanceName="descp" height="200" width="100%" toolbarSet="Basic"></FCK:editor>
	</td>
	</tr>
	
	</table>
	
	</div>
</fieldset>
<br/>
 出　　 生 　地：
 <div class="selectdiv">
            <SELECT name=province>
            </SELECT>
            </div>
             <div class="selectdiv">
            <SELECT name=city>
            </SELECT>
            </div>
             <div class="selectdiv">
            <SELECT name=area>
            </SELECT>
            </div>
 <FIELDSET style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; PADDING-TOP: 5px">
            <LEGEND>
                省市联动
            </LEGEND>
            出生地：
            <div class="selectdiv">
            <SELECT name=P1>
            </SELECT></div>
            <div class="selectdiv">
            <SELECT name=C1>
            </SELECT>
            </div>
            <BR>
            所在地：
            <SELECT name=P2>
            </SELECT>
            <SELECT name=C2>
            </SELECT>
            <BR>
            工作地：
            <SELECT name=P3>
            </SELECT>
            <SELECT name=C3>
            </SELECT>
            <BR>
        </FIELDSET>
        <BR>
        <BR>
        <FIELDSET style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; PADDING-TOP: 5px">
            <LEGEND>
                省市地区联动
            </LEGEND>
           
            <BR>
            户 口 所 在 地：
            <SELECT name=province1>
            </SELECT>
            <SELECT name=city1>
            </SELECT>
            <SELECT name=area1>
            </SELECT>
            <BR>
            工 作 所 在 地：
            <SELECT name=province2>
            </SELECT>
            <SELECT name=city2>
            </SELECT>
            <SELECT name=area2>
            </SELECT>
            <BR>
            <BR>
            无　　默　　认：
            <SELECT name=province3>
            </SELECT>
            <SELECT name=city3>
            </SELECT>
            <SELECT name=area3>
            </SELECT>
            <BR>
            默　　认　　省：
            <SELECT name=province4>
            </SELECT>
            <SELECT name=city4>
            </SELECT>
            <SELECT name=area4>
            </SELECT>
            <BR>
            默　认　省　市：
            <SELECT name=province5>
            </SELECT>
            <SELECT name=city5>
            </SELECT>
            <SELECT name=area5>
            </SELECT>
            <BR>
            默 认 省 市 区：
            <SELECT name=province6>
            </SELECT>
            <SELECT name=city6>
            </SELECT>
            <SELECT name=area6>
            </SELECT>
            <BR>
        </FIELDSET>
        <SCRIPT language=javascript defer>
            new PCAS("P1", "C1");
            new PCAS("P2", "C2", "吉林省");
            new PCAS("P3", "C3", "江苏省", "苏州市");

            new PCAS("province", "city", "area", "吉林省", "白城市", "大安市");
            new PCAS("province1", "city1", "area1", "吉林省", "吉林市", "龙潭区");
            new PCAS("province2", "city2", "area2", "江苏省", "苏州市", "沧浪区");

            new PCAS("province3", "city3", "area3");
            new PCAS("province4", "city4", "area4", "");
            new PCAS("province5", "city5", "area5", "江苏省", "苏州市");
            new PCAS("province6", "city6", "area6", "", "", "");
        </SCRIPT>
</body>
</html>