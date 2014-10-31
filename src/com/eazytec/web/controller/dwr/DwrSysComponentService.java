package com.eazytec.web.controller.dwr;

import com.eazytec.core.pojo.SysComponent;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import com.eazytec.common.module.ResultBean;
import com.eazytec.common.pages.Pager;
import com.eazytec.common.pages.PagerHelper;
import com.eazytec.common.util.UtilTool;
import com.eazytec.common.util.UtilPrimaryKey;
import com.eazytec.common.util.WebUtilWork;
import com.eazytec.core.iservice.ISysComponentService;

/**********************************************
 * Class name:
 * Description:
 * Others:
 * History:
 **********************************************/
public class DwrSysComponentService {

   private ISysComponentService sysComponentService;

   public void setSysComponentService(ISysComponentService sysComponentService){
      this.sysComponentService = sysComponentService;
   }

   /**
    * 查询 SysComponent 列表
    * @param context
    * @param request
    * @param sysComponent
    * @param pager
    */
   public ResultBean listSysComponent(ServletContext context, HttpServletRequest request, SysComponent sysComponent, Pager pager){
      List<SysComponent> list = null;
      pager = PagerHelper.getPager(pager,sysComponentService.listSysComponentCount(sysComponent));
      list = sysComponentService.listSysComponent(sysComponent, pager);
      return WebUtilWork.WebResultPack(list, pager);
   }

   /**
    * 保存 SysComponent
    * @param context
    * @param request
    * @param sysComponent
    */
   public ResultBean saveSysComponent(ServletContext context, HttpServletRequest request, SysComponent sysComponent){
      sysComponent.setPrimaryKey(UtilPrimaryKey.getPrimaryKey());
      sysComponentService.saveSysComponent(sysComponent);
      return WebUtilWork.WebResultPack(null);
   }

   /**
    * 更新 SysComponent
    * @param context
    * @param request
    * @param sysComponent
    */
   public ResultBean updateSysComponent(ServletContext context, HttpServletRequest request, SysComponent sysComponent){
      sysComponentService.saveSysComponent(sysComponent);
      return WebUtilWork.WebResultPack(null);
   }

   /**
    * 根据ID获得 SysComponent
    * @param context
    * @param request
    * @param pk
    */
   public ResultBean getSysComponentByPk(ServletContext context, HttpServletRequest request, String pk){
      SysComponent sysComponent = sysComponentService.getSysComponentByPk(pk);
      return WebUtilWork.WebObjectPack(sysComponent);
   }

   /**
    * 删除 SysComponent
    * @param context
    * @param request
    * @param pks
    */
   public ResultBean deleteSysComponentByPks(ServletContext context, HttpServletRequest request, String[] pks){
      sysComponentService.deleteSysComponentByPks(pks);
      return WebUtilWork.WebResultPack(null);
   }

/**********************************************
 * 以上代码由BAMS代码生成工具自动生成，一般情况下无需修改。
 * 开发人员在此注释以下编写业务逻辑代码，并将自己写的代码框起来，便于后期代码合并，例如：
 **********************************************/

/**********************JC-begin**********************/
   public void method(){
      System.out.println("JC's code here");
   }
/**********************JC-end**********************/

/**********************Jacy-begin**********************/
   public void method2(){
      System.out.println("Jacy's code here");
   }
/**********************Jacy-end**********************/

}