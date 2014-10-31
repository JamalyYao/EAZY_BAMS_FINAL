var cookie = new JSCookie();
var uriname ="defautUri";
var companyname ="companycode";
var uname ="urname";

var ua = navigator.userAgent.toLowerCase();
function checkNav(r){
	return r.test(ua);
}
function checkIsIe(){
	var bl = false;
	var isOpera = checkNav(/opera/);
	var isIE = !isOpera && checkNav(/msie/);
	if(isIE&&checkNav(/msie 7/)){
		bl = true;
	}
	if(isIE && checkNav(/msie 8/)){
		bl = true;
	}
	return bl;
}
window.onresize = function(){
	setTempDivHeight();
}

function setTempDivHeight(){
	var ch=document.documentElement.clientHeight;
	var th = 640;
	var tp = (ch - th)/2;
	if(tp>5){
		document.getElementById("temph").style.height=tp+"px";
	}
}

window.onload=function(){
	if(!checkIsIe()){
		document.getElementById("temph").innerHTML = "<font color='#ffffff' style='font-family: 宋体'>您的浏览器不是IE7或IE8,建议您升级安装IE7/8,以保证系统正常运行！[<a href='downloadfile/IE8-WindowsXP-x86-CHS.exe' style='color:#FFF9A0'>IE8下载安装</a>]</font>";
	}
	
	new Marquee("textdiv",0,1,713,28,20,4000,500);
	document.onkeypress = onKeyPress;
	//加载cookie
	var defaultUri =cookie.GetCookie(uriname);
	var cookcompany =cookie.GetCookie(companyname);
	var cookusername =cookie.GetCookie(uname);
	if(defaultUri != null && defaultUri != ""){
		var bl = false;
		if(methodsings.length>0){
			for(var i=0;i<methodsings.length;i++){
				if(methodsings[i]==defaultUri){
					bl = true;
					break;
				}
			}
			if(bl){
				document.getElementById("msign").value=defaultUri;
			}else{
				document.getElementById("msign").value=methodsings[0];
			}
		}
	}
	setMethodImg();
	if(cookcompany!= null&& cookcompany!=""){
		document.getElementById("companycode").value=cookcompany;
	}
	if(cookusername!= null&& cookusername!=""){
		document.getElementById("username").value=cookusername;
	}
	if(document.getElementById("companycode").value == null ||document.getElementById("companycode").value==""){
		document.getElementById("companycode").focus();
	}else if(document.getElementById("username").value==null || document.getElementById("username").value==""){
		document.getElementById("username").focus();
	}else{
		document.getElementById("userpwd").focus();
	}
	
	changecode(document.getElementById("codeimg"));
	
	//登录失败后，清空验证码
	document.getElementById("code").value = "";

	var txts = document.getElementsByTagName("input");
	for(var i=0;i<txts.length;i++){
		var txt = txts[i];
		if (txt.getAttribute("type") == "text" || txt.getAttribute("type") == "password") {
			txt.onfocus = function(){
				this.className='niceform_hover';
			};
			txt.onblur = function(){
				this.className='niceform';
			};
		}
	}
	
	setTempDivHeight();
}

function clearinput(){
	document.getElementById("username").value="";
	document.getElementById("userpwd").value="";
	document.getElementById("code").value = "";
	changecode(document.getElementById("codeimg"));
	document.getElementById("username").focus();
}

function setMethodImg(){
	var dfimg =document.getElementById("msign").value;
	if(methodsings.length>0){
		for(var i=0;i<methodsings.length;i++){
			var tmp=document.getElementById(methodsings[i]);
			if(tmp.getAttribute("value")==dfimg){
				var ts=tmp.src;
	    		tmp.src=getrepFileName(ts,"","_");
	    		document.getElementById("mid").value=methodIds[i];
			}
		}
	}
}
function getrepFileName(fileName,oldstr,repstr){
	var tmp = fileName+repstr;
	if(fileName.length>0){
		var psp =fileName.split("/"); 
		var point = ".";
		var index = psp[psp.length-1].lastIndexOf(point);
		var name =  psp[psp.length-1].substring(0, index);
		if(oldstr!=null&&oldstr.length>0){
			name = name.replace(oldstr,"");
		}
		var ext = psp[psp.length-1].substring(index + 1);
		var str ="";
		if(psp.length>1){
			for(var i=0;i<psp.length-1;i++){
				str+=psp[i]+"/";
			}
		}
		if(repstr!=null&&repstr.length>0){
			tmp = str+name +repstr+point+ext;
		}else{
			tmp =str+name +point+ext;
		}
		return  tmp;
	}else{
		return tmp;
	}
}
function selectdefault(uri,sign,pk){
	var dfimg =document.getElementById("msign").value;
	if(dfimg == sign){
		return;
	}else{
		var im=document.getElementById(dfimg);
		var ts=im.src; 
		im.src=getrepFileName(ts,"_","");
	
		var obj =document.getElementById(sign);
		ts=obj.src; 
   		obj.src = getrepFileName(ts,"","_");
   		document.getElementById("mid").value=pk;
		document.getElementById("msign").value=sign;
	}
}
function onKeyPress(){
	var keycode;
	if(window.event) {
		keycode  = window.event.keyCode;
	}
	if(keycode == 13){
		loginCheck();
	}
}
function loginCheck(path){
	var companycode =document.getElementById("companycode");
	var username = document.getElementById("username");
	var pwd = document.getElementById("userpwd");
	var ccode = document.getElementById("code");
	var lbtn = document.getElementById("loginbtndiv");
	var lod = document.getElementById("loginloadingdiv");
	var box = document.getElementById("msgbox");
	
	if(companycode.value.length == 0){
		box.innerHTML = "请输入公司码！";
		companycode.focus();
		return;
	}
	if(username.value.length == 0){
		box.innerHTML = "请输入用户名！";
		username.focus();
		return;
	}
	if(pwd.value.length == 0){
		box.innerHTML = "请输入用户密码！";
		pwd.focus();
		return;
	}
	if(ccode.value.length == 0){
		box.innerHTML = "请输入验证码！";
		ccode.focus();
		return;
	}
	
	box.innerHTML ="";
	lbtn.style.display="none";
	lod.style.display="block";
	
	var expire_time = new Date();
	expire_time.setFullYear(expire_time.getFullYear() + 1);
	var ms=document.getElementById("msign").value;
	cookie.SetCookie(uriname,ms,expire_time); 
	if(document.getElementById("cmcode").checked){
		cookie.SetCookie(companyname,companycode.value,expire_time); 
	}
	if(document.getElementById("usname").checked){
		cookie.SetCookie(uname,username.value,expire_time); 
	}
	
	document.erpfrm.submit();
}

function hiddenTipsDiv(){
	document.getElementById('tipsdiv').style.visibility ='hidden';
}

function  detectCapsLock(event){
    var e = event||window.event;   
    var o = e.target||e.srcElement;   
    var oTip = document.getElementById("tipsdiv");   
    var keyCode  =  e.keyCode||e.which; // 按键的keyCode    
    var isShift  =  e.shiftKey ||(keyCode  ==   16 ) || false ; // shift键是否按住   
     if (((keyCode >=   65   &&  keyCode  <=   90 )  &&   !isShift) // Caps Lock 打开，且没有按住shift键    
     || ((keyCode >=   97   &&  keyCode  <=   122 )  &&  isShift)// Caps Lock 打开，且按住shift键   
     ){
     	var tt =o;
     	var ttop = tt.offsetTop;    //TT控件的定位点高
	    var twid = tt.clientWidth;    //TT控件本身的宽
	    var tleft = tt.offsetLeft;    //TT控件的定位点宽
	    while (tt = tt.offsetParent) {
	        ttop += tt.offsetTop;
	        tleft += tt.offsetLeft;
	    }
	    oTip.style.top = ttop;
	    oTip.style.left = tleft+twid+10;
	    oTip.style.visibility = "visible";
     }else{
     	oTip.style.visibility = "hidden"; 
     }    
}   

window.status ="江苏卓易信息科技有限公司 Eazytec ©2008-2013";