package test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.eazytec.core.pojo.SysHelp;
import com.eazytec.core.pojo.SysMsg;

import test.iservice.ITestService;

/**
 * 测试事务是否生效
 * @author jc
 */
public class TransactionTest {
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext(
		        new String[]{"resource/springconf/spring-config-web.xml"}); 
		ITestService testService = (ITestService) context.getBean("testService");
		
		SysHelp help = new SysHelp();
		SysMsg msg = new SysMsg();
		msg.setMsgDate("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" +
				"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" +
				"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" +
				"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" +
				"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
		
		testService.saveHelpAndMsg(help, msg);
	}
}
