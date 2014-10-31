package com.eazytec.web.servlet.code;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;

/**
 * 适用于boer_erp项目创建pojo类及dao类
 * @author peng.ning
 *
 */
public class CreatePojoAndDao {

	private Connection conn = null;
	private String url = "";
	private String userName = "";
	private String userPwd = "";
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private ResultSetMetaData rm = null;
	private int isAllTable =0;
	private ArrayList<String> tables = new ArrayList<String>();//生成的表名
	private String pojopack = "";
	private String daopack = "";
	private String daoimplpack = "";
	private String filePath = "";
	
	private String databaseName = "";
	private static final String MYSQL = "mysql";
	private static final String ORACLE = "oracle";
	
	//oracle字段类型为NUMBER 并且长度为11的， 处理为java的Integer类型
	private static final int ORACLE_INTEGER_LENGTH = 11;
	
	public CreatePojoAndDao(){
		super();
	}
	
	//连接数据库
	public CreatePojoAndDao(String url, String userName, String userPwd, String tablestr,
			String filePath, String pojoPack, String daoPack, String daoImplPack) throws Exception{
		this.url = url;
		this.userName = userName;
		this.userPwd = userPwd;
		this.pojopack = pojoPack;
		this.daopack = daoPack;
		this.daoimplpack = daoImplPack;
		this.filePath = filePath;
		
		isAllTable = 1;//0查询库中所有用户表 1指定表名
		
		if(url.indexOf(MYSQL) != -1){
			this.databaseName = MYSQL;
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, userName, userPwd);
		}else if(url.indexOf(ORACLE) != -1){
			this.databaseName = ORACLE;
			Properties props = new Properties();
			props.put("user", userName);
			props.put("password", userPwd);
			props.put("remarksReporting","true");
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, props);
		}
		
		String[] tableArray = tablestr.split(",");
		
		//检测表字段注释格式
		for (String table : tableArray){
			List<String> remarks = getRemarks(conn,table);
			for (String remark : remarks) {
				if(StringUtils.isNotBlank(remark)){
					if(remark.split(remark).length != ColumnProperty.PROPERTY_COUNT){
						String message = "表字段注释格式错误！<br/>表名："+table+"<br/>注释内容："+remark;
						throw new ColumnRemarkException(message);
					}
				}
			}
		}
		
		for (String table : tableArray) {
			tables.add(table);//在此处放入自定义表，并将isAllTable修改为1
		}
	}
	
	//获取库中所有用户表
	private ArrayList<String> getDataTables() throws Exception{
		ArrayList<String> tmpList =new ArrayList<String>();
		String sql ="select name FROM sysobjects WHERE type='U'";
		conn =getConn();
		ps= conn.prepareStatement(sql);
		rs =ps.executeQuery();
		while(rs.next()){
			tmpList.add(rs.getString(1));
		}
		this.closeConn(conn, ps, rs);
		return tmpList;
	}
	private Connection getConn() throws Exception{
		if(conn == null){
			conn =DriverManager.getConnection(url, userName, userPwd);
		}
		return conn;
	}
	private void closeConn(Connection con,PreparedStatement ps,ResultSet rs) throws Exception{
		if (rs!= null) {
			rs.close();
			rs=null;
		}
		if (ps!= null) {
			ps.close();
			ps=null;
		}
		if (con!= null) {
			con.close();
			conn = null;
		}
	}
	public void getTablePojo() throws Exception{
		if (isAllTable == 0) {
			tables=this.getDataTables();
		}
		for (int i = 0; i < tables.size(); i++) {
			String sql ="select * from "+tables.get(i);
			String reString =this.getTableString(sql,tables.get(i));
			//写入文件
			SaveFile.writeFile(filePath+"/pojo/"+getTableOrColumn(tables.get(i), 1)+".java", reString);
		}
	}
	
	public void getTableDao() throws Exception{
		if (isAllTable == 0) {
			tables=this.getDataTables();
		}
		for (int i = 0; i < tables.size(); i++) {
			String sql ="select * from "+tables.get(i);
			String reString =this.getTableDaoString(sql,tables.get(i));
			//写入文件
			SaveFile.writeFile(filePath+"/dao/I"+getTableOrColumn(tables.get(i), 1)+"Dao.java", reString);
		}
	}
	
	public void getTableDaoImpl() throws Exception{
		if (isAllTable == 0) {
			tables=this.getDataTables();
		}
		for (int i = 0; i < tables.size(); i++) {
			String sql ="select * from "+tables.get(i);
			String reString =this.getTableDaoImplString(sql,tables.get(i));
			//写入文件
			SaveFile.writeFile(filePath+"/daoimpl/"+getTableOrColumn(tables.get(i), 1)+"DaoImpl.java", reString);
		}
	}
	
	private String getTableDaoImplString(String sql,String tableName) throws Exception{
		StringBuffer sb =new StringBuffer();
		String tname= getTableOrColumn(tableName, 1);
		sb.append("package "+daoimplpack+";\n\n");
		sb.append("import "+pojopack+".*;\n");
		sb.append("import "+daopack+".*;\n");
		sb.append("/**\n");
		sb.append(" * 表："+tableName+" 对应daoImpl\n");
		sb.append(" */\n");
		conn=getConn();
		ps= conn.prepareStatement(sql);
		rs= ps.executeQuery();
		rm=rs.getMetaData();
		String tmp="";
		if (rm.getColumnCount()>0) {
			int type =rm.getColumnType(1);
			if (type==Types.INTEGER) {
				tmp="Long";
			}else{
				tmp ="String";
			}
		}
		sb.append("public class "+tname+"DaoImpl extends BaseHapiDaoimpl<"+tname+", "+tmp+"> implements I"+tname+"Dao {\n\n");
		sb.append("   public "+tname+"DaoImpl(){\n");
		sb.append("      super("+tname+".class);\n");
		sb.append("   }\n");
		sb.append("}");
		this.closeConn(conn, ps, rs);
		return sb.toString();
	}
	
	private String getTableDaoString(String sql,String tableName) throws Exception{
		StringBuffer sb =new StringBuffer();
		String tname= getTableOrColumn(tableName, 1);
		sb.append("package "+daopack+";\n\n");
		sb.append("import "+pojopack+".*;\n");
		sb.append("/**\n");
		sb.append(" * 表："+tableName+" 对应dao\n");
		sb.append(" */\n");
		conn=getConn();
		ps= conn.prepareStatement(sql);
		rs= ps.executeQuery();
		rm=rs.getMetaData();
		String tmp="";
		if (rm.getColumnCount()>0) {
			int type =rm.getColumnType(1);
			if (type==Types.INTEGER) {
				tmp="Long";
			}else{
				tmp ="String";
			}
		}
		sb.append("public interface I"+tname+"Dao extends BaseDao<"+tname+","+tmp+">{\n\n");
		sb.append("}");
		this.closeConn(conn, ps, rs);
		return sb.toString();
	}
	
	/**
	 * 获得字段名及字段注释
	 * @param conn
	 * @param tableName
	 * @return
	 * @throws SQLException
	 */
	private List<String> getRemarks(Connection conn, String tableName) throws SQLException {
		List<String> list = new ArrayList<String>();
		DatabaseMetaData dbmd = conn.getMetaData();
		ResultSet resultSet = null;
		
		if(databaseName.equals(MYSQL)){
			resultSet = dbmd.getTables(null, "%", "%", new String[] { "TABLE" });
			
			while (resultSet.next()) {
		        String t = resultSet.getString("TABLE_NAME");
		        if(t.equals(tableName)){
		        	ResultSet rs = dbmd.getColumns(null, "%", tableName, "%");
		            while(rs.next()){
		                list.add(rs.getString("REMARKS"));
		            }
		        }
		    }
		}else if(databaseName.equals(ORACLE)){
			
			tableName = tableName.toUpperCase();
			resultSet = dbmd.getTables(conn.getCatalog(), "EAZYBAMS", null, new String[] { "TABLE" });
			
			while (resultSet.next()) {
		        String t = resultSet.getString("TABLE_NAME");
		        if(t.equals(tableName)){
		        	ResultSet rs = dbmd.getColumns(conn.getCatalog(), "EAZYBAMS", tableName, "%");
		        	while(rs.next()){
		                list.add(rs.getString("REMARKS"));
		            }
		        }
		    }
		}
		
		return list;
	}
	
	private String getTableString(String sql,String tableName) throws Exception{
		StringBuffer sb =new StringBuffer();
		String tname= getTableOrColumn(tableName, 1);
		sb.append("package "+pojopack+";\n\n");
		sb.append("import com.eazytec.common.annotation.Remark;\n\n");
		sb.append("/**\n");
		sb.append(" * 数据库表名："+tableName+"\n");
		sb.append(" */\n");
		conn=getConn();
		ps= conn.prepareStatement(sql);
		rs= ps.executeQuery();
		rm=rs.getMetaData();
		List<String> remarks = getRemarks(conn, tableName);
		String tmp="";
		if (rm.getColumnCount()>0) {
			int type =rm.getColumnType(1);
			if (type==Types.INTEGER) {
				tmp="BaseBean";
			}else{
				tmp ="BaseStringBean";
			}
		}
		sb.append("public class "+tname+" extends "+tmp+" implements java.io.Serializable {\n\n");
		for (int i = 2; i <=rm.getColumnCount(); i++) {
		
			String remark = remarks.get(i-1);//字段注释
			int columnSize = rm.getPrecision(i);//字段长度
			int columnType = rm.getColumnType(i);//字段类型
			String cname = getTableOrColumn(rm.getColumnName(i), 0);
			
			//如果字段有注释并且注释格式正确，加上@Remark注解
			if(StringUtils.isNotBlank(remark)){
				sb.append("   @Remark(\""+remark+"\")\n");
			}
			
			if (columnType == Types.INTEGER) {
				sb.append("   private Integer "+cname+";\n");
			}else if(columnType == Types.NUMERIC){
				//如果oracle字段类型为NUMBER 并且长度为11的， 处理为java的Integer类型，否则为Double类型
				if(columnSize == ORACLE_INTEGER_LENGTH){
					sb.append("   private Integer "+cname+";\n");
				}else{
					sb.append("   private Double "+cname+";\n");
				}
				
			}else if(columnType == Types.DOUBLE || columnType == Types.FLOAT){
				sb.append("   private Double "+cname+";\n");
			}else{
				sb.append("   private String "+cname+";\n");
			}
		}
		sb.append("\n");
		sb.append("   //默认构造方法\n");
		sb.append("   public "+tname+"(){\n");
		sb.append("      super();\n");
		sb.append("   }\n");
		
		sb.append("\n");
		sb.append("   //构造方法(手工生成)\n");
		sb.append("   \n");
		
		sb.append("\n");
		sb.append("  //get和set方法\n");
		for (int i = 2; i <=rm.getColumnCount(); i++) {
			
			String cname = getTableOrColumn(rm.getColumnName(i), 0);
			int columnSize = rm.getPrecision(i);//字段长度
			int columnType = rm.getColumnType(i);
			
			if (columnType == Types.INTEGER) {
				sb.append(this.createGetAndSetMethod("Integer", cname));
			}else if(columnType == Types.NUMERIC){
				//如果oracle字段类型为NUMBER 并且长度为11的， 处理为java的Integer类型，否则为Double类型
				if(columnSize == ORACLE_INTEGER_LENGTH){
					sb.append(this.createGetAndSetMethod("Integer", cname));
				}else{
					sb.append(this.createGetAndSetMethod("Double", cname));
				}
				
			}else if(columnType == Types.DOUBLE || columnType == Types.FLOAT){
				sb.append(this.createGetAndSetMethod("Double", cname));
			}else{
				sb.append(this.createGetAndSetMethod("String", cname));
			}
		
		}
		sb.append("}");
		this.closeConn(conn, ps, rs);
		return sb.toString();
	}
	
	private String createGetAndSetMethod(String type,String colsName){
		StringBuffer result =new StringBuffer();
		String tmp1 =colsName.substring(0,1).toUpperCase();
		String tmp2 =colsName.substring(1,colsName.length());
		String tmp3 ="a"+tmp1+tmp2;
		result.append("   public "+type+" get"+tmp1+tmp2+"(){\n");
		result.append("      return "+colsName+";\n");
		result.append("   }\n");
		result.append("\n");
		result.append("   public void set"+tmp1+tmp2+"("+type+" "+tmp3+"){\n");
		result.append("      this."+colsName+" = "+tmp3+";\n");
		result.append("   }\n");
		result.append("\n");
		return result.toString();
	}
	//对表名和列名进行转换 type==1为表名 否则为列名
	private String getTableOrColumn(String oldname,int type){
		String tmp =oldname.toLowerCase();
		String newStr="";
		if (type == 1) {
			String[] tbs =tmp.split("_");
			for (int i = 0; i < tbs.length; i++) {
				String strat=tbs[i].substring(0,1).toUpperCase();
				String end =tbs[i].substring(1,tbs[i].length());
				newStr+=strat+end;
			}
		}else{
			String[] cols =tmp.split("_");
			for (int i = 0; i < cols.length; i++) {
				if (i==0) {
					newStr+=cols[i];
				}else{
					String strat=cols[i].substring(0,1).toUpperCase();
					String end =cols[i].substring(1,cols[i].length());
					newStr+=strat+end;
				}
			}
		}
		return newStr;
		
	}
	
	public void getConfig() throws Exception{
		if (isAllTable == 0) {
			tables=this.getDataTables();
		}
		StringBuffer writeString=new StringBuffer();
		writeString.append("===========复制到dwr_base.xml文件=============\n");
		for (int i = 0; i < tables.size(); i++) {
			String dwrStr =this.getDwrString(tables.get(i));//dwr_base配置文件
			writeString.append(dwrStr);
		}
		writeString.append("==============================================\n\n");
		writeString.append("===========复制到spring-service.xml文件 Dao配置区=============\n");
		for (int i = 0; i < tables.size(); i++) {
			String springStr =this.getSpringString(tables.get(i));//spring-service配置文件
			writeString.append(springStr);
		}
		writeString.append("==============================================\n\n");
		writeString.append("===========复制到com.eazytec.erp.hbm.xml文件=============\n");
		for (int i = 0; i < tables.size(); i++) {
			String sql ="select * from "+tables.get(i);
			String hibString =this.getHibernateString(sql,tables.get(i));
			writeString.append(hibString);
		}
		writeString.append("==============================================\n\n");
		SaveFile.writeFile(filePath+"config.txt", writeString.toString());
	} 
	private String getDwrString(String tableName){
		StringBuffer sb =new StringBuffer();
		String tname= getTableOrColumn(tableName, 1);
		sb.append("<convert converter=\"hibernate3\" match=\""+pojopack+"."+tname+"\"/>\n");
		return sb.toString();
	}
	
	private String getSpringString(String tableName){
		StringBuffer sb= new StringBuffer();
		String tname =getTableOrColumn(tableName, 1);
		sb.append("<bean id=\""+getTableOrColumn(tableName,0)+"DaoImpl\" class=\""+daoimplpack+"."+tname+"DaoImpl\">\n");
		sb.append("    <property name=\"sessionFactory\" ref=\"sessionFactory\"/>\n</bean>\n");
		return sb.toString();
	}
	
	private String getHibernateString(String sql,String tableName) throws Exception{
		StringBuffer sb= new StringBuffer();
		String tname =getTableOrColumn(tableName, 1);
		conn=getConn();
		ps= conn.prepareStatement(sql);
		rs= ps.executeQuery();
		rm=rs.getMetaData();
		String tmp="";
		String tmp2=null;
		String oneCol="";
		if (rm.getColumnCount()>0) {
			oneCol =rm.getColumnName(1);
			int type =rm.getColumnType(1);
			if (type==Types.INTEGER) {
				tmp="long";
			}else{
				tmp ="java.lang.String";
			}
			if (rm.isAutoIncrement(1)) {
				tmp2="        <generator class=\"identity\" />";
			}
		}
		sb.append("<class name=\""+pojopack+"."+tname+"\" table=\""+tableName+"\" >\n");
		sb.append("    <id name=\"primaryKey\" type=\""+tmp+"\">\n");
		sb.append("        <column name=\""+oneCol+"\" />\n");
		if (tmp2 != null) {
			sb.append(tmp2+"\n");
		}
		sb.append("    </id>\n");
		for (int i = 2; i <=rm.getColumnCount(); i++) {
			String cname = getTableOrColumn(rm.getColumnName(i), 0);
			
			int columnSize = rm.getPrecision(i);//字段长度
			int columnType = rm.getColumnType(i);
			
			if (columnType == Types.INTEGER) {
				sb.append(this.CreateHib("java.lang.Integer", cname,rm.getColumnName(i)));
			}else if(columnType == Types.NUMERIC){
				//如果oracle字段类型为NUMBER 并且长度为11的， 处理为java的Integer类型，否则为Double类型
				if(columnSize == ORACLE_INTEGER_LENGTH){
					sb.append(this.CreateHib("java.lang.Integer", cname,rm.getColumnName(i)));
				}else{
					sb.append(this.CreateHib("java.lang.Double", cname,rm.getColumnName(i)));
				}
				
			}else if(columnType == Types.DOUBLE || columnType == Types.FLOAT){
				sb.append(this.CreateHib("java.lang.Double", cname,rm.getColumnName(i)));
			}else{
				sb.append(this.CreateHib("java.lang.String", cname,rm.getColumnName(i)));
			}
		}
		sb.append("</class>\n\n");
		return sb.toString();
	}
	private String CreateHib(String type,String colName,String baseColName){
		StringBuffer sb =new StringBuffer();
		sb.append("    <property name=\""+colName+"\" type=\""+type+"\">\n");
		sb.append("        <column name=\""+baseColName+"\"/>\n");
		sb.append("    </property>\n");
		return sb.toString();
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
