<%@ page pageEncoding="UTF-8" language="java"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.eazytec.core.pojo.HrmDepartment"%>
<%@page import="com.eazytec.web.controller.dwr.DwrHrmEmployeeService"%>
<%
String fid = request.getParameter("fid");
if(fid == null||fid.length()==0){
	return;
}else{
	WebApplicationContext webAppContext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
	DwrHrmEmployeeService hrmService = (DwrHrmEmployeeService)webAppContext.getBean("dwrHrmEmployeeService");
	List<HrmDepartment> deptlist = hrmService.listDownDepartByCode(request,fid);
	if(deptlist!=null&& deptlist.size()>0){
		StringBuffer sb = new StringBuffer();
		sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
		sb.append("<tree>\n");
		for(int i=0;i<deptlist.size();i++){
			HrmDepartment dep = deptlist.get(i);
			String tmp = "";
			int row = hrmService.listDownDepartByCodeCount(request,dep.getHrmDepCode());
			if(row>0){
				tmp ="src=\"xmlshow.jsp?fid="+dep.getHrmDepCode()+"\"  action=\"alert("+dep.getPrimaryKey()+");\"";
			}else{
				tmp ="type =\"check\" onchange=\"alert("+dep.getPrimaryKey()+");\"";
			}
			//输出树节点
			sb.append("<tree id =\"dept_"+dep.getPrimaryKey()+"\" text=\""+dep.getHrmDepName()+"\" value=\""+dep.getHrmDepId()+"\" "+tmp+"/>\n");
		}
		sb.append("</tree>");
		if(sb.toString().length()>0){
			response.setContentType("text/xml; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print(sb.toString());
			pw.flush();
			pw.close();
		}
	}
}
%>
