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
			String pid = request.getParameter("pid");
			SessionUser usermsg = (SessionUser) LoginContext.getSessionValueByLogin(request);
			int row = 15;
			String title =usermsg.getCompanyName()+UtilTool.getSysParamByIndex(request,"erp.settle.title");
		%>
		<title>结算单打印</title>
		<script type="text/javascript">

window.onload = function(){
	dwrStorehouseService.getAstSettleByPK("<%=pid%>",setpagevalue);
}


function setpagevalue(data){
	if(data.success&&data.resultList.length>0){
		var astSettlementInfo = new Object();
		astSettlementInfo = data.resultList[0];
		DWRUtil.setValue("providerName", astSettlementInfo.provider.astProvName);
		DWRUtil.setValue("primaryKey",astSettlementInfo.primaryKey);
		
		DWRUtil.setValue("settleEmp", astSettlementInfo.employee.hrmEmployeeName);
		DWRUtil.setValue("settleTime",astSettlementInfo.astSettlementTime);
		DWRUtil.setValue("remark",astSettlementInfo.astSettlementText);
		
		var sumMoney = astSettlementInfo.astSettlementAmount;
		var payMoney = astSettlementInfo.astPaymentAmount;
		var lastMoney = astSettlementInfo.lastMoney;
		dwrStorehouseService.getAstSettleDetailsBySettlePK('<%=pid%>',function(data){
			creatDetail(data,sumMoney,payMoney,lastMoney);
		});
	}
}

function creatDetail(data,sumMoney,payMoney,lastMoney){
	var tab= document.getElementById("productlist");
	if(data.success&&data.resultList.length>0){
		var len = data.resultList.length;
		for ( var i = 0; i < len; i++) {

			var dt = data.resultList[i];
			var prod = dt.product;
			var prov = dt.provider;
			var otr = tab.insertRow(-1);

	        var td1=document.createElement("td");
	        td1.style.cssText="text-align:center";
	        td1.innerHTML = i+1;
	  
	        var td3=document.createElement("td");
	        td3.style.cssText="text-align:center";
	        td3.innerHTML =dt.primaryKey;
	       
	        var td4=document.createElement("td");
	        td4.style.cssText="text-align:center";
	        if(dt.astDeliverGoodsDate != null && trim(dt.astDeliverGoodsDate).length > 0){
	        	  td4.innerHTML =dt.astDeliverGoodsDate;
	        }
	        
	        var td5=document.createElement("td");
	        td5.style.cssText="text-align:center";
	        td5.innerHTML =prod.astProCode;
	       
	        var td6=document.createElement("td");
	        td6.style.cssText="text-align:center";
	        td6.innerHTML =prod.astProName;
	        
	        var td7=document.createElement("td");
	        td7.style.cssText="text-align:center";
			td7.innerHTML = prod.astProSpec;
			
			var td8 = document.createElement("td");
			td8.style.cssText="text-align:center";
			td8.innerHTML = prod.astProType;
			
			var td9=document.createElement("td");
			td9.style.cssText="text-align:right;padding-right:5px;";
			td9.innerHTML=  "￥"+fmoney(dt.astUnitPrice,<%=SystemConfig.getParam("erp.purchase.payshow")%>);
			
			var td10=document.createElement("td");
			td10.style.cssText="text-align:center";
			td10.innerHTML= fmoney(dt.num,0) + dt.product.libraryInfoUnit.libraryInfoName;
					
			var td11=document.createElement("td");
			td11.style.cssText="text-align:right;padding-right:5px;";
			td11.innerHTML =  "￥"+fmoney(dt.payMoney,<%=SystemConfig.getParam("erp.purchase.payshow")%>);
			
	        otr.appendChild(td1);
	        otr.appendChild(td3);
	        otr.appendChild(td4);
	        otr.appendChild(td5);
	        otr.appendChild(td6);
	        otr.appendChild(td7);
	        otr.appendChild(td8);
	        otr.appendChild(td9);
	        otr.appendChild(td10);
	        otr.appendChild(td11);
        }
        createRow(len+1);
        
        createRowSum(sumMoney,payMoney,lastMoney);
	}
}
function createRowSum(sumMoney,payMoney,lastMoney){
	var tab = document.getElementById("productlist");
		var otr = tab.insertRow(-1);
		var td1=document.createElement("td");
		td1.colSpan ="1";
		td1.style.cssText = "text-align:right";
		td1.innerHTML ="合计：";
		
		var td2=document.createElement("td");
		td2.colSpan ="1";
		td2.style.cssText = "text-align:right";
		td2.innerHTML ="总金额：";
		
		var td3=document.createElement("td");
		td3.colSpan = "2";
		td3.style.cssText = "text-align:right;padding-right:5px;";
		td3.innerHTML ="￥"+fmoney(sumMoney,<%=SystemConfig.getParam("erp.purchase.payshow")%>);
		
		var td4=document.createElement("td");
		td4.colSpan ="1";
		td4.style.cssText = "text-align:right";
		td4.innerHTML ="已付金额：";
		
		var td5=document.createElement("td");
		td5.colSpan = "2";
		td5.style.cssText = "text-align:right;padding-right:5px;";
		td5.innerHTML ="￥"+fmoney(payMoney,<%=SystemConfig.getParam("erp.purchase.payshow")%>);
		
		var td6=document.createElement("td");
		td6.colSpan ="1";
		td6.style.cssText = "text-align:right";
		td6.innerHTML ="未付金额：";
		
		var td7 = document.createElement("td");
		td7.colSpan = "2";
		td7.style.cssText = "text-align:right;padding-right:5px;";
		td7.innerHTML ="￥"+fmoney(lastMoney,<%=SystemConfig.getParam("erp.purchase.payshow")%>);
		
		otr.appendChild(td1);
		otr.appendChild(td2);
		otr.appendChild(td3);
		otr.appendChild(td4);
		otr.appendChild(td5);
		otr.appendChild(td6);
		otr.appendChild(td7);
}
function createRow(row){
	var tab = document.getElementById("productlist");
	for ( var i = row ; i < <%=row%>; i++) {
		var otr = tab.insertRow(-1);
		for(var j=0;j<10;j++){
			var td=document.createElement("td");
			td.innerHTML ="&nbsp;";
			otr.appendChild(td);
		}
    }
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
	<body style="overflow: auto; text-align: center;">
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
					供应商名称：<u><span id="providerName"></span></u>
				</td>
				<td class="printFontSign" align="right">
					结算单号：<u><span id="primaryKey"></span></u>
				</td>
			</tr>
		</table>
		<table class='printTableRowMore' width='98%' border='1' id='productlist'>
			<tr class="printTableRow_tr">
				<td class='printTableRow_td'>
					序号
				</td>
				<td class='printTableRow_td'>
					订单明细编号
				</td>
				<td class='printTableRow_td'>
					收货日期
				</td>
				<td class='printTableRow_td'>
					产品编号
				</td>
				<td class='printTableRow_td'>
					产品名称
				</td>
				<td class='printTableRow_td'>
					产品规格
				</td>
				<td class='printTableRow_td'>
					产品型号
				</td>
				<td class='printTableRow_td'>
					产品单价
				</td>
				<td class='printTableRow_td'>
					数量
				</td>
				<td class='printTableRow_td'>
					金额小计
				</td>
			</tr>
		</table>
		<table width="98%" border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td class="printFontSign" align="left">
					结算日期：<u><span id="settleTime"></span></u>
				</td>
				<td class="printFontSign" align="right">
					结算人员：<u><span id="settleEmp"></span></u>
				</td>
			</tr>
			<tr>
				<td class="printFontSign" align="left">
					结算单备注：<u><span id="remark"></span></u>
				</td>
			</tr>
		</table>
		<br />
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