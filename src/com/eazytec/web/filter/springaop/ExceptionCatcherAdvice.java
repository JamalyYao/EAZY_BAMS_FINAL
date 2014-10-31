package com.eazytec.web.filter.springaop;

import java.lang.reflect.Method;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.aop.ThrowsAdvice;
import com.eazytec.common.module.SessionUser;
import com.eazytec.common.util.EnumUtil;
import com.eazytec.common.util.LoginContext;
import com.eazytec.common.util.UtilWork;
import com.eazytec.core.dao.ISysExceptionDao;
import com.eazytec.core.pojo.HrmEmployee;
import com.eazytec.core.pojo.SysException;

	public class ExceptionCatcherAdvice implements ThrowsAdvice {
		private Logger logger = Logger.getLogger(this.getClass());
		private ISysExceptionDao sysExceptionDao;
		
		public void setSysExceptionDao(ISysExceptionDao sysExceptionDao) {
			this.sysExceptionDao = sysExceptionDao;
		}
		
	    public void afterThrowing(Method method, Object[] args, Object target,
	            Exception throwable) throws Throwable {
	    	
	    	WebContext ctx = WebContextFactory.get();
	    	int userId =-1;
		    int companyId= -1;
		    String exceptionClass = throwable.fillInStackTrace().toString();//异常类型
		    String className = target.getClass().getName();
		    String methodName = method.getName();
		    String exceptionMsg = throwable.getMessage()+ "," + throwable.getCause();  
		    StringBuffer sb =new StringBuffer(); 
		    for(int i=0;i<throwable.getStackTrace().length;i++){
		    	sb.append(throwable.getStackTrace()[i]);
		    }
		    
	    	if (ctx != null) {
	    		HttpServletRequest request = ctx.getHttpServletRequest();
	    		
		    	SessionUser sessionUser = (SessionUser) LoginContext.getSessionValueByLogin(request);
				String name = "中断用户";
				HrmEmployee employee =sessionUser.getEmployeeInfo();
				if (employee != null) {
					name = employee.getHrmEmployeeName();
				}
				
		        //for(Object o:args){  
		        //    System.out.println("方法的参数：   " + o.toString());  
		        //}  
				
				if(sessionUser != null){
		        	userId = Integer.parseInt(sessionUser.getUserInfo().getPrimaryKey()+"");
		        	companyId = Integer.parseInt(sessionUser.getCompanyId()+"");
		        }
		        logger.info("用户[" + name + ",ip:"
						+ request.getRemoteAddr() + "]：" + "exception:" + exceptionClass + "-class:" + className
						+ "-method:" + methodName);
	    	}else{
	    		logger.info("exception:" + exceptionClass + "-class:" + className + "-method:" + methodName);
	    	}
	    	
    		SysException sException =new SysException();
	        
	        sException.setUserId(userId);
	        sException.setCompanyId(companyId);
	        sException.setExceptionClass(exceptionClass);
	        sException.setExceptionDate(UtilWork.getNowTime());
	        sException.setExceptionMsg(exceptionMsg);
	        sException.setExceptionContext(sb.toString());
	        sException.setExceptionStatus(EnumUtil.SYS_EXCEPTION_STATUS.Vaild.value);
	        sysExceptionDao.save(sException);
	    }
	
	}
