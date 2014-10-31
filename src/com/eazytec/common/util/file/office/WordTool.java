package com.eazytec.common.util.file.office;

import java.io.FileNotFoundException;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import org.apache.log4j.Logger;
//import com.softartisans.wordwriter.WordTemplate;

/**
 * Word^jLLWord^jIJ.
 */
public class WordTool
{
	private Logger log = Logger.getLogger("WordTool");

	/**
	 * DOC
	 * @param template g
	 * @param map 
	 * @param out 
	 * @return boolean 
	 */
	public boolean exportWordDoc(String template, Map map, OutputStream out)
	{
		//У
//		if (template == null || out == null)
//		{
//			log.error("==>gl.");
//			return false;
//		}
//
//		//Wordg,gl
//		WordTemplate wt = new WordTemplate();
//
//		try
//		{
//			wt.open(template);
//		}
//		catch (FileNotFoundException e1)
//		{
//			log.error("==>δgl:" + template);
//			return false;
//		}
//		catch (SecurityException e1)
//		{
//			log.error("==>^ugl");
//			return false;
//		}
//		catch (Exception e1)
//		{
//			log.error("==>gl:" + template);
//			return false;
//		}
//		log.info("gl");
//
//		boolean result = parseSingleMap(wt, map);
//		if (!result)
//		{
//			log.error("^jg.");
//			return false;
//		}
//
//		//?^j
//		try
//		{
//			wt.process();
//			wt.save(out);
//		}
//		catch (Exception e)
//		{
//			e.printStackTrace();
//			return false;
//		}
//		log.info("^j");

		return true;
	}
	
	/**
	 * DOC
	 * @param template g
	 * @param object 
	 * @param out 
	 * @return boolean 
	 */
	public boolean exportWordDoc(String template, Object object, OutputStream out)
	{
		if(object == null)
		{
			log.error("==>.");
			return false;
		}

		//
		Map map = this.objectToMap(object);
		return this.exportWordDoc(template, map, out);
	}

	/**
	 * ^jg^j,′^j
	 * 
	 * @param is ^jg
	 * @param singleMap 洢
	 * 		<p>洢</p>
	 * 		^jgString
	 * 		Object
	 * @param repeatMap 洢
	 * 		<p>洢</p>
	 * 		^jgString
	 * 		Map洢
	 * 		Mapl(String)(Object[])
	 * @param out L
	 * @return true:;false:
	 */
	public boolean outputWordDoc(String template, Map singleMap, Map repeatMap, OutputStream out)
	{
		//У
//		if (template == null)
//		{
//			log.error("==>gl.");
//			return false;
//		}
//
//		//Wordg,gl
//		WordTemplate wt = new WordTemplate();
//
//		try
//		{
//			wt.open(template);
//		}
//		catch (FileNotFoundException e1)
//		{
//			log.error("==>δgl:" + template);
//			return false;
//		}
//		catch (SecurityException e1)
//		{
//			log.error("==>^ugl");
//			return false;
//		}
//		catch (Exception e1)
//		{
//			log.error("==>gl:" + template);
//			return false;
//		}
//		log.info("gl");
//
//		//
//		if (singleMap != null)
//		{
//			log.info("’...");
//			boolean result = parseSingleMap(wt, singleMap);
//			if (!result)
//			{
//				log.error(".");
//				return false;
//			}
//		}
//
//		//
//		if (repeatMap != null)
//		{
//			log.info("’...");
//			boolean result = parseRepeatMap(wt, repeatMap);
//			if (!result)
//			{
//				log.error(".");
//				return false;
//			}
//		}
//
//		//?^j
//
//		try
//		{
//			wt.process();
//			wt.save(out);
//		}
//		catch (Exception e)
//		{
//			e.printStackTrace();
//			return false;
//		}
//		log.info("^j");

		return true;
	}

	/**
	 * Wordg÷
	 * 
	 * @param wt Wordg
	 * @param map 洢
	 * 		<p>洢</p>
	 * 		^jgString
	 * 		Object
	 * @return true:ó;false:
	 */
//	private boolean parseSingleMap(WordTemplate wt, Map map)
//	{
//		String[] fieldNames = new String[map.size()];
//		String[] dataRows = new String[map.size()];
//		Iterator itr = map.entrySet().iterator();
//		for (int i = 0; itr.hasNext(); i++)
//		{
//			Entry entry = (Entry) itr.next();
//			Object objTemp = entry.getKey();
//			if (!(objTemp instanceof String))
//			{
//				return false;
//			}
//			fieldNames[i] = (String) objTemp;
//			dataRows[i] = entry.getValue().toString();
//		}
//
//		try
//		{
//			wt.setDataSource(dataRows, fieldNames);
//		}
//		catch (NullPointerException e)
//		{
//			e.printStackTrace();
//			return false;
//		}
//		catch (Exception e)
//		{
//			e.printStackTrace();
//			return false;
//		}
//
//		log.info("");
//
//		return true;
//	}

	/**
	 * Wordg
	 * 
	 * @param wt Wordg
	 * @param map 洢
	 * 		<p>洢</p>
	 * 		^jgString
	 * 		Map洢
	 * 		Mapl(String)(Object[])
	 * @return true:ó;false:
	 */
//	private boolean parseRepeatMap(WordTemplate wt, Map map)
//	{
//
//		for (Iterator itr = map.entrySet().iterator(); itr.hasNext();)
//		{
//
//			Entry entry = (Entry) itr.next();
//			Object objTemp = entry.getKey();
//			if (!(objTemp instanceof String))
//			{
//				return false;
//			}
//			//
//			String repeatName = (String) objTemp;
//			objTemp = entry.getValue();
//			if (!(objTemp instanceof Map))
//			{
//				return false;
//			}
//			Map subMap = (Map) objTemp;
//			String[] fieldNames = new String[subMap.size()];
//			Object[][] dataRows = new Object[subMap.size()][];
//			Iterator itr2 = subMap.entrySet().iterator();
//			for (int i = 0; itr2.hasNext(); i++)
//			{
//				Entry entry2 = (Entry) itr2.next();
//				objTemp = entry2.getKey();
//				if (!(objTemp instanceof String))
//				{
//					return false;
//				}
//				fieldNames[i] = (String) objTemp;
//				objTemp = entry2.getValue();
//				if (!(objTemp instanceof Object[]))
//				{
//					return false;
//				}
//				dataRows[i] = (Object[]) objTemp;
//			}
//
//			try
//			{
//				wt.setRepeatBlock(dataRows, fieldNames, repeatName);
//			}
//			catch (Exception e)
//			{
//				e.printStackTrace();
//				return false;
//			}
//		}
//
//		return true;
//	}

	private Map objectToMap(Object object)
	{
		if (object == null)
		{
			return null;
		}
		Map<String, String> map = new HashMap<String, String>();
		Class myclass = object.getClass();
		String objName = myclass.getName();
		objName = objName.substring(objName.lastIndexOf(".") + 1);
		objName = objName.substring(0, 1).toLowerCase() + objName.substring(1);
		Method[] method = myclass.getMethods();
		for (int i = 0; i < method.length; i++)
		{
			String mname = method[i].getName();
			if (mname.startsWith("get"))
			{
				mname = mname.substring(3);
				mname = mname.substring(0, 1).toLowerCase() + mname.substring(1);
			}
			else
			{
				continue;
			}
			try
			{
				Object obj = method[i].invoke(object);
				if (obj != null)
				{
					map.put(objName + "_" + mname, obj.toString());
				}
			}
			catch (Exception ex)
			{
				ex.printStackTrace();
			}
		}

		return map;
	}
}
