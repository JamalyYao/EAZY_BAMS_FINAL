package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_SMS_SEND 对应daoImpl
 */
public class OaSmsSendDaoImpl extends BaseHapiDaoimpl<OaSmsSend, Long> implements IOaSmsSendDao {

   public OaSmsSendDaoImpl(){
      super(OaSmsSend.class);
   }
}