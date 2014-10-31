package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：SYS_ERROR 对应daoImpl
 */
public class SysErrorDaoImpl extends BaseHapiDaoimpl<SysError, Long> implements ISysErrorDao {

   public SysErrorDaoImpl(){
      super(SysError.class);
   }
}