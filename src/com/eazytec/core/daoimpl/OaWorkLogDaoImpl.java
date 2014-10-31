package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_WORK_LOG 对应daoImpl
 */
public class OaWorkLogDaoImpl extends BaseHapiDaoimpl<OaWorkLog, Long> implements IOaWorkLogDao {

   public OaWorkLogDaoImpl(){
      super(OaWorkLog.class);
   }
}