<%@page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
<%
    String pk = request.getParameter("pk");
    String isedit = "false";
    String saveOrEdit = "新增";
    String helpTitle = "您可以在此处添加您想新增的组件！";
    if(pk != null){
        isedit = "true";
        saveOrEdit = "编辑";
        helpTitle = "您可以在此处编辑组件信息！";
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=saveOrEdit%>组件</title>
<script type="text/javascript" src="<%=contextPath%>/dwr/interface/dwrSysComponentService.js"></script>
<script type="text/javascript">
window.onload = function(){
    useLoadingMassage();
    initInput("helpTitle","<%=helpTitle%>");
    saveOrEdit();
}
function saveOrEdit(){
    if(<%=isedit%>){
        var pk = '<%=pk%>';
        dwrSysComponentService.getSysComponentByPk(pk,setComponent);
    }
}

var fckvalue = "";
var fck;

function setComponent(data){
    if(data.success == true){
        if(data.resultList.length > 0){
            var component = data.resultList[0];
            DWRUtil.setValue("comInput",component.comInput);
            DWRUtil.setValue("comNumform",component.comNumform);
            DWRUtil.setValue("comRmbform",component.comRmbform);
            DWRUtil.setValue("comDateform",component.comDateform);
            setSelectValue("comSelect",component.comSelect);
            setRadioValueByName("comRadio",component.comRadio);
            setCheckboxValueByName("comCheckbox",component.comCheckbox);
            DWRUtil.setValue("comTakeformText",component.comTakeformText);
            DWRUtil.setValue("comTakeformTextarea",component.comTakeformTextarea);
            DWRUtil.setValue("comTextarea",component.comTextarea);
            fckvalue = component.comFck;
            if(Sys.isNotBlank(component.comUploadimg)){
                dwrCommonService.getImageInfoListToString(component.comUploadimg,function(data){Sys.setFilevalue("comUploadimg",data);});
            }
            if(Sys.isNotBlank(component.comUploadfile)){
                dwrCommonService.getAttachmentInfoListToString(component.comUploadfile,function(data){Sys.setFilevalue("comUploadfile",data);});
            }
        }else{
            alert(data.message);
        }
    }else{
        alert(data.message);
    }
}
function FCKeditor_OnComplete(editorInstance) {
    fck = editorInstance;
    editorInstance.SetHTML(fckvalue);
    window.status = editorInstance.Description;
}
function save(){
    var warnArr = new Array();
    //清空所有信息提示
    warnInit(warnArr);
    var bl = validvalue('helpTitle');
    if(bl){
        //此处可编写js代码进一步验证数据项目的正确

        var attach = DWRUtil.getValue("");//附件
        var imgfile = DWRUtil.getValue("");//图片
        Btn.close();
        if(<%=isedit%>){
            dwrSysComponentService.updateSysComponent(getComponent(),updateCallback);
        }else{
            dwrSysComponentService.saveSysComponent(getComponent(),saveCallback);
        }
    }
}
function getComponent(){
    var component = new Object();
    if(<%=isedit%>){
        component.primaryKey = '<%=pk%>';
    }
    component.comInput = DWRUtil.getValue("comInput");
    component.comNumform = DWRUtil.getValue("comNumform");
    component.comRmbform = DWRUtil.getValue("comRmbform");
    component.comDateform = DWRUtil.getValue("comDateform");
    component.comSelect = DWRUtil.getValue("comSelect");
    component.comRadio = getRadioValueByName("comRadio");
    component.comCheckbox = getCheckboxValueByName("comCheckbox");
    component.comTakeformText = DWRUtil.getValue("comTakeformText");
    component.comTakeformTextarea = DWRUtil.getValue("comTakeformTextarea");
    component.comTextarea = DWRUtil.getValue("comTextarea");
    component.comFck = fck.GetXHTML();
    return component;
}
function saveCallback(data){
    Btn.open();
    if(data.success){
        confirmmsgAndTitle("添加组件成功！是否想继续添加组件？","reset();","继续添加","closePage();","关闭页面");
    }else{
        alertmsg(data);
    }
}
function updateCallback(data){
    Btn.open();
    if(data.success){
        alertmsg(data,"closePage();");
    }else{
        alertmsg(data);
    }
}
function reset(){
    Sys.reload();
}
function closePage(){
    var frm = Sys.getMDIFrame(<%=request.getParameter("nowwindow")%>);
    if(typeof frm != "undefined"){
        frm.queryData();//调用原页面查询方法
    }
    Sys.closeMDITab();
}
</script>
</head>
<body class="inputcls">
    <div class="formDetail">
        <div class="requdiv"><label id="helpTitle"></label></div>
        <div class="formTitle"><%=saveOrEdit%>组件</div>
        <table class="inputtable">
            <tr>
                <th><em>*</em>&nbsp;&nbsp;普通文本框</th>
                <td><input type="text" id="comInput" must="普通文本框不能为空!" formust="comInputMust"></input><label id="comInputMust"></label></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;数字框</th>
                <td><input type="text" id="comNumform" class="numform" must="数字框不能为空!" formust="comNumformMust"></input><label id="comNumformMust"></label></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;金额框</th>
                <td><input type="text" id="comRmbform" class="rmbform" must="金额框不能为空!" formust="comRmbformMust"></input><label id="comRmbformMust"></label></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;日期框</th>
                <td><input type="text" id="comDateform" class="Wdate" readonly="readonly" onClick="WdatePicker()" must="日期框不能为空!" formust="comDateformMust"></input><label id="comDateformMust"></label></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;下拉框</th>
                <td><select id="comSelect"><%=UtilTool.getSelectOptions(this.getServletContext(),request,null,"21") %></select></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;单选框</th>
                <td><%=UtilTool.getRadioOptionsByEnum(EnumUtil.HRM_EMPLOYEE_SEX.getSelectAndText(""),"comRadio")%></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;多选框</th>
                <td><%=UtilTool.getCheckboxOptions(this.getServletContext(),request,null,"06","comCheckbox") %></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;弹出单选框</th>
                <td><input type="text" id="comTakeformText" class="takeform" readonly="readonly" linkclear="" onClick="" title="点击选择"></input><label id="comTakeformTextMust"></label></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;弹出多选框</th>
                <td><textarea id="comTakeformTextarea" readonly="readonly" linkclear="" onclick="" title="点击选择"></textarea><label id="comTakeformTextareaMust"></label></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;文本域</th>
                <td><label id="comTextareaMust"></label><br/><textarea width="90%" id="comTextarea" style="height:150px;"></textarea></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;富文本</th>
                <td><label id="comFckMust"></label><FCK:editor instanceName="comFck" width="90%" height="150"></FCK:editor></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;上传图片</th>
                <td><file:imgupload width="120" acceptTextId="comUploadimg" height="135" edit="<%=isedit %>"></file:imgupload></td>
            </tr>
            <tr>
                <th><em>*</em>&nbsp;&nbsp;上传附件</th>
                <td><file:multifileupload width="90%" acceptTextId="oaNotiAcce" height="100" edit="<%=isedit %>"></file:multifileupload></td>
            </tr>
        </table>
    </div>
    <table align="center">
        <tr>
            <td><btn:btn onclick="save();" value="保 存 " imgsrc="../../images/png-1718.png" title="保存组件信息" /></td>
            <td style="width:20px;"></td>
            <td><btn:btn onclick="closePage();" value="关 闭 " imgsrc="../../images/winclose.png" title="关闭当前页面"/></td>
        </tr>
    </table>
</body>
</html>
