package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_CAR_USE 对应daoImpl
 */
public class OaCarUseDaoImpl extends BaseHapiDaoimpl<OaCarUse, Long> implements IOaCarUseDao {

   public OaCarUseDaoImpl(){
      super(OaCarUse.class);
   }
}