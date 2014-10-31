package com.eazytec.web.servlet.code;

import java.io.InputStream;

import com.eazytec.common.util.UtilPrimaryKey;

/**
 * 适用于BAMS项目创建Dwr类及Service类
 * @author JC
 */
public class CreateDwrAndService{
	
	String pojoPack = "";
	String daoPack = "";
	String dwrPack = "";
	String servicePack = "";
	String serviceImplPack = "";
	String filePath = "";
	String dwrClass = "";
	String serviceClass = "";
	String[] daoArray = null;
	String[] pojoArray = null;
	String hqlOrSqlPackName = "";
	String moduleName = "";
	
	public CreateDwrAndService(){
		super();
	}

	public CreateDwrAndService(String pojoPack, String daoPack, String dwrPack, String servicePack,
			String serviceImplPack, String filePath, String moduleName, String pojoClass) {
		this.pojoPack = pojoPack;
		this.daoPack = daoPack;
		this.dwrPack = dwrPack;
		this.servicePack = servicePack;
		this.serviceImplPack = serviceImplPack;
		this.filePath = filePath;
		this.dwrClass = "Dwr"+moduleName+"Service";
		this.serviceClass = "I"+moduleName+"Service";
		this.daoArray = getdaoArray(pojoClass);
		this.pojoArray = getPojoArray(pojoClass);
		this.hqlOrSqlPackName = moduleName+"Pack";
		this.moduleName = moduleName;
	}

	private String[] getdaoArray(String pojoClass) {
		String[] temp = getPojoArray(pojoClass);
		String[] daoArray = new String[temp.length];
		for (int i = 0;i < temp.length;i++) {
			String tempStr = temp[i];
			daoArray[i] = "I"+tempStr+"Dao";
		}
		return daoArray;
	}

	private String[] getPojoArray(String pojoClass) {
		return pojoClass.split(",");
	}

	public void getDwr() throws Exception{
		String reString =this.getDwrString();
		//写入文件
		SaveFile.writeFile(filePath+"/dwr/"+dwrClass+".java", reString);
	}

	private String getDwrString() {
		
		String servicevar = lowerCaseFirstLetter(removeFirstLetter(serviceClass));//接口变量
		
		StringBuffer sb =new StringBuffer();
		sb.append("package "+dwrPack+";\n\n");
		
		for (int i = 0;i < pojoArray.length;i++) {
			String pojo = pojoArray[i];
			sb.append("import "+pojoPack+"."+pojo+";\n");
		}
		
		sb.append("import java.util.ArrayList;\n");
		sb.append("import java.util.List;\n");
		sb.append("import javax.servlet.ServletContext;\n");
		sb.append("import javax.servlet.http.HttpServletRequest;\n");
		sb.append("import com.eazytec.common.module.ResultBean;\n");
		sb.append("import com.eazytec.common.pages.Pager;\n");
		sb.append("import com.eazytec.common.pages.PagerHelper;\n");
		sb.append("import com.eazytec.common.util.UtilTool;\n");
		sb.append("import com.eazytec.common.util.UtilPrimaryKey;\n");
		sb.append("import com.eazytec.common.util.WebUtilWork;\n");
		sb.append("import "+servicePack+"."+serviceClass+";\n\n");
		
		sb.append("/**********************************************\n");
		sb.append(" * Class name:\n");
		sb.append(" * Description:\n");
		sb.append(" * Others:\n");
		sb.append(" * History:\n");
		sb.append(" **********************************************/\n");
		
		sb.append("public class "+dwrClass+" {\n\n");
		sb.append("   private "+serviceClass+" "+servicevar+";\n\n");
		
		sb.append("   public void set"+removeFirstLetter(serviceClass)+"("+serviceClass+" "+servicevar+"){\n");
		sb.append("      this."+servicevar+" = "+servicevar+";\n");
		sb.append("   }\n");
		sb.append("\n");
		
		
		for (int i = 0;i < pojoArray.length;i++) {
			String pojo = pojoArray[i];
			String lowerPojo = lowerCaseFirstLetter(pojo);
			
			sb.append("   /**\n");
			sb.append("    * 查询 "+pojo+" 列表\n");
			sb.append("    * @param context\n");
			sb.append("    * @param request\n");
			sb.append("    * @param "+lowerPojo+"\n");
			sb.append("    * @param pager\n");
			sb.append("    */\n");
			sb.append("   public ResultBean list"+pojo+"(ServletContext context, HttpServletRequest request, "+pojo+" "+lowerPojo+", Pager pager){\n");
			sb.append("      List<"+pojo+"> list = null;\n");
			sb.append("      pager = PagerHelper.getPager(pager,"+servicevar+".list"+pojo+"Count("+lowerPojo+"));\n");
			sb.append("      list = "+servicevar+".list"+pojo+"("+lowerPojo+", pager);\n");
			sb.append("      return WebUtilWork.WebResultPack(list, pager);\n");
			sb.append("   }\n\n");
			
			sb.append("   /**\n");
			sb.append("    * 保存 "+pojo+"\n");
			sb.append("    * @param context\n");
			sb.append("    * @param request\n");
			sb.append("    * @param "+lowerPojo+"\n");
			sb.append("    */\n");
			sb.append("   public ResultBean save"+pojo+"(ServletContext context, HttpServletRequest request, "+pojo+" "+lowerPojo+"){\n");
			sb.append("      "+lowerPojo+".setPrimaryKey(UtilPrimaryKey.getPrimaryKey());\n");
			sb.append("      "+servicevar+".save"+pojo+"("+lowerPojo+");\n");
			sb.append("      return WebUtilWork.WebResultPack(null);\n");
			sb.append("   }\n\n");
			
			sb.append("   /**\n");
			sb.append("    * 更新 "+pojo+"\n");
			sb.append("    * @param context\n");
			sb.append("    * @param request\n");
			sb.append("    * @param "+lowerPojo+"\n");
			sb.append("    */\n");
			sb.append("   public ResultBean update"+pojo+"(ServletContext context, HttpServletRequest request, "+pojo+" "+lowerPojo+"){\n");
			sb.append("      "+servicevar+".save"+pojo+"("+lowerPojo+");\n");
			sb.append("      return WebUtilWork.WebResultPack(null);\n");
			sb.append("   }\n\n");
			
			sb.append("   /**\n");
			sb.append("    * 根据ID获得 "+pojo+"\n");
			sb.append("    * @param context\n");
			sb.append("    * @param request\n");
			sb.append("    * @param pk\n");
			sb.append("    */\n");
			sb.append("   public ResultBean get"+pojo+"ByPk(ServletContext context, HttpServletRequest request, String pk){\n");
			sb.append("      "+pojo+" "+lowerPojo+" = "+servicevar+".get"+pojo+"ByPk(pk);\n");
			sb.append("      return WebUtilWork.WebObjectPack("+lowerPojo+");\n");
			sb.append("   }\n\n");
			
			sb.append("   /**\n");
			sb.append("    * 删除 "+pojo+"\n");
			sb.append("    * @param context\n");
			sb.append("    * @param request\n");
			sb.append("    * @param pks\n");
			sb.append("    */\n");
			sb.append("   public ResultBean delete"+pojo+"ByPks(ServletContext context, HttpServletRequest request, String[] pks){\n");
			sb.append("      "+servicevar+".delete"+pojo+"ByPks(pks);\n");
			sb.append("      return WebUtilWork.WebResultPack(null);\n");
			sb.append("   }\n\n");
		}
		
		sb.append("/**********************************************\n");
		sb.append(" * 以上代码由BAMS代码生成工具自动生成，一般情况下无需修改。\n");
		sb.append(" * 开发人员在此注释以下编写业务逻辑代码，并将自己写的代码框起来，便于后期代码合并，例如：\n");
		sb.append(" **********************************************/\n\n");
		
		sb.append("/**********************JC-begin**********************/\n");
		sb.append("   public void method(){\n");
		sb.append("      System.out.println(\"JC's code here\");\n");
		sb.append("   }\n");
		sb.append("/**********************JC-end**********************/\n\n");
		
		sb.append("/**********************Jacy-begin**********************/\n");
		sb.append("   public void method2(){\n");
		sb.append("      System.out.println(\"Jacy's code here\");\n");
		sb.append("   }\n");
		sb.append("/**********************Jacy-end**********************/\n\n");
		
		sb.append("}");
		
		return sb.toString();
	}
	
	//去除第一个字母
	private String removeFirstLetter(String str) {
		return str.substring(1, str.length());
	}

	//第一个字母小写
	private String lowerCaseFirstLetter(String str) {
		return str.substring(0,1).toLowerCase()+str.substring(1);
	}
	
	

	public void getService() throws Exception{
		String reString = this.getServiceString();
		String reString2 = this.getServiceImplString();
		//写入文件
		SaveFile.writeFile(filePath+"/iservice/"+serviceClass+".java", reString);
		SaveFile.writeFile(filePath+"/service/"+removeFirstLetter(serviceClass)+".java", reString2);
	}

	private String getServiceString() {
		StringBuffer sb =new StringBuffer();
		sb.append("package "+servicePack+";\n\n");
		
		for (int i = 0;i < pojoArray.length;i++) {
			String pojo = pojoArray[i];
			sb.append("import "+pojoPack+"."+pojo+";\n");
		}
		sb.append("import java.util.List;\n");
		sb.append("import com.eazytec.common.pages.Pager;\n\n");
		
		sb.append("public interface "+serviceClass+"{\n\n");
		
		for (int i = 0;i < pojoArray.length;i++) {
			String pojo = pojoArray[i];
			String lowerPojo = lowerCaseFirstLetter(pojo);
			sb.append("   public int list"+pojo+"Count("+pojo+" "+lowerPojo+");\n");
			sb.append("   public List<"+pojo+"> list"+pojo+"("+pojo+" "+lowerPojo+", Pager pager);\n");
			sb.append("   public "+pojo+" save"+pojo+"("+pojo+" "+lowerPojo+");\n");
			sb.append("   public "+pojo+" get"+pojo+"ByPk(String pk);\n");
			sb.append("   public void delete"+pojo+"ByPks(String[] pks);\n\n");
		}
		
		sb.append("}");
		return sb.toString();
	}
	
	private String getServiceImplString() {
		StringBuffer sb =new StringBuffer();
		sb.append("package "+serviceImplPack+";\n\n");
		
		for (int i = 0;i < pojoArray.length;i++) {
			String pojo = pojoArray[i];
			sb.append("import "+pojoPack+"."+pojo+";\n");
		}
		
		for (int i = 0;i < daoArray.length;i++) {
			String dao = daoArray[i];
			sb.append("import "+daoPack+"."+dao+";\n");
		}
		sb.append("import com.eazytec.core.iservice."+serviceClass+";\n");
		sb.append("import com.eazytec.common.pages.Pager;\n");
		sb.append("import com.eazytec.common.pack."+moduleName+"Pack;\n");
		sb.append("import java.util.List;\n\n");
		
		sb.append("public class "+removeFirstLetter(serviceClass)+" implements "+serviceClass+"{\n\n");
		
		for (int i = 0;i < daoArray.length;i++) {
			String dao = daoArray[i];
			String daovar = lowerCaseFirstLetter(removeFirstLetter(dao));
			sb.append("   private "+dao+" "+daovar+";\n");
		}
		
		sb.append("\n");
		
		for (int i = 0;i < daoArray.length;i++) {
			String dao = daoArray[i];
			String daovar = lowerCaseFirstLetter(removeFirstLetter(dao));
			sb.append("   public void set"+removeFirstLetter(dao)+"("+dao+" "+daovar+"){\n");
			sb.append("      this."+daovar+" = "+daovar+";\n");
			sb.append("   }\n");
			sb.append("\n");
		}
		
		
		
		for (int i = 0;i < pojoArray.length;i++) {
			String pojo = pojoArray[i];
			String lowerPojo = lowerCaseFirstLetter(pojo);
			String pojoDao = lowerPojo+"Dao";
			
			sb.append("   public int list"+pojo+"Count("+pojo+" "+lowerPojo+"){\n");
			sb.append("      int count = "+pojoDao+".findByHqlWhereCount("+moduleName+"Pack.pack"+pojo+"Query("+lowerPojo+"));\n");
			sb.append("      return count;\n");
			sb.append("   }\n\n");
			
			sb.append("   public List<"+pojo+"> list"+pojo+"("+pojo+" "+lowerPojo+", Pager pager){\n");
			sb.append("      List<"+pojo+"> list = "+pojoDao+".findByHqlWherePage("+moduleName+"Pack.pack"+pojo+"Query("+lowerPojo+"), pager);\n");
			sb.append("      return list;\n");
			sb.append("   }\n\n");
			
			sb.append("   public "+pojo+" save"+pojo+"("+pojo+" "+lowerPojo+"){\n");
			sb.append("      "+pojo+" temp = ("+pojo+")"+pojoDao+".save("+lowerPojo+");\n");
			sb.append("      return temp;\n");
			sb.append("   }\n\n");
			
			sb.append("   public "+pojo+" get"+pojo+"ByPk(String pk){\n");
			sb.append("      "+pojo+" "+lowerPojo+" = ("+pojo+")"+pojoDao+".getByPK(pk);\n");
			sb.append("      return "+lowerPojo+";\n");
			sb.append("   }\n\n");
			
			sb.append("   public void delete"+pojo+"ByPks(String[] pks){\n");
			sb.append("      for (String l : pks) {\n");
			sb.append("         "+pojo+" "+lowerPojo+" = "+pojoDao+".getByPK(l);\n");
			sb.append("         "+pojoDao+".remove("+lowerPojo+");\n");
			sb.append("      }\n");
			
			sb.append("   }\n\n");
		}
		
		sb.append("}");
		return sb.toString();
	}
	
	public void getPack() throws Exception {
		String reString =this.getPackString();
		SaveFile.writeFile(filePath+hqlOrSqlPackName+".java", reString);
	}

	private String getPackString() {
		StringBuffer sb =new StringBuffer();
		sb.append("package com.eazytec.common.pack;\n\n");
		
		for (int i = 0;i < pojoArray.length;i++) {
			String pojo = pojoArray[i];
			sb.append("import "+pojoPack+"."+pojo+";\n");
		}
		
		sb.append("import com.eazytec.common.util.UtilWork;\n\n");
		
		sb.append("public class "+moduleName+"Pack{\n\n");
		
		for (int i = 0;i < pojoArray.length;i++) {
			String pojo = pojoArray[i];
			sb.append("   public static String pack"+pojo+"Query("+pojo+" "+lowerCaseFirstLetter(pojo)+"){\n");
			sb.append("      StringBuffer result = new StringBuffer();\n");
			sb.append("      return result.toString();\n");
			sb.append("   }\n\n");
		}
		
		sb.append("}");
		return sb.toString();
	}

	public void getConfig() throws Exception {
		StringBuffer sb=new StringBuffer();
		
		sb.append("===========复制到dwr_service.xml文件=============\n");
		sb.append("<create javascript=\"dwr"+moduleName+"Service\" creator=\"spring\">\n");
		sb.append("   <param name=\"beanName\" value=\"dwr"+moduleName+"Service\"/>\n");
		sb.append("</create>\n");
		sb.append("==============================================\n\n");
		
		sb.append("===========复制到spring-service.xml文件 Dwr配置区=============\n");
		sb.append("<bean id=\"dwr"+moduleName+"Service\" class=\""+dwrPack+"."+dwrClass+"\">\n");
		sb.append("   <property name=\""+lowerCaseFirstLetter(moduleName)+"Service\" ref=\""+lowerCaseFirstLetter(moduleName)+"Service\"/>\n");
		sb.append("</bean>\n");
		sb.append("==============================================\n\n");
		
		sb.append("===========复制到spring-service.xml文件 Service配置区=============\n");
		sb.append("<bean id=\""+lowerCaseFirstLetter(moduleName)+"Service\" class=\""+serviceImplPack+"."+moduleName+"Service\">\n");
		
		for (int i = 0;i < pojoArray.length;i++) {
			String pojo = pojoArray[i];
			sb.append("   <property name=\""+lowerCaseFirstLetter(pojo)+"Dao\" ref=\""+lowerCaseFirstLetter(pojo)+"DaoImpl\"></property>\n");
		}
		
		sb.append("</bean>\n");
		sb.append("==============================================\n\n");
			
		SaveFile.writeFile(filePath+"dwrAndServiceConfig.txt", sb.toString());
	}
	
	public static void main(String[] args) {
		String pojoPack = "com.eazytec.core.pojo";
		String daoPack = "com.eazytec.core.dao";
		String dwrPack = "com.eazytec.web.controller.dwr";
		String servicePack = "com.eazytec.core.iservice";
		String serviceImplPack = "com.eazytec.core.service";
		String filePath = "c:/userfiles/";
		String moduleName = "Project";
		String pojoClass = "HrmEmployee,HrmDepartment";
		CreateDwrAndService cp = new CreateDwrAndService(pojoPack,daoPack,dwrPack,servicePack,serviceImplPack,filePath,moduleName,pojoClass);
		try {
			cp.getDwr();
			cp.getService();//创建Service
			cp.getPack();
			cp.getConfig();//生成配置临时文件
		} catch (Exception e) {
			e.printStackTrace();
		}//创建Dwr
	}
	

	/**
	 * 打开目录
	 * @param dir
	 */
	public void openExplorer(String dir){
		Runtime run = Runtime.getRuntime();   
	    try {   
	        // run.exec("cmd /k shutdown -s -t 3600");   
	        Process process = run.exec("cmd.exe /c start " + dir);   
	        InputStream in = process.getInputStream();     
	        while (in.read() != -1) {   
	            System.out.println(in.read());   
	        }   
	        in.close();   
	        process.waitFor();   
	    } catch (Exception e) {            
	        e.printStackTrace();   
	    }   
	}
}
