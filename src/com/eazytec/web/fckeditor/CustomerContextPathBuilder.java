package com.eazytec.web.fckeditor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import net.fckeditor.requestcycle.impl.ContextPathBuilder;

import com.eazytec.common.util.UtilTool;
import com.eazytec.common.util.file.properties.SystemConfig;

/**
 * 用户目录管理
 * 
 * @author peng.ning
 * 
 */
public class CustomerContextPathBuilder extends ContextPathBuilder {
	
	
	@Override
	public String getUserFilesPath(HttpServletRequest request) {
		String s = "";
		try {
			
			int position =  Integer.valueOf(SystemConfig.getParam("erp.fckfile.position"));
    		if(position == 0){
    			//使用相对路径时使用以下方法
    			s = super.getUserFilesPath(request) + UtilTool.getCompanyAndUserPath(request,true);
    		}else{
    			//使用绝对路径时使用下面两个方法，配置fck图片服务器路径
    			s = SystemConfig.getParam("erp.fckfile.url") + UtilTool.getCompanyAndUserPath(request,true);
    		}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return s;
	}

	@Override
	public String getUserFilesAbsolutePath(HttpServletRequest request) {
		String s = "";
		try {
			
			int position =  Integer.valueOf(SystemConfig.getParam("erp.fckfile.position"));
    		if(position == 0){
    			//使用相对路径时使用以下方法
    			s = super.getUserFilesPath(request) + UtilTool.getCompanyAndUserPath(request,true);
    		}else{
    			//使用绝对路径时使用下面两个方法，配置fck图片服务器路径
    			s = SystemConfig.getParam("erp.fckfile.url") + UtilTool.getCompanyAndUserPath(request,true);
    		}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return s;
	}
}
