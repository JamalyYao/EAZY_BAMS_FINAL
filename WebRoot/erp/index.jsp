<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%

		response.setHeader("Cache-Control","no-cache"); 
		response.setHeader("Pragma","no-cache"); 
		response.setDateHeader("Expires",0);

		SessionUser sessionUser = (SessionUser)LoginContext.getSessionValueByLogin(request);
		String url =  request.getParameter("url");//打开页面，常用于IM打开链接，定位页面
		String mid = request.getParameter("mid");	//跳转项目代码
		if(mid == null){
			mid = ConstWords.getProjectCode();
		}
		
		int height = ConstWords.getProjectChangeHeight(sessionUser.getUserModuleMethods().size());	//功能切换栏高度
		
		SysConfig indexconfing = sessionUser.getSysconfig();
		SysMethodInfo method = UtilTool.getSysMethodInfoByPk(this.getServletContext(),ConstWords.getProjectCode());
		String ietitle="";
		if(indexconfing==null || method == null){
			out.print("不能加载配置系统信息..");
			return;
		}else{
			ietitle = indexconfing.getProjectName();
		}
		
		SysCompanyInfo companyinfo = sessionUser.getCompanyInfo();
		if(companyinfo!=null){
			if(companyinfo.getCompanyInfoTitle()!=null&&companyinfo.getCompanyInfoTitle().trim().length()>0){
				ietitle = companyinfo.getCompanyInfoTitle();
			}
		}
		
		//跑马灯
		WebApplicationContext webcontext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
		DwrOADesktopService dekService = (DwrOADesktopService)webcontext.getBean("dwrOADesktopService");
		String min = SystemConfig.getParam("erp.desktop.showMinRow");
		int row = Integer.parseInt(min);
		List<OaNotice> listNotice = dekService.getOaNoticeListByEmpId(this.getServletContext(),request,row);
		List<OaAnnouncement> listAnnouncement = dekService.getOaAnnouncementBydesk(this.getServletContext(),request,row);
				 %>
				 
		<title><%=ietitle %></title>
		<link rel='stylesheet' type='text/css' href='<%=contextPath%>/erp/tabs/tabs.css' />
		<script type="text/javascript" src="<%=contextPath%>/erp/tabs/tabs.js"></script>
		<script type="text/javascript">
		window.onload = function(){
			//登陆提示信息
			var msg = "<%=request.getAttribute(ConstWords.TempStringMsg)%>";
			if(msg != "null" && msg.length > 0){
				alert(msg);
			}
			
			document.getElementById("methodleftfrm").src="<%=request.getContextPath() %>/erp/index_left.jsp?mid=<%=mid%>";
			document.getElementById("projectchangefrm").src="<%=request.getContextPath() %>/projectChange.jsp?mid=<%=mid%>&uid=<%=sessionUser.getUserInfo().getPrimaryKey() %>";
		}
	
		</script>
	</head>

	<body style="overflow:hidden;">
		<div style="height:12%;background: url('<%=request.getContextPath()%>/images/top-5.png') repeat-x;">
			<%@ include file="index_top.jsp"%>
		</div>
		<div id="splitterContainer" style="height:83%;">
			<div id="leftPane">
				<div id="leftSplitterContainer">
					<div class="div_title_img">功能菜单</div>
					<div id="leftTopPane">
						<iframe frameborder="0" allowTransparency="true" id="methodleftfrm" width="100%" height="100%" scrolling="no" marginheight="0"></iframe>
					</div>
					<div class="div_title_img">模块切换</div>
					<div id="leftBottomPane">
						<iframe frameborder="0" allowTransparency="true" id="projectchangefrm" width="100%" height="100%" scrolling="auto" marginheight="0"></iframe>
					</div>
				</div>
			
			</div>
			
			<div id="rightPane">
					<div style="height:5%;overflow:hidden;">
			            <TABLE style="WIDTH: 100%; TABLE-LAYOUT: fixed;" cellSpacing="0" summary="功能条" cellPadding="0" class="right_line">
			              <TBODY>
			              <TR>
			                <TD style="WIDTH: 1px"></TD>
			                <TD id=tab_left class=pre><A class=hidden title=向前 
			                  onclick=onLefttab(); href="javascript:void(0);">向前</A></TD>
			                <TD><IFRAME frameSpacing=0 marginHeight=0 
			                  src="<%=request.getContextPath() %>/erp/tabs/systabs.html" frameBorder="0" width="100%" height="27"
			                  allowTransparency name=tabs marginWidth=0 
			                  scrolling=no></IFRAME></TD>
			                <TD id=tab_right class=next><A class=hidden title=向后 
			                  onclick=onRighttab(); href="javascript:void(0);">向后</A></TD>
			                <TD id=search style="width: 220px;">
			                	<span id="systime" style="font-weight: normal;color:#04487D;vertical-align: bottom;"></span>
			                 </TD>
			              </TR>
				          </TBODY>
				        </TABLE>
			        </div>
			        <div style="height:95%;">
			        <IFRAME height="100%" width="100%" 
			            marginHeight=0 frameBorder=0 
			            name="mainframe" id="mainframe" marginWidth=0 scrolling=no></IFRAME>
					</div>
			</div>
		</div>
		
	<div class="div_title" style="height:5%;">
		<table cellpadding="0" width="100%" cellspacing="0" border="0" height="100%">
			<tr>
				<td style="padding-left: 10px;"nowrap="nowrap">
					<font color="#ffffff" style="font-size: 12px;font-family: sans-serif;"">
					(c)2008-2014 Eazytec BAMS Version 1.0
					</font>
				</td>
				<td nowrap="nowrap" style="padding-left: 15px;padding-right: 15px;" valign="middle">
				
				</td>
				<td align="right" style="padding-right: 5px;" nowrap="nowrap" width="140" valign="middle">
					<%@include file="index_bottom.jsp"%> 
				</td>
			</tr>
		</table>					
	</div>

	</body>
<script type="text/javascript">

  function showtime () {
	  var tm = getServerDate();
	  var year = tm[0];
	  var month = tm[1];
	  var date = tm[2];
	  var hours = tm[3];
	  var minutes =tm[4];
	  var seconds =tm[5];
	  var day = tm[6];
	  var tp = tm[7];
	  var timeValue = "";
	  timeValue += year + "年";
	  timeValue += month + "月";
	  timeValue += date + "日  ";
	  timeValue += day + "  ";
	  //timeValue += tp+" ";

	  timeValue += hours;
	  timeValue +=  ":" + minutes;
	  timeValue += ":" + seconds;
	  document.getElementById("systime").innerHTML = timeValue;
	  timerID = setTimeout("showtime()",1000);
	  timerRunning = true;
  }
  
	//注册事件
	if (document.all) {
		window.attachEvent("onload", showtime);
	} else {
		window.addEventListener("load", showtime, false);
	}

	setTimeout("MDIOpen(\"<%=request.getContextPath() %>/erp/center.jsp\");", 1000);
	
	//setTimeout("MDIOpen(\"<%=request.getContextPath() %>/erp/system_set/component_manage.jsp\");", 1000);
	
	//打开页面
	var openUrl = "<%= url%>";
	if(openUrl != "null" && openUrl != ""){
		setTimeout("MDIOpen(\"<%=request.getContextPath() %>/erp/\"+openUrl);", 1000);
	}
	
</script>

<%@include file="desktop/serverTimer.jsp"%>
</html>
