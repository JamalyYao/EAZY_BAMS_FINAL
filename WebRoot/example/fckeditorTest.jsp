<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../erp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>fck测试</title>
<style type="text/css">
	body {
	margin: 15px;
}
</style>
<script type="text/javascript">
var tmp ="";
window.onload = function(){
	tmp = "111111";
}
var fck;
function FCKeditor_OnComplete(editorInstance) {
	fck= editorInstance;
	editorInstance.SetHTML(tmp);//初始赋值
	window.status = editorInstance.Description;
}
</script>
</head>
<body>
默认高度350，默认宽度100%
<br/><br/>
<FCK:editor instanceName="EditorDefault" basePath="/fckeditor" width="80%" ></FCK:editor>
<br/><br/>
<button onclick="checkAll();"  value="fck为空验证">fck为空验证</button>
<button onclick="settext();"  value="赋值">赋值</button>
<button onclick="gettext();"  value="得值">得值</button>
<script type="text/javascript">
function checkAll()   
    {   
        var checkContent = fck.GetXHTML();
        if(checkContent == "")   
        {   
            alert("空哎！");   
            fck.Focus();   
            return false;   
        }   
    } 
    function settext(){
    fck.SetHTML("12312");
    }
    function gettext(){
    	var a=fck.GetXHTML();
    	alert(a);
    }
</script>
</body>
</html>