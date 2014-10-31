<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../common_print.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrStorehouseService.js"></script>
<%
String pid =request.getParameter("pid");
Integer settSus = Integer.valueOf(request.getParameter("settSus"));
SessionUser usermsg = (SessionUser)LoginContext.getSessionValueByLogin(request);
int row = 15;

String title = usermsg.getCompanyName()+UtilTool.getSysParamByIndex(request,"erp.order.title");

String back = request.getParameter("back");
 %>
<title>采购单打印</title>
<script type="text/javascript">

window.onload = function(){
	dwrStorehouseService.getAstOrderByPkForDetail('<%=pid%>',setpagevalue);
}


function setpagevalue(data){
	if(data.success&&data.resultList.length>0){
		var obj = data.resultList[0];
		DWRUtil.setValue("astWarehouseId",obj.wareHouse.astWarehouseName);
		DWRUtil.setValue("astOrderDate",obj.astOrderDate);
		DWRUtil.setValue("primaryKey",obj.primaryKey);
		DWRUtil.setValue("astWarehouseContactEmpId",obj.astWarehouseContactEmpId);
		DWRUtil.setValue("astWarehouseContactPhoneId",obj.astWarehouseContactPhoneId);
		DWRUtil.setValue("astOrderAdder",obj.astOrderAdder);
		DWRUtil.setValue("astOrderRemark",obj.astOrderRemark);
		
		var ename = "";
		if(obj.hrmEmployee!=null){
			ename = obj.hrmEmployee.hrmEmployeeName
		}
		DWRUtil.setValue("sellEmployee",ename);
		var summon = obj.astOrderSumtotal;
		dwrStorehouseService.getAstOrderDetailListByOid('<%=pid%>',function(data){
			creatDetail(data,summon);
		});
	}else{
		alertmsg(data,null,"closeMDITab(window.parent.parent);")
	}
}

function creatDetail(data,smon){
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
	  
	        var td2=document.createElement("td");
	        td2.innerHTML =prod.astProCode;
	       
	        var td2_1=document.createElement("td");
	        td2_1.innerHTML =prod.astProName;
	        
	        var td2_2=document.createElement("td");
	        td2_2.innerHTML =prod.astProSpec;
	       
	        var td2_3=document.createElement("td");
	        td2_3.innerHTML =prod.astProType;
	        
	        var td3=document.createElement("td");
			td3.innerHTML = prov.astProvName;
			
			var td4 = document.createElement("td");
			td4.style.cssText="text-align:center";
			td4.innerHTML = fmoney(dt.astDetailCount,0)+ prod.libraryInfoUnit.libraryInfoName;
			
			var td5=document.createElement("td");
			td5.style.cssText="text-align:right";
			td5.innerHTML= forPackMoney(dt.astUnitPrice,<%=SystemConfig.getParam("erp.purchase.priceshow")%>);
			
			var td6=document.createElement("td");
			td6.style.cssText="text-align:right";
			td6.innerHTML= forPackMoney(dt.astDetailCount*dt.astUnitPrice,<%=SystemConfig.getParam("erp.purchase.priceshow")%>);
					
			var td7=document.createElement("td");
			td7.style.cssText="text-align:center";
			var tm = "&nbsp;";
			if(dt.astDeliverGoodsTime!=null&&dt.astDeliverGoodsTime.length>0){
				tm = dt.astDeliverGoodsTime;
			}
			
			td7.innerHTML = tm;
			
	        otr.appendChild(td1);
	        otr.appendChild(td2);
	        otr.appendChild(td2_1);
	        otr.appendChild(td2_2);
	        otr.appendChild(td2_3);
	        otr.appendChild(td3);
	        otr.appendChild(td4);
	        otr.appendChild(td5);
	        otr.appendChild(td6);
	        otr.appendChild(td7);
        }
        createRow(len+1);
        
        createRowSum(smon);
	}
}
function createRowSum(smon){
	var tab = document.getElementById("productlist");
		var otr = tab.insertRow(-1);
		var td1=document.createElement("td");
		td1.colSpan ="8";
		td1.style.cssText = "text-align:right";
		td1.innerHTML ="合计：";
		
		var td2=document.createElement("td");
		td2.colSpan = "2";
		td2.style.cssText = "text-align:center;";
		td2.innerHTML ="￥"+fmoney(smon,<%=SystemConfig.getParam("erp.purchase.priceshow")%>);
		
		otr.appendChild(td1);
		otr.appendChild(td2);
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

function back(back){
	if (back == 1){
		Sys.href("<%=contextPath%>/erp/store_house/order_manager.jsp");
	}else if(back == 2){
		Sys.href("<%=contextPath%>/erp/store_house/order_query.jsp");
	}else if(back == 3){
		Sys.href("<%=contextPath%>/erp/store_house/order_detail.jsp?pid=<%=pid%>&settSus=<%=settSus%>");
	}else if(back == 4){
		Sys.href("<%=contextPath%>/erp/store_house/order_confirm.jsp");
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
				<img src="<%=contextPath%>/images/cross.png"
				style="padding-right: 10px; cursor: pointer;" alt="关闭" border="0"
				title="关闭当前页面" onclick="closeMDITab(window.parent.parent);" />
	</div>
	<table width="98%" border="0" cellpadding="3" cellspacing="0">
	<tr height="50">
	<td class="printTitle" colspan="3">
	<%=title %>
	</td>
	</tr>
	<tr>
	<td align="left" class="printFontSign">
	仓库名称：<u><span id="astWarehouseId"></span></u>
	</td>
	<td align="right" class="printFontSign">
	采购单号：<u><span id="primaryKey"></span></u>
	</td>
	</tr>
	</table>
	<table class='printTableRowMore' width='98%' border='1' id='productlist'>
			<tr class="printTableRow_tr">
				<td  class='printTableRow_td'>序号</td>
				<td  class='printTableRow_td'>产品编号</td>
				<td  class='printTableRow_td'>产品名称</td>
				<td  class='printTableRow_td'>产品规格</td>
				<td  class='printTableRow_td'>产品型号</td>
				<td  class='printTableRow_td'>供应商</td>
				<td  class='printTableRow_td'>订货数量</td>
				<td  class='printTableRow_td'>单价(元)</td>
				<td  class='printTableRow_td'>小计(元)</td>
				<td  class='printTableRow_td'>要求送货时间</td>
			</tr>
	</table>
	<table width="98%" border="0" cellpadding="2" cellspacing="0">
	<tr>
	<td align="left" class="printFontSign">仓库联系人：<u><span id="astWarehouseContactEmpId"></span></u></td>
	<td width="90%"></td>
	<td align="right" class="printFontSign">采购人员：<u><span id="sellEmployee"></span></u></td>
	</tr>
	<tr>
	<td align="left" class="printFontSign">仓库电话：<u><span id="astWarehouseContactPhoneId"></span></u></td>
	<td width="90%"></td>	
	<td align="right" class="printFontSign">采购日期：<u><span  id="astOrderDate"></span></u></td>
	</tr>
	<tr>
	<td align="left" class="printFontSign">仓库地址：<u><span id="astOrderAdder"></span></u></td>
	</tr>
	<tr>
	<td valign="top" colspan="3" class="printFontSign">备注:<u><span id="astOrderRemark"></span></u></td>
	</tr>
	</table>
</body>
</html>