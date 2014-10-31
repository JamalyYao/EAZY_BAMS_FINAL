package com.eazytec.web.servlet.code;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.eazytec.common.util.ConstWords;
import com.eazytec.common.util.file.properties.PropertyTool;
import com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException;

public class CreatePojoAndDaoServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public CreatePojoAndDaoServlet() {
		super();
	}
	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{		
		String absPath = this.getServletContext().getRealPath("");
		String propertyPath = absPath + "/WEB-INF/classes/resource/dbpool/proxool.properties";
		String jspPath = "/erp/code_create/code_create_one.jsp";
		PropertyTool propertyTool = PropertyTool.getInstance(propertyPath);
		request.setAttribute("url", propertyTool.getProperty("sql.driver-url"));
		request.setAttribute("user", propertyTool.getProperty("sql.user"));
		request.setAttribute("password", propertyTool.getProperty("sql.password"));
		request.getRequestDispatcher(jspPath).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String jspPath = "/erp/code_create/code_create_one.jsp";
		String url = request.getParameter("url");
		String user = request.getParameter("user");
		String password = request.getParameter("password");
		String tables = request.getParameter("tables");
		String filePath = request.getParameter("filePath");
		String pojoPack = request.getParameter("pojoPack");
		String daoPack = request.getParameter("daoPack");
		String daoImplPack = request.getParameter("daoImplPack");
		
		CreatePojoAndDao cp = null;
		
		try {
			cp = new CreatePojoAndDao(url,user,password,tables,filePath,pojoPack,daoPack,daoImplPack);
		}catch (ColumnRemarkException e){
			request.setAttribute(ConstWords.TempStringMsg, e.getErrorMessage());
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		if(cp != null){
			try {	
				cp.getTablePojo();//创建pojo
				cp.getTableDao();//创建dao
				cp.getTableDaoImpl();//创建daoImpl
				cp.getConfig();//生成配置临时文件
				cp.openExplorer(filePath);//打开目录
				request.setAttribute(ConstWords.TempStringMsg, "代码生成成功，请查看！");
			} catch (MySQLSyntaxErrorException e){
				request.setAttribute(ConstWords.TempStringMsg, "代码生成失败，数据表不存在！");
			} catch (Exception e) {
				request.setAttribute(ConstWords.TempStringMsg, "代码生成失败，请注意查看相关数据项！");
				e.printStackTrace();
			}
		}
		
		request.setAttribute("url", url);
		request.setAttribute("user", user);
		request.setAttribute("password", password);
		request.setAttribute("tables", tables);
		request.setAttribute("filePath", filePath);
		request.setAttribute("pojoPack", pojoPack);
		request.setAttribute("daoPack", daoPack);
		request.setAttribute("daoImplPack", daoImplPack);
		
		request.getRequestDispatcher(jspPath).forward(request, response);
	}	
	
	public void init() throws ServletException {
		super.init();
	}
}
