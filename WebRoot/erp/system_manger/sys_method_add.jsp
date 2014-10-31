<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加功能目录</title>
<script type="text/javascript" src="<%=contextPath%>/dwr/interface/dwrSysProcessService.js"></script>
<link type='text/css' rel='stylesheet' href='<%=contextPath%>/css/xtree.css' />
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/map.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/xtree.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/xloadtree.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/checkboxTreeItem.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/xmlextras.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/checkboxXLoadTree.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/radioTreeItem.js' charset='UTF-8'></script>
<script type='text/javascript' src='<%=contextPath%>/js/treeJs/radioXLoadTree.js' charset='UTF-8'></script>
<script type='text/javascript'>webFXTreeConfig.setImagePath('<%=contextPath%>/js/treeJs/images/default/');</script>
<script type="text/javascript">
var tree = new WebFXLoadTree("系统功能目录","<%=request.getContextPath()%>/erp/tree/sysmethods.jsp?code=-1&method=treeclick");
	function treeclick(code, name) {
		document.getElementById("upcode").value = code;
		document.getElementById("upcodeName").value = name;
	}
</script>
<script type="text/javascript">
	window.onload = function() {
		initInput('title','新增顶级栏目之后需要重启web服务器！重启之后进入公司管理，分配公司权限。');
	}

	function save() {
		var warnArr = new Array();
		warnArr[0] = "methodNameMust";
		warnArr[1] = "methodSignMust";
	    warnInit(warnArr);
		var bl = validvalue('title');
		if (bl) {
			if(DWRUtil.getValue("upcode") == ""){
				if(DWRUtil.getValue("methodSign") == ""){
					setMustWarn("methodSignMust","顶级目录需要填写功能标识。")
					return false;
				}
			}
			
			dwrSysProcessService.saveMethod(getMethodInfo(), saveCallback);
		}
	}

	function getMethodInfo() {
		var method = new Object();
		method.methodInfoName = DWRUtil.getValue("methodName");
		method.methodInfoEngname = DWRUtil.getValue("methodEName");
		method.imageSrc = DWRUtil.getValue("imagepath");
		method.methodSign = DWRUtil.getValue("methodSign");
		method.isAction = getRadioValueByName("isVaild");
		var up = DWRUtil.getValue("upcode");
		method.levelUnit = DWRUtil.getValue("upcode");
		method.methodUri = DWRUtil.getValue("methodLoad");
		method.methodMsg = DWRUtil.getValue("methodMsg");
		return method;
	}

	function saveCallback(data) {
		if (data.success) {
			confirmmsgAndTitle("添加功能目录成功！是否想继续添加？", "resetPage();", "继续添加",
					"closePage();", "关闭页面");
		} else {
			alertmsg(data);
		}
	}

	function resetPage() {
		DWRUtil.setValue("methodName", "");
		DWRUtil.setValue("methodEName", "");
		//DWRUtil.setValue("upcode","");
		//DWRUtil.setValue("upcodeName","");
		DWRUtil.setValue("methodLoad", "");
		DWRUtil.setValue("methodMsg", "");
		document.getElementById("isVaild").selectedIndex = 0;
		//DWRUtil.setValue("imagepath","");
		tree.reload();
	}

	function closePage() {
		var frm = Sys.getMDIFrame(<%=request.getParameter("nowwindow")%>);
		if (typeof frm != "undefined") {
			frm.queryData();//调用原页面查询方法
			frm.tree.reload();
		}
		Sys.closeMDITab();
	}
	
	function getImg(){
		var box = SEL.getImg("projectimg","imagepath");
	    box.show();
	}
</script>
</head>
<body>
	<div id="splitterContainer">
		<div id="leftPane">
			<div class="div_title1_img">选择上级</div>
			<div class="div_tree">
			<script type="text/javascript">
				document.write(tree);
			</script>
			</div>
		</div>
		<div id="rightPane">
			<div class="requdiv">
				<label id="title"></label>
			</div>
			<fieldset>
				<legend>新增功能目录</legend>
				<table class="inputtable" width="95%">
					<tr>
						<th>上级功能目录</th>
						<td colspan="3">
							<input type="text" id="upcodeName" readonly="readonly" class="niceform"
							linkclear="upcode" style="color: #999;" />
							<input type="hidden" id="upcode" />
							<font color="#808080">点击左侧目录树选择，若为顶级留空</font>
						</td>
					</tr>
					<tr>
						<th><em>*</em>功能名称</th>
						<td>
							<input type="text" id="methodName" must="功能名称不能为空！" formust="methodNameMust" />
							<label id="methodNameMust"></label>
						</td>
						<th>功能英文名</th>
						<td style="text-align: left">
							<input type="text" id="methodEName" />
						</td>
					</tr>
					<tr>
						<th>功能标识</th>
						<td>
						<input type="text" id="methodSign" maxlength="50" />
						<label id="methodSignMust"><font color="#808080">顶级目录需填写功能标识</font></label>
						</td>
						<th>是否有效</th>
						<td>
							<%=UtilTool.getRadioOptionsByEnum(EnumUtil.SYS_ISACTION.getSelectAndText(""),"isVaild")%>
						</td>
					</tr>
					<tr>
						<th>图片</th>
						<td colspan="3">
							<input type="text" id="imagepath" maxlength="50" value="file.png" readonly="readonly" class="takeform" onclick="getImg()" />
							<font color="#808080">图片为你要添加的图片文件名（例：file.png），同时把文件复制到工程指定目录下！</font>
						</td>
					</tr>
					<tr>
						<th>跳转路径</th>
						<td colspan="3">
						<input type="text" id="methodLoad" style="width:90%"/>
						</td>
					</tr>
					<tr>
						<th>描述</th>
						<td colspan="3">
							<textarea id="methodMsg" style="height:100px"></textarea>
						</td>
					</tr>
				</table>
			</fieldset>
			<br /> <br />
			<table align="center">
				<tr>
					<td><btn:btn onclick="save();" value=" 确  定 " />
					</td>
					<td style="width: 20px;"></td>
					<td><btn:btn onclick="closePage();" value=" 关  闭 " />
					</td>
				</tr>
			</table>
		</div>
	</div>

</body>
</html>