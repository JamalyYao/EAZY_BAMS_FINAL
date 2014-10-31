package test.service;

import org.apache.log4j.Logger;

import com.eazytec.core.dao.ISysHelpDao;
import com.eazytec.core.dao.ISysMsgDao;
import com.eazytec.core.pojo.SysHelp;
import com.eazytec.core.pojo.SysMsg;

import test.iservice.ITestService;

public class TestService implements ITestService {
	private Logger log =Logger.getLogger(this.getClass());
	
	private ISysHelpDao sysHelpDao;
	private ISysMsgDao sysMsgDao;
	
	public ISysHelpDao getSysHelpDao() {
		return sysHelpDao;
	}
	public void setSysHelpDao(ISysHelpDao sysHelpDao) {
		this.sysHelpDao = sysHelpDao;
	}
	public ISysMsgDao getSysMsgDao() {
		return sysMsgDao;
	}
	public void setSysMsgDao(ISysMsgDao sysMsgDao) {
		this.sysMsgDao = sysMsgDao;
	}
	
	public void saveHelpAndMsg(SysHelp help, SysMsg msg) {
		log.info("测试事务是否生效...");
		sysHelpDao.save(help);
		sysMsgDao.save(msg);
	}
	
	

}
