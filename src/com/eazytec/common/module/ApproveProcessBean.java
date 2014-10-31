package com.eazytec.common.module;

import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;


public class ApproveProcessBean {
	private ProcessDefinition processDefinition;
	private Deployment deployment;
	private String deploymentTime;
	
	public ProcessDefinition getProcessDefinition() {
		return processDefinition;
	}
	public void setProcessDefinition(ProcessDefinition processDefinition) {
		this.processDefinition = processDefinition;
	}
	public Deployment getDeployment() {
		return deployment;
	}
	public void setDeployment(Deployment deployment) {
		this.deployment = deployment;
	}
	public String getDeploymentTime() {
		return deploymentTime;
	}
	public void setDeploymentTime(String deploymentTime) {
		this.deploymentTime = deploymentTime;
	}
	
}
