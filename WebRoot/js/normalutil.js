//银行账号格式化
function formatAccount(account,len,split){
	if(account==null||account.length==0){
		return "";
	}
	if(len==null){
		len = 4;
	}
	if(split==null){
		split = " ";
	}
	var result = "";
	var a = 1;
	for (var i = 0; i <account.length; i++) {
		result+=account.charAt(i);
		if (i+1==len*a) {
			result+=split;
			a++;
		}
	}
	return result;
}


//去除字符串中相同的项
function removerepeat(ids,names){
   var values = new Array();
   var idsarray = ids.substring(0,ids.length-1).split(",");
   var namesarray = null;
   if(names!=null&&names.length>0){
   		namesarray = names.substring(0,names.length-1).split(",");
   }
   var retid = new　Array();
   var retname = new　Array();
   var tempid="";
   var tempname ="";
   for(var i=0;i<idsarray.length;i++){
		if(checkItem(retid,idsarray[i])　==　-1){
		   retid.push(idsarray[i]);
		   if(namesarray!=null){
		   		retname.push(namesarray[i]);
		   }
		}
   }
   
   for(var i=0;i<retid.length;i++){
      tempid+=retid[i]+",";
      values[0] = tempid;
   }
   if(namesarray!=null){
	   for(var i=0;i<retname.length;i++){
	      tempname+=retname[i]+",";
	      values[1] = tempname;
	   }
   }
   return values;
}

//去除字符串中相同的项
function removerepeatIds(ids){
   var idsarray = ids.substring(0,ids.length-1).split(",");
   var retid = new　Array();
   var tempid="";

   for(var i=0;i<idsarray.length;i++){
		if(checkItem(retid,idsarray[i])　==　-1){
		   retid.push(idsarray[i]);
		}
   }
   
   for(var i=0;i<retid.length;i++){
      tempid+=retid[i]+";";
   }
   return tempid;
}



var tempUrlParameter ={
	setTmpvalue:function(val){
		var obj = window.parent.document.getElementById("tempUrlParameter");
		if(obj!=null){
			obj.value = val;
			return;
		}else{
			var input = window.parent.document.createElement("input");
			input.setAttribute("type","hidden");
			input.setAttribute("id","tempUrlParameter");
			input.setAttribute("value",val);
			window.parent.document.body.appendChild(input);
		}
	},
	getTmpvalue:function(wp){
		var obj = wp.document.getElementById("tempUrlParameter");
		if(obj!=null && obj != "undefined" && obj != undefined){
			var val = obj.value;
			return val;
		}else{
			return null;
		}
	}
};

function checkItem(receiveArray,　checkItem){
   var　index　=　-1;　　//　函数返回值用于布尔判断
　　for　(var　i=0;　i<receiveArray.length;　i++){
	　　if　(receiveArray[i]==checkItem){
	　　		index　=　i;
	　　		break;
	　　}
　　}
　　return　index;
}
//通过传入的id，去除该id和对应的名字
function removeItemFromIds(empid,ids,names){
   var values = new Array();
   var idsarray = ids.substring(0,ids.length-1).split(",");
   var namesarray = null;
   if(names!=null&&names.length>0){
   		namesarray = names.substring(0,names.length-1).split(",");
   }
   var retid = new　Array();
   var retname = new　Array();
   var tempid="";
   var tempname ="";
   for(var i=0;i<idsarray.length;i++){
		if(empid != idsarray[i]){
		   retid.push(idsarray[i]);
		   if(namesarray!=null){
		   	retname.push(namesarray[i]);
		   }
		}
   }
   
   for(var i=0;i<retid.length;i++){
      tempid+=retid[i]+",";
      values[0] = tempid;
   }
   if(namesarray!=null){
	   for(var i=0;i<retname.length;i++){
	      tempname+=retname[i]+",";
	      values[1] = tempname;
	   }
   }
   return values;

}


function changebg(obj,borcolor,bgcolor,wd){
	if(wd == 0){
		obj.style.border = "0px";
		obj.style.backgroundColor = "";
		return;
	}
	if(wd==null){
		wd =1;
	}
	obj.style.border =wd+"px solid "+borcolor;
	obj.style.backgroundColor = bgcolor;
}



var dateoldbgcolor = "";
var dateoldcolor = "";
function changDateColorOver(obj,bgcolor,fontcolor){
	dateoldbgcolor = obj.style.backgroundColor;
	dateoldcolor = obj.style.color;
	
	obj.style.backgroundColor = bgcolor;
	obj.style.color = fontcolor;
}

function changDateColorOut(obj){
	obj.style.backgroundColor = dateoldbgcolor;
	obj.style.color = dateoldcolor;
	
}

function validinput(obj){
	if(obj == null ||obj == "undefined" || obj == undefined){
		return false;
	}
	return true;
}

function changecode(obj){
	obj.src = Sys.getProjectPath()+"/validcode.do?t="+Math.random();
}


function getById(id){
	return document.getElementById(id);
}
//删除左右两端的空格   
function trim(str){   
 return str.replace(/(^\s*)|(\s*$)/g, "");
}   
//删除左边的空格   
function ltrim(str){   
 return str.replace(/(^\s*)/g,"");   
}   
//删除右边的空格   
function rtrim(str){   
 return str.replace(/(\s*$)/g,"");   
}

//验证text radio select checkbox 是否为空
function validvalue(requtid){
	var lb =document.getElementById(requtid);
	var ips = document.getElementsByTagName("input");
	var sels = document.getElementsByTagName("select");
	var tas = document.getElementsByTagName("textarea");
	for(var b=0;b<sels.length;b++){
		if(sels[b].options.length==0){
			var warn = "注意：请确保下拉列表已经初始化!";
			alert(warn);
			lb.innerHTML = "<font color=\"#19437E\">"+warn+"</font>";
			sels[b].focus();
			return false;
		}
	}
	
	//input
	for(var c=0;c<ips.length;c++){
		var cln = ips[c].className;
		if(cln=="numform" || cln == "rmbform"){
			var vl = ips[c].value;
			if(vl!=null&&trim(vl).length>0){
				if(!checkIsNumber(vl)){
					var warn = "注意：数字框只能输入数字!";
					alert(warn);
					lb.innerHTML = "<font color=\"#19437E\">"+warn+"</font>";
					ips[c].focus();
					return false;
				}
			}
		}
	}
	
	for(var a=0;a<ips.length;a++){
		var type = ips[a].type;
		var ms = ips[a].getAttribute("must");
		var msTitle = ips[a].getAttribute("formust");
		if(msTitle != null && msTitle!="" && trim(msTitle).length>0){
			lb = document.getElementById(msTitle);
		}
		if(ms!=null&&ms.length>0){
			if(type=="text" || type == "password"){
				var vl = ips[a].value;
				if(vl==""||trim(vl).length==0){
					lb.innerHTML = "<img src=\""+Sys.getProjectPath()+"/images/grid_images/rowdel.png\">&nbsp;<font color=\"red\">" + ms + "</font>";
					ips[a].focus();
				
					return false;
				}else{
					lb.innerHTML="";
				}
			}
			if(type=="radio"){
				var rn = ips[a].name;
				if(getRadioValueByName(rn)==null){
					lb.innerHTML = ms;
					ips[a].focus();
				
					return false;
				}else{
					lb.innerHTML="";
				}
			}
			if(type=="checkbox"){
				var rn = ips[a].name;
				if(getCheckedCount(rn)==0){
					lb.innerHTML = ms;
					ips[a].focus();
				
					return false;
				}else{
					lb.innerHTML="";
				}
			}
		}
	}
	
	//select
	for(var b=0;b<sels.length;b++){
		var ms = sels[b].getAttribute("must");
		var msTitle = sels[b].getAttribute("formust");
		if(msTitle != null && msTitle!="" && trim(msTitle).length>0){
			lb = document.getElementById(msTitle);
		}
		if(ms!=null&&ms.length>0){
			if(sels[b].value == null||sels[b].value==-1){
				lb.innerHTML = ms;
				sels[b].focus();
			
				return false;
			}else{
				lb.innerHTML="";
			}
		}
	}
	
	//textarea
	for(var a=0;a<tas.length;a++){
		var ms = tas[a].getAttribute("must");
		var msTitle = tas[a].getAttribute("formust");
		if(msTitle != null && msTitle!="" && trim(msTitle).length>0){
			lb = document.getElementById(msTitle);
		}
		if(ms!=null&&ms.length>0){
			var vl = tas[a].value;
			if(vl==""||trim(vl).length==0){
				lb.innerHTML = "<img src=\""+Sys.getProjectPath()+"/images/grid_images/rowdel.png\">&nbsp;<font color=\"red\">" + ms + "</font>";
				tas[a].focus();
			
				return false;
			}else{
				lb.innerHTML="";
			}
		}
	}
	
	return true;
}

//设置提示
function setMustWarn(id,mustTitle){
	document.getElementById(id).innerHTML = "<img src=\""+Sys.getProjectPath()+"/images/grid_images/rowdel.png\">&nbsp;<font color=\"red\">"+mustTitle+"</font>";
}

function setMustWarnByObj(obj,mustTitle){
	obj.innerHTML = "<img src=\""+Sys.getProjectPath()+"/images/grid_images/rowdel.png\">&nbsp;<font color=\"red\">"+mustTitle+"</font>";
}

//可选项提示初始化
function warnInit(chooseArr){
	for(var i = 0 ;i < chooseArr.length;i++){
		document.getElementById(chooseArr[i]).innerHTML = "";
	}
}

//可选项提示
function chooseWarn(chooseArr){
	for(var i = 0 ;i < chooseArr.length;i++){
		document.getElementById(chooseArr[i]).innerHTML = "<img src='"+Sys.getProjectPath()+"/images/fileclear.png' width='13px'>&nbsp;阅读范围部门和人员至少要有一项。";
	}
}

 function getContextPath(){
	var path = self.location+"";
	var psp =path.split("/"); 
	var contextPath = psp[0]+"/"+psp[1]+"/"+psp[2]+"/"+psp[3]+"/"+psp[4];
	return contextPath;
}
//重写outerHTML方法
if (typeof (HTMLElement) != "undefined" && !window.opera) {
	HTMLElement.prototype.__defineGetter__("outerHTML", function () {
		var a = this.attributes, str = "<" + this.tagName, i = 0;
		for (; i < a.length; i++) {
			if (a[i].specified) {
				str += "   " + a[i].name + "=\"" + a[i].value + "\"";
			}
		}
		if (!this.canHaveChildren) {
			return str + "   />";
		}
		return str + ">" + this.innerHTML + "</" + this.tagName + ">";
	});
	HTMLElement.prototype.__defineSetter__("outerHTML", function (s) {
		var d = document.createElement("DIV");
		d.innerHTML = s;
		for (var i = 0; i < d.childNodes.length; i++) {
			this.parentNode.insertBefore(d.childNodes[i], this);
		}
		this.parentNode.removeChild(this);
	});
	HTMLElement.prototype.__defineGetter__("canHaveChildren", function () {
		return !/^(area|base|basefont|col|frame|hr|img|br|input|isindex|link|meta|param)$/.test(this.tagName.toLowerCase());
	});
}

function getCurrentDate(){
	var now = new Date();
	  var year = now.getYear();
	  if(navigator.userAgent.indexOf("Firefox")>0){
	  	year+=1900;
	  }
	  var month = now.getMonth() + 1;
	  var date = now.getDate();
	  var timeValue = "";
	  timeValue += year + "-";
	  timeValue += ((month < 10) ? "0" : "") + month + "-";
	  timeValue += ((date < 10) ? "0" : "") + date;
	  return timeValue;
}
function getFullCurrentDate(){
	var now = new Date();
	  var year = now.getYear();
	  if(navigator.userAgent.indexOf("Firefox")>0){
	  	year+=1900;
	  }
	  var month = now.getMonth() + 1;
	  var date = now.getDate();
	  var minutes = now.getMinutes();
   	  var second = now.getSeconds();
   	  var hour = now.getHours();
	  var timeValue = "";
	  timeValue += year + "-";
	  timeValue += ((month < 10) ? "0" : "") + month + "-";
	  timeValue += ((date < 10) ? "0" : "") + date+" ";
	  timeValue += ((hour < 10) ? "0" : "") + hour+":";
	  timeValue += ((minutes < 10) ? "0" : "") + minutes+":";
	  timeValue += ((second < 10) ? "0" : "") + second;
	  return timeValue;
}
function getFullDate(){
	var now = new Date();
	  var year = now.getYear();
	  if(navigator.userAgent.indexOf("Firefox")>0){
	  	year+=1900;
	  }
	  var month = now.getMonth() + 1;
	  var date = now.getDate();
	  var hour = now.getHours();
   	  var minutes = now.getMinutes();
   	  var second = now.getSeconds();
   	  var mill = now.getMilliseconds();
	  var timeValue = "";
	  timeValue += year;
	  timeValue += ((month < 10) ? "0" : "") + month;
	  timeValue += ((date < 10) ? "0" : "") + date;
	  timeValue += ((hour < 10) ? "0" : "") + hour;
	  timeValue += ((minutes < 10) ? "0" : "") + minutes;
	  timeValue += ((second < 10) ? "0" : "") + second;
	  timeValue += ((mill < 10) ? "0" : "") + mill;
	  return timeValue;
}

function setSelectOption(selectid,data){
	var selectObj = document.getElementById(selectid);
	if(selectObj!=null){
		selectObj.options.length=0;
	}
	var rlen = data.resultList.length;
	for ( var i = 0; i < rlen; i++) {
		var name = data.resultList[i].name;
		var pid = data.resultList[i].id;
		var option = new Option(name,pid);
		option.setAttribute("title",name);
		selectObj.options.add(option);
	}
}

function setRadioOption(radioid,data){
	var radioObj = document.getElementById(radioid);

	var rlen = data.resultList.length;
	var radioText = "";
	var radioName = radioid+"Radio";
	for ( var i = 0; i < rlen; i++) {
		var name = data.resultList[i].name;
		var pid = data.resultList[i].id;

		var radioIndex = radioName+i;
		if(pid != "-1"){
			radioText += "<input type='radio' name='"+radioName+"' id='"+radioIndex+"' value='"+pid+"'/><label for='"+radioIndex+"'>"+name+"</label>&nbsp;&nbsp;&nbsp;&nbsp;";
		}
	}
	
	radioObj.innerHTML = radioText;
}

function setList(obj,data){
	obj.options.length=0;
	var rlen = data.resultList.length;
	for ( var i = 0; i < rlen; i++) {
		var name = data.resultList[i].name;
		var pid = data.resultList[i].id;
		var optionItem=new Option(name,pid);
		obj.options.add(optionItem);
	}
}

function selectAll(obj,checkname) {
	var flag = obj.checked;
	var checks = document.getElementsByName(checkname);
	for ( var i = 0; i < checks.length; i++) {
		checks[i].checked = flag;
	}
	
}
function selectAllTree(flag,checkname) {
	var checks = document.getElementsByName(checkname);
	for ( var i = 0; i < checks.length; i++) {
		checks[i].checked = flag;
	}
}

function controlCheckBox(obj,checkname) {
	var checks = document.getElementsByName(checkname);
	for ( var i = 0; i < checks.length; i++) {
		checks[i].checked = obj;
	}
}
function getCheckCount(checkname){
	var count = 0;
	var Areas = document.getElementsByName(checkname);
	if(Areas!=null){
		count=Areas.length;
	}
	return count;
}
/**
 * 根据表格绑定checkbox名称得到选择数量
 * @param checkboxname
 * @return count
 * */
function getCheckedCount(checkname) {
	var count = 0;
	var Areas = document.getElementsByName(checkname);
	for ( var i = 0; i < Areas.length; i++) {
		if (Areas[i].checked == true) {
			count++;
		}
	}
	return count;
}
/**
 * 根据表格绑定checkbox名称得到选择values
 * @param checkboxname
 * @return values
 * */
function getCheckedValues(checkname){
	var val=new Array();
	var checks = document.getElementsByName(checkname);
	var a=0;
	for ( var i = 0; i < checks.length; i++) {
		if (checks[i].checked == true) {
			val[a]=checks[i].value;
			a++;
		}
	}
	return val;
}
/**
 * 根据checkbox名称得到所有values
 * @param checkboxname
 * @return values
 * */
function getCheckBoxValues(checkname){
	var val=new Array();
	var checks = document.getElementsByName(checkname);
	for ( var i = 0; i < checks.length; i++) {
		val[i]=checks[i].value;
	}
	return val;
}

/**
 * 得到父窗体所有checkvalues
 * **/
function getParentCheckedValues(checkname){
	var val=new Array();
	var checks = parent.document.getElementsByName(checkname);
	var a=0;
	for ( var i = 0; i < checks.length; i++) {
		if (checks[i].checked == true) {
			val[a]=checks[i].value;
			a++;
		}
	}
	return val;
}
/**
 * 得到父窗体文本框值
 * */
function getParentTextValue(txtid){
	if(parent.document.getElementById(txtid)==null){
		return "no";
	}
	return parent.document.getElementById(txtid).value;
}
function getCheckedValuesByObj(obj){
	var val=new Array();
	var a=0;
	for ( var i = 0; i < obj.length; i++) {
		if (obj[i].checked == true) {
			val[a]=obj[i].value;
			a++;
		}
	}
	return val;
}
function listmove(selectfrom,selectto){
    var list1 = document.getElementById(selectfrom);
    var list2 = document.getElementById(selectto);
    var list2length = list2.length;
	var sel	= list1.selectedIndex;
	if (sel!=-1){
	     var b=0;
	     var indexarr = new Array();
	     for (var a=0;a<list1.length;a++){
	     if (list1.options[a].selected){
	             list2length = list2.length;
	             list2.options[list2length] = new Option(list1.options[a].text,list1.options[a].value);
	             indexarr[b]= a;
	             b++;
	       }
	     }
	     for (var c=0;c<b;c++){
	    	 list1.options[indexarr[c]-c] = null;
	     }
	}else{
		alert ("请选择要移动的内容！");
	}
}
function getSelectListBack(obj){
	var val=new Array();
	var a=0;
	for ( var i = 0; i < obj.options.length; i++) {
			val[a]=obj.options[i].value;
			a++;
	}
	return val;
}

/**
 * 根据value设置下拉框选中值
 * */
function setSelectValue(selectid,datavalue){
	var option=document.getElementById(selectid).options;
	var index=0;
	for(var i=0;i<option.length;i++){
		if(option[i].value==datavalue){
			index=i;
		}
	}
	document.getElementById(selectid).selectedIndex = index;
}


function getCheckBox(index,name){
	var checkBoxs = document.getElementsByName(name);
	if(checkBoxs[index].checked == true){
		checkBoxs[index].checked = false;
	}else{
		checkBoxs[index].checked = true;
	}
}

/*点击tr，选中checkbox*/
function clickCheckBox(id){
	var checkBoxs = document.getElementById(id);
	if(checkBoxs.checked == true){
		checkBoxs.checked = false;
	}else{
		checkBoxs.checked = true;
	}
}

//判断所有的select是否初始化完成，true为完成
function checkSelectInit(selectArray){
	for(var i = 0 ;i<selectArray.length;i++){
		if(document.getElementById(selectArray[i]) == null){
			return false;
		}
	}
	
	return true;
}

function browserFunction(){
	if (window.navigator.userAgent.indexOf("MSIE")>=1){
		//如果浏览器为IE
		return true;
	}else if (window.navigator.userAgent.indexOf("Firefox")>=1){
		return false;
	}else{
		return false;
	}
}

function ExceptionHandler(exception){
	alert('操作错误');
	//ymPrompt.errorInfo(exception,null,null,'操作错误',null);
}

//判断是否为数字  可以为负数 小数
function checkIsNumber(val){
	var re = /^-?[0-9]+.?[0-9]*$/;
	if (!re.test(val)){
	   return false;
	}
	return true;
}

//判断是否为正整数
function checkIsNumberInt(val){
	var re = /^[1-9]+[0-9]*]*$/;
	if (!re.test(val)){
	   return false;
	}
	return true;
}

//获取radio的值
function getRadioValueByName(RadioName){
    var obj;    
    obj=document.getElementsByName(RadioName);
    if(obj!=null){
        var i;
        for(i=0;i<obj.length;i++){
            if(obj[i].checked){
                return obj[i].value;            
            }
        }
    }
    return null;
}

//set radio的值
function setRadioValueByName(RadioName,value){
    var obj;    
    obj=document.getElementsByName(RadioName);
    if(obj!=null){
        var i;
        for(i=0;i<obj.length;i++){
            if(obj[i].value == value){    
                obj[i].checked = true; 
            }else{
               obj[i].checked = false;  
            }
        }
    }
}

//获取checkbox的值
function getCheckboxValueByName(CheckboxName){
	var strnums = "";
    var obj=document.getElementsByName(CheckboxName);
    if(obj!=null){
        for(var i=0;i<obj.length;i++){
            if(obj[i].checked){
                strnums+=obj[i].value+"|";;            
            }
        }
    }
    return strnums.substring(0,strnums.length-1);
}

//set checkbox的值
function setCheckboxValueByName(CheckboxName,value){
	var values = new Array();
	if(value != null && value != ""){
		values = value.split("|");
	}
    var obj =document.getElementsByName(CheckboxName);
    if(obj!=null && values.length > 0){
        for(var i=0;i<obj.length;i++){
			for(var j=0;j<values.length;j++){
			   if(obj[i].value == values[j]){
	                obj[i].checked = true; 
	            }
			}
		}
    }
}


/***
 * 格式化数据显示
 * 
 * @param 数字
 * @param 小数位数
 * 
 * **/
function FormatNumber(srcStr,nAfterDot)        //nAfterDot小数位数
{
   var srcStr,nAfterDot;
   var resultStr,nTen;
   srcStr = ""+srcStr+"";
   strLen = srcStr.length;
   dotPos = srcStr.indexOf(".",0);
   if (dotPos == -1){
     resultStr = srcStr+".";
     for (i=0;i<nAfterDot;i++){
       resultStr = resultStr+"0";
     }
     return resultStr;
   }
   else{
     if ((strLen - dotPos - 1) >= nAfterDot){
       nAfter = dotPos + nAfterDot + 1;
       nTen =1;
       for(j=0;j<nAfterDot;j++){
　        nTen = nTen*10;
       }
       resultStr = Math.round(parseFloat(srcStr)*nTen)/nTen;
       return resultStr;
     }
     else{
       resultStr = srcStr;
       for (i=0;i<(nAfterDot - strLen + dotPos + 1);i++){
　        resultStr = resultStr+"0";
       }
       return resultStr;
     }
   }
 } 
 
function fmoney(s, n){//将数字转换成逗号分隔的样式,保留两位小数s:value,n:小数位数
	if(s == null || s == undefined){
		return 0;
	}
	
	var tmp = s.toString().toLowerCase();
   	if(tmp.length>0&&tmp.indexOf('e')>0){
   		return tmp;
   	}
    s = parseFloat(s).toFixed(12);
    s = parseFloat(s);
    
    if(s<=0){
    	return s;
    }
    
    if(n>0){
    	n = n > 0 && n <= 20 ? n : 2;
    	s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";   
    }else{
    	s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toString();   
    }
    var l = s.split(".")[0].split("").reverse();
    var len = s.split(".").length;
    var r="";
    if(len>1){
    	r = s.split(".")[1];
    }
    t = "";   
    for(i = 0; i < l.length; i ++ ){   
   		t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");   
    }
    if(len>1){
    	return t.split("").reverse().join("") + "." + r;   
    }else{
    	return t.split("").reverse().join("");
    }
    
} 

function forPackMoney(price,point){
	return "<font color='blue'>￥"+fmoney(price,point)+"</font>";
}

function forPackMoneyColor(price,point,color){
	return "<font color='"+color+"'>￥"+fmoney(price,point)+"</font>";
}

function forPackNumberColor(num,point,color,unit){
	if(color == null){
		color = "blue";
	}
	if(unit == null){
		unit = "";
	}
	return "<font color='"+color+"'>"+fmoney(num,point)+"</font> " + unit;
}

function showQueryInfo(id,text){
	document.getElementById(id).innerHTML=text;
}
function showQueryInfo(id,text){
	document.getElementById(id).innerHTML=text;
}



// 1.判断select选项中是否存在Value="paraValue"的Item       
function jsSelectIsExitItem(objSelect, objItemValue) {       
    var isExit = false;       
    for (var i = 0; i < objSelect.options.length; i++) {       
        if (objSelect.options[i].value == objItemValue) {       
            isExit = true;       
            break;       
        }       
    }       
    return isExit;       
}        
  
// 2.向select选项中加入一个Item       
function jsAddItemToSelect(objSelect, objItemText, objItemValue) {       
    //判断是否存在       
    if (jsSelectIsExitItem(objSelect, objItemValue)) {       
        alert("该Item的Value值已经存在");       
    } else {       
        var varItem = new Option(objItemText, objItemValue);     
        objSelect.options.add(varItem);    
        alert("成功加入");    
    }       
}       
  
// 3.从select选项中删除一个Item       
function jsRemoveItemFromSelect(objSelect, objItemValue) {       
    //判断是否存在       
    if (jsSelectIsExitItem(objSelect, objItemValue)) {       
        for (var i = 0; i < objSelect.options.length; i++) {       
            if (objSelect.options[i].value == objItemValue) {       
                objSelect.options.remove(i);       
                break;       
            }       
        }       
        alert("成功删除");       
    } else {       
        alert("该select中不存在该项");       
    }       
}   
  
  
// 4.删除select中选中的项   
function jsRemoveSelectedItemFromSelect(objSelect) {       
    var length = objSelect.options.length - 1;   
    for(var i = length; i >= 0; i--){   
        if(objSelect[i].selected == true){   
            objSelect.options[i] = null;   
        }   
    }   
}     
  
// 5.修改select选项中 value="paraValue"的text为"paraText"       
function jsUpdateItemToSelect(objSelect, objItemText, objItemValue) {       
    //判断是否存在       
    if (jsSelectIsExitItem(objSelect, objItemValue)) {       
        for (var i = 0; i < objSelect.options.length; i++) {       
            if (objSelect.options[i].value == objItemValue) {       
                objSelect.options[i].text = objItemText;       
                break;       
            }       
        }       
        alert("成功修改");       
    } else {       
        alert("该select中不存在该项");       
    }       
}       
  
// 6.设置select中text="paraText"的第一个Item为选中       
function jsSelectItemByValue(objSelect, objItemText) {           
    //判断是否存在       
    var isExit = false;       
    for (var i = 0; i < objSelect.options.length; i++) {       
        if (objSelect.options[i].text == objItemText) {       
            objSelect.options[i].selected = true;       
            isExit = true;       
            break;       
        }       
    }             
    //Show出结果       
    if (isExit) {       
        alert("成功选中");       
    } else {       
        alert("该select中不存在该项");       
    }       
}       

/**
function   document.oncontextmenu(){event.returnValue=false;}//屏蔽鼠标右键   
*/   
//function   window.onhelp(){return  false}   //屏蔽F1帮助
function loadKeycode(){
   document.onkeydown = keyListener;
}

function keyListener(){
	var keycode;
	if(window.event) {
		keycode  = window.event.keyCode;
	}
	
  //屏蔽 ctrl + W 关闭当前页面
  if((window.event.ctrlKey)&&(keycode==87)){
  	window.event.returnValue=false; //表示按后不出现W字符，不然在text内会自动加上W
  }
  
  keyListenerCallback(keycode);
}
/*
function keyListenerCallback(keycode){
  //回车
  if(keycode == 13){
  }
  //ESC
  if(keycode == 27){
  }
  //ctrl + S
  if((window.event.ctrlKey)&&(keycode==83)){
  	window.event.returnValue=false; 
  }
  //ctrl + N
  if((window.event.ctrlKey)&&(keycode==78)){
  	window.event.returnValue=false; 
  }
  //ctrl + E
  if((window.event.ctrlKey)&&(keycode==69)){
  	window.event.returnValue=false; 
  }
  //ctrl + F
  if((window.event.ctrlKey)&&(keycode==70)){
  	window.event.returnValue=false; 
  }
  //ctrl + O
  if((window.event.ctrlKey)&&(keycode==79)){
  	window.event.returnValue=false; 
  }
}*/

//给tr设置orderby顺序，默认为10列
var orderByArray = new Array();
for(var i=0;i<10;i++){
	orderByArray[i] = 0;
}

//清除箭头
function clearArrow(num){
	for(var i=1;i<=num;i++){
		document.getElementById("arrow"+i).innerHTML = "";
	}
}

/*用来使table的第一列具有排序功能
*name为字段名称
*num为当前第几个字段
*param为隐藏表单域，用来往后台传order by的值
*fun为点击后调用的查询方法
*arrowNum为总共列数，用来清除其他不用的箭头
*/
function orderByHelper(name,num,param,fun,arrowNum){	
	//清除其他箭头
	clearArrow(arrowNum);
		
	if(orderByArray[num] == 0){
		DWRUtil.setValue(param,name);
		document.getElementById("arrow"+num).innerHTML = "&nbsp;<img src='"+Sys.getProjectPath()+"/images/arrow_up.gif'/>";
		orderByArray[num] = 1;
	}else{
		DWRUtil.setValue(param,name+" desc");
		document.getElementById("arrow"+num).innerHTML = "&nbsp;<img src='"+Sys.getProjectPath()+"/images/arrow_down.gif'/>";
		orderByArray[num] = 0;
	}
	eval(fun);
}
	
// 7.设置select中value="paraValue"的Item为选中   
//document.all.objSelect.value = objItemValue;   
      
// 8.得到select的当前选中项的value   
//var currSelectValue = document.all.objSelect.value;   
      
// 9.得到select的当前选中项的text   
//var currSelectText = document.all.objSelect.options[document.all.objSelect.selectedIndex].text;   
      
// 10.得到select的当前选中项的Index   
//var currSelectIndex = document.all.objSelect.selectedIndex;   
      
// 11.清空select的项   
//document.all.objSelect.options.length = 0;  


function nocontextmenu() {
 event.cancelBubble = true;
 event.returnValue = false;
 
 return false;
}
 
function norightclick(e) {

  if (event.button == 2 || event.button == 3)
  {
   event.cancelBubble = true;
   event.returnValue = false;
   return false;
  }
}

function getReportMessages(){
  var msg = "?";
  msg += "PBarLoadingText=加载图标.&";
  msg += "XMLLoadingText=正在载入数据.&";
  msg += "ParsingDataText=正在初始化数据.&";
  msg += "ChartNoDataText=没有相关数据.&";
  msg += "RenderingChartText=正在加载报表数据.&"; 
  msg += "LoadDataErrorText=数据加载错误,请重试.&";
  msg += "InvalidXMLText=数据错误,请重试.&";
  
  return msg;
}


//弹出会话框，用于多页面弹出操作
function modelesswin(url,wid,hei){
	if (document.all&&window.print){
		eval('window.showModelessDialog(url,window,"help:0;edge:sunken;resizable:1;dialogWidth:'+wid+'px;dialogHeight:'+hei+'px")');
	}else{
		var iTop = (window.screen.availHeight-30-hei)/2;         //获得窗口的水平位置
    	var iLeft = (window.screen.availWidth-10-wid)/2;      //获得窗口的高度位置
		eval('window.open(url,"","width='+wid+'px,height='+hei+'px,top='+iTop+',left='+iLeft+',toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no,status=no,alwaysRaised=yes,depended=yes")');
	}
}

//弹出会话框，用于多页面弹出操作，确认大小
function modelesswin(url,type){
	var wid;//子屏幕宽度
	var hei;//子屏幕高度
	
	if(type == 1){
		//小屏
		wid = screen.width * 0.5;
		hei = screen.height * 0.4;	
	}else if(type == 1){
		//中屏
		wid = screen.width * 0.6;	
		hei = screen.height * 0.5;	
	}else{
		//大屏
		wid = screen.width * 0.7;	
		hei = screen.height * 0.6;	
	}
	
	if (document.all&&window.print){
		eval('window.showModelessDialog(url,window,"help:0;edge:sunken;resizable:1;dialogWidth:'+wid+'px;dialogHeight:'+hei+'px")');
	}else{
		var iTop = (window.screen.availHeight-30-hei)/2;         //获得窗口的水平位置
    	var iLeft = (window.screen.availWidth-10-wid)/2;      //获得窗口的高度位置
		eval('window.open(url,"","width='+wid+'px,height='+hei+'px,top='+iTop+',left='+iLeft+',toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no,status=no,alwaysRaised=yes,depended=yes")');
	}
}

// 判断是否中文函数 true表示有汉字
function isChinese(s){ 
	var ret = false; 
	
	for(var i=0;i<s.length;i++) {
		if(s.charCodeAt(i)>=10000){
			ret = true;
		}
	} 
	
	return ret; 
}


function closeMDITab(win){
	win.MDIClose();
}

function openMDITab(win,url){
	win.MDIOpen(url);
}

//显示、隐藏明细
function showSliderDetail(obj,divid){
	if(document.getElementById(divid).style.display == "" || document.getElementById(divid).style.display == "block"){
		$("#"+divid).animate({height: 'hide',   opacity: 'hide'  }, 'slow');
		obj.src = Sys.getProjectPath()+"/images/scroll_down.gif";
	}else{
		$("#"+divid).animate({height: 'show',opacity: 'show'  }, 'slow');
		obj.src = Sys.getProjectPath()+"/images/scroll_up.gif";
	}
}

//提供比较精确的js四则运算
//说明：javascript的四则运算结果会有误差，在两个浮点数四则运算的时候会比较明显。以下函数返回较为精确的运算结果。
//加法
function accAdd(arg1,arg2){
	var r1,r2,m;
	try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
	m=Math.pow(10,Math.max(r1,r2));
	return (arg1*m+arg2*m)/m;
}
//减法
function Subtr(arg1,arg2){
     var r1,r2,m,n;
     try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
     try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
     m=Math.pow(10,Math.max(r1,r2));
     //last modify by deeka
     //动态控制精度长度
     n=(r1>=r2)?r1:r2;
     return ((arg1*m-arg2*m)/m).toFixed(n);
}
//乘法
function accMul(arg1,arg2){
	var m=0,s1=arg1.toString(),s2=arg2.toString();
	try{m+=s1.split(".")[1].length}catch(e){}
	try{m+=s2.split(".")[1].length}catch(e){}
	return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);
}
//除法(arg1除以arg2的精确结果)
function accDiv(arg1,arg2){
	var t1=0,t2=0,r1,r2;
	try{t1=arg1.toString().split(".")[1].length}catch(e){}
	try{t2=arg2.toString().split(".")[1].length}catch(e){}
	with(Math){
		r1=Number(arg1.toString().replace(".",""));
		r2=Number(arg2.toString().replace(".",""));
		return (r1/r2)*pow(10,t2-t1); 
	}
} 
