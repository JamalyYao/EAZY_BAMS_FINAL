package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_REGULATIONS 对应daoImpl
 */
public class OaRegulationsDaoImpl extends BaseHapiDaoimpl<OaRegulations, Long> implements IOaRegulationsDao {

   public OaRegulationsDaoImpl(){
      super(OaRegulations.class);
   }
}