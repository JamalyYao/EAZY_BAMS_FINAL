<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公司投票</title>
<script  type='text/javascript'   src='<%=contextPath%>/js/leftMethod.js'></script>
<script type="text/javascript">
window.onload=function(){
    Sys.load('vote_info.jsp','voter');
}
</script>
</head>
<body style="overflow: hidden;">
<div id="splitterContainer">
	<div id="leftPane">
		<div class="div_title1_img">选择操作</div>	
		<div class="div_leftmethod">
			<div class="leftbut" onclick="Sys.load('vote_info.jsp','voter');" title="正在投票">
			<img src="<%=contextPath %>/images/pagemethodimg/im.png"/>
			<div>正在投票</div>
			</div>
			<div class="leftbut" onclick="Sys.load('vote_history_info.jsp','voter');" title="投票历史">
			<img src="<%=contextPath %>/images/pagemethodimg/page_white_paint.png"/>
			<div>投票历史</div>
			</div>
		</div>
	</div>
	<div id="rightPane">
	<iframe  frameborder="0"  height="100%" scrolling="auto" marginheight="3" id="voter" width="100%"></iframe>
	</div>
</div>

</body>
</html>
