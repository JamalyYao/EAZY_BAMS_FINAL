package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：SYS_USER_INFO 对应daoImpl
 */
public class SysUserInfoDaoImpl extends BaseHapiDaoimpl<SysUserInfo, Long> implements ISysUserInfoDao {

   public SysUserInfoDaoImpl(){
      super(SysUserInfo.class);
   }
}