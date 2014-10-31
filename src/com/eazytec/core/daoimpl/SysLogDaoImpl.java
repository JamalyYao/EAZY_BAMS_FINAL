package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：SYS_LOG 对应daoImpl
 */
public class SysLogDaoImpl extends BaseHapiDaoimpl<SysLog, Long> implements ISysLogDao {

   public SysLogDaoImpl(){
      super(SysLog.class);
   }
}