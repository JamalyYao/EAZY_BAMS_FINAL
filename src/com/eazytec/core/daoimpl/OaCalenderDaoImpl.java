package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_CALENDER 对应daoImpl
 */
public class OaCalenderDaoImpl extends BaseHapiDaoimpl<OaCalender, Long> implements IOaCalenderDao {

   public OaCalenderDaoImpl(){
      super(OaCalender.class);
   }
}