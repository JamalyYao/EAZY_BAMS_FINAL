package com.eazytec.core.pojo;

import com.eazytec.common.annotation.Remark;

/**
 * 数据库表名：sys_component
 */
public class SysComponent extends BaseStringBean implements java.io.Serializable {

   @Remark("普通文本框|1|1|1|1")
   private String comInput;
   @Remark("数字框|2|2|2|1")
   private Integer comNumform;
   @Remark("金额框|2|2|3|1")
   private Double comRmbform;
   @Remark("日期框|2|2|4|1")
   private String comDateform;
   @Remark("下拉框|2|2|5|1")
   private Integer comSelect;
   @Remark("单选框|2|2|6|1")
   private Integer comRadio;
   @Remark("多选框|2|2|7|1")
   private String comCheckbox;
   @Remark("弹出单选框|2|2|8|1")
   private String comTakeformText;
   @Remark("弹出多选框|2|2|9|1")
   private String comTakeformTextarea;
   @Remark("文本域|2|2|10|1")
   private String comTextarea;
   @Remark("富文本|2|2|11|1")
   private String comFck;
   @Remark("上传图片|2|2|12|1")
   private Integer comUploadimg;
   @Remark("上传附件|2|2|13|1")
   private String comUploadfile;

   //默认构造方法
   public SysComponent(){
      super();
   }

   //构造方法(手工生成)
   

  //get和set方法
   public String getComInput(){
      return comInput;
   }

   public void setComInput(String aComInput){
      this.comInput = aComInput;
   }

   public Integer getComNumform(){
      return comNumform;
   }

   public void setComNumform(Integer aComNumform){
      this.comNumform = aComNumform;
   }

   public Double getComRmbform(){
      return comRmbform;
   }

   public void setComRmbform(Double aComRmbform){
      this.comRmbform = aComRmbform;
   }

   public String getComDateform(){
      return comDateform;
   }

   public void setComDateform(String aComDateform){
      this.comDateform = aComDateform;
   }

   public Integer getComSelect(){
      return comSelect;
   }

   public void setComSelect(Integer aComSelect){
      this.comSelect = aComSelect;
   }

   public Integer getComRadio(){
      return comRadio;
   }

   public void setComRadio(Integer aComRadio){
      this.comRadio = aComRadio;
   }

   public String getComCheckbox(){
      return comCheckbox;
   }

   public void setComCheckbox(String aComCheckbox){
      this.comCheckbox = aComCheckbox;
   }

   public String getComTakeformText(){
      return comTakeformText;
   }

   public void setComTakeformText(String aComTakeformText){
      this.comTakeformText = aComTakeformText;
   }

   public String getComTakeformTextarea(){
      return comTakeformTextarea;
   }

   public void setComTakeformTextarea(String aComTakeformTextarea){
      this.comTakeformTextarea = aComTakeformTextarea;
   }

   public String getComTextarea(){
      return comTextarea;
   }

   public void setComTextarea(String aComTextarea){
      this.comTextarea = aComTextarea;
   }

   public String getComFck(){
      return comFck;
   }

   public void setComFck(String aComFck){
      this.comFck = aComFck;
   }

   public Integer getComUploadimg(){
      return comUploadimg;
   }

   public void setComUploadimg(Integer aComUploadimg){
      this.comUploadimg = aComUploadimg;
   }

   public String getComUploadfile(){
      return comUploadfile;
   }

   public void setComUploadfile(String aComUploadfile){
      this.comUploadfile = aComUploadfile;
   }

}