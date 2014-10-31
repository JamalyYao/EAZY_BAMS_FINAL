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
			String ids = request.getParameter("ids");
			SessionUser usermsg = (SessionUser) LoginContext.getSessionValueByLogin(request);
			int row = 15;
			String title = usermsg.getCompanyName()+UtilTool.getSysParamByIndex(request,"erp.warehouse.title");
		%>
		<title>库存统计打印</title>
		<script type="text/javascript">
window.onload = function(){	
	var arry = "<%=ids%>".split(",");
	dwrStorehouseService.getWarehouseStockByIds(arry,setpagevalue);
}


function setpagevalue(data){
	if(data.success&&data.resultList.length>0){
		var count = 0;
		back = data.resultList[0];
		if(back.warehouse != null){
			DWRUtil.setValue("astWarehouseName", back.warehouse.astWarehouseName);
			DWRUtil.setValue("title", '<%=title%>'+"中的"+back.warehouse.astWarehouseName+"库存单据");
		}
		
		for(i=0;i<data.resultList.length;i++){
			count +=Math.abs(data.resultList[i].astStockCount);
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
			var otr = tab.insertRow(-1);

	        var td1=document.createElement("td");
	        td1.style.cssText="text-align:center";
	        td1.innerHTML = i+1;
	       
	        var td2=document.createElement("td");
	        td2.style.cssText="text-align:center";
	        
	        var td3=document.createElement("td");
	        td3.style.cssText="text-align:center";
	        
	        var td4=document.createElement("td");
	        td4.style.cssText="text-align:center";
	        
	        var td5=document.createElement("td");
	        td5.style.cssText="text-align:center";
	        if(dt.product != null){
		       if(dt.product.astProCode != null&&dt.product.astProCode.length > 0){
			        td2.innerHTML =dt.product.astProCode;
	       		}else{
	       		    td2.innerHTML ="&nbsp;";
	       		}
	       
	       		if(dt.product.astProName != null&&dt.product.astProName.length > 0){
			        td3.innerHTML =dt.product.astProName;
	       		}else{
	       		    td3.innerHTML ="&nbsp;";
	       		}
	       		
	       		if(dt.product.astProSpec != null&&dt.product.astProSpec > 0){
			         td4.innerHTML =dt.product.astProSpec;
	       		}else{
	       		    td4.innerHTML ="&nbsp;";
	       		}
		        
		      if(dt.product.astProType != null&&dt.product.astProType.length > 0){
		       	 	td5.innerHTML =dt.product.astProType;
	       		}else{
	       		    td5.innerHTML ="&nbsp;";
	       		}
	        }
	        
	        var unit="";
			if(dt.product.libraryInfoUnit!=null){
				unit = dt.product.libraryInfoUnit.libraryInfoName;
			}
	        var td6=document.createElement("td");
	        td6.style.cssText="text-align:center";
			td6.innerHTML = fmoney(dt.astStockCount,0) +unit;
			
	        otr.appendChild(td1);
	        otr.appendChild(td2);
	        otr.appendChild(td3);
	        otr.appendChild(td4);
	        otr.appendChild(td5);
            otr.appendChild(td6);
        }
        createRow(len+1);
        
        createRowSum(count);
	}
}
function createRowSum(count){
	var tab = document.getElementById("productlist");
	var otr = tab.insertRow(-1);
	var td1=document.createElement("td");
	td1.colSpan ="5";
	td1.style.cssText = "text-align:right";
	td1.innerHTML ="合计：";
	
	var td2=document.createElement("td");
	td2.colSpan = "1";
	td2.style.cssText = "text-align:center";
	td2.innerHTML =fmoney(count,0);
	
	otr.appendChild(td1);
	otr.appendChild(td2);
}
function createRow(row){
	var tab = document.getElementById("productlist");
	for ( var i = row ; i < <%=row%>; i++) {
		var otr = tab.insertRow(-1);
		for(var j=0;j<6;j++){
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

function backToList(){
	Sys.href("<%=contextPath%>/erp/store_house/warehouse_pro_query.jsp");
}
</script>
	</head>
	<body style="overflow: auto; text-align: center;">
		<div class="printBtn" id = "pngdiv">
			<img src="<%=contextPath %>/images/printpage.png" style="padding-right: 10px;cursor: pointer;" alt="打印"  border="0" title="打印" onclick="printorder();"/>
			&nbsp;&nbsp;			
			<img src="<%=contextPath%>/images/cross.png"
				style="padding-right: 10px; cursor: pointer;" alt="关闭" border="0"
				title="关闭当前页面" onclick="closeMDITab(window.parent.parent);" />
		</div>
		<table width="98%" border="0" cellpadding="3" cellspacing="0">
			<tr height="50">
				<td colspan="3" class="printTitle">
				<%=title %>
				</td>
			</tr>
			<tr>
		<td class="printFontSign" align="right">
			仓库：<u><span id="astWarehouseName"></span></u>
		</td>
	</tr>
		</table>
		<table class='printTableRowMore' width='98%' border='1' id='productlist'>
			<tr class="printTableRow_tr">
				<td class='printTableRow_td'>
					序号
				</td>
				<td class='printTableRow_td'>
					产品编码
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
					库存数量
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