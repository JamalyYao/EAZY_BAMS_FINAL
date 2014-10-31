$(document).ready(function() {
	var lw="15%", cw="0.5%", rw="84.5%",fw="99.5%";
	var leftPane = $("#leftPane");
	var rightPane = $("#rightPane");
	
	if(leftPane != null && rightPane != null){
	
		leftPane.after("<div id='cenPane' title='点击收缩'><div id='cenPaneButton'></div></div>");
		var cenPane = $("#cenPane");
		var cenPaneButton = $("#cenPaneButton");
		cenPane.css("width",cw);
		
		$("#cenPane").click(function(){
			
			//普通效果
			if(leftPane.is(":hidden")){  
				leftPane.show();
				rightPane.css("width",rw);
				cenPaneButton.css("background-position","0px 0px");
			}else{
				leftPane.hide();
				rightPane.css("width",fw);
				cenPaneButton.css("background-position","-14px 0px");
			}
			
			
			/**
			//左右滑动效果，会引起数据表格产生x滚动条，暂不用
			if(leftPane.is(":hidden")){  
				leftPane.animate({width:lw,opacity:"show"},150);
				rightPane.animate({width:rw},50);
				cenPaneButton.css("background-position","0px 0px");
			}else{
				leftPane.animate({width:"0px",opacity:"hide"},50);
				rightPane.animate({width:fw},150);
				cenPaneButton.css("background-position","-14px 0px");
			}
			**/
		});
	}
});

