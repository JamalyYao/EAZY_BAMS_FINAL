package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：SYS_USER_GROUP 对应daoImpl
 */
public class SysUserGroupDaoImpl extends BaseHapiDaoimpl<SysUserGroup, Long> implements ISysUserGroupDao {

   public SysUserGroupDaoImpl(){
      super(SysUserGroup.class);
   }
}