package com.eazytec.web.fckeditor;

import java.io.IOException;
import java.io.InputStream;

import net.fckeditor.connector.exception.InvalidCurrentFolderException;
import net.fckeditor.connector.exception.WriteException;
import net.fckeditor.connector.impl.ContextConnector;
import net.fckeditor.handlers.ResourceType;

import com.eazytec.common.util.ConvertPinyin;
import com.eazytec.common.util.file.properties.SystemConfig;
/**
 * 上传及文件重命名
 * @author peng.ning
 *
 */
public class CustomerContextConnector extends ContextConnector { 
    @Override  
    public String fileUpload(ResourceType type, String currentFolder,   
            String fileName, InputStream inputStream)   
            throws InvalidCurrentFolderException, WriteException {
    	String tmp = fileName;
        try {
			tmp=ConvertPinyin.getPinyin(fileName);//重命名操作在这里进行
		} catch (Exception e) {
			tmp=fileName;
		}
        return super.fileUpload(type, currentFolder, tmp, inputStream);   
    }

    @Override  
    protected String getRealUserFilesAbsolutePath(String userFilesAbsolutePath) {
    	String path = "";
    	try {
    		int position =  Integer.valueOf(SystemConfig.getParam("erp.fckfile.position"));
    		if(position == 0){
    			//相对路径
    			String[] arr = userFilesAbsolutePath.split("/");
    			String tmp = userFilesAbsolutePath.substring(arr[1].length()+1);//去掉项目名和"/"
    			path = super.getRealUserFilesAbsolutePath(tmp);
    		}else{
    			//绝对路径
    			String url = SystemConfig.getParam("erp.fckfile.url");
    	    	String absolutePath = userFilesAbsolutePath.substring(url.length());
    			path = SystemConfig.getParam("erp.fckfile.path") + absolutePath;
    		}
		
		} catch (IOException e) {
			e.printStackTrace();
		}
    	
		return path;
	}
}
