package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：HRM_TIMEDRECORD 对应daoImpl
 */
public class HrmTimedrecordDaoImpl extends BaseHapiDaoimpl<HrmTimedrecord, Long> implements IHrmTimedrecordDao {

   public HrmTimedrecordDaoImpl(){
      super(HrmTimedrecord.class);
   }
}