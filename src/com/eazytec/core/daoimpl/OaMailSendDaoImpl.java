package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_MAIL_SEND 对应daoImpl
 */
public class OaMailSendDaoImpl extends BaseHapiDaoimpl<OaMailSend, Long> implements IOaMailSendDao {

   public OaMailSendDaoImpl(){
      super(OaMailSend.class);
   }
}