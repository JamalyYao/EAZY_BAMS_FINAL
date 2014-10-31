package com.eazytec.core.service;

import com.eazytec.core.pojo.SysComponent;
import com.eazytec.core.dao.ISysComponentDao;
import com.eazytec.core.iservice.ISysComponentService;
import com.eazytec.common.pages.Pager;
import com.eazytec.common.pack.SysComponentPack;
import java.util.List;

public class SysComponentService implements ISysComponentService{

   private ISysComponentDao sysComponentDao;

   public void setSysComponentDao(ISysComponentDao sysComponentDao){
      this.sysComponentDao = sysComponentDao;
   }

   public int listSysComponentCount(SysComponent sysComponent){
      int count = sysComponentDao.findByHqlWhereCount(SysComponentPack.packSysComponentQuery(sysComponent));
      return count;
   }

   public List<SysComponent> listSysComponent(SysComponent sysComponent, Pager pager){
      List<SysComponent> list = sysComponentDao.findByHqlWherePage(SysComponentPack.packSysComponentQuery(sysComponent), pager);
      return list;
   }

   public SysComponent saveSysComponent(SysComponent sysComponent){
      SysComponent temp = (SysComponent)sysComponentDao.save(sysComponent);
      return temp;
   }

   public SysComponent getSysComponentByPk(String pk){
      SysComponent sysComponent = (SysComponent)sysComponentDao.getByPK(pk);
      return sysComponent;
   }

   public void deleteSysComponentByPks(String[] pks){
      for (String l : pks) {
         SysComponent sysComponent = sysComponentDao.getByPK(l);
         sysComponentDao.remove(sysComponent);
      }
   }

}