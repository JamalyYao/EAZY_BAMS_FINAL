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
			String rid = request.getParameter("rid");
			String title = usermsg.getCompanyName() + UtilTool.getSysParamByIndex(request,"erp.inspectorOne.title");
		%>
		<title>质检日志打印</title>
		<script type="text/javascript">
window.onload = function(){
	dwrStorehouseService.getAstInsepctorByIds(<%=rid%>,setpagevalue);
}

function setpagevalue(data){
	if(data != null){
	    if(data.resultList.length>0){
			var obj = data.resultList[0];
			var product = obj.astprod;//原料
			DWRUtil.setValue("astProductionName",obj.astProduction.astProductionName);
			DWRUtil.setValue("astProductionId",obj.astProduction.astProductionNumbers);
			DWRUtil.setValue("astInspectorEmp",obj.insepctionEmp.hrmEmployeeName);
			DWRUtil.setValue("astInspectorDate",obj.astInspectorDate);
			DWRUtil.setValue("astInspectorRemark",obj.astInspectorRemark);
			
			createDetail(obj);
		}
	}
}

function createDetail(obj){
	var tab = document.getElementById("inspectordetaillist");
	var rlen = tab.rows.length;	
	
	for(var i=rlen-1;i>=1;i--){
		tab.deleteRow(i);
	}
	var detailList = obj.astInspectDetailList;
	if(detailList != null){
		var length = detailList.length;
	}
	if( detailList != null && length> 0){
			for ( var i = 0; i < length; i++) {
				var inspdetail = detailList[i];
				var finpro = obj.astProductionLog.astFinishedProductList[i];
				var prod = finpro.astProduct;	//成品入库对象
				
				var otr = tab.insertRow(-1);
		
		        var td1=document.createElement("td");
		        var td2=document.createElement("td");
		        var td3=document.createElement("td");
		        var td4=document.createElement("td");
		        var td5=document.createElement("td");
		        var td6=document.createElement("td");
		        var td7=document.createElement("td");
		 		var td8=document.createElement("td");
		        
		        td1.style.cssText="text-align:center";
		        td2.style.cssText="text-align:center";
				td3.style.cssText="text-align:center";
				td4.style.cssText="text-align:center";
				td5.style.cssText="text-align:center";
				td6.style.cssText ="text-align:center";
				td7.style.cssText="text-align:center";
				td8.style.cssText="text-align:center";
		
				
				td1.innerHTML = i + 1;
		        td2.innerHTML = prod.astProCode;
				td3.innerHTML = prod.astProName;
	        	td4.innerHTML = prod.astProType;
	        	td5.innerHTML = prod.astProSpec;
	        	var unit="";
				if(prod.libraryInfoUnit!=null){
					unit = prod.libraryInfoUnit.libraryInfoName;
				}
	        	td6.innerHTML = finpro.astFinishedNum + unit;
	        	td7.innerHTML = inspdetail.astAcceptNum + unit;
	        	td8.innerHTML = inspdetail.passRate + "%";
				
		        otr.appendChild(td1);
		        otr.appendChild(td2);
		        otr.appendChild(td3);
		        otr.appendChild(td4);
		        otr.appendChild(td5);
		        otr.appendChild(td6);
		        otr.appendChild(td7);
		        otr.appendChild(td8);
	        }
        }
}

function back(back){
	Sys.href("<%=contextPath%>/erp/store_house/production_inspector_view_print.jsp?productionid="+<%=pid%>);
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
		<table width="95%" border="0" cellpadding="2" cellspacing="0">
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
			<tr>
				<td class="printFontSign" align="left">
					质检人：<u><span id="astInspectorEmp"></span> </u>
				</td>
				<td class="printFontSign" align="right">
					日期：<u><span id="astInspectorDate"></span> </u>
				</td>
			</tr>
			<tr>
				<td class="printFontSign" align="left">
					质检记录：<u><span id="astInspectorRemark"></span> </u>
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
					产品编号
				</td>
				<td class='printTableRow_td'>
					产品名称
				</td>
				<td class='printTableRow_td'>
					产品型号
				</td>
				<td class='printTableRow_td'>
					产品规格
				</td>
				<td class='printTableRow_td'>
					当日生产
				</td>
				<td class='printTableRow_td'>
					当日合格
				</td>
				<td class='printTableRow_td'>
					合格率
				</td>
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
					审核人：___________
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