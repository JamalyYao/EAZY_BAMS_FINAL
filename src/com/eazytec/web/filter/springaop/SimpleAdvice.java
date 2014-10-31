package com.eazytec.web.filter.springaop;

import javax.servlet.http.HttpServletRequest;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;

import com.eazytec.common.module.SessionUser;
import com.eazytec.common.util.LoginContext;
import com.eazytec.core.pojo.HrmEmployee;

/**
 * 
 * @author Frin
 * @description
 * @more
 */
public class SimpleAdvice implements MethodInterceptor {
	private Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 对方法进行全面跟踪
	 */
	public Object invoke(MethodInvocation invocation) throws Throwable {
		WebContext ctx = WebContextFactory.get();

		if (ctx != null) {
			HttpServletRequest request = ctx.getHttpServletRequest();

			long methodStart = System.currentTimeMillis();
			
			SessionUser sessionUser = (SessionUser) LoginContext.getSessionValueByLogin(request);
			String className = invocation.getThis().getClass().getSimpleName();
			String methodName = invocation.getMethod().getName();

			String name = "中断用户";
			String operate = "";
			HrmEmployee employee =sessionUser.getEmployeeInfo();
			if (employee != null) {
				name = employee.getHrmEmployeeName();
			}
			logger.info("[" + methodStart + "开始]:" + "用户[" + name + ",ip:"
					+ request.getRemoteAddr() + "]：" + "class:" + className
					+ "-method:" + methodName);

			Object methodReturn = invocation.proceed();

			logger.info("[" + methodStart + "结束]:" + "用户[" + name + "]"
					+ operate + "-method:" + methodName + ",耗时："
					+ (System.currentTimeMillis() - methodStart) + "毫秒");

			return methodReturn;
		} else {
			String className = invocation.getThis().getClass().getSimpleName();
			String methodName = invocation.getMethod().getName();
			
			long methodStart = System.currentTimeMillis();
			logger.info("[" + methodStart + "开始]:" + "class:" + className
					+ "-method:" + methodName);

			Object methodReturn = invocation.proceed();

			logger.info("[" + methodStart + "结束]:耗时："
					+ (System.currentTimeMillis() - methodStart) + "毫秒");
			return methodReturn;
		}
	}
}
