<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common_print.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript"
			src="<%=contextPath%>/dwr/interface/dwrStorehouseService.js"></script>
		<%
			int row = 15;
			SessionUser usermsg = (SessionUser) LoginContext.getSessionValueByLogin(request);
			String tracId = request.getParameter("tracId");
			String title = usermsg.getCompanyName() + UtilTool.getSysParamByIndex(request,"erp.stock.allocationOne.title");
		%>
		<title>库存调拨记录单打印</title>
		<script type="text/javascript">
window.onload = function(){
		dwrStorehouseService.getWarehouseTracByPK(<%=tracId%>,setPageValue);
}

function setPageValue(data){
	if(data.success&&data.resultList.length>0){
		var obj = data.resultList[0];
		if(obj.product != null){
		    DWRUtil.setValue("proName",obj.product.astProName);
		    DWRUtil.setValue("proCode",obj.product.astProCode);
		    DWRUtil.setValue("proType",obj.product.astProType);
		    DWRUtil.setValue("proSpec",obj.product.astProSpec);
		}
		if(obj.warehouseOut != null){
		    DWRUtil.setValue("outHouse",obj.warehouseOut.astWarehouseName);
		}
		if(obj.warehouseInput != null){
		    DWRUtil.setValue("inhouse",obj.warehouseInput.astWarehouseName);
		}
		
		var unit="";
		if(obj.product.libraryInfoUnit!=null){
			unit = obj.product.libraryInfoUnit.libraryInfoName;
		}
		DWRUtil.setValue("tracCount",fmoney(obj.astTracCount,0)+" "+unit);
		DWRUtil.setValue("astTracDate",obj.astTracDate);
		DWRUtil.setValue("tracReason",obj.astTracReason);
		
		if(obj.employee != null){
		    DWRUtil.setValue("tracEmpName",obj.employee.hrmEmployeeName);
		}
	}
}


function back(back){
	Sys.href("<%=contextPath%>/erp/store_house/warehouse_stock_pass_query.jsp");
}

function printorder(){
	pngdiv.style.display='none';
	print();
	pngdiv.style.display='block';
}
</script>

	</head>
	<body style="overflow: auto; text-align: center;">
		<div class="printBtn" id="pngdiv">
			<img src="<%=contextPath%>/images/printpage.png"
				style="padding-right: 10px; cursor: pointer;" alt="打印单据" border="0"
				title="打印单据" onclick="printorder();" />
			&nbsp;&nbsp;
			<img src="<%=contextPath%>/images/cross.png"
				style="padding-right: 10px; cursor: pointer;" alt="关闭" border="0"
				title="关闭当前页面" onclick="closeMDITab(window.parent.parent);" />
		</div>

		<table width="98%" border="0" cellpadding="2" cellspacing="0">
			<tr height="50">
				<td colspan="3" class="printTitle">
					<%=title%>
				</td>
			</tr>
		</table>
		<table class="printTableRow" width='98%' border='1' id='productlist'>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					产品编码
				</td>
				<td class="printTable_td" id="proCode" width="15%"></td>
				<td class='printTable_tr' style="text-align: center;">
					调拨产品
				</td>
				<td class="printTable_td" id="proName" width="15%"></td>
			</tr>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					产品型号
				</td>
				<td class="printTable_td" id="proType"></td>
				<td class='printTable_tr' style="text-align: center;">
					产品规格
				</td>
				<td class="printTable_td" id="proSpec"></td>
			</tr>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					调出仓库
				</td>
				<td class="printTable_td" id="outHouse"></td>
				<td class='printTable_tr' style="text-align: center;">
					调入仓库
				</td>
				<td class="printTable_td" id="inhouse"></td>
			</tr>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					调拨数量
				</td>
				<td class="printTable_td" id="tracCount"></td>
				<td class='printTable_tr' style="text-align: center;">
					调拨人
				</td>
				<td class="printTable_td" id="tracEmpName"></td>
			</tr>
			<tr>
				<td class='printTable_tr' style="text-align: center;">
					调拨时间
				</td>
				<td class="printTable_td" id="astTracDate"></td>
				<td class='printTable_tr' style="text-align: center;">
				</td>
				<td class="printTable_td"></td>
			</tr>
			<tr height="100px">
				<td class='printTable_tr' style="text-align: center;">
					调拨原因
				</td>
				<td colspan="3" class="printTable_td" id="tracReason"></td>
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
					日 期：___________
				</td>
				<td width="90%"></td>
				<td class="printFontSign" align="right">
					日 期：___________
				</td>
			</tr>
		</table>
	</body>
</html>