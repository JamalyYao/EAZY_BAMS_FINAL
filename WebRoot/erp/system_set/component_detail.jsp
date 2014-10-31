<%@page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组件明细</title>
<script type="text/javascript" src="<%=contextPath%>/dwr/interface/dwrSysComponentService.js"></script>
<%
    String pk = request.getParameter("pk");
%>
<script type="text/javascript">
window.onload = function(){
    dwrSysComponentService.getSysComponentByPk('<%=pk%>',setPageValue);
}
function setPageValue(data){
    if(data.success == true){
        if(data.resultList.length > 0){
            var component = data.resultList[0];
            DWRUtil.setValue("comInput",component.comInput);
            DWRUtil.setValue("comNumform",component.comNumform);
            DWRUtil.setValue("comRmbform",component.comRmbform);
            DWRUtil.setValue("comDateform",component.comDateform);
            DWRUtil.setValue("comSelect",component.comSelect);
            DWRUtil.setValue("comRadio",component.comRadio);
            DWRUtil.setValue("comCheckbox",component.comCheckbox);
            DWRUtil.setValue("comTakeformText",component.comTakeformText);
            DWRUtil.setValue("comTakeformTextarea",component.comTakeformTextarea);
            DWRUtil.setValue("comTextarea",component.comTextarea);
            DWRUtil.setValue("comFck",component.comFck,{escapeHtml:false});
            //放入图片
            if(Sys.isNotBlank(component.comUploadimg)){
                var face = document.getElementById("comUploadimg");
                face.src+="&imgId="+component.comUploadimg;
            }
            //放入附件
            if(Sys.isNotBlank(component.comUploadfile)){
                Sys.showDownload(component.comUploadfile,"comUploadfile");
            }
        }else{
            alert(data.message);
        }
    }else{
        alert(data.message);
    }
}
</script>
</head>
<body class="inputdetail">
    <div class="requdivdetail"><label>查看帮助:&nbsp; 显示组件相关信息！</label></div>
    <div class="detailtitle">组件明细</div>
    <table class="detailtable">
        <tr>
            <th>普通文本框</th>
            <td id="comInput" class="detailtabletd"></td>
        </tr>
        <tr>
            <th>数字框</th>
            <td id="comNumform" class="detailtabletd"></td>
        </tr>
        <tr>
            <th>金额框</th>
            <td id="comRmbform" class="detailtabletd"></td>
        </tr>
        <tr>
            <th>日期框</th>
            <td id="comDateform" class="detailtabletd"></td>
        </tr>
        <tr>
            <th>下拉框</th>
            <td id="comSelect" class="detailtabletd"></td>
        </tr>
        <tr>
            <th>单选框</th>
            <td id="comRadio" class="detailtabletd"></td>
        </tr>
        <tr>
            <th>多选框</th>
            <td id="comCheckbox" class="detailtabletd"></td>
        </tr>
        <tr>
            <th>弹出单选框</th>
            <td id="comTakeformText" class="detailtabletd"></td>
        </tr>
        <tr>
            <th>弹出多选框</th>
            <td id="comTakeformTextarea" class="detailtabletd"></td>
        </tr>
        <tr>
            <th>文本域</th>
            <td id="comTextarea" class="detailtabletd"></td>
        </tr>
        <tr>
            <th>富文本</th>
            <td id="comFck" class="detailtabletd"></td>
        </tr>
        <tr>
            <th>上传图片</th>
            <td><file:imgshow id="comUploadimg" width="120"></file:imgshow></td>
        </tr>
        <tr>
            <th>上传附件</th>
            <td id="comUploadfile" class="detailtabletd"></td>
        </tr>
    </table>
</body>
</html>
