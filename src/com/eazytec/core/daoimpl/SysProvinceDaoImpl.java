package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：SYS_PROVINCE 对应daoImpl
 */
public class SysProvinceDaoImpl extends BaseHapiDaoimpl<SysProvince, String> implements ISysProvinceDao {

   public SysProvinceDaoImpl(){
      super(SysProvince.class);
   }
}