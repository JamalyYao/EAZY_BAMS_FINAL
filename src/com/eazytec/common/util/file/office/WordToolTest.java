package com.eazytec.common.util.file.office;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import org.apache.log4j.Logger;

public class WordToolTest
{
	private static String REPEAT_BLOCK = "repeat";
	private static Logger log = Logger.getLogger("WordToolTest");

	/*
	 * Test method for 'com.koal.util.WordTool.outputWordDoc
	 * 	(String template, Map singleMap, Map repeatMap,OutputStream out)'
	 */
	public void testOutputWordDoc() throws Exception
	{
		Map<String,String> shm = new HashMap<String,String>();
		shm.put("У", "XX");
		shm.put("", "о");
		shm.put("", new Date().toString());

		Map<String, Map> rhm = new HashMap<String, Map>();
		Map<String,Object[]> map = new HashMap<String,Object[]>();
		Object[] objArray1 =
		{ "0001", "0002", "0003", "0004" };
		Object[] objArray2 =
		{ "", "", "", "" };
		Object[] objArray3 =
		{ "", "U" , ""};
		map.put("", objArray1);
		map.put("", objArray2);
		map.put("", objArray3);
		rhm.put(REPEAT_BLOCK, map);
		String path = this.getClass().getResource("").getPath();
		log.info(path);
		FileOutputStream fout = new FileOutputStream(path + "mytest.doc");
		WordTool wt = new WordTool();
		boolean result = wt.outputWordDoc(path + "test.doc",
				new HashMap(), rhm, fout);
		log.info("result = " + result);
	}
	
	public void testMap()
	{
		String path = this.getClass().getResource("").getPath();
		FileOutputStream fout;
		try {
			fout = new FileOutputStream(path + "mytest.doc");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return;
		}
	}
}
