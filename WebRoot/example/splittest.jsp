<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
<%
SessionUser sessionUser = (SessionUser)LoginContext.getSessionValueByLogin(request);
 %>
 <script type="text/javascript">
	var interval;
	function show2(){
		var tr1h=document.getElementById("tr1").clientHeight;
		interval = setInterval(move, 10);
		
		//document.getElementById("tr2").style.display ="";
	}
	function show1(){
		document.getElementById("tr2").style.display ="none";
		document.getElementById("tr1").style.display ="";
	}
	function move() {
		var t1 = document.getElementById("tr1");
		alert(t1.style.height);
		if(t1.style.height>10){
        	t1.style.height = t1.clientHeight-10;
        }else{
        	clearInterval(interval);
        	t1.style.height ="0px";
        }
    }
 </script>
	</head>
	<body>
		<DIV id=splitpanel1 style="WIDTH: 100%; HEIGHT: 100%">

			<TABLE>


				<TR>

					<TD style="HEIGHT: 100%">
						
						<DIV id=splitpanel2 style="WIDTH: 100%; HEIGHT: 100%">
							<TABLE>
								<TR>
									<TD style="HEIGHT: 100%">
										<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
										<tr>
										<td valign="top" height="22" colspan="2"><div class="div_title_img" onclick="show1()">功能菜单</div></td>
										</tr>
										<tr id="tr1">
										<td width="8px"></td>
										<td valign="top" style="padding: 1px;">
										<iframe  frameborder="0" src="<%=request.getContextPath() %>/erp/index_left.jsp" height="100%" scrolling="no" marginheight="0" allowTransparency="true" width="100%"></iframe>
										</td>
										</tr>
										<tr>
										<td valign="top" height="22" colspan="2"><div class="div_title_img" onclick="show2()">功能菜单2</div></td>
										</tr>
										<tr style="display: none;" id="tr2">
										<td width="8px"></td>
										<td valign="top" style="padding: 1px;">
										<iframe  frameborder="0" src="<%=request.getContextPath() %>/erp/index_left.jsp" height="100%" scrolling="no" marginheight="0" allowTransparency="true" width="100%"></iframe>
										</td>
										</tr>
										</table>
									</TD>
								</TR>

								<TR>
									<TD></TD>
								</TR>

								<TR>
									<TD style="HEIGHT: 100%">
										<iframe  frameborder="0" src="<%=request.getContextPath() %>/projectChange.jsp?mid=<%=ConstWords.getProjectCode() %>&uid=<%=sessionUser.getUserInfo().getPrimaryKey() %>" height="100%" scrolling="no" marginheight="4" allowTransparency="true" width="100%"></iframe>
									</TD>
								</TR>
							</TABLE>
						</DIV>

					</TD>


					<TD></TD>


					<TD style="HEIGHT: 100%">
						
						<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
							<td width="50%">固定纵向分隔left</td>
							<td class="Splitter_h"></td>
							<td>
							<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
							<td>固定横向分隔top</td>
							</tr>
							<tr class="Splitter_v">
							<td></td>
							</tr>
							<tr>
							<td>固定横向分隔bottom</td>
							</tr>
							</table>
							
							</td>
							</tr>
						</table>
					</TD>
				</TR>
			</TABLE>
		</DIV>
		<script type="text/javascript">
			//横向分隔
			var t1=createhr("splitpanel2", "vertical");
			t1.setPadding(0);
			t1.setPosition("88%");
			
			//纵向分隔
			var t2=createhr("splitpanel1", "horizontal");
			t2.setPadding(0);
			t2.setPosition("150");
		</script>
	</body>
</html>