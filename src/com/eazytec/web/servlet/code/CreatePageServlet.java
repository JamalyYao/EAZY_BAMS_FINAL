package com.eazytec.web.servlet.code;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.eazytec.common.util.ConstWords;

public class CreatePageServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public CreatePageServlet(){
		super();
	}
	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String jspPath = "/erp/code_create/code_create_three.jsp";
		String pojoPack = request.getParameter("pojoPack");
		String pojoClass = request.getParameter("pojoClass");
		String pojoShortName = request.getParameter("pojoShortName");
		String pojoName = request.getParameter("pojoName");
		String dwrName = request.getParameter("dwrName");
		String filePath = request.getParameter("filePath");
		String columnCount = request.getParameter("columnCount");
		String folderName = request.getParameter("folderName");
		
		try {
			CreatePage cp = new CreatePage(pojoPack,pojoClass,pojoShortName,pojoName,dwrName,filePath,columnCount,folderName);
			cp.getAddPage();//创建新增/编辑页
			cp.getManagePage();//创建列表页
			cp.getDetailPage();//创建详情页
			cp.openExplorer(filePath);//打开目录
			request.setAttribute(ConstWords.TempStringMsg, "页面生成成功，请查看！");
		} catch (Exception e) {
			request.setAttribute(ConstWords.TempStringMsg, "页面生成失败，请注意查看相关数据项！");
			e.printStackTrace();
		}
		
		request.setAttribute("pojoPack", pojoPack);
		request.setAttribute("pojoClass", pojoClass);
		request.setAttribute("pojoShortName", pojoShortName);
		request.setAttribute("pojoName", pojoName);
		request.setAttribute("dwrName", dwrName);
		request.setAttribute("filePath", filePath);
		request.setAttribute("columnCount", columnCount);
		request.setAttribute("folderName", folderName);
		
		request.getRequestDispatcher(jspPath).forward(request, response);
	}	
	
	public void init() throws ServletException {
		super.init();
	}
}
