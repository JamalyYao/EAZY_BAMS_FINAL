package com.eazytec.web.servlet;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import org.activiti.engine.ManagementService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.apache.log4j.Logger;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.eazytec.core.iservice.IFileProcessService;
import com.eazytec.core.iservice.IHrmEmployeeService;
import com.eazytec.core.iservice.ISysProcessService;
import com.eazytec.core.iservice.IUserLoginService;
import com.eazytec.core.iservice.IWorkArrangeService;

/**
 * 
 * @author Frin
 * @description 定义service实例化方法,通过获取ServletContext来获取spring容器，然后注入service。
 */
public abstract class ServletServiceController extends HttpServlet {
	private Logger logger = Logger.getLogger(ServletServiceController.class);

	private ServletContext context; // servlet容器
	private WebApplicationContext webAppContext; // spring容器

	private IUserLoginService userLoginService;
	private ISysProcessService sysProcessService;
	private IFileProcessService fileProcessService;
	private IWorkArrangeService workArrangeService;
	private IHrmEmployeeService hrmEmployeeService;
	private RepositoryService repositoryService;
	private RuntimeService runtimeService;
	private ManagementService managementService;
	
	public void setContext(ServletContext context) {
		if(webAppContext == null && this.context == null){
			this.context = context;
		}
	}

	private void checkSpringWebAppContext(ServletContext context) {
		logger.debug("check spring application context...");

		if (context == null) {
			logger.error("please add servlet context to your servlet.setContext(ServletContext)...");
			throw new RuntimeException("please add servlet context to your servlet.setContext(ServletContext)...");
		}
		if (webAppContext == null) {
			webAppContext = WebApplicationContextUtils
					.getWebApplicationContext(context);
		}
	}
	
	public IUserLoginService getUserLoginService(){
		checkSpringWebAppContext(this.context);
		if (userLoginService == null) {
			userLoginService = (IUserLoginService) webAppContext.getBean("userLoginService");
		}
		return userLoginService;
	}

	
	public ISysProcessService getSysProcessService(){
		checkSpringWebAppContext(this.context);
		if (sysProcessService == null) {
			sysProcessService = (ISysProcessService) webAppContext.getBean("sysProcessService");
		}
		return sysProcessService;
	}
	
	public IFileProcessService getFileProcessService(){
		checkSpringWebAppContext(this.context);
		if (fileProcessService == null) {
			fileProcessService = (IFileProcessService) webAppContext.getBean("fileProcessService");
		}
		return fileProcessService;
	}
	
	public IWorkArrangeService getWorkArrangeService(){
		checkSpringWebAppContext(this.context);
		if (workArrangeService == null) {
			workArrangeService = (IWorkArrangeService) webAppContext.getBean("workArrangeService");
		}
		return workArrangeService;
	}
	
	public IHrmEmployeeService getHrmEmployeeService(){
		checkSpringWebAppContext(this.context);
		if (hrmEmployeeService == null) {
			hrmEmployeeService = (IHrmEmployeeService) webAppContext.getBean("hrmEmployeeService");
		}
		return hrmEmployeeService;
	}
	
	public RepositoryService getRepositoryService(){
		checkSpringWebAppContext(this.context);
		if (repositoryService == null) {
			repositoryService = (RepositoryService) webAppContext.getBean("repositoryService");
		}
		return repositoryService;
	}
	
	public RuntimeService getRuntimeService(){
		checkSpringWebAppContext(this.context);
		if (runtimeService == null) {
			runtimeService = (RuntimeService) webAppContext.getBean("runtimeService");
		}
		return runtimeService;
	}
	
	public ManagementService getManagementService(){
		checkSpringWebAppContext(this.context);
		if (managementService == null) {
			managementService = (ManagementService)webAppContext.getBean("managementService");
		}
		return managementService;
	}
}
