package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_POSTS 对应daoImpl
 */
public class OaPostsDaoImpl extends BaseHapiDaoimpl<OaPosts, Long> implements IOaPostsDao {

   public OaPostsDaoImpl(){
      super(OaPosts.class);
   }
}