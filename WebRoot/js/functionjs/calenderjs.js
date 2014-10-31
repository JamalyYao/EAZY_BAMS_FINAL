/**日程安排**/


function displaydiv(obj,divid){
	var div = document.getElementById(divid);
	var nodes = div.getElementsByTagName("div");
	var sta = obj.getAttribute("value");
	var pk = obj.getAttribute("pk");
	if(sta == 1){
		nodes[0].innerHTML ="重新启用";
		nodes[0].style.backgroundImage = "url('"+Sys.getProjectPath()+"/images/grid_images/set.png')";
		nodes[0].onclick =function(){
			complete(pk);
			closediv(this);
		};
	}else{
		nodes[0].innerHTML ="完成工作";
		nodes[0].style.backgroundImage = "url('"+Sys.getProjectPath()+"/images/grid_images/info.png')";
		nodes[0].onclick =function(){
			complete(pk);
			closediv(this);
		};
	}
	nodes[1].onclick = function(){
	   edit(pk);
	   closediv(this);
	}
	nodes[2].onclick = function(){
	   del(pk);
	   closediv(this);
	}
	var tp = event.clientY;
	var lf = event.clientX;
	div.style.top = tp;
    div.style.left = lf;
	div.style.display = "";
}
function hiddendiv(obj,divid){
	var div = document.getElementById(divid);
	var event  = window.event || event;
	var tobj = event.toElement ? event.toElement: event.relatedTarget;
	if(tobj == div) return;
	var nodes = div.childNodes;
	for(var i=0;i<nodes.length;i++){
		if(tobj == nodes[i]) return; 
	}
	div.style.display = "none";
}

function childover(obj){
	obj.style.backgroundColor ="#eeeeee";
}
function childout(obj,divid){
	obj.style.backgroundColor ="#D8D6D6";  //内层div对象
	var div = document.getElementById(divid);//外层div对象
	var event  = window.event || event;
	var tobj = event.toElement ? event.toElement: event.relatedTarget;//鼠标进入的对象
	var nodes = div.childNodes;
	if(tobj == div){ return;}//鼠标进入外层div对象
	for(var i=0;i<nodes.length;i++){
		if(tobj!=obj&&tobj == nodes[i]) return;
	}
	div.style.display = "none";
}
function closediv(obj){
	var div = obj.parentNode;
	div.style.display = "none";
}


