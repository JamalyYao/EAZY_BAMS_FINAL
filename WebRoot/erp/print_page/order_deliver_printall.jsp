<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common_print.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript"
			src="<%=contextPath%>/dwr/interface/dwrStorehouseService.js"></script>
		<%
			String ids = request.getParameter("arrary");
			String cid= request.getParameter("cid");
			String back= request.getParameter("back");
			SessionUser usermsg = (SessionUser) LoginContext.getSessionValueByLogin(request);
			int row = 15;
			String title = usermsg.getCompanyName()+UtilTool.getSysParamByIndex(request,"erp.orderdeilverall.title");
		%>
		<title>收货单统计打印</title>
		<script type="text/javascript">
window.onload = function(){	
	var sArr = "<%=ids%>".split(",");
	dwrStorehouseService.getAstPurchaseDeliveryByPks(sArr,setpagevalue);
}


function setpagevalue(data){
	if(data.success&&data.resultList.length>0){
		var count = 0.00;
		astpurchase = data.resultList[0];
		DWRUtil.setValue("providerName", astpurchase.provider.astProvName);
		for(i=0;i<data.resultList.length;i++){
			count += data.resultList[i].astDeliveryCount;
		}
		creatDetail(data,count);
	}
}

function creatDetail(data,count){
	var tab= document.getElementById("productlist");
	if(data.success&&data.resultList.length>0){
		var len = data.resultList.length;
		for ( var i = 0; i < len; i++) {

			var dt = data.resultList[i];
			var prod = dt.product;
			var prov = dt.employee;
			var otr = tab.insertRow(-1);

	        var td1=document.createElement("td");
	        td1.style.cssText="text-align:center";
	        td1.innerHTML = i+1;
	  
	        var td2=document.createElement("td");
	        td2.style.cssText="text-align:center";
	        td2.innerHTML =dt.astOrderId;
	       
	        var td3=document.createElement("td");
	        td3.style.cssText="text-align:center";
	        td3.innerHTML =dt.astOrderDetailId;
	        
	        var td4=document.createElement("td");
	        td4.style.cssText="text-align:center";
	        td4.innerHTML =dt.astDeliveryId;
	       
	        var td5=document.createElement("td");
	        td5.style.cssText="text-align:center";
	        td5.innerHTML =prod.astProName;
	        
	        var td6=document.createElement("td");
	        td6.style.cssText="text-align:center";
			td6.innerHTML = prod.astProSpec;
			
			var td7 = document.createElement("td");
			td7.style.cssText="text-align:center";
			td7.innerHTML = prod.astProType;
			
			var td8=document.createElement("td");
			td8.style.cssText="text-align:center";
			td8.innerHTML= fmoney(dt.astDeliveryCount,0) + dt.product.libraryInfoUnit.libraryInfoName;
					
			var td9=document.createElement("td");
			td9.style.cssText="text-align:center";
			td9.innerHTML =  prov.hrmEmployeeName;
			
			var td10=document.createElement("td");
			td10.style.cssText="text-align:center";
			td10.innerHTML =  dt.astDeliveryDate;
			
	        otr.appendChild(td1);
	        otr.appendChild(td2);
	        otr.appendChild(td3);
	        otr.appendChild(td4);
	        otr.appendChild(td5);
	        otr.appendChild(td6);
	        otr.appendChild(td7);
	        otr.appendChild(td8);
	        otr.appendChild(td9);
	        otr.appendChild(td10);
        }
        
        createRowSum(count);
	}
}
function createRowSum(count){
	var tab = document.getElementById("productlist");
		var otr = tab.insertRow(-1);
		var td1=document.createElement("td");
		td1.colSpan ="7";
		td1.style.cssText = "text-align:right";
		td1.innerHTML = "收货总数：";
		
		var td2=document.createElement("td");
		td2.colSpan = "3";
		td2.style.cssText = "text-align:center;";
		td2.innerHTML =fmoney(count,2);
		
		otr.appendChild(td1);
		otr.appendChild(td2);
}

function printorder(){
	pngdiv.style.display='none';
	print();
	pngdiv.style.display='block';
}

function back(back){
	if (back == 1){
		Sys.href("<%=contextPath%>/erp/store_house/order_deliver_history.jsp?cid="+<%=cid%>);
	}else if(back == 2){
		Sys.href("<%=contextPath%>/erp/store_house/order_query.jsp");
	}
}
</script>
	</head>
	<body style="overflow: auto; text-align: center;">
	<div class="printBtn" id = "pngdiv">
		<img src="<%=contextPath %>/images/printpage.png" style="padding-right: 10px;cursor: pointer;" alt="打印"  border="0" title="打印" onclick="printorder();"/>
		&nbsp;&nbsp;<img src="<%=contextPath%>/images/cross.png" style="padding-right: 10px; cursor: pointer;" alt="关闭" border="0" title="关闭当前页面" onclick="closeMDITab(window.parent.parent);" />
	</div>
		<table width="98%" border="0" cellpadding="3" cellspacing="0">
			<tr height="50">
				<td colspan="3" class="printTitle">
						<%=title %>
				</td>
			</tr>
			<tr>
				<td class="printFontSign" align="right">
				供应商名称：<u><span id="providerName"></span></u>
				</td>
			</tr>
		</table>
		<table class='printTableRowMore' width='98%' border='1' id='productlist'>
			<tr class="printTableRow_tr">
				<td class='printTableRow_td'>
					序号
				</td>
				<td class='printTableRow_td'>
					订单编号
				</td>
				<td class='printTableRow_td'>
					订单明细编号
				</td>
				<td class='printTableRow_td'>
					收货单号
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
					数量
				</td>
				<td class='printTableRow_td'>
					收货人
				</td>
				<td class='printTableRow_td'>
					收货时间
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