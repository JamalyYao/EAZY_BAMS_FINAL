package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：HRM_EMPLOYEE 对应daoImpl
 */
public class HrmEmployeeDaoImpl extends BaseHapiDaoimpl<HrmEmployee, String> implements IHrmEmployeeDao {

   public HrmEmployeeDaoImpl(){
      super(HrmEmployee.class);
   }
}