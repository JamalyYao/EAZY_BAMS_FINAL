jQuery(document).ready(function() {
	var cookie = new JSCookie();
	var ck = cookie.GetCookie(document.URL);
	var qm = document.getElementById("queryMore");
	if(qm!=null && qm != "undefined" && qm != undefined){
	$("#queryMore").toggle(
		function() {  
			$("#queryParam").animate({height: 'show',opacity: 'show'  }, 'slow');
				document.getElementById("queryImg").src =formStylePath.getImagePath()+"grid_images/uup.png";
				document.getElementById('searchType').value = "1";
				var queryvalue = document.getElementById("simpleQueryValue");
				if(queryvalue!=null && queryvalue != "undefined" && queryvalue != undefined){
					queryvalue.value ="";
					queryvalue.disabled=true;
					queryvalue.style.backgroundColor = "#EEEEEE";
				}
			}, 
		function() {  
			$("#queryParam").animate(
				{   height: 'hide',   opacity: 'hide'  }, 'slow'); 
				document.getElementById("queryImg").src = formStylePath.getImagePath()+"grid_images/ddn.png";
				document.getElementById('searchType').value = "0";
				var queryvalue = document.getElementById("simpleQueryValue");
				if(queryvalue!=null && queryvalue != "undefined" && queryvalue != undefined){				
					queryvalue.disabled=false;
					queryvalue.style.backgroundColor = "#FFFFFF";
				}
			}
		);
	}
	var tit = document.getElementById("helpProcessTitle");
	if(tit!=null && tit != "undefined" && tit != undefined){
		if(ck!=null&&ck!=""){
			$("#helpProcessTitle").toggle(
				function() {
					$("#processTitleTable").animate({height: 'show',opacity: 'show'  }, 'slow');
						document.getElementById("helptitleImg").src =formStylePath.getImagePath()+"grid_images/uup.png";
					}, 
				function() {  
					$("#processTitleTable").animate(
						{   height: 'hide',   opacity: 'hide'  }, 'slow'); 
						document.getElementById("helptitleImg").src = formStylePath.getImagePath()+"grid_images/ddn.png";
					}
				);
		}else{
			$("#helpProcessTitle").toggle(
				function() {  
					$("#processTitleTable").animate(
						{   height: 'hide',   opacity: 'hide'  }, 'slow'); 
						document.getElementById("helptitleImg").src = formStylePath.getImagePath()+"grid_images/ddn.png";
					},
				function() {
					$("#processTitleTable").animate({height: 'show',opacity: 'show'  }, 'slow');
						document.getElementById("helptitleImg").src =formStylePath.getImagePath()+"grid_images/uup.png";
					}
				);		
		}
	}
	var sm = document.getElementById("showMore");
	if(sm!=null && sm != "undefined" && sm != undefined){
	$("#showMore").toggle(
		function() {  
			$("#showParam").animate(
				{	height: 'show',   opacity: 'show'  }, 'slow');
				document.getElementById("showImg").src = formStylePath.getImagePath()+"grid_images/uup.png";
			}, 
		function() {
			$("#showParam").animate(
				{   height: 'hide',   opacity: 'hide'  }, 'slow'); 
				document.getElementById("showImg").src = formStylePath.getImagePath()+"grid_images/ddn.png";
			}
		);
	}
	var sp = document.getElementById("showParam");
	if(sp!=null && sp != "undefined" && sp != undefined){
		$("#showParam").hide();
	}
	var tt = document.getElementById("processTitleTable");
	if(tt!=null && tt != "undefined" && tt != undefined){
		if(ck!=null&&ck!=""){
			$("#processTitleTable").hide();
		}else{
			var expire_time = new Date();
			expire_time.setFullYear(expire_time.getFullYear() + 1);
			cookie.SetCookie(document.URL,"1",expire_time);
			$("#processTitleTable").show();
			document.getElementById("helptitleImg").src =formStylePath.getImagePath()+"grid_images/uup.png";
		}
	}
	var qp = document.getElementById("queryParam");
	if(qp!=null && qp != "undefined" && qp != undefined){
		$("#queryParam").hide();
	}
	document.getElementById('searchType').value = "0";
	var res = document.getElementById("tableResult");
	if(res!=null && res != "undefined" && res != undefined){
		initDragTable(res);
	}
});

function  colsControl(table,num,isShow){   
	for(i=0;i<table.rows.length;i++){
		var td = table.rows[i].cells[num];
		var str = isShow?"block":"none";
  		td.style.display=str;
  	}
}   
/*
function MouseDownToResize(obj){
obj.mouseDownX=event.clientX;
obj.pareneTdW=obj.parentElement.offsetWidth;
obj.pareneTableW=theObjTable.offsetWidth;
obj.setCapture();
}

function MouseMoveToResize(obj){
	alert(123);
    if(!obj.mouseDownX) return false;
    var newWidth=obj.pareneTdW*1+event.clientX*1-obj.mouseDownX;
    if(newWidth>0){
	obj.parentElement.style.width = newWidth;
	//theObjTable.style.width=obj.pareneTableW*1+event.clientX*1-obj.mouseDownX;
	}
}

function MouseUpToResize(obj){
	obj.releaseCapture();
	obj.mouseDownX=0;
}
*/