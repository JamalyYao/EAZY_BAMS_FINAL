package com.eazytec.common.util.file.office;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
//import jxl.CellType;
//import jxl.Workbook;
//import jxl.write.Label;
//import jxl.write.WritableCell;
//import jxl.write.WritableSheet;
//import jxl.write.WritableWorkbook;
import org.apache.log4j.Logger;

/**
 * Word^jLLWord^jIJ.
 * 
 * <p><b>Company</b>ShangHai KOAL SoftWare CO.,LTD.</p>
 * <p><b>Author</b>Ф</p>
 * <p><b>Date</b>2006.07.10</p>
 */
public class ExcelTool 
{
//	private Logger log = Logger.getLogger(this.getClass());
//	public String exportExcelDoc(String template, List list) {
//		String tmpFileName = null;
//		try {
//			File file = new File(template);
//			tmpFileName = file.getPath().replace(file.getName(), "") + java.util.UUID.randomUUID().toString().replace("-", "")+ ".xls";
//			FileOutputStream fout = new FileOutputStream(tmpFileName);
//			Workbook workbook = Workbook.getWorkbook(file);
//			WritableWorkbook copy = Workbook.createWorkbook(fout,workbook);
//			WritableSheet sheet = copy.getSheet(0);
//			// cellУ
//			// ~n
//			// 4δ
//			for (int i = 0; i < list.size(); i++) 
//			{
//				List listrow = (List) list.get(i);
//				int col = 0; // ’
//				int row = i; // ’
//
//				// 4δ,Уλ
//				for (int j = 1; j < listrow.size(); j++) {
//					WritableCell cellb = sheet
//							.getWritableCell(col + j -1, row);
//					if (cellb.getType() == CellType.EMPTY) {
//						String labelvalue = (String) listrow.get(j);
//						if (labelvalue == null)
//							labelvalue = "0";
//						Label label = new Label(col + j -1, row, labelvalue);
//						sheet.addCell(label);
//					}
//				}
//			}
//			log.info("ó.");
//
//			copy.write();
//			copy.close();
//			workbook.close();
//			
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			return null;
//		}
//
//		return tmpFileName;
//	}
}
