<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>多窗口切换</title>
<script type="text/javascript">
	var tmparray = new Array();
	
	function defaultload(){
		winopen('Eazytec','卓易科技','http://www.eazytec.com');
	}
	
	window.onload = function(){
		defaultload();
	}
	
	
	
	function winopen(code,name,url){
		var bl = true;
		for(var i=0;i<tmparray.length;i++){
			
			if(tmparray[i] == code){
				bl = false;
				document.getElementById(code+"_LEFTTAB").style.backgroundPosition = "top";
				document.getElementById(code+"_CENTERTAB1").style.backgroundPosition = "top";
				document.getElementById(code+"_CENTERTAB2").style.backgroundPosition = "top";
				document.getElementById(code+"_RIGHTTAB").style.backgroundPosition = "top";
				document.getElementById(code+"_NAMECOL").style.color = "#022333";
				document.getElementById(code+"_FRM").style.display = "";
				
			}else{
				document.getElementById(tmparray[i]+"_LEFTTAB").style.backgroundPosition = "bottom";
				document.getElementById(tmparray[i]+"_CENTERTAB1").style.backgroundPosition = "bottom";
				document.getElementById(tmparray[i]+"_CENTERTAB2").style.backgroundPosition = "bottom";
				document.getElementById(tmparray[i]+"_RIGHTTAB").style.backgroundPosition = "bottom";
				document.getElementById(tmparray[i]+"_NAMECOL").style.color = "#166ba9";
				document.getElementById(tmparray[i]+"_FRM").style.display = "none";
				//document.getElementById(tmparray[i]+"_labc").style.display = "none";
			}
		}
		if(bl){
			tmparray.push(code);
			
			//重新设置宽度
			var tdvwd = parseFloat(100/(tmparray.length+0.1)).toFixed(1);
			if(tdvwd>=12){
				tdvwd =12;
			}else{
				if(tdvwd<=0){
					tdvwd = 1;
				}
				for(var i=0;i<tmparray.length;i++){
					if(tmparray[i] != code){
						document.getElementById(tmparray[i]+"_TABDIV").style.width=tdvwd+"%";
					}
				}
			}
			
			
			var ishidden="display:none";
			if(tmparray.length>1){
				ishidden ="";
			}
			
			var tdv = document.createElement("div");
			tdv.id = code+"_TABDIV";
			
			var tmpstr="<table width='99%' height='100%' cellpadding='0' cellspacing='0' border='0' style='line-height:23px'>";
			tmpstr += "<tr><td nowrap='nowrap' width='4px' style=\"width:4px;BACKGROUND:url('<%=contextPath%>/images/morewinleft.png')  no-repeat top \" id='"+code+"_LEFTTAB'>&nbsp;</td>";
			tmpstr +="<td nowrap='nowrap' align='center' width='20px' id='"+code+"_CENTERTAB1' style=\"BACKGROUND:url('<%=contextPath%>/images/morewincenter.png') repeat-x top;\"><img src='<%=contextPath %>/images/loading2.gif' id='"+code+"loadimg' width='16' height='16' style='vertical-align: middle;padding-left:3px;padding-right:3px;'></td>";
			tmpstr += "<td nowrap='nowrap' align='left' width='100%' id='"+code+"_CENTERTAB2' style=\"BACKGROUND:url('<%=contextPath%>/images/morewincenter.png') repeat-x top;\"><div style='overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:80%;color:#022333' id='"+code+"_NAMECOL' title='"+name+"'>"+name+"</div><div style='position:absolute;top:0px;right:3px;z-index:500;float:right;width:13px;height:13px;"+ishidden+"' id='"+code+"_labc'><label onclick=\"closem('"+code+"')\" style='vertical-align: middle;color:#074e82;font-size:13px;font-weight: bold;' onmouseover=\"this.style.color='red'\"  onmouseout=\"this.style.color='#074e82'\"  title='关闭'>×</label></div></td>"
			tmpstr += "<td nowrap='nowrap' width='4px' style=\"width:4px;BACKGROUND:url('<%=contextPath%>/images/morewinright.png') no-repeat top\" id='"+code+"_RIGHTTAB'>&nbsp;</td>";
			tmpstr += "</tr></table>";
			tdv.innerHTML = tmpstr;
			tdv.onclick = function(){
				winopen(code,name);
			}

			tdv.style.cssText="cursor: pointer;overflow:hidden;white-space:nowrap;;width:"+tdvwd+"%;height:23px;float:left;";
			document.getElementById("tabdivtd").appendChild(tdv);
			
			var frm = document.createElement("iframe");
			frm.id = code+"_FRM";
			frm.frameBorder = "0";
			frm.height = "100%";
			frm.width = "100%";
			frm.marginheight = "0";
			frm.border = "0";
			frm.allowTransparency="true";
			frm.onreadystatechange = function(){
				showloading2(code,this);
			}
			frm.scrolling = "auto";
			frm.src = url;
			frm.style.cssText ="border:0px;padding:1px";
			document.getElementById("frmtd").appendChild(frm);
			
		}
	}
	
	function closem(code){
		var index=0;
		var tcode = null;
		for(var i=0;i<tmparray.length;i++){
			if(tmparray[i] == code){
				index = i;
			}
		}
		if(index == tmparray.length-1){
			tcode = tmparray[index-1];
		}else{
			tcode = tmparray[index+1];
		}
		
		tmparray.splice(index,1);
		document.getElementById("tabdivtd").removeChild(document.getElementById(code+"_TABDIV"));
		document.getElementById("frmtd").removeChild(document.getElementById(code+"_FRM"));
		winopen(tcode);
		var tdvwd = parseFloat(100/(tmparray.length+0.1)).toFixed(1);
		if(tdvwd>=15){
			return;
		}else{
			if(tdvwd<=0){
				tdvwd = 1;
			}
			for(var i=0;i<tmparray.length;i++){
				document.getElementById(tmparray[i]+"_TABDIV").style.width=tdvwd+"%";
			}
		}
	}
	function showloading2(code,obj){
		var pnode = document.getElementById(code+"loadimg");
		if(pnode!=null && pnode.tagName =="IMG"){
			if(obj.readyState =="complete"){
				pnode.src ="<%=contextPath%>/images/projectimg/tab_go.png";
			}
		}
	}
	function closeall(){
		tmparray.length=0
		document.getElementById("tabdivtd").innerHTML ="";
		document.getElementById("frmtd").innerHTML ="";
		defaultload();
	}
</script>
</head>
<body style="overflow: hidden;">
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr >
<td valign="top" align="center">
<input type="button" value="网易" onclick="winopen('163','网易','http://www.163.com')" style="width: 100px;">
<input type="button" value="搜狐" onclick="winopen('sohu','搜狐','http://www.sohu.com')" style="width: 100px">
<input type="button" value="卓易科技" onclick="winopen('eazytec','卓易科技','http://www.eazytec.com')" style="width: 100px">
<input type="button" value="百度" onclick="winopen('baidu','百度','http://www.baidu.com')" style="width: 100px">
<input type="button" value="126" onclick="winopen('126','126','http://www.126.com')" style="width: 100px">
<input type="button" value="hao123" onclick="winopen('hao123','hao123','http://www.hao123.com')" style="width: 100px">
<input type="button" value="google" onclick="winopen('google','谷歌','http://www.google.com.cn')" style="width: 100px">
<input type="button" value="腾讯" onclick="winopen('qq','腾讯','http://www.qq.com')" style="width: 100px">
<input type="button" value="淘宝网" onclick="winopen('taobao','淘宝','http://www.taobao.com')" style="width: 100px">
<input type="button" value="当当" onclick="winopen('dangdang','当当','http://www.dangdang.com')" style="width: 100px">
<input type="button" value="cctv" onclick="winopen('cctv','央视网','http://www.cctv.com')" style="width: 100px">
<input type="button" value="新浪" onclick="winopen('sina','新浪网','http://www.sina.com')" style="width: 100px">
<input type="button" value="工商银行" onclick="winopen('icbc','工商银行','http://www.icbc.com.cn')" style="width: 100px">
<input type="button" value="优酷网" onclick="winopen('youku','优酷网','http://www.youku.com')" style="width: 100px">
<input type="button" value="新华网" onclick="winopen('xinhua','新华网','http://www.xinhuanet.com')" style="width: 100px">
<input type="button" value="凤凰网" onclick="winopen('ifeng','凤凰网','http://www.ifeng.com')" style="width: 100px">
</td>
</tr>
<tr height="100%">
<td valign="top" align="center">
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr height="23px">
<td width="5px"></td>
<td nowrap="nowrap" id="tabdivtd" align="left">
</td>
<td nowrap="nowrap" align="right" width="20px">
<img src="<%=contextPath %>/images/morewinclose.png" border="0" style="cursor: pointer;" onclick="closeall()" title="关闭所有" alt="关闭所有">
</td>
</tr>
<tr height="100%">
<td nowrap="nowrap" align="center" id="frmtd" valign="top" colspan="3" style="border-top:#43b0ff 2px solid;">
</td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>