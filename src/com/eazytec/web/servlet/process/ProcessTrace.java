package com.eazytec.web.servlet.process;

import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.activiti.engine.impl.interceptor.Command;
import com.eazytec.common.activiti.HistoryProcessInstanceDiagramCmd;
import com.eazytec.web.servlet.ServletServiceController;
/**
 * 当前节点
 * @author JC
 * @date   2013-08-28
 */
public class ProcessTrace extends ServletServiceController {
	private static final long serialVersionUID = 5370773249895204349L;

	public ProcessTrace() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}


	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String processInstanceId = request.getParameter("id");
		Command<InputStream> cmd = new HistoryProcessInstanceDiagramCmd(processInstanceId);
        InputStream is = this.getManagementService().executeCommand(cmd);
        response.setContentType("image/png");

        int len = 0;
        byte[] b = new byte[1024];

        while ((len = is.read(b, 0, 1024)) != -1) {
            response.getOutputStream().write(b, 0, len);
        }
	}

	public void init() throws ServletException {
		super.init();
		super.setContext(this.getServletContext());
	}
}
