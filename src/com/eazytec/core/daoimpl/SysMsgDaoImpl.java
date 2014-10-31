package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：SYS_MSG 对应daoImpl
 */
public class SysMsgDaoImpl extends BaseHapiDaoimpl<SysMsg, Long> implements ISysMsgDao {

   public SysMsgDaoImpl(){
      super(SysMsg.class);
   }
}