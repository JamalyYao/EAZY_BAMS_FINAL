package com.eazytec.web.servlet.process;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.apache.commons.io.IOUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.eazytec.web.servlet.ServletServiceController;

/**
 * 导出模型
 * @author JC
 * @date   2013-08-29
 */
public class ModelExport extends ServletServiceController {
	private static final long serialVersionUID = 5370773249895204349L;
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	public ModelExport() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}


	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String modelId = request.getParameter("id");
		RepositoryService repositoryService = this.getRepositoryService();
		
		try {
		      Model modelData = repositoryService.getModel(modelId);
		      BpmnJsonConverter jsonConverter = new BpmnJsonConverter();
		      JsonNode editorNode = new ObjectMapper().readTree(repositoryService.getModelEditorSource(modelData.getId()));
		      BpmnModel bpmnModel = jsonConverter.convertToBpmnModel(editorNode);
		      BpmnXMLConverter xmlConverter = new BpmnXMLConverter();
		      byte[] bpmnBytes = xmlConverter.convertToXML(bpmnModel);

		      ByteArrayInputStream in = new ByteArrayInputStream(bpmnBytes);
		      IOUtils.copy(in, response.getOutputStream());
		      String filename = bpmnModel.getMainProcess().getId() + ".bpmn20.xml";
		      response.setHeader("Content-Disposition", "attachment; filename=" + filename);
		      response.flushBuffer();
		    } catch (Exception e) {
		      logger.error("导出model的xml文件失败：modelId={}", modelId, e);
		    }
	}

	public void init() throws ServletException {
		super.init();
		super.setContext(this.getServletContext());
	}
}
