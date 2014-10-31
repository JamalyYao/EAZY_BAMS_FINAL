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
			String pid = request.getParameter("pid");
			String ids = request.getParameter("ids");
			String title = usermsg.getCompanyName() + UtilTool.getSysParamByIndex(request,"erp.recipientMore.title");
		%>
		<title>领料单统计打印</title>
		<script type="text/javascript">
window.onload = function(){	
	var win = window.parent.parent.getMDIFrame(<%=request.getParameter("nowwindow")%>);
	//var ids = win.document.getElementById("printids").value;
	dwrStorehouseService.getRecipientsByProductionIds( "<%=ids%>",createReceiveDetail);
}

function createReceiveDetail(data){
	var tab = document.getElementById("receivedetaillist");
	var rlen = tab.rows.length;	
	
	for(var i=rlen-1;i>=1;i--){
		tab.deleteRow(i);
	}
	var length = data.resultList.length;
	if(data.success && length> 0){
			var production = data.resultList[0].astProduction;
			DWRUtil.setValue("astProductionName",production.astProductionName);
			DWRUtil.setValue("astProductionId",production.astProductionNumbers);
			for ( var i = 0; i < length - 1; i++) {
				var recipients = data.resultList[i];
				if(recipients.asttBom != null){
					var pbom = recipients.asttBom.proBom;	//生产产品
				}
				var prod = recipients.astProduct;	//原料

				var otr = tab.insertRow(-1);
		
				var td0=document.createElement("td");
		        var td1=document.createElement("td");
		        var td2=document.createElement("td");
		        var td3=document.createElement("td");
		        var td4=document.createElement("td");
		        var td5=document.createElement("td");
		        var td6=document.createElement("td");
		        var td7=document.createElement("td");
		        var td8=document.createElement("td");
				var td9=document.createElement("td");
				var td10=document.createElement("td");
		        
				td0.style.cssText="text-align:center";
		        td1.style.cssText="text-align:center";
		        td2.style.cssText="text-align:center";
				td3.style.cssText="text-align:center";
				td4.style.cssText="text-align:center";
				td5.style.cssText="text-align:center";
				td6.style.cssText ="text-align:center";
				td7.style.cssText="text-align:center";
				td8.style.cssText="text-align:center";
				td9.style.cssText="text-align:center";
				td10.style.cssText="text-align:center";
				
				td0.innerHTML = i + 1;
		        td1.innerHTML = pbom.astProName;
		        td2.innerHTML = prod.astProName;
				td3.innerHTML = prod.astProSpec;
	        	td4.innerHTML =prod.astProType;
	        	
				if(recipients.astApplyEmployee != null){
					td5.innerHTML = recipients.astApplyEmployee.hrmEmployeeName;
				}else{
					td5.innerHTML = "&nbsp;";
				}
				td6.innerHTML = recipients.astApplyTime ;
				
				if(recipients.astReceiveEmp != null){
					td7.innerHTML = recipients.astReceiveEmployee.hrmEmployeeName;
				}else{
					td7.innerHTML = "&nbsp;";
				}
				td8.innerHTML = recipients.astReceiveTime != null ? recipients.astReceiveTime : "&nbsp;";
				
				var unit="";
				if(prod.libraryInfoUnit!=null){
					unit = prod.libraryInfoUnit.libraryInfoName;
				}
				
				td9.innerHTML = recipients.astProductNum + unit;
				
				if(recipients.astOutStoreStatus == 1){
					td10.innerHTML = "未出库";
				}else{
					td10.innerHTML = "已出库";
				}
				
		        otr.appendChild(td0);
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
	        //统计数量
	       	//createRow(length);
			var recipient = data.resultList[length - 1];
      		createRowSum(recipient.astProductNum);
        }
}

function createRowSum(count){
	var tab = document.getElementById("receivedetaillist");
		var otr = tab.insertRow(-1);
		var td1=document.createElement("td");
		td1.colSpan ="8";
		td1.style.cssText = "text-align:right";
		td1.innerHTML ="&nbsp;";
		
		var td2=document.createElement("td");
		td2.colSpan ="1";
		td2.style.cssText = "text-align:right";
		td2.innerHTML ="总数量:";
		
		var td3=document.createElement("td");
		td3.colSpan = "1";
		td3.style.cssText = "text-align:center;";
		td3.innerHTML =fmoney(count,2);
		
		var td4=document.createElement("td");
		td4.colSpan ="2";
		td4.style.cssText = "text-align:right";
		td4.innerHTML ="&nbsp;";
		
		otr.appendChild(td1);
		otr.appendChild(td2);
		otr.appendChild(td3);
		otr.appendChild(td4);
}

function createRow(row){
	var tab = document.getElementById("receivedetaillist");
	for ( var i = row ; i < <%=row%>; i++) {
		var otr = tab.insertRow(-1);
		for(var j=0;j<11;j++){
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

function back(back){
	Sys.href("<%=contextPath%>/erp/store_house/production_task_bom_receive.jsp?id="+<%=pid%>);
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
		<table width="98%" border="0" cellpadding="2" cellspacing="0">
			<tr height="50">
				<td colspan="3" class="printTitle">
					<%=title%>
				</td>
			</tr>
			<tr>
				<td class="printFontSign" align="left">
					生产任务名称：<u><span id="astProductionName"></span> </u>
				</td>
				<td class="printFontSign" align="right">
					生产任务单号：<u><span id="astProductionId"></span> </u>
				</td>
			</tr>
		</table>
		<table class='printTableRowMore' width='98%' border='1'
			id='receivedetaillist'>
			<tr class="printTableRow_tr">
				<td class='printTableRow_td'>
					序号
				</td>
				<td class='printTableRow_td'>
					生产产品
				</td>
				<td class='printTableRow_td'>
					原料名称
				</td>
				<td class='printTableRow_td'>
					原料规格
				</td>
				<td class='printTableRow_td'>
					原料型号
				</td>
				<td class='printTableRow_td'>
					申请人
				</td>
				<td class='printTableRow_td'>
					申请时间
				</td>
				<td class='printTableRow_td'>
					领料人
				</td>
				<td class='printTableRow_td'>
					领料时间
				</td>
				<td class='printTableRow_td'>
					领料数量
				</td>
				<td class='printTableRow_td'>
					出库状态
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