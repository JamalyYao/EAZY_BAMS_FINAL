package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_PHOTO 对应daoImpl
 */
public class OaPhotoDaoImpl extends BaseHapiDaoimpl<OaPhoto, Long> implements IOaPhotoDao {

   public OaPhotoDaoImpl(){
      super(OaPhoto.class);
   }
}