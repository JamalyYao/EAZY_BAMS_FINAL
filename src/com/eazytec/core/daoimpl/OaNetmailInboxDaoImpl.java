package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_NETMAIL_INBOX 对应daoImpl
 */
public class OaNetmailInboxDaoImpl extends BaseHapiDaoimpl<OaNetmailInbox, Long> implements IOaNetmailInboxDao {

   public OaNetmailInboxDaoImpl(){
      super(OaNetmailInbox.class);
   }
}