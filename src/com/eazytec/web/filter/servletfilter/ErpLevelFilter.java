package com.eazytec.web.filter.servletfilter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.eazytec.common.util.LoginContext;

public class ErpLevelFilter implements Filter {
	private Logger logger = Logger.getLogger(this.getClass());
	private static final String DEFAULT_ENCODE = "GBK";
	
	private Boolean docheck;	//是否使用过滤器
	private String encodeReq;	//请求时编码
	private String encodeResp;  //回应是编码

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		
		httpRequest.setCharacterEncoding(encodeReq);
		httpResponse.setCharacterEncoding(encodeResp);
		boolean flag = true;
		//判断是否已经登陆
		if (docheck) {
			Object obj =  LoginContext.getSessionValueByLogin(httpRequest);
			if(obj==null){
				flag = false;
			}
		}

		if (flag) {
			chain.doFilter(httpRequest, httpResponse);
		} else {
			logger.info("系统尚未登录....");
			httpResponse.sendRedirect(httpRequest.getContextPath()+"/centerSend.jsp");
		}
	}

	public void init(FilterConfig config) throws ServletException {
		String checkLevel = config.getInitParameter("checkLevel");
		if (checkLevel == null) {
			docheck = true;
		} else {
			docheck = Boolean.parseBoolean(checkLevel);
		}
		
		encodeReq = config.getInitParameter("encodeReq");
		encodeResp = config.getInitParameter("encodeResp");
		if (encodeReq == null) {
			encodeReq = DEFAULT_ENCODE;
		}
		if (encodeResp == null) {
			encodeResp = DEFAULT_ENCODE;
		}
	}
}
