package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_ANNOUNCEMENT 对应daoImpl
 */
public class OaAnnouncementDaoImpl extends BaseHapiDaoimpl<OaAnnouncement, Long> implements IOaAnnouncementDao {

   public OaAnnouncementDaoImpl(){
      super(OaAnnouncement.class);
   }
}