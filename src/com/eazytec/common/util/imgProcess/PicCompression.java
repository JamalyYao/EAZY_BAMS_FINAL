package com.eazytec.common.util.imgProcess;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;

import javax.imageio.ImageIO;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * 图片压缩、添加水印
 * 
 * @author peng.ning
 * 
 */
public class PicCompression {
	/**
	 * 添加水印
	 * 
	 * @param fpath 图片路径
	 * @param txt 水印文字
	 * @throws Exception
	 */
	public static void proceWatermark(String fpath, String txt) throws Exception {
		File _file = new File(fpath);
		FileOutputStream out = null;
		try {
			if (!_file.exists()) { // 文件不存在时
				throw new Exception("图片不存在!");
			}
			Image src = javax.imageio.ImageIO.read(_file);
			int wideth = src.getWidth(null);
			int height = src.getHeight(null);
			BufferedImage tag = new BufferedImage(wideth, height, BufferedImage.TYPE_INT_RGB);
			Graphics g = tag.getGraphics();
			g.drawImage(src, 0, 0, wideth, height, null);
			if (txt != null) {
				g.drawString(txt, 10, height - 10);
			}
			out = new FileOutputStream(fpath);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(tag);
		} catch (Exception e) {
			throw new Exception("添加水印异常:" + e.getMessage());
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	/**
	 * 图片压缩
	 * @param oldFile 压缩文件绝对路径
	 * @param width 压缩宽度
	 * @param smallIcon	压缩后文件所加标识
	 * @return
	 * @throws Exception
	 */
	public static String proceSize(String oldFile, int width, String smallIcon) throws Exception {
		if (oldFile == null) {
			return null;
		}
		FileOutputStream out = null;
		String newImage = null;
		Image srcFile = null;
		try {
			File file = new File(oldFile);
			if (!file.exists()||!file.isFile()) { // 文件不存在时
				throw new Exception("图片不存在!");
			}
			srcFile = ImageIO.read(file);
			// 为等比缩放计算输出的图片宽度及高度
			double rate = ((double) srcFile.getWidth(null)) / (double) width;
			int new_w = width;
			int new_h = (int) (((double) srcFile.getHeight(null)) / rate);
			// 宽,高设定
			BufferedImage tag = new BufferedImage(new_w, new_h, BufferedImage.TYPE_INT_RGB);
			tag.getGraphics().drawImage(srcFile, 0, 0, new_w, new_h, null);
			String filePrex = oldFile.substring(0, oldFile.indexOf('.'));
			//压缩后的文件名
			newImage = filePrex +smallIcon+ oldFile.substring(filePrex.length());
			out = new FileOutputStream(newImage);
			
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(tag);
			// 压缩质量
			jep.setQuality(1, true);
			encoder.encode(tag, jep);
		} catch (Exception e) {
			throw new Exception("压缩图片出现问题:" + e.getMessage());
		} finally {
			if (out != null) {
				out.close();
			}
			if (srcFile != null) {
				srcFile.flush();
			}
		}
		return newImage;
	}
	
	
	//
	public static void main(String str[]) {
		try {
			String newpath = PicCompression.proceSize("C:/Documents and Settings/All Users/Documents/My Pictures/示例图片/Blue hills.jpg", 180, "Min2");
			//PicCompression.proceWatermark(newpath, "测试水印");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
