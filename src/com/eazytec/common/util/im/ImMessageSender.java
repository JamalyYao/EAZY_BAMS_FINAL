package com.eazytec.common.util.im;

import java.io.IOException;
import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.ConnectionConfiguration;
import org.jivesoftware.smack.XMPPConnection;
import com.eazytec.common.util.file.properties.SystemConfig;

public class ImMessageSender implements Runnable{
	
	private String u;
	private String msg;
	
	public ImMessageSender(String u, String msg) {
		super();
		this.u = u;
		this.msg = msg;
	}
	
	public void run() {
		Boolean isopen = null;
		String host = null, port = null, username = null ,password = null;
		
		try {
			//获取配置文件属性
			isopen = Boolean.valueOf(SystemConfig.getParam("im.isopen"));
			host = SystemConfig.getParam("im.host");
			port = SystemConfig.getParam("im.port");
			username = SystemConfig.getParam("im.username");
			password = SystemConfig.getParam("im.password");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(isopen){
			//推送IM信息
			ConnectionConfiguration c = getConnectionConfiguration(host, Integer.valueOf(port));
			XMPPConnection connection = new XMPPConnection(c);
			
			try {
				connection.connect();
				connection.login(username, password);
				Chat chat = connection.getChatManager().createChat(u + "@" + host, null);
				chat.sendMessage(msg);
				Thread.sleep(2 * 1000);//睡2秒钟
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				connection.disconnect();
			}
		}
	}

	/**
	 * 获得连接参数对象
	 * @param host
	 * @param port
	 * @return
	 */
	private ConnectionConfiguration getConnectionConfiguration(String host, Integer port) {
		ConnectionConfiguration config = new ConnectionConfiguration(host, port);
		config.setCompressionEnabled(true);
		config.setSASLAuthenticationEnabled(true);
		return config;
	}
}
