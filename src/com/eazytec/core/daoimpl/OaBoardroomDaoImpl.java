package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_BOARDROOM 对应daoImpl
 */
public class OaBoardroomDaoImpl extends BaseHapiDaoimpl<OaBoardroom, Long> implements IOaBoardroomDao {

   public OaBoardroomDaoImpl(){
      super(OaBoardroom.class);
   }
}