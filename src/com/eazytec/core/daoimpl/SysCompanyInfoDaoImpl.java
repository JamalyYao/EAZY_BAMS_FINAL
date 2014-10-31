package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：SYS_COMPANY_INFO 对应daoImpl
 */
public class SysCompanyInfoDaoImpl extends BaseHapiDaoimpl<SysCompanyInfo, Long> implements ISysCompanyInfoDao {

   public SysCompanyInfoDaoImpl(){
      super(SysCompanyInfo.class);
   }
}