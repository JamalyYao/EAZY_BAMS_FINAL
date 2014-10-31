/**
 *审批流程相关
 *peng.ning
 **/ 
 
 var Approve = {
 	projectPath:"/",
 	typearray:null,
 	approveStatusColName:"",
 	setStatusColName:function(cname){
 		this.approveStatusColName = cname;
 	},
 	getStatusColName:function(){
 		return this.approveStatusColName;
 	},
 	setProjectPath:function(path){
		this.projectPath = path;
	},
	setTypeArray:function(array){
		this.typearray = array;
	},
	getImagePath:function(){
		return this.projectPath+"/images/approveprocess";
	},
	getTypeImgArray:function(){
		var imgpath = this.projectPath+"/images/approveprocess/";
		var typeimgarray = new Array(8);
		typeimgarray[0] = imgpath+"rightarrow.gif";
		typeimgarray[1] = imgpath+"process_employee.gif";
		typeimgarray[2] = imgpath+"process_depmanger.gif";
		typeimgarray[3] = imgpath+"process_postmanger.gif";
		typeimgarray[4] = imgpath+"process_appdept.gif";
		typeimgarray[5] = imgpath+"process_apppost.gif";
		typeimgarray[6] = imgpath+"process_appupdept.gif";
		typeimgarray[7] = imgpath+"process_appuppost.gif";
		typeimgarray[8] = imgpath+"process_up.gif";
		return typeimgarray;
	},
	createProcess:function(obj,trid){
		var tmpstr ="";
		var typemsg ="";
		var tmpval ="";
		if(obj.setDetailValuename!=null&&obj.setDetailValuename!= "undefined"&&obj.setDetailValuename != undefined&&obj.setDetailValuename.length>0){
			tmpstr =obj.setDetailValuename;
		}
		
		if(obj.setDetailValue!=null&&obj.setDetailValue!= "undefined"&&obj.setDetailValue != undefined&&obj.setDetailValue.length>0){
			tmpval = obj.setDetailValue;
		}
		
		var typeimgarray = this.getTypeImgArray();
		var type = obj.setDetailType;
		
		typemsg = this.typearray[type-1];
		
		var tr1 = document.getElementById(trid);
		if(obj.setDetailLevel>1){
			var td1_1 = document.createElement("td");
			td1_1.width = "64px";
			td1_1.style.textAlign ="center";
			td1_1.innerHTML = "<img src ='"+typeimgarray[0]+"' border='0'/>";
			tr1.appendChild(td1_1);
		}
		var td1 = document.createElement("td");
		td1.width = "128px";
		td1.style.textAlign ="center";
		str = "<div style='border:1px solid #c1c1c1;height:100%;width:128px;overflow:hidden'>";
		str += "<nobr><div style='padding:5px;background-color:#eeeeee'>第 <font color='green'>"+obj.setDetailLevel+"</font> 步</div></nobr>";
		str+= "<img src ='"+typeimgarray[type]+"' border='0' title='"+tmpstr+"' style='padding:3px;'/>";
		str+="<div style='padding:5px;background-color:#eeeeee;line-height:20px;text-aling:left'>"+typemsg+"<br/><nobr><font color='blue'>"+tmpstr+"</font></nobr></div>";
		str+="<input type='hidden' name='approvelevel' value ='"+obj.setDetailLevel+"'/>";
		str+="<input type='hidden' name='approvetype' value ='"+type+"'/>";
		str+="<input type='hidden' name='approvvalue' value ='"+tmpval+"'/>";
		str+="</div>"
		td1.innerHTML = str;
		tr1.appendChild(td1);
	},
	clearprocess:function(trid,pcount,ptype){
		var tr1 = document.getElementById(trid);
		var cells = tr1.cells;
		if(cells.length>0){
			confirmmsg("确定要清空流程吗?","Approve.clearok('"+trid+"','"+pcount+"','"+ptype+"')");
		}
	},
	clearok:function(trid,pcount,ptype){
		var tr1 = document.getElementById(trid);
		var cells = tr1.cells;
		for(var i=cells.length-1;i>=0;i--){
			tr1.deleteCell(i);
		}
		document.getElementById(pcount).value ="1";
		document.getElementById(ptype).value ="-1";
	},
	createApproveProcess:function(data,status,name,da,divid){
		var index =1;
		var str="";
		var cols=1;
		var imgpath = this.getImagePath();
		var approveRecordList = data;
		str+="<table border=0 align='center'>";
		str+="<tr>";
		str+="<td align='center' style='padding:10px'><img src='"+imgpath+"/people.png' alt='申请时间：" + da + "' title='申请时间：" + da + "'/><br/>申请人：<label id='applyPerson'>" + name + "</label></td>";
		if(approveRecordList.length >0){
			str+="<td><img src='"+imgpath+"/row.png'/></td>";
			cols++;
		}
		var len=approveRecordList.length;
		for(var i=0;i<len; i++){
			var approveRecord =approveRecordList[i];
			if(approveRecord.approveIsprocess == 1){
				// 本次审批还没有处理
				str+="<td align='center' style='padding:10px'><img src='"+imgpath+"/people_.png' alt='审批信息：审批人员还未处理该申请。' title='审批信息：审批人员还未处理该申请。'/><br/>";
				str+="审批人：" + approveRecord.approveEmployee.hrmEmployeeName+ "<br/>";
				str+="<font color='orange'>未处理该申请</font><br/>";
				str+="</td>";
				cols++;
				if(index != len){
					// 审批记录不为最后一条
					str+="<td align='center' style='padding:10px'><img src='"+imgpath+"/row_.png' alt='不可到达下级操作。' title='不可到达下级操作。'/></td>";
					cols++;
				}
			}else if(approveRecord.approveIsprocess == 2){
				str+="<td align='center' style='padding:10px'>";
				var recordShow = "审批日期：" + approveRecord.approveDate + "&#10;审批意见：" + approveRecord.approveRemark;
				if (approveRecord.approveIspass == 1) {
					// 未通过
					str+="<img src='"+imgpath+"/deny.png' alt='" + recordShow + "' title='" + recordShow + "'/><br/>";
				} else if (approveRecord.approveIspass == 2) {
					// 通过
					str+="<img src='"+imgpath+"/allow.png' alt='" + recordShow + "' title='" + recordShow + "'/><br/>";
				} else {
					// 未知或结束
					str+="<img src='"+imgpath+"/people_.png'  alt='" + recordShow + "' title='" + recordShow + "'/><br/>";
				}
				str+="审批人：" + approveRecord.approveEmployee.hrmEmployeeName+ "<br/>";
		
				var res=applyRecordIsPassStatus(approveRecord.approveIspass, 'cn');
				str+="审批结果：" +res+ "<br/>";
				str+="</td>";
				cols++;
				if (index != len) {
					// 审批记录不是最后一条
					str+="<td align='center' style='padding:10px'><img src='"+imgpath+"/row.png' alt='到达下级操作。' title='到达下级操作。'/></td>";
					cols++;
				}
			}
			index++;
		}
		str+="</tr>";
		var r="审批结果："+applyRecordStatus(status, 'cn');
		str+="<tr><td colspan='"+cols+"'><hr style='width:80%;color:#ededed'/></td></tr>"
		str+="<tr><td colspan='"+cols+"' align='center' style='padding:3px'>"+r+"</td></tr>"
		str+="</table>";
		document.getElementById(divid).innerHTML = str;
	},
	showApproveProcess:function(recordId,recordType,recordStatus,applyName,applyDate,divid){
		dwrCommonService.getApproveReocrdByType(recordId,recordType,function(data){
			Approve.createApproveProcess(data,recordStatus,applyName,applyDate,divid);
		});
	}
 };
 
 function applyRecordIsPassStatus(approveStatusCode,language) {
		if (language == "cn" ) {
			if (approveStatusCode == 1) {
				return "<font color='red'>不通过</font>";
			} else if (approveStatusCode == 2) {
				return "<font color='green'>通过</font>";
			}else if (approveStatusCode == 5) {
				return "<font color='#666666'>已结束</font>";
			} else {
				return "<font color='orange'>其他</font>";
			}
		} else {
			if (approveStatusCode == 1) {
				return "failed";
			} else if (approveStatusCode == 2) {
				return "pass";
			} else {
				return "others";
			}
		}
	}
function applyRecordStatus(approveStatusCode,language) {
		var imgpath = Approve.getImagePath();
		if (language == "cn" ) {
			if (approveStatusCode == 1) {
				return "<font size='3' color='blue'><u>&nbsp;&nbsp;申请中&nbsp;&nbsp;</u></font>&nbsp;&nbsp;&nbsp;&nbsp;<img src='"+imgpath+"/approve_process.png' title='申请中' alt='申请中'/>";
			} else if (approveStatusCode == 2) {
				return "<font size='3' color='green'><u>&nbsp;&nbsp;已通过&nbsp;&nbsp;</u></font>&nbsp;&nbsp;&nbsp;&nbsp;<img src='"+imgpath+"/approve_pass.png' title='通过' alt='通过'/>";
			} else if (approveStatusCode == 3) {
				return "<font size='3' color='red'><u>&nbsp;&nbsp;未通过&nbsp;&nbsp;</u></font>&nbsp;&nbsp;&nbsp;&nbsp;<img src='"+imgpath+"/approve_nopass.png' title='未通过' alt='未通过'/>";
			} else if (approveStatusCode == 4) {
				return "<font size='3' color='orange'><u>&nbsp;&nbsp;审批中&nbsp;&nbsp;</u></font>&nbsp;&nbsp;&nbsp;&nbsp;<img src='"+imgpath+"/approve_process.png' title='审批中' alt='审批中'/>";
			}else if (approveStatusCode == 5) {
				return "<font size='3' color='orange'><u>&nbsp;&nbsp;已结束&nbsp;&nbsp;</u></font>&nbsp;&nbsp;&nbsp;&nbsp;<img src='"+imgpath+"/approve_end.png' title='已结束' alt='已结束'/>";
			} else {
				return "<font size='3' color='blue'><u>&nbsp;&nbsp;其他&nbsp;&nbsp;</u></font>&nbsp;&nbsp;&nbsp;&nbsp;<img src='"+imgpath+"/approve_process.png' title='审批中' alt='审批中'/>";
			}
		} else {
			if (approveStatusCode == 1) {
				return "<img src='"+imgpath+"/approve_process.png' title='申请中' alt='申请中' border='0'/>";
			} else if (approveStatusCode == 2) {
				return "<img src='"+imgpath+"/approve_pass.png' title='通过' alt='通过' border='0'/>";
			} else if (approveStatusCode == 3) {
				return "<img src='"+imgpath+"/approve_nopass.png' title='未通过' alt='未通过' border='0'/>";
			} else if (approveStatusCode == 4) {
				return "<img src='"+imgpath+"/approve_process.png' title='审批中' alt='审批中' border='0'/>";
			}else if (approveStatusCode == 4) {
				return "<img src='"+imgpath+"/approve_end.png' title='已结束' alt='已结束' border='0'/>";
			} else {
				return "<img src='"+imgpath+"/approve_process.png' title='审批中' alt='审批中' border='0'/>";
			}
		}
	}