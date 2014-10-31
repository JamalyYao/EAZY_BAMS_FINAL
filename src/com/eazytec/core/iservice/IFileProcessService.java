package com.eazytec.core.iservice;

import com.eazytec.core.pojo.SysAttachmentInfo;
import com.eazytec.core.pojo.SysImageInfo;

public interface IFileProcessService {
	public SysImageInfo getImageInfoByPk(long pk);
	
	public SysAttachmentInfo getAttachmentInfoByPk(long pk);
}
