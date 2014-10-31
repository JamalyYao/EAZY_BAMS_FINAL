package com.eazytec.common.util.file.office;

import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;

public class ExcelToolTest
{
	private Logger log = Logger.getLogger(this.getClass());

	public void testExportExcelDoc()
	{
		List list = new ArrayList();

		List list0 = new ArrayList();
		list0.add("");
		list0.add("");
		list0.add("2");
		list.add(list0);

		List list1 = new ArrayList();
		list1.add("001");
		list1.add("xiaobaiyou");
		list1.add("xiaobaiyou");
		list.add(list1);

		List list2 = new ArrayList();
		list2.add("002");
		list2.add("xiaobaiyou");
		list2.add("xiaobaiyou");
		list.add(list2);

		List list3 = new ArrayList();
		list3.add("003");
		list3.add("xiaobaiyou");
		list3.add("xiaobaiyou");
		list.add(list3);

		String path = this.getClass().getResource("").getPath();
		log.info(path);

		ExcelTool wt = new ExcelTool();
//		 wt.exportExcelDoc(path + "test.xls", list);
		//log.info("result = " + result);
	}

}
