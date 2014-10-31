package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_NOTICE 对应daoImpl
 */
public class OaNoticeDaoImpl extends BaseHapiDaoimpl<OaNotice, Long> implements IOaNoticeDao {

   public OaNoticeDaoImpl(){
      super(OaNotice.class);
   }
}