package com.eazytec.common.util.office;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class DocumentHandler {

	private Configuration configuration = null;

	public DocumentHandler() {
		configuration = new Configuration();
		configuration.setDefaultEncoding("utf-8");
		// 设置模本装置方法和路径,FreeMarker支持多种模板装载方法。可以重servlet，classpath，数据库装载，
		// 这里我们的模板是放在com.havenliu.document.template包下面
		configuration.setClassicCompatible(true);
		configuration.setClassForTemplateLoading(this.getClass(),"/resource/doc");
	}

	public void exportAnnounce(String fileName, Map<String, Object> map) throws IOException, TemplateException {
		Template t = configuration.getTemplate("announce.xml");// xml文件为要装载的模板
		// 输出文档路径及名称
		File outFile = new File(fileName);
		Writer out = null;
		out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "utf-8"));
		t.process(map, out);
		out.close();
	}

}