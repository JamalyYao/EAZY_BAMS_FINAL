<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>编辑功能目录</title>
		<%
			String sid = request.getParameter("sid");
		%>
		<script type="text/javascript"
			src="<%=contextPath%>/dwr/interface/dwrSysProcessService.js"></script>
		<script type="text/javascript">

window.onload = function(){
	useLoadingMassage();
	initInput('helpTitle','您可以在此处编辑功能目录信息！');
	dwrSysProcessService.getSysMethodInfoByPK('<%=sid%>',setpagevalue);
}
	
function saveSysMethodInfo(){
	var warnArr = new Array();
	warnArr[0] ="methodInfoNameMust";
	warnArr[1] = "methodLevelMust";
	warnArr[2] ="methodNoMust";
	warnInit(warnArr);
	var bl = validvalue('helpTitle');
	
	if(bl){
	 	var desc = DWRUtil.getValue("methodMsg");
		if(desc.length>500){
		 	setMustWarn("methodMsgMust","功能目录描述不能超过500字符");
		 	return;
		}
	    Btn.close();
		dwrSysProcessService.updateSysMethodInfo(getSysMethodInfo(),savecallback);
	}
}

function savecallback(data){
    Btn.open();//开放按钮
	if(data.success){
		alertmsg(data,"reload()");
	}else{
		alertmsg(data);
	}
}

function reload(){//重载父页面，用于编辑
	var frm = Sys.getMDIFrame(<%=request.getParameter("nowwindow")%>);
    if(typeof frm != "undefined"){
    	frm.tree.reload();
        frm.queryData();//调用原页面查询方法
    }
    Sys.closeMDITab();
}

	
function getSysMethodInfo(){
	 var info = new Object();
     info.primaryKey = DWRUtil.getValue("primaryKey");
	 info.methodInfoName = DWRUtil.getValue("methodInfoName");
	 info.methodInfoEngname =  DWRUtil.getValue("methodInfoEngname");
	 info.levelUnit = DWRUtil.getValue("levelUnitId");
	 info.imageSrc = DWRUtil.getValue("imageSrc");
	 info.methodNo = DWRUtil.getValue("methodNo");
	 info.methodLevel =  DWRUtil.getValue("methodLevel");
	 info.isAction = getRadioValueByName("isAction");
	 info.isDefault = getRadioValueByName("isDefault");
	 info.methodSign =  DWRUtil.getValue("methodSign");
	 info.defaultPage = DWRUtil.getValue("defaultPage");
	 info.methodUri = DWRUtil.getValue("methodUri");
	 info.methodMsg =  DWRUtil.getValue("methodMsg");
	 return info;
}

function setpagevalue(data){
	if(data != null && data.resultList.length > 0){
 			var info = data.resultList[0];
 			DWRUtil.setValue("primaryKey",info.primaryKey);
 			DWRUtil.setValue("methodInfoName",info.methodInfoName);
		    DWRUtil.setValue("methodInfoEngname",info.methodInfoEngname);
		    if(info.upSysMethodInfo != null){
		    	DWRUtil.setValue("levelUnitName",info.upSysMethodInfo.methodInfoName);
		    }
		    DWRUtil.setValue("levelUnitId",info.levelUnit);
	        DWRUtil.setValue("imageSrc",info.imageSrc);
	        DWRUtil.setValue("methodNo",info.methodNo);
	        DWRUtil.setValue("methodLevel",info.methodLevel);
	        setRadioValueByName("isAction",info.isAction);
	       	setRadioValueByName("isDefault",info.isDefault);
		    DWRUtil.setValue("methodSign",info.methodSign);
		    DWRUtil.setValue("defaultPage",info.defaultPage);
		    DWRUtil.setValue("methodUri",info.methodUri);
            DWRUtil.setValue("methodMsg",info.methodMsg);
 		}
 		
}

function getSysMethodInfoUpid(){
    var box = SEL.getSysMethodInfoIds("radio","levelUnitName","levelUnitId");
    box.show();
}

function getImg(){
	var box = SEL.getImg("projectimg","imageSrc");
    box.show();
}
</script>
	</head>
	<body class="inputcls">
		<div class="formDetail">
			<div class="requdiv">
				<label id="helpTitle"></label>
			</div>
			<div class="formTitle">
				编辑功能信息
			</div>
			<div>
				<table class="inputtable" border="0">
					<tr>
						<th width="15%">
							<em>* </em>功能编号
						</th>
						<td>
							<input type="text" id="primaryKey">
						</td>
						<th width="15%">
							<em>* </em>功能名称
						</th>
						<td>
							<input type="text" id="methodInfoName" maxlength="50" must="功能名称不能为空。" formust="methodInfoNameMust">
							<label id="methodInfoNameMust"></label>
						</td>
					</tr>
					
					<tr>
						<th>
							<em>* </em>功能层次
						</th>
						<td>
							<input type="text" id="methodLevel" maxlength="9" formust="methodLevelMust" must="功能层次不能为空">
							<label id="methodLevelMust"></label>
						</td>
						<th>
							<em>* </em>显示顺序
						</th>
						<td>
							<input type="text" id="methodNo" maxlength="9" class="numform" formust="methodNoMust" must="显示顺序不能为空">
							<label id="methodNoMust"></label>
						</td>
						
					</tr>
					
					
					<tr>
						<th>
							上级功能
						</th>
						<td>
						<input type="text" id=levelUnitName class="takeform" readonly="readonly" linkclear="levelUnitId" onclick="getSysMethodInfoUpid()" style="color: #999">
							<input type="hidden" id="levelUnitId" >
						</td>
						
						<th>
							英文名称
						</th>
						<td>
							<input type="text" id="methodInfoEngname" maxlength="50">
						</td>
					</tr>
					
					
					<tr>
						<th>
							是否有效
						</th>
						<td>
							 <%=UtilTool.getRadioOptionsByEnum(EnumUtil.SYS_ISACTION.getSelectAndText(""),"isAction")%>
						</td>
						<th>
							是否默认
						</th>
						<td>
							 <%=UtilTool.getRadioOptionsByEnum(EnumUtil.SYS_IS_DEFAULT.getSelectAndText(""),"isDefault")%>
						</td>
					</tr>
					
					
					<tr>
						<th>
							功能标识
						</th>
						<td>
							<input type="text" id="methodSign" maxlength="50">
						</td>
						<th>
							功能图标
						</th>
						<td>
							<input type="text" id="imageSrc" maxlength="50" readonly="readonly" class="takeform" onclick="getImg()"/>
						</td>
					</tr>
					
					<tr>
						<th>
							跳转路径
						</th>
						<td colspan="3">
							<input type="text" id="methodUri" maxlength="100" size="116">
						</td>
					</tr>
					<tr>
						<th>
							默 认 页
						</th>
						<td colspan="3">
							<input type="text" id="defaultPage" maxlength="100" size="116">
						</td>
					</tr>
					<tr>
						<th></th>
						<td colspan="3" id="methodMsgMust"></td>
					</tr>
					<tr>
						<th>
							功能描述
						</th>
						<td colspan="3">
							<textarea id="methodMsg" style="width: 100%"></textarea>
						</td>
					</tr>
					
				</table>
				<br />
			</div>
		</div>
		<br />
		<table align="center">
			<tr>
				<td>
					<btn:btn onclick="saveSysMethodInfo();" value="保 存 "
						imgsrc="../../images/png-1718.png" title="保存功能目录"></btn:btn>
				</td>
				<td style="width: 10px;"></td>
				<td>
					<btn:btn onclick="reload()" value="关 闭 "
						imgsrc="../../images/winclose.png" title="关闭当前页面"></btn:btn>
				</td>
			</tr>
		</table>
	</body>
</html>