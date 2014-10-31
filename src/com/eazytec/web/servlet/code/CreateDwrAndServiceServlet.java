package com.eazytec.web.servlet.code;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.eazytec.common.util.ConstWords;

public class CreateDwrAndServiceServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public CreateDwrAndServiceServlet(){
		super();
	}
	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String jspPath = "/erp/code_create/code_create_two.jsp";
		String pojoPack = request.getParameter("pojoPack");
		String daoPack = request.getParameter("daoPack");
		String dwrPack = request.getParameter("dwrPack");
		String servicePack = request.getParameter("servicePack");
		String serviceImplPack = request.getParameter("serviceImplPack");
		String filePath = request.getParameter("filePath");
		String pojoClass = request.getParameter("pojoClass");
		String moduleName = request.getParameter("moduleName");
		
		try {
			CreateDwrAndService cp = new CreateDwrAndService(pojoPack,daoPack,dwrPack,servicePack,serviceImplPack,filePath,moduleName,pojoClass);
			cp.getDwr();//创建Dwr
			cp.getService();//创建Service
			cp.getPack();
			cp.getConfig();//生成配置临时文件
			cp.openExplorer(filePath);//打开目录
			request.setAttribute(ConstWords.TempStringMsg, "代码生成成功，请查看！");
		} catch (Exception e) {
			request.setAttribute(ConstWords.TempStringMsg, "代码生成失败，请注意查看相关数据项！");
			e.printStackTrace();
		}
		
		request.setAttribute("pojoPack", pojoPack);
		request.setAttribute("daoPack", daoPack);
		request.setAttribute("dwrPack", dwrPack);
		request.setAttribute("servicePack", servicePack);
		request.setAttribute("serviceImplPack", serviceImplPack);
		request.setAttribute("filePath", filePath);
		request.setAttribute("pojoClass", pojoClass);
		request.setAttribute("moduleName", moduleName);
		
		request.getRequestDispatcher(jspPath).forward(request, response);
	}	
	
	public void init() throws ServletException {
		super.init();
	}
}
