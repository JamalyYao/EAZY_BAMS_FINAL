/**页面与后台交互js**/
var getwinsize = function(par) {
	if(par == null ||par == "undefined" || par == undefined){
		par = window.parent;
	}
	return [par.document.body.clientWidth, par.document.body.clientHeight];
};
var Sys = {
	frmname:"mainframe",
	projectcode:"00",
	projectPath:"/",
	
	getMDIFrame:function(id){
		return window.parent.parent.getMDIFrame(id);
	},
	closeMDITab:function(){
		return closeMDITab(window.parent.parent);
	},
	getWindow:function(){
		return window.parent.parent.getNowWindow();
	},
	MDIOpen:function(url){
		window.parent.parent.MDIOpen(url);
	},
	MDIOpen2:function(url){
		window.parent.parent.parent.MDIOpen(url);
	},
	isNotBlank:function(obj){
		if(obj != null && obj != "" && obj != "undefined" && obj != undefined)
			return true;
		else
			return false;
	},
	isBlank:function(obj){
		if(obj == null || obj == "" || obj == "undefined" || obj == undefined)
			return true;
		else
			return false;
	},
	setFrmname:function(fname){
		this.frmname = fname;
	},
	setProjectcode:function(code){
		this.projectcode = code;
	},
	getProjectcode:function(){
		return this.projectcode;
	},
	setProjectPath:function(path){
		this.projectPath = path;
	},
	getProjectPath:function(){
		return this.projectPath;
	},
	setcurrent:function(data){
		var obj = document.getElementById("currenthref");
		if(obj == null ||obj == "undefined" || obj == undefined){
			obj = window.parent.document.getElementById("currenthref");
		}
		var tmp ="&nbsp;=>";
		if(data!=null&&data.length > 0){
			for (var i = 0; i < data.length; i++) {
				var me = data[i];
				var clickstr ="";
				var pk =me.primaryKey;
				var url = me.methodUri;
				var sname = me.methodInfoName;
				if(url!=null&&url.length>0){
					clickstr = "onclick =\"Sys.open('"+pk+"','"+url+"');\"";
				}
				tmp += "&nbsp;<a href=\"javascript:void(0);\" "+clickstr+" style='color:#005790;font-family: Helvetica;'>"+sname+"</a>&nbsp;=>";
			}
		}
		if(tmp.length>0){
			tmp =tmp.substring(0,tmp.length-1);
		}
		obj.innerHTML = tmp;
	},
	load:function(url,fname){
		//var win = parent.parent.parent.getMDI();
		if(fname == null||fname == "undefined" || fname == undefined){
			//fname=this.frmname;
			fname = parent.parent.parent.parent.getNowWindowFrame()
		}
		var fm = window.document.getElementById(fname);
		
		if(fm == null ||fm == "undefined" || fm == undefined){
			fm = window.parent.document.getElementById(fname);
		}
		
		fm.src = url;
	},
	reload:function(){
		window.location.reload();
	},
	href:function(url){
		window.setTimeout("window.location.href='"+url+"'",0);
	},
	getfrm:function(fname,par){
		var win = parent.getMDI();
		return win;
	},
	open:function(code,url){
		/*
		var cu = document.getElementById("currentCode");
		if(cu == null ||cu == "undefined" || cu == undefined){
			cu = window.parent.document.getElementById("currentCode");
		}
		if(cu==null||cu.value == code){
			return;
		}else{
			cu.value = code;
		}
		*/
		var fm =document.getElementById(this.frmname);
		if(fm == null ||fm == "undefined" || fm == undefined){
			fm =window.parent.document.getElementById(this.frmname);
		}
		fm.src = url;
		if(code == this.projectcode){
			var obj = document.getElementById("currenthref");
			if(obj == null ||obj == "undefined" || obj == undefined){
				obj = window.parent.document.getElementById("currenthref");
			}
			obj.innerHTML ="";
			return;
		}
		//加载当前位置
		dwrCommonService.saveMethodLog(code);//写入日志
		dwrCommonService.getMethodInfoListByCode(code,Sys.setcurrent);
	},
	
	//重新封装的弹出窗口
	msgbox:function(tit,uri,wh,hh,par){
		var dialogId = uri.substring(uri.length-8,uri.length);//取uri后8位作为ID
		var wid_heig=getwinsize(par);
		var bl =false;
		if(wh == null || (wid_heig[0]>0 && wid_heig[0]<=wh)){
			wh =wid_heig[0]-50;
			bl = true;
		}
		if(hh==null||(wid_heig[1]>0 && wid_heig[1]<=hh)){
			hh= wid_heig[1]-50;
			bl=true;
		}
		this.max = bl;
		this.tit = tit;
		this.uri = uri;
		this.width = wh;
		this.height = hh;
		this.msgtitle = "";
		this.buttons = null;
		this.par = par;
		this.dialogId = dialogId;
	},
	//关闭弹出窗体
	close:function(dialogId){
		window.parent.art.dialog({id:dialogId}).close();
	},
	alert:function(msg,event){
		window.alert(msg);
		var str='ok';
		if(event!=null){
			return new Function(event(str));
		}
	},
	//封装confirm函数
	confirm:function(msg,event){
		var result = window.confirm(msg);
		var str="";
		if(result == true){
			str='ok';
		}
		if(event!=null){
			return new Function(event(str));
		}
	},
	setFilevalue:function(acceptid,vl,frmid){
		if(document.getElementById(acceptid)!=null){
			document.getElementById(acceptid).value = vl;
			if(frmid==null||frmid == "undefined" || frmid == undefined ||frmid.length==0){
				frmid= acceptid+"__SysFrm";
				if(document.getElementById(frmid)!=null){
					window.setTimeout("document.getElementById('"+frmid+"').src = document.getElementById('"+frmid+"').src",0);
				}
			}
		}
	},
	setdownloadvalue:function(data,sid,bs){
		var str="";
		
		str += "<div style='display:none;' id='attachMenu'>"+
				  "<ul>"+
				  	"<li id='download'><img src='"+Sys.getProjectPath()+"/images/icons/download.gif'/> 下载</li>"+
			        "<li id='read'><img src='"+Sys.getProjectPath()+"/images/icons/contacts_shared.png'/> 在线阅读</li>"+
			      "</ul>"+
			   "</div>";
		
		var c =0 ;
		if(data!=null&&data.length>0){
			for(var i=0;i<data.length;i++){
			    var fileName = (data[i].attachmentName.substr(data[i].attachmentName.length -5)).substr((data[i].attachmentName.substr(data[i].attachmentName.length -5)).indexOf('.')+1).toLowerCase();
			    var imgSrc = "<img src='"+Sys.getProjectPath()+"/images/filetype/"+fileName+".gif' onerror=\"javascript:this.src='"+Sys.getProjectPath()+"/images/filetype/unknown.gif'\" border='0'/>";
			
				str+="<a id='"+data[i].primaryKey+"' title='"+data[i].attachmentName+"' class='attachName' style='line-height:24px;color:#044577;' href='javascript:void(0);'>" + imgSrc + "&nbsp;" + data[i].attachmentName+"</a>&nbsp;&nbsp;&nbsp;&nbsp;";
				
				c++;
				if(bs=="no"){
					str+="<br/>";
				}else if((bs!="no"&&c%bs==0)){
					str+="<br/>";
				}
			}
		}
		
		if(str.length==0){
			str ="<无附件>";
		}
		document.getElementById(sid).innerHTML = str;
		
		$('a.attachName').contextMenu('attachMenu',{
			allowLeft:true,
		    bindings: {
		    	'read': function(t) {
		    		if(isOffice(t.title))
		    			window.open(Sys.getProjectPath()+"/erp/show_office.jsp?fileId="+t.id);
		    		else
		    			alert("暂不支持");
		    	},
				'download': function(t) {
					location.href = Sys.getProjectPath()+"/download.do?fileId="+t.id;
				}
		    }
		});
	},
	//显示下载
	showDownload:function(ids,showobj,count){
		
		if(count==null || count==undefined || count== "undefined" || count.length ==0){
			count="no";
		}
		if(document.getElementById(showobj)==null){
			document.write("请定义下载接收对象id!");
			return;
		}
		if(ids!=null && ids!=undefined && ids!= "undefined" && ids.length>0){
			dwrCommonService.getAttachmentInfoList(ids,function(data){
				Sys.setdownloadvalue(data,showobj,count);
			});
		}else{
			document.getElementById(showobj).innerHTML = "<无附件>";
		}
	},
	setNamesEmpOrDept:function(data,bl,nobj){
		var str="";
		var tmp =",";
		if(bl==false){
			tmp="&nbsp;&nbsp;";
		}
		if(data!=null&&data.length>0){
			for(var i=0;i<data.length;i++){
				str+=data[i]+tmp;
			}
		}
		if(bl){
			document.getElementById(nobj).value = str;
		}else{
			document.getElementById(nobj).innerHTML = str;
		}
	},
	//显示人员
	showEmpNames:function(ids,nameobj,idobj){
		var bl = false;
		if(ids==null||ids.length==0){
			return;
		}
		if(nameobj==null||nameobj.length==0||document.getElementById(nameobj)==null ){
			document.write("请定义下载接收对象id!");
			return;
		}
		if(idobj!=null&&idobj!=undefined && idobj!= "undefined"&& idobj.length > 0){
			var objids = document.getElementById(idobj)
			if(objids==null||objids == undefined || objids =="undefined"){
				return;
			}else{
				objids.value = ids;
			}
			bl = true;
		}
		dwrCommonService.getHrmEmployeeNamesByIds(ids,function(data){
			Sys.setNamesEmpOrDept(data,bl,nameobj);
		});
	},
	//显示部门
	showDeptNames:function(ids,nameobj,idobj){
		var bl = false;
		if(ids==null||ids.length==0){
			return;
		}
		if(nameobj==null||nameobj.length==0||document.getElementById(nameobj)==null ){
			document.write("请定义下载接收对象id!");
			return;
		}
		if(idobj!=null&&idobj!=undefined && idobj!= "undefined"&& idobj.length > 0){
			var objids = document.getElementById(idobj)
			if(objids==null||objids == undefined || objids =="undefined"){
				return;
			}else{
				objids.value = ids;
			}
			bl = true;
		}
		dwrCommonService.getHrmDeptNamesByIds(ids,function(data){
			Sys.setNamesEmpOrDept(data,bl,nameobj);
		});
	}
};
	
	
	//=======================弹出框===============================
	Sys.msgbox.prototype.btncancel = function(click,value){
		if(value==null||value == "undefined" || value == undefined ||value.length==0){
			value = "关 闭 ";
		}
		if(click==null||click == "undefined" || click == undefined ||click.length==0){
			click ="Sys.close('"+this.dialogId+"');";
		}else{
			click ="document.getElementById('titframe').contentWindow."+click+";";
		}
		
		var btn = "<table cellpadding='0' cellspacing='0' border='0' onmouseover='Btn.btnTableOver(this);' onmouseout='Btn.btnTableOut(this);'>";
		    btn += "<tr height='1px'><td class='jiaotd'></td><td class='linetd'></td><td class='jiaotd'></td></tr>";
			btn += "<tr><td width='1px' class='linetd'></td><td class='inputtd' align='center' onclick =\""+click+"\">";
			btn += "<img src='../images/winclose.png' style='width: 16px;height: 16px; margin-left: 3px;margin-right: 3px;vertical-align:middle !important; *vertical-align: baseline;' border='0'>";
			btn += "<input type='button' class='btn_table' value ='"+value+"'/></td><td width='1px' class='linetd'></td></tr>";
			btn +="<tr height='1px'><td class='jiaotd'></td><td class='linetd'></td><td class='jiaotd'></td></tr></table>";
		return btn;
	};
	
	Sys.msgbox.prototype.btnok = function(click,value){
		if(value==null||value == "undefined" || value == undefined ||value.length==0){
			value = "确 定 ";
		}
		if(click==null||click == "undefined" || click == undefined || click.length==0){
			document.write("请指定按钮事件...");
			return;
		}else{
			click ="document.getElementById('titframe').contentWindow."+click+";";
		}
		var btn = "<table cellpadding='0' cellspacing='0' border='0' onmouseover='Btn.btnTableOver(this);' onmouseout='Btn.btnTableOut(this);'>";
			btn += "<tr height='1px'><td class='jiaotd'></td><td class='linetd'></td><td class='jiaotd'></td></tr>";
			btn += "<tr><td width='1px' class='linetd'></td><td class='inputtd' align='center' onclick =\""+click+"\">";
			btn += "<img src='../images/fileokico.png' style='width: 16px;height: 16px; margin-left: 3px;margin-right: 3px;vertical-align:middle !important; *vertical-align: baseline;' border='0'>";
			btn += "<input type='button' class='btn_table' value ='"+value+"'/></td><td width='1px' class='linetd'></td></tr>";
			btn +="<tr height='1px'><td class='jiaotd'></td><td class='linetd'></td><td class='jiaotd'></td></tr></table>";
		return btn;
	};
	Sys.msgbox.prototype.validbut = function(tmps,s){
		if(tmps.length>0&&tmps.length>s){
			return tmps[s];
		}else{
			return null;
		}
	};
	Sys.msgbox.prototype.show=function(){
		var msg = "";
		msg+= "<table cellpadding='2' cellspacing='0' border='0' width='100%' height='100%'>";
		if(this.msgtitle != ""){
			msg+= "<tr height='35'>";
			msg+= "		<td align='center' style='padding-left:10px;'>";
			msg+= "			<img src='"+Sys.projectPath+"/images/alertimg/window.gif' width='32' height='32'/>";
			msg+= "		</td>";
			msg+= "		<td align='left' style='line-height:20px;width:100%;padding-left:10px;'>"+this.msgtitle+"</td>";
			msg+= "</tr>";
		}else{
			msg+= "<tr height='8'>";
			msg+= "		<td></td>";
			msg+= "		<td></td>";
			msg+= "</tr>";
		}
		msg+= "<tr>";
		msg+= "		<td colspan='2' style='padding-left: 10px;padding-right: 10px;'>";
		msg+= "			<iframe frameborder='0' scrolling='auto' height='100%' width='100%' id='titframe' src='"+this.uri+"' style='border: 1px solid #739ecf;padding: 0px;background-color:#FFFFFF;'  marginheight='0'></iframe>";
		msg+= "		</td>";
		msg+= "</tr>";
		msg+= "<tr height='40'>";
		msg+= "		<td align='right' style='background-color:#fff;padding-right:15px;' colspan='2'>";
		if(this.buttons==null||this.buttons == "undefined" || this.buttons == undefined){
			msg += this.btncancel(null,'关 闭 ');
		}else if(this.buttons.length == 1){
			var tmps = this.buttons[0].split("|");
			if(this.validbut(tmps,0)=="cancel"){
				msg += this.btncancel(this.validbut(tmps,1),this.validbut(tmps,2));
			}else{
				msg += this.btnok(this.validbut(tmps,1),this.validbut(tmps,2));
			}
		}else{
			msg +="<table cellpadding='5' cellspacing='0' border='0'><tr>";
			for(var i=0;i<this.buttons.length;i++){
				msg+="<td>";
				var tmps = this.buttons[i].split("|");
				if(this.validbut(tmps,0)=="cancel"){
					msg += this.btncancel(this.validbut(tmps,1),this.validbut(tmps,2));
				}else{
					msg += this.btnok(this.validbut(tmps,1),this.validbut(tmps,2));
				}
				msg+="</td>";
			}
			msg+="</tr></table>";
		}
		msg+= "</td></tr></table>";
		if(this.par == null ||this.par == "undefined" || this.par == undefined){
			this.par = window.parent.parent.parent.parent;//两层 tab页一层 右侧框架一层 编辑一层 右侧框架左右分栏
		}
		this.par.art.dialog({id:this.dialogId,title:this.tit,content:msg,width:this.width,height:this.height});
		
		if(this.max){
			//TODO
		}
	};
	function showorhiddenloading(obj){
		if(obj.readyState =="complete"){
			var pnode = obj.previousSibling;
			if(pnode!=null){
				pnode.style.display ='none';
				obj.style.display ='';
			}
		}
	}
	function SaveAs(obj){   
	    var a  = document.getElementById("filedownloadfrm");
	    a.src = obj.href;
	    return false ;
  	}
	function isOffice(attachName){
		var typeArray = new Array(".docx",".doc",".xlsx",".xls");
		for(var i=0;i<typeArray.length;i++){
			if(attachName.indexOf(typeArray[i]) > 0){
				return true;
				break;
			}
		}
		return false;
	}	
	