package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_FORMS 对应daoImpl
 */
public class OaFormsDaoImpl extends BaseHapiDaoimpl<OaForms, Long> implements IOaFormsDao {

   public OaFormsDaoImpl(){
      super(OaForms.class);
   }
}