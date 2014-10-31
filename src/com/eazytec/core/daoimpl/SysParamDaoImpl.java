package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：SYS_PARAM 对应daoImpl
 */
public class SysParamDaoImpl extends BaseHapiDaoimpl<SysParam, Long> implements ISysParamDao {

   public SysParamDaoImpl(){
      super(SysParam.class);
   }
}