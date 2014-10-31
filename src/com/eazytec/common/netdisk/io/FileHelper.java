package com.eazytec.common.netdisk.io;

import de.innosystec.unrar.Archive;
import de.innosystec.unrar.exception.RarException;
import de.innosystec.unrar.rarfile.FileHeader;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.DirectoryWalker;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;


public class FileHelper extends DirectoryWalker {
	private static final Log log = LogFactory.getLog(FileHelper.class);
	private String startDirectory;

	public void upload(HttpServletRequest request) {
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
			items = upload.parseRequest(request);
		} catch (FileUploadException e1) {
			e1.printStackTrace();
		}
		Iterator iter = items.iterator();
		HashMap params = new HashMap();
		FileItem file = null;

		while (iter.hasNext()) {
			FileItem item = (FileItem) iter.next();
			if (item.isFormField())
				params.put(item.getFieldName(), item.getString());
			else {
				file = item;
			}

		}

		String incomingName = file.getName();
		String nakedFilename = FilenameUtils.getName(incomingName);
		try {
			InputStream is = file.getInputStream();
			OutputStream os = new FileOutputStream(
					(String) params.get("uploadDirectory") + File.separator
							+ nakedFilename);
			int bytesRead = 0;
			byte[] buffer = new byte[8192];
			while ((bytesRead = is.read(buffer, 0, 8192)) != -1) {
				os.write(buffer, 0, bytesRead);
			}
			is.close();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void download(HttpServletRequest request,
			HttpServletResponse response) {
		String filePath = request.getParameter("p");
		String fileName = request.getParameter("n");
		response.setContentType("application/unknown");
		response.addHeader("Content-Disposition", "attachment; filename="
				+ fileName);
		try {
			File f = new File(filePath + File.separator + fileName);
			FileInputStream fis = new FileInputStream(f);
			PrintWriter pw = response.getWriter();
			int c = -1;
			while ((c = fis.read()) != -1) {
				pw.print((char) c);
			}
			fis.close();
			pw.flush();
			pw = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected boolean handleDirectory(final File directory, int depth,
			Collection results) {
		if (depth <= 1) {
			if (directory.getParent() != null) {
				if (!this.startDirectory.equals(directory.getPath())) {
					MyDirectory dv = new MyDirectory();
					dv.setName(directory.getName());
					dv.setPath(directory.getPath());

					String[] childDirectories = directory
							.list(new FilenameFilter() {
								public boolean accept(File dir, String name) {
									if (name != directory.getName()) {
										File f = new File(dir.getPath()
												+ File.separator + name);
										if (f.isDirectory()) {
											return true;
										}
									}
									return false;
								}
							});
					if ((childDirectories != null)
							&& (childDirectories.length > 0)) {
						dv.setHasChildren(true);
					}
					results.add(dv);
				}
			}
			return true;
		}
		return false;
	}

	public List<MyFile> listFiles(String directory) throws Exception {
		try {
			File[] files = new File(directory).listFiles();
			List results = new ArrayList();
			if (files != null) {
				for (File f : files) {
					MyFile fv = new MyFile();
					fv.setName(f.getName());
					fv.setSize(f.length());
					if (f.isDirectory())
						fv.setType("Directory");
					else {
						fv.setType(null);
					}
					fv.setModified(new Date(f.lastModified()));
					results.add(fv);
				}
			}
			return results;
		} catch (Exception e) {
			throw new Exception("Exception occurred: " + e);
		}
	}

	public List<MyDirectory> listDirectories(String startDirectory)
			throws Exception {
		this.startDirectory = startDirectory;

		List results = new ArrayList();
		try {
			walk(new File(startDirectory), results);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Exception occurred: " + e);
		}
		return results;
	}

	public List<MyDirectory> listRoots() throws Exception {
		try {
			File[] roots = File.listRoots();
			List results = new ArrayList();
			for (final File f : roots) {
				MyDirectory dv = new MyDirectory();
				dv.setName(f.getPath());
				dv.setPath(f.getPath());

				String[] childDirectories = f.list(new FilenameFilter() {
					public boolean accept(File dir, String name) {
						if (name != f.getName()) {
							File f = new File(dir.getPath() + File.separator
									+ name);
							if (f.isDirectory()) {
								return true;
							}
						}
						return false;
					}
				});
				if ((childDirectories != null) && (childDirectories.length > 0)) {
					dv.setHasChildren(true);
				}
				results.add(dv);
			}
			return results;
		} catch (Exception e) {
			throw new Exception("Exception occurred: " + e);
		}
	}

	public void createChildDirectory(String path) throws Exception {
		boolean outcome = false;
		try {
			outcome = new File(path + File.separator + "new_directory").mkdir();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Exception occurred: " + e);
		}
		if (!outcome)
			throw new Exception(
					"Directory could not be created\n\n(Does a directory with the name 'new_directory' already exist?");
	}

	public boolean createDirectory(String path) {
		File file = null;
		try {
			file = new File(path);
			if (!file.exists())
				return file.mkdirs();
		} catch (RuntimeException e) {
			e.printStackTrace();
		} finally {
			file = null;
		}
		file = null;

		return false;
	}

	public void createDirectory(String directory, String subDirectory) {
		File fileDir = new File(directory);
		try {
			if ((subDirectory == "") && (!fileDir.exists())) {
				fileDir.mkdir();
			} else if (subDirectory != "") {
				String[] dir = subDirectory.replace('\\', '/').split("/");
				for (int i = 0; i < dir.length; i++) {
					File subFile = new File(directory + File.separator + dir[i]);
					if (!subFile.exists())
						subFile.mkdir();
					directory = directory + File.separator + dir[i];
				}
			}
		} catch (Exception ex) {
			log.debug(ex.getMessage());
		}
	}

	public void deleteFile(String fullPath) throws Exception {
		boolean outcome = false;
		try {
			outcome = new File(fullPath).delete();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Exception occurred: " + e);
		}
		if (!outcome)
			throw new Exception(
					"File/directory could not be deleted\n\nPossible permission issue?\n\n(If it's a directory, it must be empty to be deleted)");
	}

	public boolean deleteDirectory(File file) {
		boolean flag = false;
		try {
			if (!file.exists()) {
				throw new RuntimeException("File not exist!");
			}

			if (!file.isDirectory()) {
				throw new RuntimeException("File is not a Directory!");
			}

			String[] contents = file.list();
			for (int i = 0; i < contents.length; i++) {
				File file2X = new File(file.getAbsolutePath() + File.separator
						+ contents[i]);
				if (file2X.isFile())
					flag = file2X.delete();
				else if (file2X.isDirectory()) {
					deleteDirectory(file2X);
				}
			}

			flag = file.delete();
		} catch (Exception e) {
			flag = false;
			e.printStackTrace();
		}
		return flag;
	}

	public void renameFile(String oldFullPath, String newFullPath)
			throws Exception {
		boolean outcome = false;
		try {
			outcome = new File(oldFullPath).renameTo(new File(newFullPath));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Exception occurred: " + e);
		}
		if (!outcome)
			throw new Exception(
					"File/directory could not be renamed\n\n(Does a file/directory with the new name already exist?");
	}

	public void createFile(String path) throws Exception {
		try {
			File f = new File(path + File.separator + "new_file.txt");
			if (!f.createNewFile())
				throw new Exception("File already exists");
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Exception occurred: " + e);
		}
	}

	public void copyMoveFile(String sourcePath, String sourceName,
			String destinationPath, String operation, String type)
			throws Exception {
		boolean outcome = true;
		try {
			File src = new File(sourcePath + File.separator + sourceName);
			File dest = new File(destinationPath + File.separator
					+ (operation.equals("copy") ? "copy_of_" : "") + sourceName);

			if (type.equals("file"))
				FileUtils.copyFile(src, dest);
			else {
				FileUtils.copyDirectory(src, dest);
			}

			if (operation.equals("cut"))
				deleteFile(sourcePath + File.separator + sourceName);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Exception occurred: " + e);
		}
		if (!outcome)
			throw new Exception(
					"File/directory could not be copied/moved\n\n(Does the file/directory already exist in the destination?)");
	}

	public String editFile(String path) throws Exception {
		String fileContents = null;
		try {
			fileContents = FileUtils.readFileToString(new File(path));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Exception occurred: " + e);
		}
		return fileContents;
	}

	public void saveFile(String path, String text) throws Exception {
		try {
			File f = new File(path);
			FileUtils.writeStringToFile(f, text);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Exception occurred: " + e);
		}
	}

	public String getPostfix(String fileName) {
		return fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
	}

	public boolean isValidType(String contentType, String[] allowTypes) {
		if ((contentType == null) || ("".equals(contentType))) {
			return false;
		}
		for (String type : allowTypes) {
			if (contentType.equals(type)) {
				return true;
			}
		}
		return false;
	}

	public String checkFileName(String fileName, String dir) {
		boolean isDirectory = new File(dir + fileName).isDirectory();
		if (isFileExist(fileName, dir)) {
			int index = fileName.lastIndexOf(".");
			StringBuffer newFileName = new StringBuffer();
			String name = isDirectory ? fileName : fileName.substring(0, index);
			String extendName = isDirectory ? "" : fileName.substring(index);
			int nameNum = 1;
			while (true) {
				newFileName.append(name).append("(").append(nameNum)
						.append(")");
				if (!isDirectory) {
					newFileName.append(extendName);
				}
				if (!isFileExist(newFileName.toString(), dir))
					break;
				nameNum++;
				newFileName = new StringBuffer();
			}

			return newFileName.toString();
		}

		return fileName;
	}

	public boolean upload(String uploadFileName, String savePath,
			File uploadFile) {
		boolean flag = false;
		try {
			uploadForName(uploadFileName, savePath, uploadFile);
			flag = true;
		} catch (IOException e) {
			flag = false;
			e.printStackTrace();
		}
		return flag;
	}

	public String uploadForName(String uploadFileName, String savePath,
			File uploadFile) throws IOException {
		String newFileName = checkFileName(uploadFileName, savePath);
		FileOutputStream fos = null;
		FileInputStream fis = null;
		try {
			fos = new FileOutputStream(savePath + newFileName);
			fis = new FileInputStream(uploadFile);
			byte[] buffer = new byte[1024];
			int len = 0;
			while ((len = fis.read(buffer)) > 0)
				fos.write(buffer, 0, len);
		} catch (FileNotFoundException e) {
			throw e;
		} catch (IOException e) {
			throw e;
		} finally {
			try {
				if (fos != null) {
					fos.close();
				}
				if (fis != null)
					fis.close();
			} catch (IOException e) {
				throw e;
			}
		}
		return newFileName;
	}

	public static boolean isFileExist(String fileName, String dir) {
		File files = new File(dir + fileName);
		return files.exists();
	}

	public String getRandomName(String fileName, String dir) {
		String[] split = fileName.split("\\.");
		String extendFile = "." + split[(split.length - 1)].toLowerCase();

		Random random = new Random();
		int add = random.nextInt(1000000);
		String ret = add + extendFile;
		while (isFileExist(ret, dir)) {
			add = random.nextInt(1000000);
			ret = fileName + add + extendFile;
		}
		return ret;
	}

	public void unZip(String zipFileName, String outputDirectory) {
		try {
			ZipFile zipFile = new ZipFile(zipFileName);
			Enumeration e = zipFile.getEntries();
			ZipEntry zipEntry = null;
			createDirectory(outputDirectory, "");
			while (e.hasMoreElements()) {
				zipEntry = (ZipEntry) e.nextElement();
				if (zipEntry.isDirectory()) {
					String name = zipEntry.getName();
					name = name.substring(0, name.length() - 1);
					File f = new File(outputDirectory + File.separator + name);
					f.mkdir();
					log.info("创建目录：" + outputDirectory + File.separator + name);
				} else {
					String fileName = zipEntry.getName();
					fileName = fileName.replace('\\', '/');
					if (fileName.indexOf("/") != -1) {
						createDirectory(outputDirectory, fileName.substring(0,
								fileName.lastIndexOf("/")));
						log.info("文件的路径：" + fileName);
						fileName = fileName.substring(
								fileName.lastIndexOf("/") + 1,
								fileName.length());
					}

					File f = new File(outputDirectory + File.separator
							+ zipEntry.getName());

					f.createNewFile();
					InputStream in = zipFile.getInputStream(zipEntry);
					FileOutputStream out = new FileOutputStream(f);

					byte[] by = new byte[1024];
					int c;
					while ((c = in.read(by)) != -1) {
						//int c;
						out.write(by, 0, c);
					}
					out.close();
					in.close();
				}
			}
		} catch (Exception ex) {
			log.info(ex.getMessage());
		}
	}

	public void unzipFiles(String filesFolder, String outputDirectory) {
		File zipFolder = new File(filesFolder);
		try {
			String[] zipFiles = zipFolder.list();
			for (int i = 0; i < zipFiles.length; i++)
				if ("zip".equals(getPostfix(zipFiles[i]))) {
					String zipFileAbs = filesFolder + File.separator
							+ zipFiles[i];
					unZip(zipFileAbs, outputDirectory);
				}
		} catch (SecurityException ex) {
			ex.printStackTrace();
		}
	}

	public boolean decompressionRarFiles(String rarFileName, String extPlace) {
		boolean flag = false;
		Archive archive = null;
		File out = null;
		File file = null;
		File dir = null;
		FileOutputStream os = null;
		FileHeader fh = null;
		String dirPath = "";
		try {
			file = new File(rarFileName);
			archive = new Archive(file);
		} catch (RarException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		} finally {
			if (file != null) {
				file = null;
			}
		}
		if (archive != null) {
			try {
				fh = archive.nextFileHeader();
				while (fh != null) {
					String path = (extPlace + fh.getFileNameString().trim())
							.replaceAll("\\\\", "/");
					int end = path.lastIndexOf("/");
					if (end != -1)
						dirPath = path.substring(0, end);
					try {
						dir = new File(dirPath);
						if (!dir.exists())
							dir.mkdirs();
					} catch (RuntimeException e1) {
						e1.printStackTrace();
					} finally {
						if (dir != null) {
							dir = null;
						}
					}
					if (fh.isDirectory()) {
						fh = archive.nextFileHeader();
					} else {
						out = new File(extPlace + fh.getFileNameString().trim());
						try {
							os = new FileOutputStream(out);
							archive.extractFile(fh, os);
						} catch (FileNotFoundException e) {
							e.printStackTrace();
						} catch (RarException e) {
							e.printStackTrace();
						} finally {
							if (os != null) {
								try {
									os.close();
								} catch (IOException e) {
									e.printStackTrace();
								}
							}
							if (out != null) {
								out = null;
							}
						}
						fh = archive.nextFileHeader();
					}
				}
			} catch (RuntimeException e) {
				e.printStackTrace();

				fh = null;
				if (archive != null)
					try {
						archive.close();
					} catch (IOException e1) {
						e1.printStackTrace();
					}
			} finally {
				fh = null;
				if (archive != null) {
					try {
						archive.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			flag = true;
		}
		return flag;
	}

	public boolean decompressionZipFiles(String zipFileName, String extPlace) {
		boolean flag = false;
		try {
			unZip(zipFileName, extPlace);
			flag = true;
		} catch (RuntimeException e) {
			e.printStackTrace();
		}
		return flag;
	}

	public void compressionFiles(ZipOutputStream zosm, File file,
			String basePath) {
		if (file.isDirectory()) {
			File[] files = file.listFiles();
			try {
				zosm.putNextEntry(new ZipEntry(basePath + "/"));
			} catch (IOException e) {
				e.printStackTrace();
			}
			basePath = basePath + (basePath.length() == 0 ? "" : "/")
					+ file.getName();
			for (File f : files)
				compressionFiles(zosm, f, basePath);
		} else {
			FileInputStream fism = null;
			BufferedInputStream bism = null;
			try {
				byte[] bytes = new byte[1024];
				fism = new FileInputStream(file);
				bism = new BufferedInputStream(fism, 1024);
				basePath = basePath + (basePath.length() == 0 ? "" : "/")
						+ file.getName();
				zosm.putNextEntry(new ZipEntry(basePath));
				int count;
				while ((count = bism.read(bytes, 0, 1024)) != -1) {
					//int count;
					zosm.write(bytes, 0, count);
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();

				if (bism != null) {
					try {
						bism.close();
					} catch (IOException e1) {
						e1.printStackTrace();
					}
				}
				if (fism != null)
					try {
						fism.close();
					} catch (IOException e2) {
						e2.printStackTrace();
					}
			} catch (IOException e) {
				e.printStackTrace();

				if (bism != null) {
					try {
						bism.close();
					} catch (IOException e1) {
						e1.printStackTrace();
					}
				}
				if (fism != null)
					try {
						fism.close();
					} catch (IOException e2) {
						e2.printStackTrace();
					}
			} finally {
				if (bism != null) {
					try {
						bism.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (fism != null)
					try {
						fism.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
			}
		}
	}
}