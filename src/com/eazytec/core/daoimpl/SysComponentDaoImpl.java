package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：sys_component 对应daoImpl
 */
public class SysComponentDaoImpl extends BaseHapiDaoimpl<SysComponent, String> implements ISysComponentDao {

   public SysComponentDaoImpl(){
      super(SysComponent.class);
   }
}