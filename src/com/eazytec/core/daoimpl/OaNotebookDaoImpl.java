package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_NOTEBOOK 对应daoImpl
 */
public class OaNotebookDaoImpl extends BaseHapiDaoimpl<OaNotebook, Long> implements IOaNotebookDao {

   public OaNotebookDaoImpl(){
      super(OaNotebook.class);
   }
}