package com.eazytec.common.module;

import org.activiti.engine.history.HistoricActivityInstance;

import com.eazytec.core.pojo.HrmEmployee;

public class HistoricActivityInstanceBean {
	private HistoricActivityInstance historicActivityInstance;
	private HrmEmployee employee;
	private String instanceStartTime;
	private String instanceEndTime;
	private String durationTime;
	
	public HistoricActivityInstance getHistoricActivityInstance() {
		return historicActivityInstance;
	}
	public void setHistoricActivityInstance(
			HistoricActivityInstance historicActivityInstance) {
		this.historicActivityInstance = historicActivityInstance;
	}

	public HrmEmployee getEmployee() {
		return employee;
	}
	public void setEmployee(HrmEmployee employee) {
		this.employee = employee;
	}
	public String getDurationTime() {
		return durationTime;
	}
	public void setDurationTime(String durationTime) {
		this.durationTime = durationTime;
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
