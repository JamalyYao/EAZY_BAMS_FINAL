package com.eazytec.core.service;

import org.apache.log4j.Logger;

import com.eazytec.core.dao.ISysAttachmentInfoDao;
import com.eazytec.core.dao.ISysImageInfoDao;
import com.eazytec.core.iservice.IFileProcessService;
import com.eazytec.core.pojo.SysAttachmentInfo;
import com.eazytec.core.pojo.SysImageInfo;

public class FileProcessService implements IFileProcessService {
	private Logger log =Logger.getLogger(this.getClass());
	
	private ISysImageInfoDao sysImageInfodao;
	
	private ISysAttachmentInfoDao sysAttachmentDao;

	public void setSysImageInfodao(ISysImageInfoDao sysImageInfodao) {
		this.sysImageInfodao = sysImageInfodao;
	}

	public void setSysAttachmentDao(ISysAttachmentInfoDao sysAttachmentDao) {
		this.sysAttachmentDao = sysAttachmentDao;
	}
	
	public SysImageInfo getImageInfoByPk(long pk){
		return sysImageInfodao.getByPK(pk);
	}
	
	public SysAttachmentInfo getAttachmentInfoByPk(long pk){
		return sysAttachmentDao.getByPK(pk);
	}
}
