package test;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngineConfiguration;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class ProcessEngineTest {
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext(
		        new String[]{"resource/springconf/spring-config-web.xml"}); 
		ProcessEngineConfiguration configuration = (ProcessEngineConfiguration) context.getBean("processEngineConfiguration");
		ProcessEngine processEngine = (ProcessEngine) context.getBean("processEngine");
		
		System.out.println("=============================================================");
		
		System.out.println(configuration.getDataSource());
		System.out.println(processEngine.getName());
		
	}
}
