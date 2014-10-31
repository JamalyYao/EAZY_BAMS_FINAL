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
		String title = usermsg.getCompanyName() + UtilTool.getSysParamByIndex(request,"erp.taskbegin.title");
		
		//String back = request.getParameter("back");
		 %>
	<title>开始生产任务单据</title>
	
	
	<script type="text/javascript">
	window.onload = function(){
		dwrStorehouseService.getProductionByPk('<%=pid%>',setAstProduction);
	}
	
	
	function setAstProduction(data){
	   if(data != null){
		      if(data.resultList.length>0){
		          var production = data.resultList[0];
		          DWRUtil.setValue("astProductionNumbers",production.astProductionNumbers);
		          DWRUtil.setValue("astProductionName",production.astProductionName);
		          DWRUtil.setValue("astProductionRdata",production.astProductionRdata);
		          DWRUtil.setValue("astProductionTime",production.astProductionSdata + " 至 " + production.astProductionEdata);
		  		  DWRUtil.setValue("qualifiedPercent",production.qualifiedPercent + "%");
		  		  DWRUtil.setValue("astProductionPriority",production.astProductionPriority);
		  		  
		  		  
		  		  
		          var type = "<无>";
		          if(production.astProductionType != null){
		              type = production.oaTypeLib.libraryInfoName;
		          }
		          document.getElementById("astProductionType").innerHTML = type;
	
		          var cname = "&nbsp;";
		          if(production.astProductionChargeEmployee!=null){
		          	cname= production.astProductionChargeEmployee.hrmEmployeeName;
		          }else{
		          	cname ="&nbsp;";
		          }
		          document.getElementById("astProductionChargeEmployee").innerHTML = cname;
		          
		          var iname = "&nbsp;";
		          if(production.astInspectorEmployee!=null){
		          	iname= production.astInspectorEmployee.hrmEmployeeName;
		          }else{
		          	iname ="&nbsp;";
		          }
		          document.getElementById("astInspectorEmp").innerHTML = iname;
		     
		          var rname = "&nbsp;";
		          if(production.astProductionREmployee!=null){
		          	rname= production.astProductionREmployee.hrmEmployeeName;
		          }else{
		          	rname ="&nbsp;";
		          }
		          document.getElementById("astProductionREmployee").innerHTML = rname;
		          
		          var astWarehouseNames= "&nbsp";
		          if(production.astWarehouseNames != null && trim(production.astWarehouseNames).length > 0){
		          	astWarehouseNames = production.astWarehouseNames;
		          }
		          document.getElementById("astWarehouseNames").innerHTML = astWarehouseNames;
		         
		         
		          var astProductionNote= "&nbsp;"; 
		          if(production.astProductionNote != null && trim(production.astProductionNote).length > 0){
		          	astProductionNote = production.astProductionNote;
		          }else{
		          	astProductionNote = "&nbsp;";  
		          }
		          document.getElementById("astProductionNote").innerHTML = astProductionNote;
		      }
	    }
	    	dwrStorehouseService.getlistAstProductionDetail(<%=pid%>,createProductionDetail);
	}
	
	function createProductionDetail(data){
		var tab = document.getElementById("productdetaillist");
		var rlen = tab.rows.length;	
		for(var i=rlen-1;i>=1;i--){
			tab.deleteRow(i);
		}
		if(data.length > 0){
			for ( var i = 0; i < data.length; i++) {
				var productionDetail = data[i];
				var product = productionDetail.astProduct;
				
				var otr = tab.insertRow(-1);
				otr.style.cssText="height:24px";
				
		        var td1=document.createElement("td");
		        var td2=document.createElement("td");
				var td3=document.createElement("td");
				var td4=document.createElement("td");
				var td5=document.createElement("td");
				var td6=document.createElement("td");
				var td7=document.createElement("td");
				var td7_1=document.createElement("td");
				var td8=document.createElement("td");
				var td9=document.createElement("td");
			
	        	td1.style.cssText="text-align:center";
	        	td2.style.cssText="text-align:center";
	        	td3.style.cssText="text-align:center";
				td4.style.cssText="text-align:center";
				td5.style.cssText="text-align:center";
				td6.style.cssText="text-align:center";
				td7.style.cssText="text-align:center";
				td7_1.style.cssText="text-align:center";
				td8.style.cssText="text-align:center";
				td9.style.cssText="text-align:center";
				
				if(product != null && product.productCategroy != null){
		        	td1.innerHTML = product.productCategroy.astCatName;
		        }else{
		        	td1.innerHTML = "<无>";
		        }
		        
		        if(product!=null){
		        	pcode = product.astProCode;
		        }
		        td2.innerHTML =pcode;
		        
		        if(product!=null){
		        	pname = product.astProName;
		        }
				td3.innerHTML = pname;
	        	
	        	td4.innerHTML = product.astProSpec;
		        td5.innerHTML =product.astProType;
				var unit="";
				if(product!=null&&product.libraryInfoUnit!=null){
					unit = product.libraryInfoUnit.libraryInfoName;
				}
				td6.innerHTML = fmoney(productionDetail.astProductsNum,0)+"&nbsp;"+unit;
				td7.innerHTML = fmoney(productionDetail.astProductsCount,0)+"&nbsp;"+unit;
				td7_1.innerHTML = fmoney(productionDetail.qualifiedNum,0)+"&nbsp;"+unit;
				td8.innerHTML = fmoney(productionDetail.astInstoreCount,0)+"&nbsp;"+unit;
	
				var priority = productionDetail.astProductPriority == null ? 0 : productionDetail.astProductPriority
				td9.innerHTML = priority;
										
		        otr.appendChild(td1);
		        otr.appendChild(td2);
		        otr.appendChild(td3);
		        otr.appendChild(td4);
		        otr.appendChild(td5);
		        otr.appendChild(td6);
		        otr.appendChild(td7);
		        otr.appendChild(td7_1);
		        otr.appendChild(td8);
		        otr.appendChild(td9);
			}
	    }else{
	       	var otr = tab.insertRow(-1);
	        var td1=document.createElement("td");
	        td1.style.cssText="text-align:center";
	        td1.colSpan = 8;
	        td1.innerHTML = "没有生产明细记录。";
	        otr.appendChild(td1);
	     }
	}
	
	function printorder(){
		pngdiv.style.display='none';
		print();
		pngdiv.style.display='block';
	}
	
	function back(back){
		Sys.href("<%=contextPath%>/erp/store_house/production_task_ready.jsp?type=manager");
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
		</table>
		
		<table width="98%" border="0" cellpadding="3" cellspacing="0">
			<tr>
				<td align="left"><span class="printFontSign">生产任务明细</span></td>
			</tr>
		</table>
		
		<table class="printTableRow" border='1' width='98%'>
				<tr class="printTableRow_tr">
					<td  class='printTable_tr' style="text-align: center;">任务编号</td>
					<td  class='printTable_td' id="astProductionNumbers"></td>
					<td  class='printTable_tr' style="text-align: center;">任务名称</td>
					<td  class='printTable_td' id="astProductionName"></td>
				</tr>
				<tr>
					<td  class='printTable_tr' style="text-align: center;">任务类型</td>
					<td  class='printTable_td' id="astProductionType"></td>
					<td  class='printTable_tr' style="text-align: center;">任务优先级</td>
					<td  class='printTable_td' id="astProductionPriority"></td>
				</tr>
				<tr>
					<td  class='printTable_tr' style="text-align: center;">任务周期</td>
					<td  class='printTable_td' id="astProductionTime"></td>
					<td  class='printTable_tr' style="text-align: center;">提交时间</td>
					<td  class='printTable_td' id="astProductionRdata"></td>
				</tr>
				<tr>
					<td  class='printTable_tr' style="text-align: center;">提交人</td>
					<td  class='printTable_td' id="astProductionREmployee"></td>
					<td  class='printTable_tr' style="text-align: center;">负责人</td>
					<td  class='printTable_td' id="astProductionChargeEmployee"></td>
				</tr>
				<tr>
					<td  class='printTable_tr' style="text-align: center;">质检人</td>
					<td  class='printTable_td' id="astInspectorEmp"></td>
					<td  class='printTable_tr' style="text-align: center;">合格率</td>
					<td  class='printTable_td' id="qualifiedPercent"></td>
				</tr>
				<tr height="50px">
					<td  class='printTable_tr' style="text-align: center;">出入仓库</td>
					<td  class='printTable_td' colspan="3" id="astWarehouseNames"></td>
				</tr>
				<tr  height="50px">
					<td  class='printTable_tr' style="text-align: center;">任务备注</td>
					<td  class='printTable_td' colspan="3" id="astProductionNote"></td>
				</tr>
				
		</table>
		<br/>
		
		<table width="98%" border="0" cellpadding="3" cellspacing="0">
			<tr>
				<td align="left"><span class="printFontSign">成品生产统计</span></td>
			</tr>
		</table>
		
		<table class='printTableRowMore' width='98%' border='1' id='productdetaillist'>
				<tr class="printTableRow_tr">
					<td  class='printTableRow_td'>产品类别</td>
					<td  class='printTableRow_td'>产品编号</td>
					<td  class='printTableRow_td'>产品名称</td>
					<td  class='printTableRow_td'>产品规格</td>
					<td  class='printTableRow_td'>产品型号</td>
					<td  class='printTableRow_td'>预计生产</td>
					<td  class='printTableRow_td'>实际生产</td>
					<td  class='printTableRow_td'>合格数量</td>
					<td  class='printTableRow_td'>入库数量</td>
					<td  class='printTableRow_td'>生产级别</td>
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