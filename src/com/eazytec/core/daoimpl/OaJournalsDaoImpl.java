package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_JOURNALS 对应daoImpl
 */
public class OaJournalsDaoImpl extends BaseHapiDaoimpl<OaJournals, Long> implements IOaJournalsDao {

   public OaJournalsDaoImpl(){
      super(OaJournals.class);
   }
}