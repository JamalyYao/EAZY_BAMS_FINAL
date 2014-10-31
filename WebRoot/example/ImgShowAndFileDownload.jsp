<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.eazytec.common.util.security.Base64"%>
<%@ taglib uri="http://www.eazytec.com/taglibs/filetag" prefix="file" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试图片显示及下载</title>
<script type="text/javascript">
//js动态设置
function showimgid(){
	var a=document.getElementById("asb");
	a.src+="&imgId=1";
	alert(a.src);
}

function setdownload(){
	var dw = document.getElementById("dw");
	alert(dw.href);
	dw.href+="&fileId=1";
	dw.innerHTML ="文件名";
	alert(dw.href);
	
}
</script>
</head>
<body>
 显示图片
<img src="<%=request.getContextPath() %>/showimg.do?imgId=1&imgCode=_Max&noImgPath=<%=Base64.getBase64FromString("d:/123.jpg") %>" border="0"><br/>
标签调用：<br/>
<file:imgshow title="123" style="border:1px solid #333;" onclick="showimgid();" id="asb" imageCode="aaa"></file:imgshow>
<file:imgshow imageId="1" width="120" ></file:imgshow>
<textarea style="height:200px; width: 100%">

/**
 * 显示图片 imgPath(base64加密) imgId至少有一个(不要包含中文) imgPath图片绝对路径（优先使用） imgId 图片表主键
 * 
 * noImgPath 指定的无图片时去查找的图片绝对路径(base64加密)（可以不指定，系统将自动查找缺省图片),可以放入系统配置文件进行调用 
 * imgCode 如果存在压缩图片，压缩图片与原图的标识（可以不指定），可以放入系统配置文件进行调用
 * 
 * 调用方法
 * 
 * <img src="<%=request.getContextPath() %>/showimg.do?imgId=1">
 * 
 * <img src="<%=request.getContextPath()%>/showimg.do?imgId=1&imgCode=_Max&noImgPath=<%=Base64.getBase64FromString("d:/123.jpg") %>" border="0">
 * 
 * <img src="<%=request.getContextPath() %>/showimg.do?imgPath=<%=Base64.getBase64FromString("d:/2222.jpg") %>&imgCode=_Max&noImgPath=<%=Base64.getBase64FromString("d:/123.jpg")%>" border="0">
 */
</textarea> 
<br/>
<br/>
 <a href='<%=request.getContextPath() %>/download.do?filePath=<%=Base64.getBase64FromString("d:/2222.txt") %>&saveName=测试文档'>文件</a><br/><br/>
标签调用
<file:downlaod value="<%="默认文件名" %>"  id="dw"></file:downlaod><input type="button" value="动态修改下载" onclick="setdownload();">

<file:downlaod value="文件下载" fileId="1"></file:downlaod>
<textarea style="height:200px; width: 100%">
/**
 * 文件下载 fileId filePath至少需要一个 
 * 
 * fileId 附件表主键 
 * 
 * filePath 附件绝对路径(优先使用)进行base64加密 
 * 
 * saveName 下载显示的文件名(可以不指定，不指定filePath将采用系统默认，fileId将采用数据库存储名称)
 * 
 * 调用方法 
 * 
 * <a href='<%=request.getContextPath() %>/download.do?filePath=<%=Base64.getBase64FromString("d:/2222.txt")%>&saveName=测试文档'>文件</a>
 * 
 * <a href='<%=request.getContextPath() %>/download.do?fileId=1'>文件</a>
 */
</textarea>
</body>
</html>