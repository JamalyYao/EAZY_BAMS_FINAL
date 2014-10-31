package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_MAIL_EMP 对应daoImpl
 */
public class OaMailEmpDaoImpl extends BaseHapiDaoimpl<OaMailEmp, Long> implements IOaMailEmpDao {

   public OaMailEmpDaoImpl(){
      super(OaMailEmp.class);
   }
}