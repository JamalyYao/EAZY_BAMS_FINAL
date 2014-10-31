package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_VOTE_STATUS 对应daoImpl
 */
public class OaVoteStatusDaoImpl extends BaseHapiDaoimpl<OaVoteStatus, Long> implements IOaVoteStatusDao {

   public OaVoteStatusDaoImpl(){
      super(OaVoteStatus.class);
   }
}