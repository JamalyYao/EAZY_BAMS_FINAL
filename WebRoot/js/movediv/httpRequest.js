
	function CreateXmlHttpRequest(){
	    // 先定义一个变量，并赋初值为 false，方便后面判断对象是否创建成功          
	    // 使用 try 来捕获创建失败，再换个方法来创建
	    var xmlhttp;
	    try {
	        // 在 Mozilla 中使用这种方式来创建 XMLHttpRequest 对象
	        xmlhttp = new XMLHttpRequest;
	    }catch (e) {
	        try {
	            // 如果不成功，那么尝试在较新 IE 里的方式
	            xmlhttp = new ActiveXObject("MSXML2.XMLHTTP");
	        }catch (e2) {
	            try {
	                // 失败则尝试使用较老版本 IE 里的方式 
	                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	            }catch (e3){
	                // 还是失败，那么就认为创建失败……
	                xmlhttp = false;
	            }
	        }
	    }
	    
	    return xmlhttp;
	}
	function GetXmlHttp(url){
	    var xh = CreateXmlHttpRequest();
		// 如果创建 XMLHttpRequest 对象失败，那么提醒访问者该页面可能无法正确访问
	    if (!xh) {
	        document.write("XMLHttpRequest请求对象创建失败！");
	        return;
	    }else{
		    // 因为使用异步方式所以要在 XMLHttpRequest 对象的状态改变时做相应的处理
		    xh.onreadystatechange =function(){GetXmlValueByTag(xh)};
		    xh.open("GET", url, true);
		    // 发送请求，因为是GET，所以send的内容为null
		    xh.send(null);
	    }
	}
	
	function GetXmlHttpRef(url){
	    var xh = CreateXmlHttpRequest();
		// 如果创建 XMLHttpRequest 对象失败，那么提醒访问者该页面可能无法正确访问
	    if (!xh) {
	        document.write("XMLHttpRequest请求对象创建失败！");
	        return;
	    }else{
		    // 因为使用异步方式所以要在 XMLHttpRequest 对象的状态改变时做相应的处理
		    xh.onreadystatechange =function(){GetXmlValueByTagRef(xh)};
		    xh.open("GET", url, true);
		    // 发送请求，因为是GET，所以send的内容为null
		    xh.send(null);
	    }
	}
	
	function GetXmlHttpSms(url){
	    var xh = CreateXmlHttpRequest();
		// 如果创建 XMLHttpRequest 对象失败，那么提醒访问者该页面可能无法正确访问
	    if (!xh) {
	        document.write("XMLHttpRequest请求对象创建失败！");
	        return;
	    }else{
		    // 因为使用异步方式所以要在 XMLHttpRequest 对象的状态改变时做相应的处理
		    xh.onreadystatechange =function(){GetXmlValueByTagSms(xh)};
		    xh.open("GET", url, true);
		    // 发送请求，因为是GET，所以send的内容为null
		    xh.send(null);
	    }
	}
	
	function GetXmlHttpMail(url,objid){
	    var xh = CreateXmlHttpRequest();
		// 如果创建 XMLHttpRequest 对象失败，那么提醒访问者该页面可能无法正确访问
	    if (!xh) {
	        document.write("XMLHttpRequest请求对象创建失败！");
	        return;
	    }else{
		    // 因为使用异步方式所以要在 XMLHttpRequest 对象的状态改变时做相应的处理
		    xh.onreadystatechange =function(){GetXmlValueByTagMail(objid,xh)};
		    xh.open("GET", url, true);
		    // 发送请求，因为是GET，所以send的内容为null
		    xh.send(null);
	    }
	}
	
	function GetXmlHttpOther(url){
	    var xh = CreateXmlHttpRequest();
		// 如果创建 XMLHttpRequest 对象失败，那么提醒访问者该页面可能无法正确访问
	    if (!xh) {
	        document.write("XMLHttpRequest请求对象创建失败！");
	        return;
	    }else{
		    // 因为使用异步方式所以要在 XMLHttpRequest 对象的状态改变时做相应的处理
		    xh.onreadystatechange =function(){GetXmlValueByTagOther(xh)};
		    xh.open("GET", url, true);
		    // 发送请求，因为是GET，所以send的内容为null
		    xh.send(null);
	    }
	}
	
	function GetXmlOnlineCount(url,obj){
		var xh = CreateXmlHttpRequest();
	    if (!xh) {
	        document.write("XMLHttpRequest请求对象创建失败！");
	        return;
	    }else{
		    // 因为使用异步方式所以要在 XMLHttpRequest 对象的状态改变时做相应的处理
		    xh.onreadystatechange = function(){GetOnlineCount(xh,obj)};
		    xh.open("GET", url, true);
		    // 发送请求，因为是GET，所以send的内容为null
		    xh.send(null);
	    }
	}
	
	function GetXmlTask(url){
		  var xh = CreateXmlHttpRequest();
		// 如果创建 XMLHttpRequest 对象失败，那么提醒访问者该页面可能无法正确访问
	    if (!xh) {
	        document.write("XMLHttpRequest请求对象创建失败！");
	        return;
	    }else{
		    // 因为使用异步方式所以要在 XMLHttpRequest 对象的状态改变时做相应的处理
		    xh.onreadystatechange =function(){GetXmlValueByTask(xh)};
		    xh.open("GET", url, true);
		    // 发送请求，因为是GET，所以send的内容为null
		    xh.send(null);
	    }
	}
	
	function GetXmlHttpApply(url,objid){
	    var xh = CreateXmlHttpRequest();
		// 如果创建 XMLHttpRequest 对象失败，那么提醒访问者该页面可能无法正确访问
	    if (!xh) {
	        document.write("XMLHttpRequest请求对象创建失败！");
	        return;
	    }else{
		    // 因为使用异步方式所以要在 XMLHttpRequest 对象的状态改变时做相应的处理
		    xh.onreadystatechange =function(){GetXmlValueByTagApply(objid,xh)};
		    xh.open("GET", url, true);
		    // 发送请求，因为是GET，所以send的内容为null
		    xh.send(null);
	    }
	}