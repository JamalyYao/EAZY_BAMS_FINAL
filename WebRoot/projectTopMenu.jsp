<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="erp/common.jsp" %>
<body style="background-color:transparent;cursor: default;">
<%
String mid =request.getParameter("mid");
String tmp = UtilTool.getProjectPath(request);
%>
<form action="<%=contextPath %>/checkSession.do" name="projectfrm">
<input type="hidden" id="cumid" name="cumid" value="<%=mid %>">
<input type="hidden" id="mid" name="mid">
<table cellspacing="0" cellpadding="0" align="right" border="0" height="28px;">
<tr valign="middle">
<td nowrap="nowrap" valign="middle" align="center" width="35">
<img src="images/person.png"  class="repimg" title="查看个人信息" onclick="goto('viewemployee');" alt="查看个人信息" onmouseover="repimgover(this)" onmouseout="repimgout(this)"/>
</td>
<td nowrap="enum" valign="middle"   align="center"  width="35">
<img  src="images/editname.png" class="repimg" style="margin:0;padding:0;" title="修改登录名" onclick="goto('editname');" alt="修改登录名" onmouseover="repimgover(this)" onmouseout="repimgout(this)"/>
</td>
<td nowrap="nowrap" valign="middle"   align="center"  width="35">
<img  src="images/editpwd.png" class="repimg" title="修改密码" onclick="goto('editpass');" alt="修改密码" onmouseover="repimgover(this)" onmouseout="repimgout(this)"/>
</td>
<td nowrap="nowrap" valign="middle" align="center"  width="35">
<img  src="images/help.png" class="repimg" title="系统帮助" onclick="goto('help');" alt="系统帮助" onmouseover="repimgover(this)" onmouseout="repimgout(this)"/>
</td>
<td nowrap="nowrap" valign="middle"  align="center"  width="35">
<img  src="images/quit.png" class="repimg" title="退出系统" onclick="goto('exit');" alt="退出系统" onmouseover="repimgover(this)" onmouseout="repimgout(this)"/>
</td>
</tr>
</table>
</form>
<script type="text/javascript">
	function goto(a){
		if(a =='exit'){
			var exitVal = window.confirm("确定退出BAMS吗？");
			if(exitVal == true){
				document.getElementById("mid").value = 'exit';
				document.projectfrm.submit();
			}else{
				return;
			}
		}else{
			if(a=="editpass"){
				var box = new Sys.msgbox('修改登录密码','<%=contextPath %>/erp/editUserPwdMsg.jsp','700','450');
				box.msgtitle="<b>修改密码</b><br/>修改登录密码后再次登录将生效!";
				var butarray = new Array();
				butarray[0] = "ok|updatepassword();";
				butarray[1] = "cancel";
				box.buttons = butarray;
				box.show();
			}else if(a =="editname"){
				var box = new Sys.msgbox('修改登录用户名','<%=contextPath %>/erp/editUserNameMsg.jsp','700','400');
				box.msgtitle="<b>修改用户名</b><br/>修改登录用户名后再次登录将生效!";
				var butarray = new Array();
				butarray[0] = "ok|updateName();";
				butarray[1] = "cancel";
				box.buttons = butarray;
				box.show();
			}else if(a =="viewemployee"){
				var box = new Sys.msgbox('个人信息','<%=contextPath %>/erp/employee_info.jsp','900','600');
				box.msgtitle="个人信息";
				box.show();
			}else{
				window.open('<%=contextPath %>/help/help_index.jsp');
			}
		}
	}
	
	
	function updatepasswordback(data){
		if(data.success){
			confirmmsg("密码修改成功，点击确定重新登录!","repload()");
		}
	}
	
	function updatenamedback(data){
		if(data.success){
			confirmmsg("用户名修改成功，点击确定重新登录!","repload()");
		}
	}
	
	function repload(){
		//window.parent.location.href="<%=UtilTool.getProjectPath(request)%>";
		window.parent.location.href="<%=contextPath %>/login.jsp";
	}
	
	var isexitbl = false;
	
	window.onbeforeunload =function(){
		
	    if(event.clientX>document.body.clientWidth && event.clientY < 0 || event.altKey){
	    	isexitbl = true;
			window.event.returnValue="确定退出BAMS吗？";
		}else{
			isexitbl = false;
		}
	}
	
	window.onunload = function(){
		if(isexitbl){
			document.getElementById("mid").value = 'exit';
			document.projectfrm.submit();
		}
	}
	function repimgover(obj){
		var path=obj.src;
		var len=path.length;
		var strname=path.substr(0,len-4);
		var strexp=path.substr(len-4,len);
		obj.src = strname+"_"+strexp;
	}
	function repimgout(obj){
		var path=obj.src;
		var len=path.length;
		var strname=path.substr(0,len-5);
		var strexp=path.substr(len-4,len);
		obj.src = strname+strexp;
	}
</script>
</body>