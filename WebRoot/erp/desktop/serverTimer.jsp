<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.eazytec.common.util.UtilWork"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0);
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>系统时间</title>
 <script type="text/javascript">
  var timerID = null;
  var timerRunning = false;
  function stopclock (){
	  if(timerRunning)
	  	clearTimeout(timerID);
	  timerRunning = false
  }
  function CreateXmlHttpRequest(){
	    // 先定义一个变量，并赋初值为 false，方便后面判断对象是否创建成功          
	    // 使用 try 来捕获创建失败，再换个方法来创建
	    var xmlhttp;
	    try {
	        // 在 Mozilla 中使用这种方式来创建 XMLHttpRequest 对象
	        xmlhttp = new XMLHttpRequest;
	    }catch (e) {
	        try {
	            // 如果不成功，那么尝试在较新 IE 里的方式
	            xmlhttp = new ActiveXObject("MSXML2.XMLHTTP");
	        }catch (e2) {
	            try {
	                // 失败则尝试使用较老版本 IE 里的方式 
	                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	            }catch (e3){
	                // 还是失败，那么就认为创建失败……
	                xmlhttp = false;
	            }
	        }
	    }
	    
	    return xmlhttp;
	}
  function getNowTime(){
  	 var xmlhttp = CreateXmlHttpRequest();
	    // 因为使用异步方式所以要在 XMLHttpRequest 对象的状态改变时做相应的处理
	  xmlhttp.onreadystatechange = function(){getTime(xmlhttp)};;
	  xmlhttp.open("GET", "<%=request.getContextPath()%>/getServerTimer.jsp?time="+Math.random(), true);
	    // 发送请求，因为是GET，所以send的内容为null
	  xmlhttp.send(null);
  }
  
  function getTime(xmlhttp){
  	if(xmlhttp.readyState == 4) {   
      if(xmlhttp.status == 200) {
        var tm =trim(xmlhttp.responseText);
        document.getElementById("currdate").value = tm;
      }
    }
  }
  
  function getServerDate(){
  	getNowTime(getTime);
  	var tmp = document.getElementById("currdate").value;
  	var tms = tmp.split("-");
  	return tms;
  }
  
	window.onunload = function(){
  		stopclock();
 	}
</script>
</head>
<input type="hidden" id="currdate" value="<%=UtilWork.getCustomerDay("yyyy-M-d-HH-mm-ss-E") %>">
</html>