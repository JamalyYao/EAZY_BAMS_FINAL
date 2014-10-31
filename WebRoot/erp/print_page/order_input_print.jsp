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
String title = usermsg.getCompanyName()+UtilTool.getSysParamByIndex(request,"erp.orderinput.title");

 %>
<title>入库单打印</title>
<script type="text/javascript">

window.onload = function(){
	dwrStorehouseService.getAstOrderDetailInstoreByPk('<%=pid%>',setpagevalue);
}


function setpagevalue(data){
	if(data != null){
	    if(data.resultList.length>0){
			var tmp = data.resultList[0];
			
			
			DWRUtil.setValue("astwarehouse",tmp.astwarehouse.astWarehouseName);
			
			DWRUtil.setValue("astOrderDetailId",tmp.astOrderDetailId);
			
			DWRUtil.setValue("instoreId",tmp.instoreId);
			DWRUtil.setValue("astProvName",tmp.astprovider.astProvName);
			DWRUtil.setValue("hrmEmployeeName",tmp.instoreEmployee.hrmEmployeeName);
			DWRUtil.setValue("instoreTime",tmp.instoreTime);
			DWRUtil.setValue("astProviderName",tmp.product.astProName);
   			DWRUtil.setValue("count",tmp.count);
			DWRUtil.setValue("astProSpec",tmp.product.astProSpec);
			DWRUtil.setValue("astProType",tmp.product.astProType);
			if(tmp.remark.length > 0 && tmp.remark != null){
				DWRUtil.setValue("remark",tmp.remark);
			}else{
				document.getElementById("remark").innerHTML =  "&nbsp;";
			}
			
			var unit="";
			if(tmp.product != null && tmp.product.libraryInfoUnit!=null){
				unit = tmp.product.libraryInfoUnit.libraryInfoName;
			}
			document.getElementById("count").innerHTML =  fmoney(tmp.count,0)+"("+unit+")";
			}
	}
}

function back(){
	Sys.href("<%=contextPath%>/erp/store_house/order_input_history.jsp");
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
	<td class="printTitle" colspan="3">
	<%=title %>
	</td>
	</tr>
	<tr>
	<td align="left" class="printFontSign">
	入库仓库：<u><span id="astwarehouse" ></span></u>
	</td>
	<td align="right" class="printFontSign">
	订单明细号：<u><span id="astOrderDetailId" ></span></u>
	</td>
	</tr>
	</table>
	<table class="printTableRow" border='1' width='98%'>
				<tr>
					<td class='printTable_tr' style="text-align: center;">入库单号</td>
					<td id="instoreId"  class="printTable_td" ></td>
					<td class='printTable_tr' style="text-align: center;">供应商</td>
					<td id=astProvName  class="printTable_td" ></td>
				</tr>
				<tr>
					<td class='printTable_tr' style="text-align: center;">入库人</td>
					<td id="hrmEmployeeName" class="printTable_td"></td>
					<td class='printTable_tr' style="text-align: center;">入库时间</td>
					<td id="instoreTime" class="printTable_td"></td>
				</tr>
				<tr>
					<td class='printTable_tr' style="text-align: center;">产品名称</td>
					<td id="astProviderName" class="printTable_td"></td>
					<td class='printTable_tr' style="text-align: center;">入库数量</td>
					<td id="count" class="printTable_td"></td>
				</tr>
				<tr>
					<td class='printTable_tr' style="text-align: center;">产品规格</td>
					<td id="astProSpec" class="printTable_td"></td>
					<td class='printTable_tr' style="text-align: center;">产品型号</td>
					<td id="astProType" class="printTable_td"></td>
				</tr>
				<tr height="50px">
					<td class='printTable_tr' style="text-align: center;">入库备注</td>
					<td id="remark" colspan="3" class="printTable_td"></td>
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