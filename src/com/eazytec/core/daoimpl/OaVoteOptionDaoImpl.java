package com.eazytec.core.daoimpl;

import com.eazytec.core.pojo.*;
import com.eazytec.core.dao.*;
/**
 * 表：OA_VOTE_OPTION 对应daoImpl
 */
public class OaVoteOptionDaoImpl extends BaseHapiDaoimpl<OaVoteOption, Long> implements IOaVoteOptionDao {

   public OaVoteOptionDaoImpl(){
      super(OaVoteOption.class);
   }
}