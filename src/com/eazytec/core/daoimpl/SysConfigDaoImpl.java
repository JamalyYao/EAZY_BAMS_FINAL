package com.eazytec.core.daoimpl;

import com.eazytec.core.dao.ISysConfigDao;
import com.eazytec.core.pojo.SysConfig;

public class SysConfigDaoImpl extends BaseHapiDaoimpl<SysConfig, Long> implements ISysConfigDao {

	   public SysConfigDaoImpl(){
	      super(SysConfig.class);
	   }
	}