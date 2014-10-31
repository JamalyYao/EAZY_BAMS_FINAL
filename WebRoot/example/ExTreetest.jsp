<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../erp/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试树</title>
<style type="text/css">
	body{
		font-size: 12px;
	}
</style>
<%
SessionUser su = (SessionUser)LoginContext.getSessionValueByLogin(request);
String cname = su.getCompanyInfo().getCompanyInfoName();//公司名称做为树起点 适用于部门
String dcode = "00";
 %>
<script type="text/javascript">
	
	//每个页面值支持一个树 默认采用该目录图片生成树
	//webFXTreeConfig.setImagePath("<%=contextPath%>/js/treeJs/images/default/");
	var tree = new WebFXRadioLoadTree("<%=cname%>","xmlshow.jsp?fid=<%=dcode%>" ,"javascript:alert('根节点');");
	//WebFXRadioLoadTree 单选树
	//WebFXCheckBoxLoadTree 复选树
	
	var vals = {
		check:function(){
			alert("value:"+getCheckValues()+"\n\n"+"Text:"+getCheckTexts()+"\n\n"+"object:"+getCheckObjects());
			
		},
		setcheck:function(vl){
			setCheckBox(vl,true);
		},
		radio:function(){
			alert("value:"+getCheckValue()+"\n\n"+"Text:"+getCheckText()+"\n\n"+"object:"+getCheckObject());
		}
	}
	
</script>
</head>
<body>
<input type="button" value="获取选中复选值" onclick="vals.check();">
<input type="button" value="获取选中单选值" onclick="vals.radio();">
<input type="button" value="设置节点value为0104选中" onclick="vals.setcheck('0104');">
<br/>
混合树
<div style="width: 50%;height: 400px;overflow: auto;margin: 5px;padding: 20px;border: 1px solid #cccccc">
<script type="text/javascript">
  document.write(tree);
</script>
</div>
</body>
</html>