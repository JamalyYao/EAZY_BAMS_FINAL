package com.eazytec.web.servlet.process;

import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import com.eazytec.web.servlet.ServletServiceController;
/**
 * 流程资源查看
 * @author JC
 * @date   2013-08-28
 */
public class ProcessResource extends ServletServiceController {
	private static final long serialVersionUID = 5370773249895204349L;

	public ProcessResource() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}


	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String resourceType = request.getParameter("type");
		String processDefinitionId = request.getParameter("pid");
		RepositoryService repositoryService = this.getRepositoryService();
		
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
	    String resourceName = "";
	    if (resourceType.equals("image")) {
	      resourceName = processDefinition.getDiagramResourceName();
	    } else if (resourceType.equals("xml")) {
	      resourceName = processDefinition.getResourceName();
	    }
	    InputStream resourceAsStream = repositoryService.getResourceAsStream(processDefinition.getDeploymentId(), resourceName);
	    byte[] b = new byte[1024];
	    int len = -1;
	    while ((len = resourceAsStream.read(b, 0, 1024)) != -1) {
	      response.getOutputStream().write(b, 0, len);
	    }
	}

	public void init() throws ServletException {
		super.init();
		super.setContext(this.getServletContext());
	}
}
