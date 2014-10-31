package com.eazytec.web.servlet.process;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.eazytec.web.servlet.ServletServiceController;

/**
 * 创建模型
 * @author JC
 * @date   2013-08-28
 */
public class ModelCreate extends ServletServiceController {
	private static final long serialVersionUID = 5370773249895204349L;
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	public ModelCreate() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}


	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		request.setCharacterEncoding("UTF-8");   
        response.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		String key = request.getParameter("key");
		String description = request.getParameter("description");
		RepositoryService repositoryService = this.getRepositoryService();
		
		try {
		      ObjectMapper objectMapper = new ObjectMapper();
		      ObjectNode editorNode = objectMapper.createObjectNode();
		      editorNode.put("id", "canvas");
		      editorNode.put("resourceId", "canvas");
		      ObjectNode stencilSetNode = objectMapper.createObjectNode();
		      stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
		      editorNode.put("stencilset", stencilSetNode);
		      Model modelData = repositoryService.newModel();

		      ObjectNode modelObjectNode = objectMapper.createObjectNode();
		      modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, name);
		      modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);
		      description = StringUtils.defaultString(description);
		      modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, description);
		      modelData.setMetaInfo(modelObjectNode.toString());
		      modelData.setName(name);
		      modelData.setKey(StringUtils.defaultString(key));

		      repositoryService.saveModel(modelData);
		      repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));

		      response.sendRedirect(request.getContextPath() + "/service/editor?id=" + modelData.getId());
		    } catch (Exception e) {
		      logger.error("创建模型失败：", e);
		    }
	}

	public void init() throws ServletException {
		super.init();
		super.setContext(this.getServletContext());
	}
}
