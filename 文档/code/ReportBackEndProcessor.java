package com.eazytec.common.activiti;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.runtime.ProcessInstance;
import com.eazytec.core.iservice.IPersonalOfficeSerivce;
import com.eazytec.core.pojo.OaLeaveregistration;
/**
 * 销假后处理器
 * <p>设置销假时间</p>
 * <p>使用Spring代理，可以注入Bean，管理事物</p>
 *
 * @author HenryYan
 */
public class ReportBackEndProcessor implements TaskListener {

	private static final long serialVersionUID = 1L;

    IPersonalOfficeSerivce personalOfficeSerivce;
	
	RuntimeService runtimeService;
	
	public void setPersonalOfficeSerivce(
			IPersonalOfficeSerivce personalOfficeSerivce) {
		this.personalOfficeSerivce = personalOfficeSerivce;
	}

	public void setRuntimeService(RuntimeService runtimeService) {
		this.runtimeService = runtimeService;
	}
	
	/* (non-Javadoc)
	 * @see org.activiti.engine.delegate.TaskListener#notify(org.activiti.engine.delegate.DelegateTask)
	 */
	public void notify(DelegateTask delegateTask) {
		String processInstanceId = delegateTask.getProcessInstanceId();
		ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
		OaLeaveregistration leave = personalOfficeSerivce.getOaLeaveregistrationByPk(new Long(processInstance.getBusinessKey()));
		
		Object realityStartTime = delegateTask.getVariable("realityStartTime");
		leave.setRealityStartTime(realityStartTime.toString());
		Object realityEndTime = delegateTask.getVariable("realityEndTime");
		leave.setRealityEndTime(realityEndTime.toString());
		
		personalOfficeSerivce.saveOaLeaveregistration(leave);
	}

}
