package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：SYS_ROLE 对应daoImpl
 */
public class SysRoleDaoImpl extends BaseHapiDaoimpl<SysRole, Long> implements ISysRoleDao {

   public SysRoleDaoImpl(){
      super(SysRole.class);
   }
}