package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：SYS_COUNTRY 对应daoImpl
 */
public class SysCountryDaoImpl extends BaseHapiDaoimpl<SysCountry, String> implements ISysCountryDao {

   public SysCountryDaoImpl(){
      super(SysCountry.class);
   }
}