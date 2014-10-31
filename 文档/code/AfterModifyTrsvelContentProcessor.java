package com.eazytec.common.activiti;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.runtime.ProcessInstance;
import com.eazytec.core.iservice.IPersonalOfficeSerivce;
import com.eazytec.core.pojo.OaTrsvel;

/**
 * 调整出差内容处理器
 *
 * @author HenryYan
 */
public class AfterModifyTrsvelContentProcessor implements TaskListener {
	
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
		OaTrsvel trsvel = personalOfficeSerivce.getOaTrsvelByPk(new Long(processInstance.getBusinessKey()));
		
		trsvel.setTrsvelArea((String) delegateTask.getVariable("trsvelArea"));
		trsvel.setTrsvelBegindata((String) delegateTask.getVariable("trsvelBegindata"));
		trsvel.setTrsvelEnddata((String) delegateTask.getVariable("trsvelEnddata"));
		trsvel.setTrsvelCause((String) delegateTask.getVariable("trsvelCause"));
		
		personalOfficeSerivce.saveOaTrsvel(trsvel);
	}

}
