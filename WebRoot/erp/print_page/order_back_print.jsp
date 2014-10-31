<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../common_print.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrStorehouseService.js"></script>
<%
String pid =request.getParameter("pid");
SessionUser usermsg = (SessionUser)LoginContext.getSessionValueByLogin(request);
int row = 15;
String cid =request.getParameter("cid");
String title = usermsg.getCompanyName()+UtilTool.getSysParamByIndex(request,"erp.orderback.title");
String back = request.getParameter("back");
 %>
<title>退货单打印</title>
<script type="text/javascript">
window.onload = function(){
	dwrStorehouseService.getAstPurchaseRejectedByPk('<%=pid%>',setpagevalue);
}

function setpagevalue(data){
	if(data != null){
	    if(data.resultList.length>0){
			var tmp = data.resultList[0];
			var product = tmp.product;
			
			DWRUtil.setValue("astOrderId",tmp.astOrderId);
			DWRUtil.setValue("astOrderDetailId",tmp.astOrderDetailId);
			DWRUtil.setValue("astRejectedId",tmp.astRejectedId);
			DWRUtil.setValue("astProName",product.astProName);
			DWRUtil.setValue("astProSpec",product.astProSpec);
			DWRUtil.setValue("astProType",tmp.product.astProType);
			DWRUtil.setValue("astProviderName",tmp.provider.astProvName);
   			DWRUtil.setValue("astRejectedPerson",tmp.employee.hrmEmployeeName);
			DWRUtil.setValue("astRejectedDate",tmp.astRejectedDate);
			
			if(tmp.astRejectedReason.length > 0 && tmp.astRejectedReason != null){
				DWRUtil.setValue("astRejectedReason",tmp.astRejectedReason);
			}else{
				document.getElementById("astRejectedReason").innerHTML =  "&nbsp;";
			}
			var unit="";
			if(product != null && product.libraryInfoUnit!=null){
				unit = product.libraryInfoUnit.libraryInfoName;
			}
			document.getElementById("astRejectedCount").innerHTML = fmoney(tmp.astRejectedCount,0)+unit;
		}
	}
}

function back(back){
	if (back == 1){
		Sys.href("<%=contextPath%>/erp/store_house/order_back_history.jsp?cid="+<%=cid%>);
	}else if(back == 2){
		Sys.href("<%=contextPath%>/erp/store_house/order_query.jsp");
	}
}

function printorder(){
	pngdiv.style.display='none';
	print();
	pngdiv.style.display='block';
}
</script>
</head>
<body style="overflow: auto;text-align: center;">
	<div class="printBtn" id = "pngdiv">
	<img src="<%=contextPath %>/images/printpage.png" style="padding-right: 10px;cursor: pointer;" alt="打印"  border="0" title="打印" onclick="printorder();"/>
	&nbsp;&nbsp;
	<img src="<%=contextPath%>/images/cross.png" style="padding-right: 10px; cursor: pointer;" alt="关闭" border="0" title="关闭当前页面" onclick="closeMDITab(window.parent.parent);" />
	</div>
	
	
	<table width="98%" border="0" cellpadding="3" cellspacing="0">
	<tr height="50">
	<td colspan="3" class="printTitle">
	<%=title %>
	</td>
	</tr>
	<tr>
	<td class="printFontSign" align="left">
		采购订单号：<u><span id="astOrderId" ></span></u>
	</td>
	<td class="printFontSign" align="right">
		订单明细号：<u><span id="astOrderDetailId"></span></u>
	</td>
	</tr>
	</table>
	<table class="printTableRow" border='1' width='98%'>
				<tr>
					<td class='printTable_tr' style="text-align: center;">退货单号</td>
					<td id="astRejectedId"  class="printTable_td"></td>
					<td class='printTable_tr' style="text-align: center;">供应商</td>
					<td id="astProviderName"  class="printTable_td"></td>
				</tr>
				<tr>
					<td class='printTable_tr' style="text-align: center;">退货人</td>
					<td id="astRejectedPerson" class="printTable_td"></td>
					<td class='printTable_tr' style="text-align: center;">退货时间</td>
					<td id="astRejectedDate" class="printTable_td"></td>
				</tr>
				<tr>
					<td class='printTable_tr' style="text-align: center;">产品名称</td>
					<td id="astProName" class="printTable_td"></td>
					<td class='printTable_tr' style="text-align: center;">退货数量</td>
					<td id="astRejectedCount" class="printTable_td"></td>
				</tr>
				<tr>
					<td class='printTable_tr' style="text-align: center;">产品规格</td>
					<td id="astProSpec" class="printTable_td"></td>
					<td class='printTable_tr' style="text-align: center;">产品型号</td>
					<td id="astProType" class="printTable_td"></td>
				</tr>
				<tr height="50px">
					<td class='printTable_tr' style="text-align: center;">退货原因</td>
					<td id="astRejectedReason" colspan="3" class="printTable_td"></td>
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