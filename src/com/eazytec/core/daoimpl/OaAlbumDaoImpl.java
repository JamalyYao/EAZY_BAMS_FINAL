package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_ALBUM 对应daoImpl
 */
public class OaAlbumDaoImpl extends BaseHapiDaoimpl<OaAlbum, Long> implements IOaAlbumDao {

   public OaAlbumDaoImpl(){
      super(OaAlbum.class);
   }
}