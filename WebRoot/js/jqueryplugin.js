jQuery(document).ready(function() {
	//showUser();
   useLoadingImage("image/loading3.gif");
   //useLoadingMessage("正在处理，请秒候. . .")
   //useLoading("Now loading...","image/loading1.gif");
			
	$("#start").toggle(
		function() {  
			$(".startdiv").animate(
				{   height: 'hide',   opacity: 'hide'  }, 'slow'); 
			}, 
		function() {  
			$(".startdiv").animate(
				{	height: 'show',   opacity: 'show'  }, 'slow');
		}
	);
	
	
	$("#userlist").find("dd").hide().end().find("dt").click(
		function(){
			var answer = $(this).next();
			if(answer.is(":visible")){
				answer.slideUp();
			}else{
				answer.slideDown();
			}
		}
	);
});