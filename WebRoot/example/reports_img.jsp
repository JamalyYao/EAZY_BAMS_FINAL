<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=contextPath%>/dwr/interface/dwrStorehouseService.js"></script>
<link rel="stylesheet" href="<%=contextPath%>/report/FusionChartsFree/Contents/Style.css" type="text/css" />
<script language="JavaScript" src="<%=contextPath%>/report/FusionChartsFree/JSClass/FusionCharts.js"></script>
<title>客户漏斗模型</title>
<script type="text/javascript">
var wid = screen.width * 0.3;
var hei = screen.height * 0.4;

window.onload = function(){
	useLoadingMassage();
	initInput("helpTitle","相关报表方法");
}

function test(num){
	alert(num);
	alert('签约客户');
}

function goto(){
 window.location='www.baidu.com';
}
</script>
</head>
<body class="inputcls">
<div class="formDetail">
	<div class="requdivdetail"><label id="helpTitle"></label></div>
	caption 标题&nbsp;&nbsp;&nbsp;&nbsp;subcaption 子标题&nbsp;&nbsp;&nbsp;&nbsp;y-axisminlimit y轴最小值<&nbsp;&nbsp;&nbsp;&nbsp;y-axismaxlimit y轴最大值<br/>
	numberPrefix 数值前缀&nbsp;&nbsp;&nbsp;&nbsp;numberSuffix 数值后缀<br/>
	<div class="formTitle">报表</div>
	<table width="98%" border="0" cellspacing="0" cellpadding="3" align="center">
	  <tr> 
	    <td valign="top" class="text" align="center"> 
	      <div id="chart1" align="center">无法显示相关图表</div>
	      <script type="text/javascript">	      
		   var chart1 = new FusionCharts("<%=contextPath%>/report/FusionChartsFree/Charts/FCF_Funnel.swf", "chart1", wid, hei);
		   	   
		   var strXML = "<?xml version=\'1.0\' encoding=\'UTF-8\'?>";
		   strXML += "<chart isSliced='1' slicingDistance='4' decimalPrecision='0' numberSuffix='（个）' >";
		   strXML += "<set name='成交客户' value='12' color='fb4201' alpha='85' link='javaScript:alert(\"成交客户\");'/>";
		   strXML += "<set name='签约客户' value='20' color='ecfb01'  alpha='85' link='javaScript:alert(\"签约客户\");'/>";
		   strXML += "<set name='产品介绍中' value='35' color='24fb01' alpha='85' link='javaScript:test(5);'/>";
		   strXML += "<set name='初级客户' value='125' color='01a3fb' alpha='85' link='javaScript:goto();'/>";
		   strXML += "</chart>";
		   
		   chart1.setDataXML(strXML);
		   chart1.render("chart1");
		</script> 
		</td>
		 <td valign="top" class="text" align="center"> 
	      <div id="chart2" align="center">无法显示相关图表</div>
	      <script type="text/javascript">
	      var chart2 = new FusionCharts("<%=contextPath%>/report/FusionChartsFree/Charts/FCF_Column3D.swf", "chart2", wid, hei);
		   	   
		   	var strXML = "<?xml version=\'1.0\' encoding=\'UTF-8\'?>";
		    strXML += "<graph caption='客户分布柱状图' subcaption='子标题' y-axisminlimit='5' y-axismaxlimit='200' numberPrefix='客户' numberSuffix='（个）' xAxisName='客户类型' yAxisName='' decimalPrecision='0' formatNumberScale='0'>";
			strXML += "<set name='初级客户' value='125' color='01a3fb' link='javaScript:goto();'/> ";
			strXML += "<set name='产品介绍中' value='35' color='24fb01' link='javaScript:test(5);'/> ";
			strXML += "<set name='签约客户' value='20' color='ecfb01' link='javaScript:alert(\"签约客户\");'/> ";
			strXML += "<set name='成交客户' value='12' color='fb4201' link='javaScript:alert(\"成交客户\");'/> ";
			strXML += "</graph>";
			
		   
		   chart2.setDataXML(strXML);
		   chart2.render("chart2");
		</script> 
		</td>
	  </tr>
	  <tr> 
	    <td valign="top" class="text" align="center"> 
	      <div id="chart3" align="center">无法显示相关图表</div>
	      <script type="text/javascript">	      
		   var chart3 = new FusionCharts("<%=contextPath%>/report/FusionChartsFree/Charts/FCF_MSColumn3D.swf", "chart3", wid, hei);
		   	   
		   var strXML = "<?xml version=\'1.0\' encoding=\'UTF-8\'?>";
		   strXML += "<graph xaxisname='产品生产率' yaxisname='使用数量' hovercapbg='DEDEBE' hovercapborder='889E6D' rotateNames='0' yAxisMaxValue='100' numdivlines='9' divLineColor='CCCCCC' divLineAlpha='80' decimalPrecision='0' showAlternateHGridColor='1' AlternateHGridAlpha='30' AlternateHGridColor='CCCCCC' caption='车间生产统计' subcaption='2010年1月统计' >";
		   strXML += "<categories font='Arial' fontSize='11' fontColor='000000'>";
		   strXML += "   <category name='车间1' hoverText='第一车间'/>";
		   strXML += "   <category name='车间2' />";
		   strXML += "   <category name='车间3' />";
		   strXML += "</categories>";
		   strXML += "<dataset seriesname='杯子' color='FDC12E'>";
		   strXML += "   <set value='30' />";
		   strXML += "   <set value='26' />";
		   strXML += "   <set value='29' />";
		   strXML += "</dataset>";
		   strXML += " <dataset seriesname='椅子' color='56B9F9'>";
		   strXML += "   <set value='67' />";
		   strXML += "   <set value='98' />";
		   strXML += "   <set value='79' />";
		   strXML += "</dataset>";
		   strXML += " <dataset seriesname='桌子' color='C9198D' >";
		   strXML += "   <set value='27' />";
		   strXML += "   <set value='25' />";
		   strXML += "   <set value='28' />";
		   strXML += "</dataset>";
		   strXML += "</graph>";
		   
		   chart3.setDataXML(strXML);
		   chart3.render("chart3");
		</script> 
		</td>
		 <td valign="top" class="text" align="center"> 
	      <div id="chart4" align="center">无法显示相关图表</div>
	      <script type="text/javascript">
	      var chart4 = new FusionCharts("<%=contextPath%>/report/FusionChartsFree/Charts/FCF_Column3D.swf", "chart4", wid, hei);
		   	   
		   	var strXML = "<?xml version=\'1.0\' encoding=\'UTF-8\'?>";
		    strXML += "<graph caption='客户分布柱状图' subcaption='子标题' y-axisminlimit='5' y-axismaxlimit='200' numberPrefix='客户' numberSuffix='（个）' xAxisName='客户类型' yAxisName='' decimalPrecision='0' formatNumberScale='0'>";
			strXML += "<set name='初级客户' value='125' color='01a3fb' link='javaScript:goto();'/> ";
			strXML += "<set name='产品介绍中' value='35' color='24fb01' link='javaScript:test(5);'/> ";
			strXML += "<set name='签约客户' value='20' color='ecfb01' link='javaScript:alert(\"签约客户\");'/> ";
			strXML += "<set name='成交客户' value='12' color='fb4201' link='javaScript:alert(\"成交客户\");'/> ";
			strXML += "</graph>";
			
		   
		   chart4.setDataXML(strXML);
		   chart4.render("chart4");
		</script> 
		</td>
	  </tr>
	</table>
</div>
</body>
</html>