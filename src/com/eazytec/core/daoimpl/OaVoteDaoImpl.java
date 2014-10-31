package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_VOTE 对应daoImpl
 */
public class OaVoteDaoImpl extends BaseHapiDaoimpl<OaVote, Long> implements IOaVoteDao {

   public OaVoteDaoImpl(){
      super(OaVote.class);
   }
}