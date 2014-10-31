package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：HRM_DEPARTMENT 对应daoImpl
 */
public class HrmDepartmentDaoImpl extends BaseHapiDaoimpl<HrmDepartment, Long> implements IHrmDepartmentDao {

   public HrmDepartmentDaoImpl(){
      super(HrmDepartment.class);
   }
}