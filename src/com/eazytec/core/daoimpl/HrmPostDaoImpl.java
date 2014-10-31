package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：HRM_POST 对应daoImpl
 */
public class HrmPostDaoImpl extends BaseHapiDaoimpl<HrmPost, Long> implements IHrmPostDao {

   public HrmPostDaoImpl(){
      super(HrmPost.class);
   }
}