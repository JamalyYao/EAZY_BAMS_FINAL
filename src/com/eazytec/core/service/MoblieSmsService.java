package com.eazytec.core.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.log4j.Logger;

import com.eazytec.common.pack.MoblieSmsHqlPack;
import com.eazytec.common.pages.Pager;
import com.eazytec.common.util.ConstWords;
import com.eazytec.common.util.EnumUtil;
import com.eazytec.core.dao.IHrmEmployeeDao;
import com.eazytec.core.dao.IOaSmsInboxDao;
import com.eazytec.core.dao.IOaSmsSendDao;
import com.eazytec.core.iservice.IMoblieSmsService;
import com.eazytec.core.pojo.HrmEmployee;
import com.eazytec.core.pojo.OaSmsInbox;
import com.eazytec.core.pojo.OaSmsSend;

public class MoblieSmsService implements IMoblieSmsService {
	private Logger log = Logger.getLogger(this.getClass());

	private IOaSmsInboxDao oaSmsInboxDao; 
	
	private IOaSmsSendDao oaSmsSendDao;
	private IHrmEmployeeDao hrmEmployeeDao;
	/**
	 * @param oaSmsInboxDao the oaSmsInboxDao to set
	 */
	public void setOaSmsInboxDao(IOaSmsInboxDao oaSmsInboxDao) {
		this.oaSmsInboxDao = oaSmsInboxDao;
	}

	/**
	 * @param oaSmsSendDao the oaSmsSendDao to set
	 */
	public void setOaSmsSendDao(IOaSmsSendDao oaSmsSendDao) {
		this.oaSmsSendDao = oaSmsSendDao;
	}
	
	//取所有未读短信,系统加载时使用
	public Map<String, Integer> getNoReadSmsCountGroupEmp(){
		Map<String, Integer> map = new HashMap<String, Integer>();
		List<Object[]> list =oaSmsInboxDao.findBySqlObjList("select oa_sms_inbox_emp,count(oa_sms_inbox_id) as num from OA_SMS_INBOX where oa_sms_inbox_isread = 2 group by oa_sms_inbox_emp");
		if(list != null && list.size()>0){
			for (Object[] objects : list) {
				map.put(objects[0].toString(), Integer.parseInt(objects[1].toString()));
			}
		}	
		return map;
	}

	public OaSmsSend saveSmsSend(ServletContext context,OaSmsSend oaSmsSend) {
		//收件人id集合
		String[] InboxSenderIds = oaSmsSend.getOaSmsSendAcpemp().substring(0, oaSmsSend.getOaSmsSendAcpemp().length()-1).split(",");
		for (int i = 0; i < InboxSenderIds.length; i++) {
			OaSmsInbox oainbox = new OaSmsInbox();
			oainbox.setOaSmsInboxEmp(InboxSenderIds[i]);
			oainbox.setCompanyId(oaSmsSend.getCompanyId());
			oainbox.setOaSmsInboxContent(oaSmsSend.getOaSmsSendContent());
			oainbox.setOaSmsInboxIsread(EnumUtil.OA_SMS_INBOX_ISREAD.two.value);
			oainbox.setOaSmsInboxSenderid(oaSmsSend.getOaSmsSendEmp());
			oainbox.setOaSmsInboxSendtime(oaSmsSend.getOaSmsSendTime());
			oainbox.setOaSmsType(EnumUtil.OA_SMS_TYPE.one.value);
			oainbox.setOaSmsInboxSenderName(oaSmsSend.getOaSmsSendEmpName());
			oainbox.setRecordDate(oaSmsSend.getRecordDate());
			oainbox.setRecordId(InboxSenderIds[i]);
			OaSmsInbox oainboxTemp = (OaSmsInbox) oaSmsInboxDao.save(oainbox);
			
			if (context.getAttribute(ConstWords.servletContext_MSGBOX)!=null) {
				Map<String,Integer> map =(Map)context.getAttribute(ConstWords.servletContext_MSGBOX);
				String userid = InboxSenderIds[i];
				if(map.containsKey(userid)){
					int count = map.get(userid)+1;
					map.put(userid, count);
				}else{
					map.put(userid, 1);
				}
			}
			
		}

		OaSmsSend oaSmsSendTemp = (OaSmsSend) oaSmsSendDao.save(oaSmsSend);
		return oaSmsSendTemp;
	}

	public int saveOaSmsInbox(ArrayList<OaSmsInbox> list){
		int c=0;
		for (OaSmsInbox oaSmsInbox : list) {
			Object obj =  oaSmsInboxDao.save(oaSmsInbox);
			if (obj!=null) {
				c++;
			}
		}
		return c;
	}
	
	
	public List<OaSmsSend> getAllOaSmsSend(OaSmsSend oaSmsSend, Pager pager) {
		List<OaSmsSend> oaSmsSendList = oaSmsSendDao.findByHqlWherePage(MoblieSmsHqlPack.getOaSmsSendSql(oaSmsSend)+" order by model.oaSmsSendTime  desc ", pager);
		return oaSmsSendList;
	}

	public int listOaSmsSendCount(OaSmsSend oaSmsSend) {
		int count = oaSmsSendDao.findByHqlWhereCount(MoblieSmsHqlPack.getOaSmsSendSql(oaSmsSend));
		return count;
	}

	public List<OaSmsInbox> getAllOaSmsInbox(OaSmsInbox oaSmsInbox, Pager pager) {
		List<OaSmsInbox> oaSmsInboxList = oaSmsInboxDao.findByHqlWherePage(MoblieSmsHqlPack.getoaSmsInboxSql(oaSmsInbox)+" order by model.oaSmsInboxIsread  desc,model.oaSmsInboxSendtime desc  ", pager);
		return oaSmsInboxList;
	}

	public int listOaSmsInboxCount(OaSmsInbox oaSmsInbox) {
		int count = oaSmsInboxDao.findByHqlWhereCount(MoblieSmsHqlPack.getoaSmsInboxSql(oaSmsInbox));
		return count;
	}

	public OaSmsSend getOaSmsSendByPK(long oaSmsSendId) {
		OaSmsSend oaSmsSend = oaSmsSendDao.getByPK(oaSmsSendId);
		return oaSmsSend;
	}

	public void deleteOaSmsSendByPks(long[] oaSmsSendPKs) {
		for (long l : oaSmsSendPKs) {
			OaSmsSend oaSmsSend = oaSmsSendDao.getByPK(l);
			oaSmsSendDao.remove(oaSmsSend);
		}
	}

	public OaSmsInbox getOaSmsInboxByPK(long oaSmsInboxId) {
		OaSmsInbox oaSmsInbox = oaSmsInboxDao.getByPK(oaSmsInboxId);
		return oaSmsInbox;
	}

	public void deleteOaSmsInboxByPks(long[] oaSmsInboxPKs) {
		for (long l : oaSmsInboxPKs) {
			OaSmsInbox oainbox = oaSmsInboxDao.getByPK(l);
			oaSmsInboxDao.remove(oainbox);
		}
	}

	public OaSmsInbox saveOaSmsInbox(OaSmsInbox oaSmsInbox) {
		OaSmsInbox oainboxTemp = (OaSmsInbox) oaSmsInboxDao.save(oaSmsInbox);
		return oainboxTemp;
	}

	/**
	 * 获得人员信息
	 */
	public HrmEmployee getEmployeeByPk(String id) {
		HrmEmployee Employee= hrmEmployeeDao.getByPK(id);
		return Employee;
	}

	public void setHrmEmployeeDao(IHrmEmployeeDao hrmEmployeeDao) {
		this.hrmEmployeeDao = hrmEmployeeDao;
	}
	
}
