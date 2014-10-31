package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_BOOK_TYPE 对应daoImpl
 */
public class OaBookTypeDaoImpl extends BaseHapiDaoimpl<OaBookType, Long> implements IOaBookTypeDao {

   public OaBookTypeDaoImpl(){
      super(OaBookType.class);
   }
}