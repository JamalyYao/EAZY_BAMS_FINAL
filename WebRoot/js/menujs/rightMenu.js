window.Menu=function(isDir,text,handle){
    this.IsDirectory=false;    //是否是目录    
    this.HTMLObj=null;    //关联HTML对象
    this.ParentMenu=null;    //父菜单
    this.SubMenus=[];    //存储子菜单数组
    this.Text="";
    this.ZIndex=900;    //层
    this.Handle=null;    //单击时所执行的语句,目录不支持此属性
    if(typeof(isDir)!="undefined" && isDir){
        this.IsDirectory=true;
    }
    if(typeof(text)!="undefined"){
        this.Text=text;
    }
    if(typeof(handle)!="undefined"){
        this.Handle=handle;
    }

    //创建并追加子菜单
    this.CreateSubMenu=function(isDir,text,handle){
        if(this.IsDirectory){
            var oMenu=new Menu();
            if(typeof(isDir)!="undefined"){
                oMenu.IsDirectory=isDir;
            }
            if(typeof(text)!="undefined"){
                oMenu.Text=text;
            }
            if(typeof(handle)!="undefined"){
                oMenu.Handle=handle;
            }
            this.AppendSubMenu(oMenu);
            return oMenu;
        }
        alert("出现错误,该对象不支持CreateSubMenu方法");
        return null;
    }

    //追加子菜单
    this.AppendSubMenu=function(oMenu){
        this.SubMenus.push(oMenu);
        oMenu.ParentMenu=this;
        oMenu.ZIndex=this.ZIndex+1;
    }

    //插入子菜单
    this.InsertSubMenu=function(oMenu,iAlign){
        if(iAlign>=this.SubMenus.length){
            this.SubMenus.push(oMenu);
        }else{
            this.SubMenus.splice(iAlign,0,oMenu);
        }
        oMenu.ParentMenu=this;
        oMenu.ZIndex=this.ZIndex+1;
    }

    //移除子菜单
    this.RemoveSubMenu=function(iAlign){
        var RemoveArr=this.SubMenus.splice(iAlign,1);
        if(RemoveArr.length>0){
            RemoveArr[0].HTMLObj.parentNode.removeChild(RemoveArr[0].HTMLObj);
        }
    }

    //把子菜单的数据转换成HTML格式
    this.Create=function(){
        if(!this.IsDirectory){
            alert("出现错误,该对象不支持Create方法");
            return false;
        }
        var ParentElement=document.createElement("div");
        this.ChildMenuHTMLObj=ParentElement;    //关联子菜单的HTML对象容器
        ParentElement.style.cursor="default";
        ParentElement.onmousedown=function(){
            window.event.cancelBubble=true;
        }
        ParentElement.onselectstart=function(){
            return false;
        }
        ParentElement.style.position="absolute";
        ParentElement.style.display="none";
        ParentElement.style.zIndex=this.ZIndex;
        ParentElement.style.border="1px outset #fff";  
        var table=document.createElement("table");
        table.border=0;
        table.cellPadding=0;
        table.cellSpacing=0;
        var tbody=document.createElement("tbody");
        table.appendChild(tbody);
        var tr=document.createElement("tr");
        var ltd=document.createElement("td");
        var rtd=document.createElement("td");
        tr.appendChild(ltd);
        tr.appendChild(rtd);
        tbody.appendChild(tr);
        ltd.style.width="22px";
        ltd.style.background ="#ededed url('"+formStylePath.getImagePath()+"clearinput.png') no-repeat center 5px";
        ParentElement.appendChild(table);
        var len=this.SubMenus.length;
        if(len>0){
            var ChildTable=document.createElement("table");
            var ChildTBody=document.createElement("tbody");
            ChildTable.appendChild(ChildTBody);
            ChildTable.border=0;
            ChildTable.cellPadding=0;
            ChildTable.cellSpacing=0;
            ChildTable.style.fontSize=Menu.Config.FontSize;
            ChildTable.style.color=Menu.Config.FontColor;
            rtd.appendChild(ChildTable);
        }
        for(var i=0;i<len;i++){
            var tempTr=document.createElement("tr");
            //关联HTML对象和DATA对象
            this.SubMenus[i].HTMLObj=tempTr;    //关联子菜单的HTML对象
            tempTr.DataObj=this.SubMenus[i];
            var tempTd=document.createElement("td");
            tempTr.style.backgroundColor=Menu.Config.BgColor;
            tempTr.appendChild(tempTd);
            tempTd.style.height=Menu.Config.PerMenuHeight;
            tempTd.vAlign="middle";            
            tempTd.style.wordWarp="normal";
            tempTd.style.paddingLeft="5px";
            tempTd.style.paddingRight="5px";
            tempTr.onmouseover=this.SubMenus[i].MouseOver;
            tempTr.onmouseout=this.SubMenus[i].MouseOut;
            tempTr.onclick=this.SubMenus[i].Click;
            tempTd.appendChild(document.createTextNode(this.SubMenus[i].Text));
            var DirectoryTd=document.createElement("td");
            if(this.SubMenus[i].IsDirectory){
                var font=document.createElement("font");
                font.style.fontFamily="webdings";
                font.appendChild(document.createTextNode("4"));
                DirectoryTd.appendChild(font);
            }
            tempTr.appendChild(DirectoryTd);
            ChildTBody.appendChild(tempTr);
        }
        document.body.appendChild(ParentElement);
        for(var i=0;i<len;i++){
            if(this.SubMenus[i].IsDirectory){
                this.SubMenus[i].Create();
            }
        }
    }

    this.Show=function(e){
        if(!this.IsDirectory){
            alert("出现错误,该对象不支持Show方法");
            return false;
        }
        if(this.SubMenus.length==0)    return;
        var ChildHTMLObj=this.ChildMenuHTMLObj;
        var DWidth=document.body.clientWidth;
        var DHeight=document.body.clientHeight;
        var left=document.body.scrollLeft,top=document.body.scrollTop;
        var x,y;
        if(this.ParentMenu==null){   //根对象
            x=e.clientX,y=e.clientY;
            if(x+ChildHTMLObj.offsetWidth>DWidth){
                x-=ChildHTMLObj.offsetWidth;
            }
            if(y+ChildHTMLObj.offsetHeight>DHeight){
                y-=ChildHTMLObj.offsetHeight;
            }
            x+=left;
            y+=top;
        }else{
            var CurrentHTMLObj=this.HTMLObj;
            var x=Menu.GetMenuPositionX(CurrentHTMLObj)+CurrentHTMLObj.offsetWidth,y=Menu.GetMenuPositionY(CurrentHTMLObj);
            if(x+ChildHTMLObj.offsetWidth>DWidth+left){
                x-=(CurrentHTMLObj.offsetWidth+ChildHTMLObj.offsetWidth);
            }
            if(y+ChildHTMLObj.offsetHeight>DHeight+top){
                y-=ChildHTMLObj.offsetHeight;
                y+=CurrentHTMLObj.offsetHeight;
            }
        }
        ChildHTMLObj.style.left=x;
        ChildHTMLObj.style.top=y;
        this.ChildMenuHTMLObj.style.display="block";
    }
    this.Hidden=function(){        
        if(!this.IsDirectory){
            alert("出现错误,该对象不支持Hidden方法");
            return false;
        }
        var len=this.SubMenus.length;
        for(var i=0;i<len;i++){
            if(this.SubMenus[i].IsDirectory){
                this.SubMenus[i].Hidden();
            }
        }
        this.ChildMenuHTMLObj.style.display="none";
    }

    this.MouseOver=function(){
        this.style.backgroundColor=Menu.Config.OverBgColor;
        var ParentMenu=this.DataObj.ParentMenu;
        var len=ParentMenu.SubMenus.length;
        for(var i=0;i<len;i++){
            if(ParentMenu.SubMenus[i].IsDirectory){
                ParentMenu.SubMenus[i].Hidden();
            }
        }
        if(this.DataObj.IsDirectory){
            this.DataObj.Show();
        }
    }

    this.MouseOut=function(){
        this.style.backgroundColor=Menu.Config.BgColor;
    }

    this.Clear=function(){
        if(this.IsDirectory){
            var len=this.SubMenus.length;
            for(var i=0;i<len;i++){
                if(this.SubMenus[i].IsDirectory){
                    this.SubMenus[i].Clear();
                }
            }
        }
        document.body.removeChild(this.ChildMenuHTMLObj);
    }

    this.Click=function(){    
        if(!this.DataObj.IsDirectory){
            eval(this.DataObj.Handle);
            Menu.Config.FirstMenu.Hidden();
        }
    }
}

//菜单配置
Menu.Config=
{
    FirstMenu:new Menu(true),    //系统定义的第一个菜单,必须为容器(IsDirectory=true)
    BgColor:"#fefefe",    //设置菜单背景颜色
    OverBgColor:"#B5BED6",    //设置菜单鼠标经过时的背景颜色
    FontSize:"13px",    //设置菜单字体大小
    FontColor:"#000000",    //设置菜单字体颜色
    PerMenuHeight:"22px"    //调整菜单的行距
};

Menu.GetMenuPositionX=function(obj){
    var ParentObj=obj;
    var left;
    left=ParentObj.offsetLeft;
    while(ParentObj=ParentObj.offsetParent){
        left+=ParentObj.offsetLeft;
    }
    return left;
}

Menu.GetMenuPositionY=function(obj){
    var ParentObj=obj;
    var top;
    top=ParentObj.offsetTop;
    while(ParentObj=ParentObj.offsetParent){
        top+=ParentObj.offsetTop;
    }
    return top;
}

Menu.Update=function(){
    var FirstMenu=Menu.Config.FirstMenu;
    FirstMenu.Clear();
    FirstMenu.Create();
}

window.CXP_Menu=Menu.Config.FirstMenu;
var help=CXP_Menu.CreateSubMenu(false,"清 除");
help.Handle="clearInput();";
function clearInput(){
	var obj = currentInputObject.getobject();
	if(obj!=null){
		obj.value = "";
		var link =obj.getAttribute("linkclear");
		if(link!=null&&link != "undefined" && link != undefined && link.length > 0){
			var linkobj=document.getElementById(link);
			if(linkobj!=null&&linkobj != "undefined" && linkobj != undefined){
				linkobj.value ="";
			}
		}
	}
}
