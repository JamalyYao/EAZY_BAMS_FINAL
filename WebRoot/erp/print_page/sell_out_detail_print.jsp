<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../common_print.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrStorehouseService.js"></script>
<%
SessionUser usermsg = (SessionUser)LoginContext.getSessionValueByLogin(request);
int row = 15;
String sid =request.getParameter("sid");

String title =usermsg.getCompanyName()+ UtilTool.getSysParamByIndex(request,"erp.sellout.title");
%>
<title>出库单打印</title>
<script type="text/javascript">

window.onload = function(){
	dwrStorehouseService.getWareHouseOutById('<%=sid%>',setPageValue);
}


function setPageValue(data){
	if(data != null){
	    if(data.resultList.length>0){
	    	var obj = data.resultList[0];
	    	DWRUtil.setValue("astSellId",obj.astSellId);
			DWRUtil.setValue("astSellDetailId",obj.astSellDetailId);
			DWRUtil.setValue("outstoreId",obj.outstoreId);
			DWRUtil.setValue("customerName",obj.sell.astSellCustomId);
			
			DWRUtil.setValue("astProName",obj.product.astProName);
		
			DWRUtil.setValue("astProSpec",obj.product.astProSpec);
		
			DWRUtil.setValue("astProType",obj.product.astProType);
		
			DWRUtil.setValue("outstoreEmployee",obj.outstoreEmployee.hrmEmployeeName);
		
			DWRUtil.setValue("outstoreTime",obj.outstoreTime);
				
			var unit="";
			if(obj.product.libraryInfoUnit!=null){
				unit = obj.product.libraryInfoUnit.libraryInfoName;
			}
			
			document.getElementById("count").innerHTML = fmoney(obj.count,0) + unit;
			DWRUtil.setValue("remark",obj.remark);
		
		}
	}
}


function back(){
		Sys.href("<%=contextPath%>/erp/store_house/sell_sell_out_history.jsp");
}

function printorder(){
	pngdiv.style.display='none';
	print();
	pngdiv.style.display='block';
}

function closePage(){
	closeMDITab(window.parent.parent);
}
</script>
</head>
<body style="overflow: auto;text-align: center;">
	<div class="printBtn" id = "pngdiv">
		<img src="<%=contextPath %>/images/printpage.png" style="padding-right: 10px;cursor: pointer;" alt="打印"  border="0" title="打印" onclick="printorder();"/>
		&nbsp;&nbsp;<img src="<%=contextPath %>/images/cross.png" style="padding-right: 10px;cursor: pointer;" alt="关闭打印页面"  border="0" title="关闭打印页面" onclick="closePage();"/>
	</div>
	<table width="98%" border="0" cellpadding="3" cellspacing="0">
	<tr height="50">
		<td colspan="3" class="printTitle">
			<%=title %>
		</td>
	</tr>
	<tr>
		<td class="printFontSign" align="left">
			销售号：
			<u><span id="astSellId" ></span></u>
		</td>
		<td class="printFontSign" align="right">
			销售明细号：
			<u><span id="astSellDetailId"></span></u>
		</td>
	</tr>
	</table>
	<table class="printTableRow" border='1' width='98%'>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					出库单号
				</td>
				<td class="printTable_td" id="outstoreId"></td>
				<td class='printTable_tr' style="text-align: center;">
					客户姓名
				</td>
				<td class="printTable_td" id="customerName"></td>
			</tr>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					产品名称
				</td>
				<td class="printTable_td" id="astProName"></td>
				<td class='printTable_tr' style="text-align: center;">
					产品规格
				</td>
				<td class="printTable_td" id="astProSpec"></td>
			</tr>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					产品型号
				</td>
				<td class="printTable_td" id="astProType"></td>
				<td class='printTable_tr' style="text-align: center;">
					出库人
				</td>
				<td class="printTable_td" id="outstoreEmployee"></td>
			</tr>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					出库数量
				</td>
				<td class="printTable_td" id="count"></td>
				<td class='printTable_tr' style="text-align: center;">
					出库时间
				</td>
				<td class="printTable_td" id="outstoreTime"></td>
			</tr>
			<tr height="60px">
				<td class='printTable_tr' style="text-align: center;">
					出库备注
				</td>
				<td class="printTable_td" colspan="3" id="remark"></td>
			</tr>
	</table>
	</br>
	<table width="98%" border="0" cellpadding="2" cellspacing="0">
		<tr>
			<td class="printFontSign" align="right">
				负责人：___________
			</td>
			<td width="90%"></td>
			<td class="printFontSign" align="right">
				审批人：___________
			</td>
		</tr>
		<tr>
			<td class="printFontSign" align="right">
				日  期：___________
			</td>
			<td width="90%"></td>
			<td class="printFontSign" align="right">
				日  期：___________
			</td>
		</tr>
	</table>
</body>
</html>