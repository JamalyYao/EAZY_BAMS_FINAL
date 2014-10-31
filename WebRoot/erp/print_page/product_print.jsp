<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../common_print.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=contextPath %>/dwr/interface/dwrStorehouseService.js"></script>
<%
SessionUser usermsg = (SessionUser)LoginContext.getSessionValueByLogin(request);
int row = 15;
String pid =request.getParameter("pid");
String title =usermsg.getCompanyName()+UtilTool.getSysParamByIndex(request,"erp.product.title");
%>
<title>产品信息打印</title>
<script type="text/javascript">

window.onload = function(){
	dwrStorehouseService.getProductByPk(<%=pid%>,setPageValue);
}


function setPageValue(data){
	if(data.success&&data.resultList.length>0){
			var obj = data.resultList[0];
			DWRUtil.setValue("astProCode",obj.astProCode);
			
			
			DWRUtil.setValue("astProName",obj.astProName);
			DWRUtil.setValue("astProEngname",obj.astProEngname);
			var cname ="";
			if(obj.productCategroy!=null){
				cname = obj.productCategroy.astCatName;
			}
			DWRUtil.setValue("astCatName",cname);
			DWRUtil.setValue("astProBrand",obj.astProBrand);
			DWRUtil.setValue("astProSpec",obj.astProSpec);
			DWRUtil.setValue("astProType",obj.astProType);
			
			DWRUtil.setValue("astProStoreMinnumber",obj.astProStoreMinnumber);
			DWRUtil.setValue("astProStoreMaxnumber",obj.astProStoreMaxnumber);
			DWRUtil.setValue("astProWarnEmpName",obj.warnEmpName);
			
			var unit="";
			if(obj.libraryInfoUnit!=null){
				unit = obj.libraryInfoUnit.libraryInfoName;
			}
			document.getElementById("astProUnit").innerHTML = unit;
			
			
			
			DWRUtil.setValue("astProUsedate",obj.astProUsedate);
			DWRUtil.setValue("astProMadebuss",obj.astProMadebuss);
			DWRUtil.setValue("astProMadearea",obj.astProMadearea);
			DWRUtil.setValue("astProApplicable",obj.astProApplicable);
			document.getElementById("astProProperty").innerHTML = obj.astProProperty;
				
			dwrStorehouseService.getProductBomByPId(<%=pid%>,setBomList);	//产品所组成原料
		}else{
			alertmsg(data,null,"closeMDITab(window.parent.parent);");
		}
}

function setBomList(data){
	   var tab = document.getElementById("productlist");
	   var count = 0;
		if(data.success&&data.resultList.length>0){
			var len = data.resultList.length;
			for ( var i = 0; i < len; i++) {
				var bom = data.resultList[i];
				count+=bom.astProCount;
				var otr = tab.insertRow(-1);
				var pname="";
				
		        var td1=document.createElement("td");
		        td1.style.cssText="text-align:center";
		        td1.innerHTML = i+1;
		  
		        var td2=document.createElement("td");
		        td2.style.cssText="text-align:center";
		        if(bom.product!=null){
		        	td2.innerHTML =bom.product.astProCode;
		        }
		       
		        var td3=document.createElement("td");
		        td3.style.cssText="text-align:center";
		        if(bom.product != null && bom.product.productCategroy != null){
		        	td3.innerHTML = bom.product.productCategroy.astCatName;
		        }
		        
		        var td4=document.createElement("td");
		        td4.style.cssText="text-align:center";
		       
		        var td5=document.createElement("td");
		        td5.style.cssText="text-align:center";
		        
		        var td6=document.createElement("td");
		        td6.style.cssText="text-align:center";
		       
	       		if(bom.product!=null){
					td4.innerHTML =bom.product.astProName;
					
					td5.innerHTML = bom.product.astProSpec;
					
					var unit="";
					if(bom.product!=null&&bom.product.libraryInfoUnit!=null){
						unit = bom.product.libraryInfoUnit.libraryInfoName;
					}
					td6.innerHTML =bom.astProCount + unit;
		        }
				
		        otr.appendChild(td1);
		        otr.appendChild(td2);
		        otr.appendChild(td3);
		        otr.appendChild(td4);
		        otr.appendChild(td5);
		        otr.appendChild(td6);
	        }
	        createRow(len+1);
	        createRowSum(count);
     }else{
       	var otr = tab.insertRow(-1);
        var td1=document.createElement("td");
        td1.style.cssText="text-align:center";
        td1.colSpan = 6;
        td1.innerHTML = "没有产品BOM信息。";
        
        otr.appendChild(td1);
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

function back(){
		Sys.href("<%=contextPath%>/erp/store_house/product_query.jsp");
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
			<td colspan="3" class="printTitle">
			<%=title %>
			</td>
		</tr>
	</table>
    <table width="98%" border="0" cellpadding="2" cellspacing="0">
		<tr>
			<td align="left">
				<span class="printFontSign">产品明细</span>
			</td>
		<tr>
	</table>
	<table class="printTableRow" border='1' width='98%'>
			<tr>
				<td class='printTable_tr'>
					产品编码
				</td>
				<td class="printTable_td" id="astProCode"></td>
				<td class='printTable_tr'>
					产品名称
				</td>
				<td class="printTable_td" id="astProName"></td>
			</tr>
			<tr>
				<td class='printTable_tr'>
					产品类型
				</td>
				<td class="printTable_td" id="astCatName"></td>
				<td class='printTable_tr'>
					产品规格
				</td>
				<td class="printTable_td" id="astProSpec"></td>
			</tr>
			<tr>
				<td class='printTable_tr'>
					下限数量
				</td>
				<td class="printTable_td" id="astProStoreMinnumber"></td>
				<td class='printTable_tr'>
					上限数量
				</td>
				<td class="printTable_td" id="astProStoreMaxnumber"></td>
			</tr>
			<tr>
				<td class='printTable_tr'>
					计量单位
				</td>
				<td class="printTable_td" id="astProUnit"></td>
				<td class='printTable_tr'>
					质保期
				</td>
				<td class="printTable_td" id="astProUsedate"></td>
			</tr>
			
			<tr>
				<td class='printTable_tr'>
					生产厂商
				</td>
				<td class="printTable_td" id="astProMadebuss"></td>
				<td class='printTable_tr'>
					产品品牌
				</td>
				<td class="printTable_td" id="astProBrand"></td>
			</tr>
			<tr>
				<td class='printTable_tr'>
					预 警 人
				</td>
				<td class="printTable_td" id="astProWarnEmpName"></td>
				<td class='printTable_tr'>
					产 地
				</td>
				<td class="printTable_td" id="astProMadearea"></td>
			</tr>
			<tr height="60px">
				<td class='printTable_tr'>
					适用范围
				</td>
				<td class="printTable_td" colspan="3" id="astProApplicable"></td>
			</tr>
			<tr height="60px">
				<td class='printTable_tr'>
					附加属性
				</td>
				<td class="printTable_td" colspan="3" id="astProProperty"></td>
			</tr>
	</table>
	<br/>
	<table width="98%" border="0" cellpadding="2" cellspacing="0">
		<tr>
			<td align="left">
				<span class="printFontSign">产品BOM明细</span>
			</td>
		<tr>
	</table>
	<table class='printTableRowMore' width='98%' border='1' id='productlist'>
			<tr class="printTableRow_tr">
				<td class='printTableRow_td'>
					序号
				</td>
				<td class='printTableRow_td'>
					原料编号
				</td>
				<td class='printTableRow_td'>
					原料类型
				</td>
				<td class='printTableRow_td'>
					原料名称
				</td>
				<td class='printTableRow_td'>
					原料规格
				</td>
				<td class='printTableRow_td'>
					所需数量
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