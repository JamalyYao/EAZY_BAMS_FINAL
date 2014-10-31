package com.eazytec.core.service;

import java.util.ArrayList;
import java.util.List;
import org.activiti.engine.identity.Group;
import org.activiti.engine.impl.persistence.entity.GroupEntity;
import org.activiti.engine.impl.persistence.entity.MembershipEntity;
import org.apache.log4j.Logger;
import com.eazytec.common.pack.OaSysHqlPack;
import com.eazytec.common.pages.Pager;
import com.eazytec.core.dao.IHrmDepartmentDao;
import com.eazytec.core.dao.IHrmEmployeeDao;
import com.eazytec.core.dao.ISysUserInfoDao;
import com.eazytec.core.iservice.IApproveProcessService;
import com.eazytec.core.pojo.SysUserInfo;

/**
 * 审批流程业务类
 * 
 * @author peng.ning
 * 
 */
public class ApproveProcessService implements IApproveProcessService {
	private Logger log = Logger.getLogger(this.getClass());

	private IHrmEmployeeDao hrmEmployeeDao;

	private IHrmDepartmentDao hrmDepartmentDao;
	
	private ISysUserInfoDao sysUserInfoDao;

	public void setHrmEmployeeDao(IHrmEmployeeDao hrmEmployeeDao) {
		this.hrmEmployeeDao = hrmEmployeeDao;
	}

	public void setHrmDepartmentDao(IHrmDepartmentDao hrmDepartmentDao) {
		this.hrmDepartmentDao = hrmDepartmentDao;
	}

	public void setSysUserInfoDao(ISysUserInfoDao sysUserInfoDao) {
		this.sysUserInfoDao = sysUserInfoDao;
	}

	public List<MembershipEntity> getMembership(String empId) {
		List<MembershipEntity> entityList = new ArrayList<MembershipEntity>();
		String sql = "select USER_ID_,GROUP_ID_ from act_id_membership where USER_ID_='"+empId+"'";
		List<Object[]> list = sysUserInfoDao.findBySqlObjList(sql);
		
		for (Object[] object : list) {
			MembershipEntity entity = new MembershipEntity();
			entity.setUserId(object[0].toString());
			entity.setGroupId(object[1].toString());
			entityList.add(entity);
		}
		
		return entityList;
	}
	
	public int getSysUserInfoListCount(SysUserInfo userinfo) {
		return sysUserInfoDao.findBySqlCount(OaSysHqlPack.getSysUserInfoSql(userinfo));
	}

	public List<SysUserInfo> getSysUserInfoListByPager(SysUserInfo userinfo, Pager pager) {
		List<SysUserInfo> userinfoList = sysUserInfoDao.findBySqlPage(OaSysHqlPack.getSysUserInfoSql(userinfo) + " order by sysuser.user_action asc", SysUserInfo.class, pager);
		for (SysUserInfo sysUserInfo : userinfoList) {
			sysUserInfo.setEmployee(hrmEmployeeDao.getByPK(sysUserInfo.getHrmEmployeeId()));
			sysUserInfo.getEmployee().setHrmDepartment(hrmDepartmentDao.getByPK(sysUserInfo.getEmployee().getHrmEmployeeDepid().longValue()));
		}
		return userinfoList;
	}
	
	public List<Group> getGroupListByUserId(String hrmEmployeeId){
		String sql = "select NAME_ from act_id_group where ID_ in" +
				" ( select GROUP_ID_ from act_id_membership where USER_ID_ = '"+hrmEmployeeId+"')";
		
		List<Object[]> list = sysUserInfoDao.findBySqlObjList(sql);
		
		List<Group> groupList = new ArrayList<Group>();
		
		for (Object[] object : list) {
			Group group = new GroupEntity();
			group.setName(object[0].toString());
			groupList.add(group);
		}
		return groupList;
	}
	
}
