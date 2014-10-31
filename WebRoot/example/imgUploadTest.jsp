<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://www.eazytec.com/taglibs/filetag" prefix="file"%>
<%@page import="com.eazytec.common.util.security.Base64"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单图片上传测试</title>
<script type="text/javascript">
	window.onload = function(){
		var t2 = document.getElementById("temptxt2");
		t2.value ="11.jpg|<%=Base64.getBase64FromString("f:/11.jpg")%>";
		document.getElementById("aad2").src=document.getElementById("aad2").src;
		
		var t2 = document.getElementById("textName2");
		t2.value ="png-0114.png|ZDovMTIzL2ltYWdlL0JPRVIvYWRtaW4vcG5nLTAxMTRfMjAwOTEyMTUxNTA3MzczOTAucG5n";
		document.getElementById("tag2").src=document.getElementById("tag2").src;
	}
	function showvalue(){
		alert(document.getElementById("textName").value);
	}
</script>
</head>
<body>
单图片上传调用,返回文本框<input type="text" name="temptxt" id="temptxt" size="150">
<br/>
<iframe width="120" frameborder="0" style="border: 1px solid #dddddd;" src="<%=request.getContextPath() %>/erp/imageupload.jsp?he=150&AcceptText=temptxt" height="150" scrolling="no" marginheight="2" allowTransparency="true" ></iframe>
<br/>
<br/>
编辑,返回文本框<input type="text" name="temptxt2" id="temptxt2" size="150"><br/>
<br/>
<br/>
<iframe width="420" frameborder="0" style="border: 1px solid #dddddd;" src="<%=request.getContextPath() %>/erp/imageupload.jsp?he=300&AcceptText=temptxt2&edit=true" height="300" scrolling="no" marginheight="2" allowTransparency="true" id="aad2"></iframe>
<br/>
<br/>
标签式调用(新增)<br/>
<file:imgupload width="200" acceptTextId="textName" height="150" style="border:1px solid #333333;" ></file:imgupload><br/>
<input type="button" onclick="showvalue();" value="取值">
标签式调用(修改)<br/>
<file:imgupload width="200" acceptTextId="textName2" height="200" id="tag2" edit="true"></file:imgupload><br/>

<textarea style="width: 100%;height: 300px;">
defaultImg 默认显示的图像,不指定将显示系统noImg图像(编辑时不能指定)

he 当前iframe高度，必须填写

AcceptText 接收返回结果的文本框Id，必须填写(结果经过base64加密，可直接写入数据库)

edit 编辑时使用 默认为false 【true】编辑时在接收文本框放入文件

调用方法
<iframe width="100" frameborder="0" style="border: 1px solid #dddddd;" src="<%=request.getContextPath() %>/erp/imageupload.jsp?he=100&AcceptText=temptxt" height="100" scrolling="no" marginheight="2" allowTransparency="true" ></iframe>
</textarea>

</body>
</html>