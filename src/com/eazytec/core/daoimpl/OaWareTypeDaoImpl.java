package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_WARE_TYPE 对应daoImpl
 */
public class OaWareTypeDaoImpl extends BaseHapiDaoimpl<OaWareType, Long> implements IOaWareTypeDao {

   public OaWareTypeDaoImpl(){
      super(OaWareType.class);
   }
}