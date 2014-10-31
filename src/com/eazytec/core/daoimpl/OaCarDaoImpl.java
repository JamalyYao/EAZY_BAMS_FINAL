package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_CAR 对应daoImpl
 */
public class OaCarDaoImpl extends BaseHapiDaoimpl<OaCar, Long> implements IOaCarDao {

   public OaCarDaoImpl(){
      super(OaCar.class);
   }
}