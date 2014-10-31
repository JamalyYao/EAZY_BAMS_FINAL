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

String title = usermsg.getCompanyName()+UtilTool.getSysParamByIndex(request,"erp.sellback.title");
%>
<title>退货单打印</title>
<script type="text/javascript">

window.onload = function(){
	dwrStorehouseService.getSellDetailByBackPk('<%=sid%>',setPageValue);
}


function setPageValue(data){
	if(data != null){
	    if(data.resultList.length>0){
	    	var obj = data.resultList[0];
	    	DWRUtil.setValue("sellId",obj.astSell.primaryKey);
			DWRUtil.setValue("outstoreId",obj.primaryKey);
			if(obj.astSell != null){
				DWRUtil.setValue("customerName",obj.astSell.astSellCustomId);
			}
			if(obj.wareHouse != null){
			  DWRUtil.setValue("astWarehouseName", obj.wareHouse.astWarehouseName);
			}
			
			if(obj.product != null){
				DWRUtil.setValue("astProCode",obj.product.astProCode);
				DWRUtil.setValue("astProName",obj.product.astProName);
				DWRUtil.setValue("astProSpec",obj.product.astProSpec);
				DWRUtil.setValue("astProType",obj.product.astProType);
			}
			
			DWRUtil.setValue("lastmodiDate",obj.lastmodiDate);
			
			var unit="";
			if(obj.product.libraryInfoUnit!=null){
				unit = obj.product.libraryInfoUnit.libraryInfoName;
			}
			
			document.getElementById("astSellCount").innerHTML = fmoney(Math.abs(obj.astSellCount),0) +unit;
			DWRUtil.setValue("astSellRemake",obj.astSellRemake);
		}
	}
}


function back(){
	Sys.href("<%=contextPath%>/erp/store_house/sell_sell_backhistory.jsp");
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
			销售单号：
			<u><span id="sellId" ></span></u>
		</td>
		<td class="printFontSign" align="right">
			入库仓库：
			<u><span id="astWarehouseName"></span></u>
		</td>
	</tr>
	</table>
	<table class="printTableRow" border='1' width='98%'>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					退货单号
				</td>
				<td class="printTable_td" id="outstoreId"></td>
				<td class='printTable_tr' style="text-align: center;">
					客户名称
				</td>
				<td class="printTable_td" id="customerName"></td>
			</tr>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					产品编码
				</td>
				<td class="printTable_td" id="astProCode"></td>
				<td class='printTable_tr' style="text-align: center;">
					产品名称
				</td>
				<td class="printTable_td" id="astProName"></td>
			</tr>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					产品规格
				</td>
				<td class="printTable_td" id="astProSpec"></td>
				<td class='printTable_tr' style="text-align: center;">
					产品型号
				</td>
				<td class="printTable_td" id="astProType"></td>
			</tr>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					退货数量
				</td>
				<td class="printTable_td" id="astSellCount"></td>
				<td class='printTable_tr' style="text-align: center;">
					退货时间
				</td>
				<td class="printTable_td" id="lastmodiDate"></td>
			</tr>
			<tr height="60px">
				<td class='printTable_tr' style="text-align: center;">
					退货原因
				</td>
				<td class="printTable_td" colspan="3" id="astSellRemake"></td>
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