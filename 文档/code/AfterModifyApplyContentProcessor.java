package com.eazytec.common.activiti;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.runtime.ProcessInstance;
import com.eazytec.core.iservice.IPersonalOfficeSerivce;
import com.eazytec.core.pojo.OaLeaveregistration;

/**
 * 调整请假内容处理器
 *
 * @author HenryYan
 */
public class AfterModifyApplyContentProcessor implements TaskListener {
	
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
		
		leave.setLeavetype((Integer) delegateTask.getVariable("leavetype"));
		leave.setStartdata((String) delegateTask.getVariable("startdata"));
		leave.setEnddata((String) delegateTask.getVariable("enddata"));
		leave.setLeavereason((String) delegateTask.getVariable("leavereason"));
		
		personalOfficeSerivce.saveOaLeaveregistration(leave);
	}

}
