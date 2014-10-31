package com.eazytec.core.iservice;

import com.eazytec.core.pojo.SysComponent;
import java.util.List;
import com.eazytec.common.pages.Pager;

public interface ISysComponentService{

   public int listSysComponentCount(SysComponent sysComponent);
   public List<SysComponent> listSysComponent(SysComponent sysComponent, Pager pager);
   public SysComponent saveSysComponent(SysComponent sysComponent);
   public SysComponent getSysComponentByPk(String pk);
   public void deleteSysComponentByPks(String[] pks);

}