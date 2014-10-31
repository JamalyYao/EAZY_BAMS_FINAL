package com.eazytec.web.servlet.process;

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;
import java.util.zip.ZipInputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;

import com.eazytec.common.activiti.WorkflowUtils;
import com.eazytec.common.util.ConstWords;
import com.eazytec.common.util.file.properties.SystemConfig;
import com.eazytec.web.servlet.ServletServiceController;
/**
 * 流程部署
 * @author JC
 * @date   2013-08-28
 */
public class ProcessDeploy extends ServletServiceController {
	private Logger log =Logger.getLogger(this.getClass());
	private static final long serialVersionUID = 5370773249895204349L;

	public ProcessDeploy() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}


	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String fileName = null;
		String exportDir = SystemConfig.getParam("erp.workflow.path");
		InputStream fileInputStream = null;
		RepositoryService repositoryService = this.getRepositoryService();
		
        //文件上传处理工厂
        FileItemFactory factory = new DiskFileItemFactory();
        
        //创建文件上传处理器
        ServletFileUpload upload = new ServletFileUpload(factory);
        
        //开始解析请求信息  
        List items = null;  
        try {  
            items = upload.parseRequest(request);  
        }  
        catch (FileUploadException e) {  
            e.printStackTrace();  
        }  
        
        //对所有请求信息进行判断  
        Iterator iter = items.iterator();  
        while (iter.hasNext()) {  
            FileItem item = (FileItem) iter.next();  
            // 信息为普通的格式
            if (!item.isFormField()) {  
            	 fileName = item.getName();  
                 int index = fileName.lastIndexOf("\\");  
                 fileName = fileName.substring(index + 1);
                 fileInputStream =  item.getInputStream();
            }  
        }  

	    try {
	      Deployment deployment = null;

	      String extension = FilenameUtils.getExtension(fileName);
	      if (extension.equals("zip") || extension.equals("bar")) {
	      	ZipInputStream zip = new ZipInputStream(fileInputStream);
	        deployment = repositoryService.createDeployment().addZipInputStream(zip).deploy();
	      } else {
	        deployment = repositoryService.createDeployment().addInputStream(fileName, fileInputStream).deploy();
	      }

	      List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).list();

	      for (ProcessDefinition processDefinition : list) {
	        WorkflowUtils.exportDiagramToFile(repositoryService, processDefinition, exportDir);
	      }

	    } catch (Exception e) {
	    	log.error("error on deploy process, because of file input stream", e);
	    	request.setAttribute(ConstWords.TempStringMsg, "部署流程失败！请检查流程定义文件！");
	    	request.getRequestDispatcher("/erp/system_set/approve_process_add.jsp").forward(request, response);
	    	return;
	    }
		request.getRequestDispatcher("/erp/system_set/approve_process.jsp").forward(request, response);
	}

	public void init() throws ServletException {
		super.init();
		super.setContext(this.getServletContext());
	}
}
