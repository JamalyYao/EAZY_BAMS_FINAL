package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_CHATTERS 对应daoImpl
 */
public class OaChattersDaoImpl extends BaseHapiDaoimpl<OaChatters, Long> implements IOaChattersDao {

   public OaChattersDaoImpl(){
      super(OaChatters.class);
   }
}