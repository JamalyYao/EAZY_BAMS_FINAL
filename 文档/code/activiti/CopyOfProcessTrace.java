package com.eazytec.web.servlet.process;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.bpmn.diagram.ProcessDiagramGenerator;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.spring.ProcessEngineFactoryBean;
import com.eazytec.web.servlet.ServletServiceController;
/**
 * 当前节点
 * @author JC
 * @date   2013-08-28
 */
public class CopyOfProcessTrace extends ServletServiceController {
	private static final long serialVersionUID = 5370773249895204349L;

	public CopyOfProcessTrace() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}


	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String executionId = request.getParameter("id");
		
		RuntimeService runtimeService = this.getRuntimeService();
		RepositoryService repositoryService = this.getRepositoryService();
		ProcessEngineFactoryBean processEngine = this.getProcessEngine();
		
		ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(executionId).singleResult();
	    BpmnModel bpmnModel = repositoryService.getBpmnModel(processInstance.getProcessDefinitionId());
	    List<String> activeActivityIds = runtimeService.getActiveActivityIds(executionId);
	    //不使用spring请使用下面的两行代码
	    //ProcessEngineImpl defaultProcessEngine = (ProcessEngineImpl) ProcessEngines.getDefaultProcessEngine();
	    //Context.setProcessEngineConfiguration(defaultProcessEngine.getProcessEngineConfiguration());

	    // 使用spring注入引擎请使用下面的这行代码
	    Context.setProcessEngineConfiguration(processEngine.getProcessEngineConfiguration());

	    InputStream imageStream = ProcessDiagramGenerator.generateDiagram(bpmnModel, "png", activeActivityIds);

	    // 输出资源内容到相应对象
	    byte[] b = new byte[1024];
	    int len;
	    while ((len = imageStream.read(b, 0, 1024)) != -1) {
	      response.getOutputStream().write(b, 0, len);
	    }
	}

	public void init() throws ServletException {
		super.init();
		super.setContext(this.getServletContext());
	}
}
