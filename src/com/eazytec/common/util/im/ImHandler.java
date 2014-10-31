package com.eazytec.common.util.im;

public class ImHandler {
	
	public static void sendMessage(String u, String msg) {
		ImMessageSender sender = new ImMessageSender(u, msg);
		Thread t = new Thread(sender);
		t.start();
	}
}
