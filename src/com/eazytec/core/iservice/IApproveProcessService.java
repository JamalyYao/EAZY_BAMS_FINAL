package com.eazytec.core.iservice;

import java.util.List;
import org.activiti.engine.identity.Group;
import org.activiti.engine.impl.persistence.entity.MembershipEntity;
import com.eazytec.common.pages.Pager;
import com.eazytec.core.pojo.SysUserInfo;

public interface IApproveProcessService {

	public List<MembershipEntity> getMembership(String empId);

	public int getSysUserInfoListCount(SysUserInfo userinfo);

	public List<SysUserInfo> getSysUserInfoListByPager(SysUserInfo userinfo,
			Pager pager);

	public List<Group> getGroupListByUserId(String hrmEmployeeId);

}
