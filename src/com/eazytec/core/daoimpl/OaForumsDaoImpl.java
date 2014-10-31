package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_FORUMS 对应daoImpl
 */
public class OaForumsDaoImpl extends BaseHapiDaoimpl<OaForums, Long> implements IOaForumsDao {

   public OaForumsDaoImpl(){
      super(OaForums.class);
   }
}