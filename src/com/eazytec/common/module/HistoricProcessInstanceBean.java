package com.eazytec.common.module;

import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.repository.ProcessDefinition;

import com.eazytec.core.pojo.HrmEmployee;

public class HistoricProcessInstanceBean {
	private HistoricProcessInstance historicProcessInstance;
	private ProcessDefinition processDefinition;
	private HrmEmployee employee;
	private String instanceStartTime;
	private String instanceEndTime;
	private Integer scope;//范围
	private String key;
	private String id;
	private Integer processStatus;
	
	public HistoricProcessInstance getHistoricProcessInstance() {
		return historicProcessInstance;
	}
	public void setHistoricProcessInstance(
			HistoricProcessInstance historicProcessInstance) {
		this.historicProcessInstance = historicProcessInstance;
	}
	public ProcessDefinition getProcessDefinition() {
		return processDefinition;
	}
	public void setProcessDefinition(ProcessDefinition processDefinition) {
		this.processDefinition = processDefinition;
	}
	
	public HrmEmployee getEmployee() {
		return employee;
	}
	public void setEmployee(HrmEmployee employee) {
		this.employee = employee;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Integer getScope() {
		return scope;
	}
	public void setScope(Integer scope) {
		this.scope = scope;
	}
	public Integer getProcessStatus() {
		return processStatus;
	}
	public void setProcessStatus(Integer processStatus) {
		this.processStatus = processStatus;
	}
	public String getInstanceStartTime() {
		return instanceStartTime;
	}
	public void setInstanceStartTime(String instanceStartTime) {
		this.instanceStartTime = instanceStartTime;
	}
	public String getInstanceEndTime() {
		return instanceEndTime;
	}
	public void setInstanceEndTime(String instanceEndTime) {
		this.instanceEndTime = instanceEndTime;
	}
}
