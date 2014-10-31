package com.eazytec.web.controller.dwr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricProcessInstanceQuery;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import com.eazytec.common.activiti.ProcessConstants;
import com.eazytec.common.module.HistoricTaskInstanceBean;
import com.eazytec.common.module.HistoricProcessInstanceBean;
import com.eazytec.common.module.ResultBean;
import com.eazytec.common.module.TaskTodoBean;
import com.eazytec.common.pages.Pager;
import com.eazytec.common.pages.PagerHelper;
import com.eazytec.common.util.DateTimeTool;
import com.eazytec.common.util.EnumUtil;
import com.eazytec.common.util.UtilTool;
import com.eazytec.common.util.UtilWork;
import com.eazytec.common.util.WebUtilWork;
import com.eazytec.common.util.im.ImMessageConstants;
import com.eazytec.common.util.im.ImHandler;
import com.eazytec.core.iservice.IHrmEmployeeService;
import com.eazytec.core.iservice.IPersonalOfficeSerivce;
import com.eazytec.core.pojo.HrmEmployee;
import com.eazytec.core.pojo.OaLeaveregistration;
import com.eazytec.core.pojo.OaTrsvel;
/**********************************************
Class name: 个人日常工作流程dwr服务
Description:
Others:         
History:        
JC    2014.1.27
**********************************************/
public class DwrPersonalProcessSerivce {
	// 日志文件
	private final static Logger logger = Logger.getLogger(DwrPersonalProcessSerivce.class);

	private IPersonalOfficeSerivce personalOfficeSerivce;
	private IHrmEmployeeService employeeinfoService;
	private TaskService taskService;
	private RuntimeService runtimeService;
	private RepositoryService repositoryService;
	private HistoryService historyService;
	
	public void setHistoryService(HistoryService historyService) {
		this.historyService = historyService;
	}

	public void setRepositoryService(RepositoryService repositoryService) {
		this.repositoryService = repositoryService;
	}

	public RuntimeService getRuntimeService() {
		return runtimeService;
	}

	public void setRuntimeService(RuntimeService runtimeService) {
		this.runtimeService = runtimeService;
	}

	public void setTaskService(TaskService taskService) {
		this.taskService = taskService;
	}

	public void setEmployeeinfoService(IHrmEmployeeService employeeinfoService) {
		this.employeeinfoService = employeeinfoService;
	}

	public IPersonalOfficeSerivce getPersonalOfficeSerivce() {
		return personalOfficeSerivce;
	}

	public void setPersonalOfficeSerivce(IPersonalOfficeSerivce personalOfficeSerivce) {
		this.personalOfficeSerivce = personalOfficeSerivce;
	}

	/**
	 * desktop待办任务
	 * @param context
	 * @param request
	 * @return
	 */
	public List<TaskTodoBean> listTaskTodo(ServletContext context,HttpServletRequest request, Integer row){
		
		String empId = UtilTool.getEmployeeId(request);
		
		List<TaskTodoBean> list = new ArrayList<TaskTodoBean>();
		
		// 已经签收的任务
	    List<Task> todoList = taskService.createTaskQuery().taskAssignee(empId).active().list();
	    for (Task task : todoList) {
	      String processDefinitionId = task.getProcessDefinitionId();
	      ProcessDefinition processDefinition = repositoryService.getProcessDefinition(processDefinitionId);
	      
	      TaskTodoBean bean = new TaskTodoBean();
	      bean.setTask(task);
	      bean.setProcessDefinition(processDefinition);
	      bean.setStatus(EnumUtil.TASK_TODO_STATUS.TODO.value);
	      list.add(bean);
	    }

	    // 等待签收的任务
	    List<Task> toClaimList = taskService.createTaskQuery().taskCandidateUser(empId).active().list();
	    for (Task task : toClaimList) {
	      String processDefinitionId = task.getProcessDefinitionId();
	      ProcessDefinition processDefinition = repositoryService.getProcessDefinition(processDefinitionId);

	      TaskTodoBean bean = new TaskTodoBean();
	      bean.setTask(task);
	      bean.setProcessDefinition(processDefinition);
	      bean.setStatus(EnumUtil.TASK_TODO_STATUS.CLAIM.value);
	      list.add(bean);
	    }
	    
	    if(row!= null && list.size() > row)
	    	list = list.subList(0, row);
	    
		return list;
	}
	
	/**
	 * desktop历史流程
	 * @param context
	 * @param request
	 * @return
	 */
	public List<HistoricProcessInstanceBean> listHistoricProcessUnfinished(ServletContext context, HttpServletRequest request, String key, int row) {
		
		String empId = UtilTool.getEmployeeId(request);
		
		List<HistoricProcessInstanceBean> beanList = new ArrayList<HistoricProcessInstanceBean>();
		
		//involvedUser 当前用户相关的
		HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery().startedBy(empId);
		query.processDefinitionKey(key);//类型
		query.unfinished();
		query.orderByProcessInstanceStartTime().desc();
		
		
		List<HistoricProcessInstance>  list = query.listPage(0,  row);
		
		for (HistoricProcessInstance historicProcessInstance : list) {
			HistoricProcessInstanceBean bean = new HistoricProcessInstanceBean();
			ProcessDefinition processDefinition = repositoryService.getProcessDefinition(historicProcessInstance.getProcessDefinitionId());
			HrmEmployee employee = employeeinfoService.getEmployeeByPK(historicProcessInstance.getStartUserId());
			
			bean.setHistoricProcessInstance(historicProcessInstance);
			bean.setProcessDefinition(processDefinition);
			bean.setInstanceStartTime(DateTimeTool.getStringFromDate(historicProcessInstance.getStartTime(), "yyyy-MM-dd HH:mm:ss"));
			bean.setInstanceEndTime(DateTimeTool.getStringFromDate(historicProcessInstance.getEndTime(), "yyyy-MM-dd HH:mm:ss"));
			bean.setEmployee(employee);
			beanList.add(bean);
		}
		
		return beanList;
	}
	
	
	/**
	 * 待办理流程（请假）
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean findTodoTasksLeave(ServletContext context, HttpServletRequest request, OaLeaveregistration oaLeaveregistration, Pager pager) {
		String empId = UtilTool.getEmployeeId(request);
		String key = EnumUtil.WORKFLOW_TYPE.LEAVE.key;
		
		List<OaLeaveregistration> results = new ArrayList<OaLeaveregistration>();
	    List<Task> tasks = new ArrayList<Task>();

	    
	    // 根据当前人的ID查询
	    TaskQuery todoQuery = taskService.createTaskQuery().processDefinitionKey(key).taskAssignee(empId).active().orderByTaskId().desc()
	            .orderByTaskCreateTime().desc();

	    // 根据当前人未签收的任务
	    TaskQuery claimQuery = taskService.createTaskQuery().processDefinitionKey(key).taskCandidateUser(empId).active().orderByTaskId().desc()
	            .orderByTaskCreateTime().desc();
	    
	    pager = PagerHelper.getPager(pager, (int)todoQuery.count() + (int)claimQuery.count());
	    
	    List<Task> todoList = todoQuery.listPage(pager.getStartRow(),  pager.getPageSize());
	    List<Task> unsignedTasks = claimQuery.listPage(pager.getStartRow(),pager.getPageSize());

	    // 合并
	    tasks.addAll(todoList);
	    tasks.addAll(unsignedTasks);

	    // 根据流程的业务ID查询实体并关联
	    for (Task task : tasks) {
	      String processInstanceId = task.getProcessInstanceId();
	      ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
	      String businessKey = processInstance.getBusinessKey();
	      OaLeaveregistration leave = personalOfficeSerivce.getOaLeaveregistrationByPk(new Long(businessKey));
	      leave.setLibrary(UtilTool.getLibraryInfoByPk(context, request, leave.getLeavetype()));
	      leave.setApplyEmployee(employeeinfoService.getEmployeeByPK(leave.getApplyuser()));
	      leave.setTask(task);
	      leave.setProcessInstance(processInstance);
	      leave.setProcessDefinition(repositoryService.getProcessDefinition(processInstance.getProcessDefinitionId()));
	      results.add(leave);
	    }
	    return WebUtilWork.WebResultPack(results, pager);
	}
	
	/**
	 * 待办理流程（出差）
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean findTodoTasksTrsvel(ServletContext context, HttpServletRequest request, OaLeaveregistration oaLeaveregistration, Pager pager) {
		String empId = UtilTool.getEmployeeId(request);
		String key = EnumUtil.WORKFLOW_TYPE.TRSVEL.key;
		
		List<OaTrsvel> results = new ArrayList<OaTrsvel>();
		List<Task> tasks = new ArrayList<Task>();
		
		
		// 根据当前人的ID查询
		TaskQuery todoQuery = taskService.createTaskQuery().processDefinitionKey(key).taskAssignee(empId).active().orderByTaskId().desc()
		.orderByTaskCreateTime().desc();
		
		// 根据当前人未签收的任务
		TaskQuery claimQuery = taskService.createTaskQuery().processDefinitionKey(key).taskCandidateUser(empId).active().orderByTaskId().desc()
		.orderByTaskCreateTime().desc();
		
		pager = PagerHelper.getPager(pager, (int)todoQuery.count() + (int)claimQuery.count());
		
		List<Task> todoList = todoQuery.listPage(pager.getStartRow(),  pager.getPageSize());
		List<Task> unsignedTasks = claimQuery.listPage(pager.getStartRow(),pager.getPageSize());
		
		// 合并
		tasks.addAll(todoList);
		tasks.addAll(unsignedTasks);
		
		// 根据流程的业务ID查询实体并关联
		for (Task task : tasks) {
			String processInstanceId = task.getProcessInstanceId();
			ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
			String businessKey = processInstance.getBusinessKey();
			OaTrsvel trsvel = personalOfficeSerivce.getOaTrsvelByPk(new Long(businessKey));
			trsvel.setApplyEmployee(employeeinfoService.getEmployeeByPK(trsvel.getTrsvelApplyuser()));
			trsvel.setTask(task);
			trsvel.setProcessInstance(processInstance);
			trsvel.setProcessDefinition(repositoryService.getProcessDefinition(processInstance.getProcessDefinitionId()));
			results.add(trsvel);
		}
		return WebUtilWork.WebResultPack(results, pager);
	}
	
	
	/**
	 * 签收任务
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean claimTask(ServletContext context, HttpServletRequest request, String taskId) {
		String empId = UtilTool.getEmployeeId(request);
	    taskService.claim(taskId, empId);
	    return WebUtilWork.WebResultPack(null);
	}
	
	
	/**
	 * 部门领导办理请假任务
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean completeLeaveTaskForDeptLeader(ServletContext context, HttpServletRequest request, String taskId, Boolean isPass, String deptLeaderTxt) {
		//设置流程变量
		Map<String, Object> variables = taskService.getVariables(taskId);
		variables.put(ProcessConstants.KEY_DEPT_LEADER_PASS, isPass);
		
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		taskService.addComment(taskId, task.getProcessInstanceId(), deptLeaderTxt);
		taskService.complete(taskId, variables);
		
		if(!isPass){//驳回后推送信息
			String empId = (String) variables.get(ProcessConstants.KEY_APPLY_USER_ID);
			ImHandler.sendMessage(UtilTool.getSysUserName(context, request, empId), ImMessageConstants.MSG_LEAVE_BACK);
		}
		
		return WebUtilWork.WebResultPack(null);
	}
	
	/**
	 * 人事办理请假任务
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean completeLeaveTaskForHr(ServletContext context, HttpServletRequest request, String taskId, Boolean isPass, String hrTxt) {
		//设置流程变量
		Map<String, Object> variables = taskService.getVariables(taskId);
		variables.put(ProcessConstants.KEY_HR_PASS, isPass);
		
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		taskService.addComment(taskId, task.getProcessInstanceId(), hrTxt);
		taskService.complete(taskId, variables);
		
		if(!isPass){//驳回后推送信息
			String empId = (String) variables.get(ProcessConstants.KEY_APPLY_USER_ID);
			ImHandler.sendMessage(UtilTool.getSysUserName(context, request, empId), ImMessageConstants.MSG_LEAVE_BACK);
		}
		
		return WebUtilWork.WebResultPack(null);
	}
	
	/**
	 * 调整请假信息
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean completeLeaveTaskForApplyer(ServletContext context, HttpServletRequest request, String taskId,Boolean isContinue, OaLeaveregistration temp) {
		if(isContinue){
			OaLeaveregistration leave = personalOfficeSerivce.getOaLeaveregistrationByPk(temp.getPrimaryKey());
			leave.setLeavetype(temp.getLeavetype());
			leave.setStartdata(temp.getStartdata());
			leave.setEnddata(temp.getEnddata());
			leave.setLeavereason(temp.getLeavereason());
			leave.setLastmodiId(UtilTool.getEmployeeId(request));
			leave.setLastmodiDate(UtilWork.getNowTime());
			personalOfficeSerivce.saveOaLeaveregistration(leave);
		}
		
		//设置流程变量
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put(ProcessConstants.KEY_LEAVE_REAPPLY, isContinue);
		taskService.complete(taskId, variables);
		return WebUtilWork.WebResultPack(null);
	}
	
	
	/**
	 * 部门领导办理出差任务
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean completeTrsvelTaskForDeptLeader(ServletContext context, HttpServletRequest request, String taskId, Boolean isPass, String deptLeaderTxt) {
		//设置流程变量
		Map<String, Object> variables = taskService.getVariables(taskId);
		variables.put(ProcessConstants.KEY_DEPT_LEADER_PASS, isPass);
		
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		taskService.addComment(taskId, task.getProcessInstanceId(), deptLeaderTxt);
		taskService.complete(taskId, variables);
		
		if(!isPass){//驳回后推送信息
			String empId = (String) variables.get(ProcessConstants.KEY_APPLY_USER_ID);
			ImHandler.sendMessage(UtilTool.getSysUserName(context, request, empId), ImMessageConstants.MSG_TRSVEL_BACK);
		}
		
		return WebUtilWork.WebResultPack(null);
	}
	
	/**
	 * 人事办理出差任务
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean completeTrsvelTaskForHr(ServletContext context, HttpServletRequest request, String taskId) {
		taskService.complete(taskId);
		return WebUtilWork.WebResultPack(null);
	}
	
	/**
	 * 调整出差信息
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean completeTrsvelTaskForApplyer(ServletContext context, HttpServletRequest request, String taskId, OaTrsvel temp) {
		OaTrsvel trsvel = personalOfficeSerivce.getOaTrsvelByPk(temp.getPrimaryKey());
		trsvel.setTrsvelArea(temp.getTrsvelArea());
		trsvel.setTrsvelBegindata(temp.getTrsvelBegindata());
		trsvel.setTrsvelEnddata(temp.getTrsvelEnddata());
		trsvel.setTrsvelCause(temp.getTrsvelCause());
		trsvel.setLastmodiId(UtilTool.getEmployeeId(request));
		trsvel.setLastmodiDate(UtilWork.getNowTime());
		personalOfficeSerivce.saveOaTrsvel(trsvel);
		taskService.complete(taskId);
		return WebUtilWork.WebResultPack(null);
	}

	/**
	 * 启动请假流程
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean addOaLeaver(ServletContext context,HttpServletRequest request, String employeeId, OaLeaveregistration oaLeaver) {
		String time = UtilWork.getNowTime();
		try {
			oaLeaver.setApplyuser(UtilTool.getEmployeeId(request));
			oaLeaver.setApplydata(time);
			oaLeaver.setCompanyId(UtilTool.getCompanyId(request));
			oaLeaver.setLastmodiId(UtilTool.getEmployeeId(request));
			oaLeaver.setLastmodiDate(time);
			oaLeaver.setRecordDate(time);
			oaLeaver.setRecordId(UtilTool.getEmployeeId(request));
			
			//设置流程变量
			Map<String, Object> variables = new HashMap<String, Object>();
			variables.put(ProcessConstants.KEY_DEPT_LEADER_ID, employeeId);
			
			//启动流程
			ProcessInstance processInstance = personalOfficeSerivce.startOaLeaveWorkflow(oaLeaver, variables);
			
			//推送提醒消息
			ImHandler.sendMessage(UtilTool.getSysUserName(context, request, employeeId), ImMessageConstants.MSG_LEAVE_TODO);
			
			return new ResultBean(true, "流程已启动，流程ID：" + processInstance.getId());
		} catch (ActivitiException e) {
			if (e.getMessage().indexOf("no processes deployed with key") != -1) {
				logger.warn("没有部署流程!", e);
				return new ResultBean(false,
						"没有部署流程，请在[工作流]->[流程管理]页面点击<重新部署流程>");
			} else {
				logger.error("启动请假流程失败：", e);
				return new ResultBean(false, "系统内部错误！");
			}
		} catch (Exception e) {
			logger.error("启动请假流程失败：", e);
			return new ResultBean(false, "系统内部错误！");
		}
	}

	/**
	 * 请假登记根据ID取值
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean getOaLeaverByPk(ServletContext context, HttpServletRequest request, long OaLeaverpk) {
		OaLeaveregistration leave = personalOfficeSerivce.getOaLeaveregistrationByPk(OaLeaverpk);
		leave.setApplyEmployee(employeeinfoService.getEmployeeByPK(leave.getApplyuser()));
		leave.setLibrary(UtilTool.getLibraryInfoByPk(context, request, leave.getLeavetype()));
		return WebUtilWork.WebObjectPack(leave);
	}
	
	/**
	 * 历史流程
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean findHistoryTasks(ServletContext context, HttpServletRequest request, HistoricProcessInstanceBean tmpbean, Pager pager) {
		
		String empId = UtilTool.getEmployeeId(request);
		
		List<HistoricProcessInstanceBean> beanList = new ArrayList<HistoricProcessInstanceBean>();
		
		//involvedUser 当前用户相关的
		HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery().involvedUser(empId);
		
		if(tmpbean.getScope() != null && tmpbean.getScope() != -1){
			if(tmpbean.getScope() == EnumUtil.WORKFLOW_SCOPE.MYJOIN.value){
				query.involvedUser(empId);
			}else if(tmpbean.getScope() == EnumUtil.WORKFLOW_SCOPE.MYSTART.value){
				query.startedBy(empId);
			}
		}
		
		if(StringUtils.isNotBlank(tmpbean.getId()))
			query.processInstanceId(tmpbean.getId());//流水号
		
		if(StringUtils.isNotBlank(tmpbean.getKey()) && !("-1".equals(tmpbean.getKey())))
			query.processDefinitionKey(tmpbean.getKey());//类型
		
		if(tmpbean.getProcessStatus() != null && tmpbean.getProcessStatus() != -1){
			if(tmpbean.getProcessStatus() == EnumUtil.PROCESS_STATUS.FINISH.value){
				query.finished();
			}else if(tmpbean.getProcessStatus() == EnumUtil.PROCESS_STATUS.DOING.value){
				query.unfinished();
			}
		}
		
		query.orderByProcessInstanceStartTime().desc();
		
		pager = PagerHelper.getPager(pager, (int)query.count());
		
		List<HistoricProcessInstance>  list = query.listPage(pager.getStartRow(),  pager.getPageSize());
		
		for (HistoricProcessInstance historicProcessInstance : list) {
			HistoricProcessInstanceBean bean = new HistoricProcessInstanceBean();
			ProcessDefinition processDefinition = repositoryService.getProcessDefinition(historicProcessInstance.getProcessDefinitionId());
			HrmEmployee employee = employeeinfoService.getEmployeeByPK(historicProcessInstance.getStartUserId());
			
			bean.setHistoricProcessInstance(historicProcessInstance);
			bean.setProcessDefinition(processDefinition);
			bean.setInstanceStartTime(DateTimeTool.getStringFromDate(historicProcessInstance.getStartTime(), "yyyy-MM-dd HH:mm:ss"));
			bean.setInstanceEndTime(DateTimeTool.getStringFromDate(historicProcessInstance.getEndTime(), "yyyy-MM-dd HH:mm:ss"));
			bean.setEmployee(employee);
			beanList.add(bean);
		}
	    return WebUtilWork.WebResultPack(beanList, pager);
	}
	
	
	/**
	 * 历史流程详情
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean findHistoryDetail(ServletContext context, HttpServletRequest request, String id) {
		List<HistoricTaskInstanceBean> beans = new ArrayList<HistoricTaskInstanceBean>();
		
		List<HistoricTaskInstance> instances = historyService.createHistoricTaskInstanceQuery().processInstanceId(id).list();
		
		for (HistoricTaskInstance historicTaskInstance : instances) {
			HistoricTaskInstanceBean bean = new HistoricTaskInstanceBean();
			
			HrmEmployee employee = new HrmEmployee();
			if(StringUtils.isNotBlank(historicTaskInstance.getAssignee()))
				employee = employeeinfoService.getEmployeeByPK(historicTaskInstance.getAssignee());
			
			bean.setHistoricTaskInstance(historicTaskInstance);
			bean.setInstanceStartTime(DateTimeTool.getStringFromDate(historicTaskInstance.getStartTime(), "yyyy-MM-dd HH:mm:ss"));
			bean.setInstanceEndTime(DateTimeTool.getStringFromDate(historicTaskInstance.getEndTime(), "yyyy-MM-dd HH:mm:ss"));
			bean.setEmployee(employee);
			
			if(historicTaskInstance.getDurationInMillis() != null)
				bean.setDurationTime(DateTimeTool.periodToString(historicTaskInstance.getDurationInMillis()));
			
			List<Comment> commentList = taskService.getTaskComments(historicTaskInstance.getId());
			
			if(commentList != null && commentList.size() > 0){
				bean.setCommentList(commentList);
			}else{
				bean.setCommentList(new ArrayList<Comment>());
			}
			
			beans.add(bean);
		}
		
	    return WebUtilWork.WebResultPack(beans);
	}

	/**
	 * 启动出差流程
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean addoaTrsvel(ServletContext context, HttpServletRequest request, OaTrsvel oaTrsvel, String employeeId) {
		String time = UtilWork.getNowTime();
		
		try {
			oaTrsvel.setTrsvelApplyuser(UtilTool.getEmployeeId(request));
			oaTrsvel.setApplydata(time);
			oaTrsvel.setCompanyId(UtilTool.getCompanyId(request));
			oaTrsvel.setRecordDate(time);
			oaTrsvel.setRecordId(UtilTool.getEmployeeId(request));
			oaTrsvel.setLastmodiId(UtilTool.getEmployeeId(request));
			oaTrsvel.setLastmodiDate(time);
			
			//设置流程变量
			Map<String, Object> variables = new HashMap<String, Object>();
			variables.put(ProcessConstants.KEY_DEPT_LEADER_ID, employeeId);

			//启动流程
			ProcessInstance processInstance = personalOfficeSerivce.startOaTrsvelWorkflow(oaTrsvel, variables);
			
			//推送提醒消息
			ImHandler.sendMessage(UtilTool.getSysUserName(context, request, employeeId), ImMessageConstants.MSG_TRSVEL_TODO);
			
			return new ResultBean(true, "流程已启动，流程ID：" + processInstance.getId());
		} catch (ActivitiException e) {
			if (e.getMessage().indexOf("no processes deployed with key") != -1) {
				logger.warn("没有部署流程!", e);
				return new ResultBean(false,
						"没有部署流程，请在[工作流]->[流程管理]页面点击<重新部署流程>");
			} else {
				logger.error("启动请假流程失败：", e);
				return new ResultBean(false, "系统内部错误！");
			}
		} catch (Exception e) {
			logger.error("启动请假流程失败：", e);
			return new ResultBean(false, "系统内部错误！");
		}
	}

	/**
	 * 出差ID取值
	 * @param context
	 * @param request
	 * @return
	 */
	public ResultBean getOaTrsvelByPk(ServletContext context, HttpServletRequest request, long OaLeaverpk) throws Exception {
		OaTrsvel oaTrsvel = personalOfficeSerivce.getOaTrsvelByPk(OaLeaverpk);
		
		oaTrsvel.setApplyEmployee(employeeinfoService.getEmployeeByPK(oaTrsvel.getTrsvelApplyuser()));
		
//		List<HistoricVariableInstance> list = historyService.createHistoricVariableInstanceQuery().
//				processInstanceId(oaTrsvel.getProcessInstanceId()).list();
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		for (HistoricVariableInstance historicVariableInstance : list) {
//			map.put(historicVariableInstance.getVariableName(), historicVariableInstance.getValue());
//		}
//		oaTrsvel.setVariables(map);
		
		return WebUtilWork.WebObjectPack(oaTrsvel);
	}

}
