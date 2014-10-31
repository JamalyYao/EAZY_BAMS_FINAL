package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_CHAT_GROUPS 对应daoImpl
 */
public class OaChatGroupsDaoImpl extends BaseHapiDaoimpl<OaChatGroups, Long> implements IOaChatGroupsDao {

   public OaChatGroupsDaoImpl(){
      super(OaChatGroups.class);
   }
}