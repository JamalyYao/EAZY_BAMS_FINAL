package com.eazytec.common.module;

import java.util.List;

import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.task.Comment;
import org.apache.commons.lang.StringUtils;

import com.eazytec.common.util.EnumUtil;
import com.eazytec.core.pojo.HrmEmployee;

public class HistoricTaskInstanceBean {
	private HistoricTaskInstance historicTaskInstance;
	private HrmEmployee employee;
	private String instanceStartTime;
	private String instanceEndTime;
	private String durationTime;
	private List<Comment> commentList;

	public HistoricTaskInstance getHistoricTaskInstance() {
		return historicTaskInstance;
	}
	public void setHistoricTaskInstance(HistoricTaskInstance historicTaskInstance) {
		this.historicTaskInstance = historicTaskInstance;
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
	public List<Comment> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
	
	public String getTaskStatus() {
		if(StringUtils.isNotBlank(getInstanceEndTime())){
			return EnumUtil.TASK_STATUS.valueOf(EnumUtil.TASK_STATUS.FINISH.value);
		}else{
			return EnumUtil.TASK_STATUS.valueOf(EnumUtil.TASK_STATUS.DOING.value);
		}
	}
}
