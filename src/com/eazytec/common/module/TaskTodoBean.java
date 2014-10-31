package com.eazytec.common.module;

import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;

public class TaskTodoBean {
	private Task task;
	private ProcessDefinition processDefinition;
	private Integer status;
	
	public Task getTask() {
		return task;
	}
	public void setTask(Task task) {
		this.task = task;
	}
	public ProcessDefinition getProcessDefinition() {
		return processDefinition;
	}
	public void setProcessDefinition(ProcessDefinition processDefinition) {
		this.processDefinition = processDefinition;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
}
