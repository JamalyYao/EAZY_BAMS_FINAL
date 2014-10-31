package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_SMS_INBOX 对应daoImpl
 */
public class OaSmsInboxDaoImpl extends BaseHapiDaoimpl<OaSmsInbox, Long> implements IOaSmsInboxDao {

   public OaSmsInboxDaoImpl(){
      super(OaSmsInbox.class);
   }
}