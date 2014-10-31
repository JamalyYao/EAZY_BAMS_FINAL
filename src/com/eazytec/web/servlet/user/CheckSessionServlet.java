package com.eazytec.web.servlet.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.eazytec.common.module.SessionUser;
import com.eazytec.common.util.ConstWords;
import com.eazytec.common.util.LoginContext;
import com.eazytec.common.util.net.ConnectionUrl;
import com.eazytec.common.util.security.Base64;
import com.eazytec.core.iservice.IUserLoginService;
import com.eazytec.core.pojo.SysMethodInfo;
import com.eazytec.web.listener.OnlineUserBindingListener;
import com.eazytec.web.servlet.ServletServiceController;

/**
 * 切换工程对登录用户验证
 * 
 * @author Administrator
 * 
 */
public class CheckSessionServlet extends ServletServiceController {
	private Logger log = Logger.getLogger(this.getClass());
	/**
	 * 
	 */
	private static final long serialVersionUID = -7036407629385969386L;

	public CheckSessionServlet() {
		super();
	}

	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean bl = true;
		String path = "";
		Object[] obj = new Object[2];
		String cumid = request.getParameter("cumid");// 当前所在工程主键
		String mid = request.getParameter("mid");// 将要跳转工程主键
		IUserLoginService userLoginService = this.getUserLoginService();
		String rm = request.getParameter("rm");
		if (rm != null) {
			String[] rms = Base64.getStringFromBase64(rm).split(",");
			if (rms.length > 0) {
				if (rms[0].equals(ConstWords.ServletTypeExit)) {
					path = "login.jsp";
				} else if (rms[0].equals(ConstWords.ServletTypeSend)) {
					path = rms[1];
				} else if (rms[0].equals(ConstWords.ServletTypeFreeSend)) {
					String code =rms[1];
					SysMethodInfo fmethod = userLoginService.getMethodInfoByPk(code);
					// 创建即将请求工程的session
					String url = fmethod.getMethodUri() + "sessionServlet";
					SessionUser sUser = (SessionUser) LoginContext.getSessionValueByLogin(request);
					response.sendRedirect(url + "?par="
							+ Base64.getBase64FromString(ConstWords.ServletTypeCreateSend + "," + sUser.getCompanyCode() + "," + sUser.getUserName() + "," + fmethod.getPrimaryKey()));
					return;
				}
			}
		} else {
			if (mid.equals("exit")) {// 系统退出
				path = "login.jsp";
				// 释放平台session
				LoginContext.removeSessionByLogin(request);
				
				//在线人员
				HttpSession session  =request.getSession(true);
				session.removeAttribute(ConstWords.OnLineUser_Sign);
				
				SysMethodInfo current = userLoginService.getMethodInfoByPk(cumid);
				if (current.getIsDefault() == null || current.getIsDefault() != ConstWords.CurrentProject) {
					String url = current.getMethodUri() + "sessionServlet";
					response.sendRedirect(url + "?par=" + Base64.getBase64FromString(ConstWords.ServletTypeFree + "," + path));
					return;
				}
			} else {
				if (LoginContext.getSessionValueByLogin(request) == null) {
					bl = false;
					log.info("用户登录超时!");
				} else {
					SessionUser sUser = (SessionUser) LoginContext.getSessionValueByLogin(request);
					// 查询当前工程是否为平台，不是释放当前工程session
					SysMethodInfo currentMethodInfo = userLoginService.getMethodInfoByPk(cumid);
					SysMethodInfo forwardMethodInfo = userLoginService.getMethodInfoByPk(mid);
					if (currentMethodInfo.getIsDefault() != null && currentMethodInfo.getIsDefault() == ConstWords.CurrentProject) {
						String url = forwardMethodInfo.getMethodUri() + "sessionServlet";
						// 创建即将请求工程的session
						response.sendRedirect(url + "?par="
								+ Base64.getBase64FromString(ConstWords.ServletTypeCreateSend + "," + sUser.getCompanyCode() + "," + sUser.getUserName() + "," + forwardMethodInfo.getPrimaryKey()));
						return;
					} else {
						// 请求释放session
						String url = currentMethodInfo.getMethodUri() + "sessionServlet";
						response.sendRedirect(url + "?par=" + Base64.getBase64FromString(ConstWords.ServletTypeFreeSend + "," + forwardMethodInfo.getPrimaryKey()));
						return;
					}
				}
			}
		}
		obj[0] = bl;
		obj[1] = path;
		request.setAttribute(ConstWords.TempCheckSession, obj);
		request.getRequestDispatcher("erp/checkSession.jsp").forward(request, response);
	}

	public void init() throws ServletException {
		super.init();
		super.setContext(this.getServletContext());
	}

}
