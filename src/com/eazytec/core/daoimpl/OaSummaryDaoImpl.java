package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_SUMMARY 对应daoImpl
 */
public class OaSummaryDaoImpl extends BaseHapiDaoimpl<OaSummary, Long> implements IOaSummaryDao {

   public OaSummaryDaoImpl(){
      super(OaSummary.class);
   }
}