package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_NETMAIL_PERSON 对应daoImpl
 */
public class OaNetmailPersonDaoImpl extends BaseHapiDaoimpl<OaNetmailPerson, Long> implements IOaNetmailPersonDao {

   public OaNetmailPersonDaoImpl(){
      super(OaNetmailPerson.class);
   }
}