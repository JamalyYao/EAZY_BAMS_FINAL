<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/runqianReport.tld" prefix="report" %>

<%@ page import="java.io.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.runqian.base.module.DataSetConfig" %>
<%@ page import="com.runqian.report.usermodel.*" %>
<%@ page import="com.runqian.report.engine.*" %>

<%
//项目相对及绝对路径
String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>打印数据</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=contextPath%>/js/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/ext-all.js"></script>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/css/ext-all.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/icons.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String raq = request.getParameter("raq");
	String reportPath = "/erp/report_files/" + raq;
	
	String saveName = raq.substring(0,raq.lastIndexOf(".raq"));
	
	String form;
	if(-1 != raq.lastIndexOf(".raq")){		
		form = raq.substring(0,raq.lastIndexOf(".raq"));		
	}else{
		form = raq;
	}
	form = form + "_arg.raq";

	String tempPath = reportPath.substring(0,reportPath.lastIndexOf("/")) + "/" + form;

	File f = new File(application.getRealPath(tempPath));
	if(!f.exists()){		
		form = null;
		System.out.println("reprotFile:" + tempPath + " isn't exist!");
	}
	
	ReportDefine rd = new ReportDefine(application.getResourceAsStream(reportPath));
	//获取参数和宏
	StringBuffer param = new StringBuffer();
	String[] argumentNames = rd.getArguments().getArgumentNames();
	if(argumentNames != null){
		for(int i=0;i<argumentNames.length;i++){
			String tmp = request.getParameter(argumentNames[i]);
            if(tmp != null){
				param.append(argumentNames[i]).append("=").append(tmp).append(";");
			}
		}
	}
	
	String[] macroNames = rd.getMacroNames();
	if(macroNames != null){
		for(int i=0;i<macroNames.length;i++){
			String tmp = request.getParameter(macroNames[i]);
			if(tmp != null){
				//tmp=new String(tmp.getBytes("iso-8859-1"));
				param.append(macroNames[i]).append("=").append(tmp).append(";");
			}
		}
	}
	
	String saveAsName = saveName;

	String scale = request.getParameter("scale");
	String scroll = "no";
	if(scale == null || scale.trim().length() == 0) scale = "1.0";
	String paged = request.getParameter("paged");
	if(paged == null || paged.trim().length() == 0) paged = "1";

	String width = "0", height = "0";
	if(paged.equals("0")){
		width = "-1";
		height = "-1";
	}
	String tmp = null;
	try{
		tmp = ExtCellSet.get().getStringLicense();
	}
	catch(Exception e){}
	request.setAttribute("tmpbean",rd);
	String submitImage = "<img src='/epstar/web/apps/images/savedata.gif' border=no style='vertical-align:middle'>";
%>


<table id="titleTable" width=100% cellspacing=0 cellpadding=0 border=0 >
	<tr>
		<td height="22" width=100% valign="middle"  style="font-size:13px" >
			<table width="100%">
				<tr>
				<td>
					<div id='tbar'></div>
				</td>
				</tr> 
		  </table>
		</td>
	</tr> 
</table>
<script type='text/javascript' src="<%=contextPath%>/servlet/com.runqian.base.util.ReadJavaScriptServlet?file=%2Fcom%2Frunqian%2Freport%2Fview%2Fhtml%2Fscroll.js"></script>

<div id="div1" style="overflow:auto;vertical-align:top;" onscroll="_reportScroll('report1')">
	<table align="center" border="0" width="700" height="505">
		<tr>
			<td width="100" align="center" >
				<div onclick="left_toPage()">
					<img src="<%=contextPath%>/images/222.GIF" title="点击预览上一页" width="40" style="cursor: hand;"/>
				</div>
			</td>
			<td align="center">
				<table id="rpt" align="center" border="1" bordercolor="black" cellspacing="0"  height="600"  width="500">
					<tr>
						<td style="padding:10px;vertical-align:top" >
						<%
							if(form != null && form.trim().length() > 0){
								//当参数模板不在根目录下,需要补齐相对路径
								if(reportPath.lastIndexOf("/") > 17){
									     form = reportPath.substring(17,reportPath.lastIndexOf("/")) + "/" + form;
								}
						%>
							<table id="param_tbl">
								<tr>
									<td>
										<report:param name="form1" paramFileName="<%=form %>" needSubmit="no" params="<%=param.toString()%>" />
									</td>
									<td>
										<a href="javascript:_submit(form1)">
											<img src="<%=contextPath%>/run/images/query.jpg" border=no style="vertical-align:middle">
										</a>
									</td>
								</tr>
							</table>
						<%	
							}
						%>
							<report:html name="report1" srcType="definebean" beanName="tmpbean" 
								width="-1"
								funcBarLocation=""
								params="<%=param.toString()%>"
								saveAsName="<%=saveAsName%>"
								needPageMark="yes"
								generateParamForm="no"
								scale="<%=scale%>"
								submit="<%=submitImage%>"
								selectText="yes"
								needScroll="<%=scroll%>"
								needDirectPrint="yes"
							/>
						</td>
					</tr>
				</table>
			</td>
			
			<td width="100" align="center">
				<div onclick="right_toPage()">
					<img src="<%=contextPath%>/images/111.GIF" title="点击预览下一页" width="40" style="cursor:hand;"/>
				</div>
			</td>
		</tr>
	</table>
</div>


<div id="div2" style="width:100%;height:100%">

</div> 
<table id="titleTable" width=100% cellspacing=0 cellpadding=0 border=0 style="padding:0px 0px 0px 0px;">
	<tr>
		<td height="22" width=100% valign="middle" style="font-size:12px" >
			<table width="100%">
				<tr>
					<td>
						<div id='tbar'></div>
					</td>
				</tr> 
		  </table>
		</td>
	</tr> 
</table>

<script type='text/javascript'>
	try{
		var obj = parent.frames[1];
		obj.document.body.style.overflow = "hidden";
	}
	catch(e)
	{
	}
	
	//window.onresize = myResize;
	var div1 = document.getElementById("div1");

	function myResize() {
		var scrolldiv = document.getElementById("report1_scrollArea");
		if( scrolldiv == null ) div1.id = "report1_contentdiv";
		if( document.all ) {
			div2.style.display = "";
			div1.style.height = document.body.offsetHeight -40;
			div1.style.width = div2.offsetWidth;
			div2.style.display = "none";
		}
		else {
			var div22 = document.getElementById("div2");
			div22.style.display = "";
			div1.style.height = div22.offsetHeight - document.getElementById("titleTable").offsetHeight;
			div1.style.width = div22.offsetWidth;
			div22.style.display = "none";
		}
		if( scrolldiv != null ) {
			div1.style.overflow = "hidden";
			scrolldiv.style.width = div1.clientWidth - 15;
			var h = div1.clientHeight - 2;
			h -= getHeightX( document.body );
			var paramTable = document.getElementById("param_tbl");
			if( paramTable != null ) h -= paramTable.offsetHeight;
			scrolldiv.style.height = h;
			_resizeScroll();
		}
	}
	myResize();
	
	
function left_toPage(){
	try{report1_toPage(report1_getCurrPage()-1);}catch(e){}return false;
}
function right_toPage(){
	try{report1_toPage(report1_getCurrPage()+1);}catch(e){}return false;
}

Ext.onReady(function(){
	var bbar = new Ext.Toolbar({
       	style: {'text-align':'right','padding-right':20},
       	el:tbar,
       	width: document.body.clientWidth-10,
       	height:30,
        items: [{
				text:'共<span id="t_page_span"></span>页/第<span id="c_page_span"></span>页' 
			},'->',{
				text:'打印',
				iconCls:'print',
				id:'btnSave',
				handler: function(){
					report1_print();return false;
				}
			},
			 
			 '-'  	,{
				text:'导出WORD',
				id:'btnSave',
				iconCls:'word',
				handler: function(){
					report1_saveAsWord();return false;
				}
			}, '-'  	,{
				text:'导出EXCEL',
				id:'btnSave',
				iconCls:'excel',
				handler: function(){
					report1_saveAsExcel();return false;
				}
			}, '-'  	,{
				text:'导出PDF',
				id:'btnSave',
				iconCls:'pdf',
				handler: function(){
					report1_saveAsPdf();return false;
				}
			}, 
			 '-'  	,{
				text:'第一页',
				id:'btnSave',
				iconCls:'firstpage',
				handler: function(){
					try{report1_toPage(1);}catch(e){}return false;
				}
			}, '-'  	,{
				text:'上一页',
				id:'btnSave',
				iconCls:'prevpage',
				handler: function(){
					try{report1_toPage(report1_getCurrPage()-1);}catch(e){}return false;
				}
			}, '-'  	,{
				text:'下一页',
				id:'btnSave',
				iconCls:'nextpage',
				handler: function(){
					try{report1_toPage(report1_getCurrPage()+1);}catch(e){}return false;
				}
			}, '-'  	,{
				text:'最后一页',
				id:'btnSave',
				iconCls:'lastpage',
				handler: function(){
					try{report1_toPage(report1_getTotalPage());}catch(e){}return false;
				}
			} 
        ]
	}); 
	bbar.render('tbar');
	document.getElementById("t_page_span").innerHTML = report1_getTotalPage();
	document.getElementById("c_page_span").innerHTML = report1_getCurrPage();
	document.getElementById("report1").style.width = document.getElementById("report1").style.posWidth + 25;
});
</script>
</body>
</html>


