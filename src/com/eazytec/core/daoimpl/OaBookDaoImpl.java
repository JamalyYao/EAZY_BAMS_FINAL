package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_BOOK 对应daoImpl
 */
public class OaBookDaoImpl extends BaseHapiDaoimpl<OaBook, Long> implements IOaBookDao {

   public OaBookDaoImpl(){
      super(OaBook.class);
   }
}