package com.eazytec.common.activiti;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import com.eazytec.common.util.im.ImMessageConstants;
import com.eazytec.common.util.im.ImMessageHandler;
import com.eazytec.core.iservice.ISysProcessService;
import com.eazytec.core.pojo.SysUserInfo;

/**
 * 申请接收人处理器
 * @author jc
 */
public class AssignmentHandler implements TaskListener {
	
	private static final long serialVersionUID = 1L;
	
	ISysProcessService sysProcessService;

	public void setSysProcessService(ISysProcessService sysProcessService) {
		this.sysProcessService = sysProcessService;
	}

	public void notify(DelegateTask delegateTask) {
		
		//设置流程接收人
		String uid = (String) delegateTask.getVariable(ProcessConstants.KEY_ASSIGNMENT_ID);
		delegateTask.setAssignee(uid);
		
		//推送提醒消息
		SysUserInfo userInfo = sysProcessService.getSysUserInfoByEmpId(uid);
		ImMessageHandler.sendMessage(userInfo.getUserName(), ImMessageConstants.MSG_TODO_TRSVEL);
	}

}
