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
			String lossId = request.getParameter("lossId");
			String title = usermsg.getCompanyName() + UtilTool.getSysParamByIndex(request, "erp.warehouse.lossOne.title");
		%>
		<title>损耗记录单打印</title>
		<script type="text/javascript">
window.onload = function(){
	useLoadingMassage();
	dwrStorehouseService.getWarehouseLossInfoByid(<%=lossId%>,setPageValue);
}

function setPageValue(data){
	if(data.success&&data.resultList.length>0){
		var obj = data.resultList[0];
		if(obj.employee != null){
		    DWRUtil.setValue("outEmp",obj.employee.hrmEmployeeName);
		}
		DWRUtil.setValue("outDate",obj.astLossDate);
		DWRUtil.setValue("receviceName",obj.astLossRemark);
		
		var detail = new Object();
		detail.astLossRec = <%=lossId%>;
		dwrStorehouseService.getWarehouseLossDetail(detail,createDetail);
	}
}

function createDetail(data){
	var tab = document.getElementById("inspectordetaillist");
	var rlen = tab.rows.length;	
	
	for(var i=rlen-1;i>=1;i--){
		tab.deleteRow(i);
	}
	
	if(data.success == true && data.resultList.length > 0){
		for ( var i = 0; i < data.resultList.length; i++) {
			var detail = data.resultList[i];
			var product = detail.product;
				
		 	var otr = tab.insertRow(-1);
		
		 	var td1=document.createElement("td");
		 	var td2=document.createElement("td");
		 	var td3=document.createElement("td");
		 	var td4=document.createElement("td");
		 	var td5=document.createElement("td");
		 	var td6=document.createElement("td");
		 	var td7=document.createElement("td");
		 	var td8=document.createElement("td");
		 	var td9=document.createElement("td");
		        
		 	td1.style.cssText="text-align:center";
		 	td2.style.cssText="text-align:center";
			td3.style.cssText="text-align:center";
			td4.style.cssText="text-align:center";
			td5.style.cssText="text-align:center";
			td6.style.cssText ="text-align:center";
			td7.style.cssText="text-align:center";
			td8.style.cssText="text-align:center";
			td9.style.cssText="text-align:center";
		
				
			td1.innerHTML = i + 1;
		    td2.innerHTML = detail.warehouse.astWarehouseName;
			td3.innerHTML = product.astProCode;
	        td4.innerHTML = product.astProName;
	        td5.innerHTML = product.astProType;
	        td6.innerHTML = product.astProSpec;
	        var unit="";
			if(product.libraryInfoUnit!=null){
				unit = product.libraryInfoUnit.libraryInfoName;
			}
	        td7.innerHTML = detail.astLossCount + unit;
	        td8.innerHTML = detail.employee.hrmEmployeeName;
			td9.innerHTML = detail.recordDate;
		    otr.appendChild(td1);
		    otr.appendChild(td2);
		    otr.appendChild(td3);
		    otr.appendChild(td4);
		    otr.appendChild(td5);
		    otr.appendChild(td6);
		    otr.appendChild(td7);
		    otr.appendChild(td8);
		    otr.appendChild(td9);
	      }
	      
        }
}

function back(back){
	Sys.href("<%=contextPath%>/erp/store_house/warehouse_loss_list.jsp");
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
				style="padding-right: 10px; cursor: pointer;" alt="打印" border="0"
				title="打印" onclick="printorder();" />
			&nbsp;&nbsp;
			<img src="<%=contextPath%>/images/cross.png"
				style="padding-right: 10px; cursor: pointer;" alt="关闭" border="0"
				title="关闭当前页面" onclick="closeMDITab(window.parent.parent);" />
		</div>
		<table width="98%" border="0" cellpadding="3" cellspacing="0">
			<tr height="50">
				<td colspan="3" class="printTitle">
					<%=title%>
				</td>
			</tr>
			<tr>
				<td class="printFontSign" align="left">
					录入时间：<u><span id="outDate"></span></u>
				</td>
				<td class="printFontSign" align="right">
					录入人：<u><span id="outEmp"></span></u>
				</td>
			</tr>
		</table>
		<table class='printTableRowMore' width='98%' border='1'
			id='inspectordetaillist'>
			<tr class="printTableRow_tr">
				<td class='printTableRow_td'>
					序号
				</td>
				<td class='printTableRow_td'>
					所属仓库
				</td>
				<td class='printTableRow_td'>
					产品编码
				</td>
				<td class='printTableRow_td'>
					损耗产品
				</td>
				<td class='printTableRow_td'>
					产品型号
				</td>
				<td class='printTableRow_td'>
					产品规格
				</td>
				<td class='printTableRow_td'>
					损耗数量
				</td>
				<td class='printTableRow_td'>
					录入人
				</td>
				<td class='printTableRow_td'>
					录入时间
				</td>
			</tr>
		</table>
		</br>
		<table width="98%" border="0" cellpadding="2" cellspacing="0">
			<tr height="50px">
				<td class="printFontSign" align="left">
					损耗备注：<u><span id="receviceName"></span></u>
				</td>
			</tr>
		</table>
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