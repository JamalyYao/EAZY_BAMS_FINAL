package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：SYS_EXCEPTION 对应daoImpl
 */
public class SysExceptionDaoImpl extends BaseHapiDaoimpl<SysException, Long> implements ISysExceptionDao {

   public SysExceptionDaoImpl(){
      super(SysException.class);
   }
}