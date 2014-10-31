/*
dwr出现加载状态js
*/

function showloading(obj){
	var pnode = obj.previousSibling;
	if(pnode!=null && pnode.tagName =="DIV"){
		if(obj.readyState =="complete"){
			pnode.style.display ='none';
			obj.style.display ='';
		}else{
			obj.style.display ='none';
			pnode.style.display ='';
		}
	}
}



function useLoadingMassage(par,massage) {
  par = window.parent.parent.parent.parent;
  var loadingmsg;
  var pt;
  if (massage) {
  	loadingmsg = massage;
  } else{
    loadingmsg = "数据处理中,请稍候...";
  }
  
  if(par){
  	pt = par;
  }else{
  	pt= window.parent;
  }
  
  dwr.engine.setPreHook(function() {
    var disabledZone =pt.document.getElementById("disabledZone");
    var imageZone = pt.document.getElementById("imageZone");
    if (!disabledZone) {
	  
      disabledZone = pt.document.createElement('div');
      disabledZone.setAttribute('id', 'disabledZone');
      disabledZone.style.position = "absolute";
      disabledZone.style.left = "0px";
      disabledZone.style.top = "0px";
      disabledZone.style.zIndex = "100";
      disabledZone.style.width = "100%";
      disabledZone.style.height = "100%";
      disabledZone.style.background = "#ffffff";
      disabledZone.style.opacity = 0.1;               //FF阴影层透明度
      disabledZone.style.filter = "alpha(opacity=10)";  //IE阴影层透明度
      pt.document.body.appendChild(disabledZone);
      
      imageZone = pt.document.createElement('div');
      imageZone.setAttribute('id', 'imageZone');
      imageZone.style.position = "absolute";
      imageZone.style.fontFamily = "宋体";
      imageZone.style.zIndex = "999";
      imageZone.style.top = "100px";
      imageZone.style.right = "50px";
      imageZone.style.color ='red';
      imageZone.style.border ='1px solid #dddddd';
      imageZone.style.backgroundColor ='#ffffbe';
      imageZone.style.padding ="3px";
      imageZone.style.paddingLeft ="15px";
      imageZone.style.paddingRight ="15px";
      imageZone.innerHTML = "<img src='"+Sys.getProjectPath()+"/images/dataload.gif' border='0' style='vertical-align:middle;'/>&nbsp;"+loadingmsg;
      pt.document.body.appendChild(imageZone);
    } else {
      pt.document.getElementById("imageZone").innerHTML =  "<img src='"+Sys.getProjectPath()+"/images/dataload.gif' style='vertical-align:middle;' border='0'/>&nbsp;"+loadingmsg;
      imageZone.style.visibility = "visible";
      disabledZone.style.visibility = "visible";
    }
  });
  
  dwr.engine.setPostHook(function() {
   pt.document.getElementById("imageZone").style.visibility = "hidden";
   pt.document.getElementById("disabledZone").style.visibility = "hidden";
  });
}
