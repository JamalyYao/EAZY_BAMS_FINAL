package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_MAIL_INBOX 对应daoImpl
 */
public class OaMailInboxDaoImpl extends BaseHapiDaoimpl<OaMailInbox, Long> implements IOaMailInboxDao {

   public OaMailInboxDaoImpl(){
      super(OaMailInbox.class);
   }
}