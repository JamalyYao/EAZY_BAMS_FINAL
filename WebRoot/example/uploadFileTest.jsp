<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.eazytec.common.util.security.Base64"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eazytec.common.util.LoginContext"%>
<%@page import="com.eazytec.common.util.ConstWords"%>
<%@page import="com.eazytec.common.util.file.FileTool"%>

<%@ taglib uri="http://www.eazytec.com/taglibs/filetag" prefix="file"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
window.onload=function(){
	var t2 = document.getElementById("temptxt2");
	t2.value ="11.jpg|<%=Base64.getBase64FromString("f:/11.jpg")%>";
	window.setTimeout("document.getElementById('aad2').src = document.getElementById('aad2').src",0);
	
	var t2 = document.getElementById("tagtxt2");
	t2.value ="系统数据字典--人力资源 .doc|ZDovMTIzL2ZpbGUvQk9FUi9hZG1pbi/Ptc2zyv2@13dfWteQtLcjLwabXytS0XzIwMDkxMjE2MTQyNDUxNjQwLmRvYw@3@3";
	window.setTimeout("document.getElementById('tagfile').src = document.getElementById('tagfile').src",0);
}
function showvalue(){
	alert(document.getElementById("tagtxt1").value);
}
</script>
<%
String eidt ="true";
 %>
</head>
<body>
文件上传调用,返回文本框<input type="text" name="temptxt" id="temptxt" size="150">

<iframe width="100%" frameborder="0" style="border: 1px solid #dddddd;" src="<%=request.getContextPath() %>/erp/fileupload.jsp?type=image&he=150&AcceptText=temptxt" height="150" scrolling="no" marginheight="4" allowTransparency="true" id="aad"></iframe>
<br/>
<br/>
编辑调用,返回文本框<input type="text" name="temptxt2" id="temptxt2" size="150">
 <iframe width="100%" frameborder="0" style="border: 1px solid #dddddd;" src="<%=request.getContextPath() %>/erp/fileupload.jsp?type=image&he=150&AcceptText=temptxt2&edit=true" height="150" scrolling="no" marginheight="4" allowTransparency="true" id="aad2"></iframe>
<br/>
<br/>
标签调用（新增）
<file:multifileupload width="100%" acceptTextId="tagtxt1" height="100" type="office" saveType="file"></file:multifileupload>
<input type="button" onclick="showvalue();" value="得值">
<br/>
<br/>
标签调用（编辑）
<file:multifileupload width="100%" acceptTextId="tagtxt2" height="100" edit="<%=eidt %>" id="tagfile"></file:multifileupload>
<br/>
<textarea style="width: 100%;height: 300px;">
适用范围:新增和编辑多文件上传

fileCount 可上传文件个数 默认为0 ，不限制
fileSize 上传文件大小，默认为2M(从配置文件读取)
type 上传文件类型 不选择可上传全部（选择后ext参数不可用）
【
	可选类型：
	image  文件类型：jpg|gif|jpeg|png|bmp
	txt    文件类型：txt|rtf
	office 文件类型：doc|docx|xls|xlsx|ppt|pptx|pdf|xml|rtf
	other  文件类型： 7z|aiff|asf|avi|bmp|csv|doc|fla|flv|gif|gz|
					gzip|jpeg|jpg|mid|mov|mp3|mp4|mpc|mpeg|mpg|ods|odt|
					pdf|png|ppt|pxd|qt|ram|rar|rm|rmi|rmvb|rtf|sdc|sitd|
					swf|sxc|sxw|tar|tgz|tif|tiff|txt|vsd|wav|wma|wmv|xls|xml|zip
】
ext 限制上传文件扩展名
【
	已'|'分隔
	例：avi|gif|aaa
】
he 当前iframe高度，必须填写

AcceptText 接收返回结果的文本框Id，必须填写(结果经过base64加密，可直接写入数据库，多个结果以','分隔)

saveType 文件存储类型 默认为image
【
	image 图片类型，系统将存放在配置文件定义的image目录
	file 文件类型，系统将存在在配置文件定义的file目录
	customer 自定义存放位置
】
saveDir 配置 saveType=customer使用，请进行base64加密 例如:d:/11111/ 系统对所有目录都会添加公司编码及用户名

edit 是否为编辑 参数true 默认为false(即添加)，如果编辑为true,编辑时请将接收文本框中赋值

调用方法
<iframe width="100%" frameborder="0" style="border: 1px solid #dddddd;" src="<%=request.getContextPath() %>/erp/fileupload.jsp?type=image&he=150&AcceptText=temptxt" height="150" scrolling="no" marginheight="4" allowTransparency="true" ></iframe>
</textarea>
</body>
</html>