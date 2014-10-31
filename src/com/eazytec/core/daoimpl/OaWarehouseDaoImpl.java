package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_WAREHOUSE 对应daoImpl
 */
public class OaWarehouseDaoImpl extends BaseHapiDaoimpl<OaWarehouse, Long> implements IOaWarehouseDao {

   public OaWarehouseDaoImpl(){
      super(OaWarehouse.class);
   }
}