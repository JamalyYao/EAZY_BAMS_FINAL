package com.eazytec.common.netdisk.action;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import com.eazytec.common.module.SessionUser;
import com.eazytec.common.netdisk.core.Page;
import com.eazytec.common.netdisk.json.bean.FileNode;
import com.eazytec.common.pages.Pager;
import com.eazytec.common.util.LoginContext;
import com.eazytec.common.util.UtilTool;
import com.eazytec.common.util.UtilWork;
import com.eazytec.common.util.file.properties.SystemConfig;
import com.eazytec.core.iservice.INetdiskService;
import com.eazytec.core.pojo.OaNetdiskConfig;
import com.eazytec.core.pojo.OaNetdiskShare;

/**
 * 
 * FileAction 
 * 
 * @author Administrator
 *
 */
public class FileAction extends BaseAction {
	
	private final static Logger logger = Logger.getLogger(FileAction.class);

	public static String ROOTPATH = null;
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -7565097044452207935L;

	private FileService fileService;

	private File myUpload;

	private String myUploadContentType;

	private String myUploadFileName;

	private String path;

	private String node="";

	private List<FileNode> nodes;
	
	private List<FileNode> shareNodes;

	private Page page;

	private String name="";

	private String[] paths;
	
	private boolean success;
	
	private String hrmEmpID = null;
		
	private Integer companyID = null;
	
	private INetdiskService netdiskService;
	
	private String isShare = "false";
	
	private double usedSpace;
	
	public static String getROOTPATH(){
		if(ROOTPATH == null) {
		    try {
				ROOTPATH = SystemConfig.getParam("erp.netdisk.path") ;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return ROOTPATH; 
	}

	/**
	 * 功能:得到个人磁盘空间
	 * @throws IOException 
	 */
	public String getPersonalSpace() throws IOException{
		OaNetdiskConfig oaNetdiskConfig = new OaNetdiskConfig();
		oaNetdiskConfig.setCompanyId(getCompanyId());
		oaNetdiskConfig.setHrmEmployeeId(getHrmEmpId());
		Pager page = new Pager();
		page.setStartRow(0);
		page.setTotalPages(1);
		OaNetdiskConfig temp = netdiskService.getOaNetdiskConfigByHrmEmpId(oaNetdiskConfig);
		HttpServletResponse response = ServletActionContext.getResponse();   
        PrintWriter out = response.getWriter();   
		if(temp != null) {
			out.print("{usedSpace:'"+temp.getUsedSpace()+"',totalSpace:'"+temp.getTotalSpace()+"'}");  
			usedSpace = temp.getUsedSpace();
		} else {
			netdiskService.getHrmEmployee(oaNetdiskConfig, getRequest());
			out.print("{usedSpace:'0',totalSpace:'"+UtilTool.getSysParamByIndex(getRequest(), "erp.Net.Disk")+"'}");
		}
		out.close();
		logger.info("磁盘管理显示取值");
		   
		return SUCCESS;
	}
	
	/**
	 * 功能:获得共享的所有目录信息
	 * 
	 * @return
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	public String getShareDirectories() throws FileNotFoundException, IOException,
			Exception {
		String empid = UtilTool.getEmployeeId(getRequest())+",";
		String deptid = UtilTool.getDeptId(getRequest())+",";
		if(node.equals("")) {
			OaNetdiskShare oaNetdiskShare = new OaNetdiskShare();
			oaNetdiskShare.setCompanyId(getCompanyId());
			List<OaNetdiskShare> list = netdiskService.getSharePathByCompanyId(oaNetdiskShare,empid,deptid);
			shareNodes = fileService.listShareFiles(getROOTPATH() + File.separator + getCompanyId() + File.separator, list);
		} else {
			shareNodes = fileService.listFiles(getROOTPATH() + File.separator + getCompanyId() + File.separator,node,getHrmEmpId(), true, true);
		}
		
		return SUCCESS;
	}
   
	/**
	 * 功能:获得指定目录下的所有目录信息
	 * 
	 * @return
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	@SuppressWarnings("unchecked")
	public String getDirectories() throws FileNotFoundException, IOException,
			Exception {
		nodes = fileService.listFiles(getROOTPATH() + File.separator + getCompanyId() + File.separator + getHrmEmpId(), node,getHrmEmpId(), true, false);
		
		return SUCCESS;
	}
	/**
	 * 功能:获得指定文件夹下面的所有文件和文件夹信息
	 * 
	 * @return
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	public String getFiles() throws FileNotFoundException, IOException,
			Exception {
		page = new Page();
		if(isShare.equals("false")) {
			nodes = fileService.listFiles(getROOTPATH() + File.separator + getCompanyId() + File.separator + getHrmEmpId(), node,getHrmEmpId(), false, false);
		} else {
			nodes = fileService.listFiles(getROOTPATH() + File.separator + getCompanyId() + File.separator, node,getHrmEmpId(), false, true);
		}
		page.setRoot(nodes);

		int length = 0;
		try {
			length = new File(node).list().length;
		} catch (Exception e) {
		}
		page.setTotalProperty(length);

		return SUCCESS;
	}
	
	/**
	 * 重命名
	 * 
	 * @return String
	 */
	public String rename() throws Exception{
		String midName = paths[0].substring(0, paths[0].lastIndexOf(File.separator));
		StringBuffer name = new StringBuffer();
		name.append(getROOTPATH() + File.separator + getCompanyId() + File.separator + getHrmEmpId());
		name.append(midName);
		name.append(File.separator);
		name.append(getName());
		setSuccess(fileService.rename(getROOTPATH() + File.separator + getCompanyId() + File.separator + getHrmEmpId() + paths[0], name.toString()));
		
		OaNetdiskShare oaNetdiskShare = new OaNetdiskShare();
		oaNetdiskShare.setCompanyId(getCompanyId());
		oaNetdiskShare.setHrmEmployeeId(getHrmEmpId());
		oaNetdiskShare.setFolderPath(paths[0]);
		netdiskService.saveOaNetdiskShareWhenRenamePath(oaNetdiskShare, midName+File.separator+getName(), getName());
		return SUCCESS;
	}

	/**
	 * 处理中文下载名
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String getDownloadFileName() throws UnsupportedEncodingException {
		if(name==null) return null;
		return new String(name.getBytes(),"ISO-8859-1");
	}
	

	/**
	 * 获得文件下载流
	 * 
	 * @return
	 * @throws FileNotFoundException
	 * @throws UnsupportedEncodingException 
	 */
	public InputStream getInputStream() throws FileNotFoundException, UnsupportedEncodingException {
		if(path==null) return null;
		if(path.lastIndexOf(File.separator) != path.length()){
			path += File.separator;
		}
		
		String downloadFilePath = null;
		if(isShare.equals("false")) {
			downloadFilePath = getROOTPATH() + File.separator + getCompanyId() + File.separator + getHrmEmpId() + getPath() + name;
		} else {
			downloadFilePath = getROOTPATH() + File.separator + getCompanyId() + File.separator  + getPath() + name;
		}
		File f = new File(downloadFilePath);
		return new FileInputStream(f);
	}

	/**
	 * 下载文件
	 * 
	 * @return
	 * @throws IOException 
	 */
	public String download() throws IOException {
		return SUCCESS;
	}

	/**
	 * 解压缩文件
	 * 
	 * @return
	 */
	public String decompressionFiles() {

		boolean flag = fileService.decompressionFiles("", getPath(), paths);
		setSuccess(flag);

		return SUCCESS;
	}
	/**
	 * 多文件下载
	 * 
	 * @throws IOException
	 */
	public String downloadAll() throws IOException {
		return SUCCESS;
	}
	/**
	 * 多文件压缩
	 * 
	 * @return
	 * @throws IOException
	 */
	public String compressionFiles() throws IOException {

		boolean flag = fileService.compressionFiles("", getPath(), paths);
		setSuccess(flag);

		return SUCCESS;
	}

	/**
	 * 多文件删除
	 * 
	 * @return
	 * @throws Exception 
	 */
	public String deleteFiles() throws Exception {
		boolean flag = false;
		try {
			for (String path : paths) {
				flag = delFiles(getROOTPATH() + File.separator + getCompanyId() + File.separator + getHrmEmpId() + path);
				if (!flag) {
					break;
				} else {
					//删除共享
						OaNetdiskShare oaNetdiskShare = new OaNetdiskShare();
						oaNetdiskShare.setCompanyId(getCompanyId());
						oaNetdiskShare.setHrmEmployeeId(getHrmEmpId());
						oaNetdiskShare.setFolderPath(path);
						netdiskService.deleteShareByHrmEmpIDandPath(oaNetdiskShare);
						
				}
			}
			
			HttpServletResponse response = ServletActionContext.getResponse();   
	        PrintWriter out = response.getWriter();   
			out.print("{usedSpace:'"+usedSpace+"'}"); 
			out.close();
			out = null;
		} catch (RuntimeException e) {
			flag = false;
			e.printStackTrace();
		} 
		setSuccess(flag);
		return SUCCESS;
	}
	
    /**  
	 * try to delete given file , try 10 times  
	 * @param f  
	 * @return true if file deleted success, nor false;  
	 */  
	private boolean forceDelete(File f)   
	{   
	    boolean result = false;   
	    int tryCount = 0;   
	    while(!result && tryCount++ <10)   
	    {   
	    System.gc();   
	    result = f.delete();   
	    }   
	    return result;   
	}  

	/**
	 * 删除指定文件路径下面的所有文件和文件夹
	 * 
	 * @param file
	 */
	private boolean delFiles(String fileName) {
		boolean flag = false;
		File file = null;
		int size = 0;
		boolean isFile = false;
		try {
			file = new File(fileName);
			if (file.exists()) {
				if (file.isDirectory()) {
					String[] contents = file.list();
					for (int i = 0; i < contents.length; i++) {
						delFiles(file.getAbsolutePath() + "/" + contents[i]);
					}
				}else {
					FileInputStream fis = new FileInputStream(file);
					size = fis.available();
					fis.close();
					fis = null;
					isFile = true;
				}
			//磁盘空间更新
			
			flag = forceDelete(file);
			if(flag && isFile) {
					//修改磁盘空间
					OaNetdiskConfig oaNetdiskConfig = new OaNetdiskConfig();
					oaNetdiskConfig.setHrmEmployeeId(getHrmEmpId());
					oaNetdiskConfig.setCompanyId(getCompanyId());
					OaNetdiskConfig temp = netdiskService.getOaNetdiskConfigByHrmEmpId(oaNetdiskConfig);
					if(temp != null) {
						double totalUsed = temp.getUsedSpace()-((double)size/1024/1024);
						if(0>totalUsed){
							totalUsed = 0;
						}
						usedSpace = totalUsed;
						temp.setUsedSpace(totalUsed);
						temp.setLastmodiId(getHrmEmpId());
						temp.setLastmodiDate(UtilWork.getNowTime());
						
						netdiskService.SeveOaNetdisk(temp);
					}
			} else if(flag && !isFile) {
				//如果是文件夹
				OaNetdiskConfig oaNetdiskConfig = new OaNetdiskConfig();
				oaNetdiskConfig.setHrmEmployeeId(getHrmEmpId());
				oaNetdiskConfig.setCompanyId(getCompanyId());
				OaNetdiskConfig temp = netdiskService.getOaNetdiskConfigByHrmEmpId(oaNetdiskConfig);
				if(temp != null) {
					usedSpace = temp.getUsedSpace()	;
				}
				
			}
			} else {
				throw new RuntimeException("File not exist!");
			}
		} catch (Exception e) {
			flag = false;
			e.printStackTrace();
		}
		finally {
			file = null;
			
		}
		return flag;
	}

	/**
	 * 创建文件夹
	 * 
	 * @returns
	 */
	public String createFolder() {
		String createPath = getROOTPATH() + File.separator + getCompanyId() + File.separator + getHrmEmpId() + getPath() + File.separator;
		setSuccess(fileService.createDirectory(createPath + getName()));
		return SUCCESS;
	}
 
	/**
	 * 上传文件
	 * 
	 * @return
	 * @throws Exception 
	 */
	public String uploadFiles() throws Exception {
		String sp = getROOTPATH() + File.separator + getCompanyId() + File.separator + getHrmEmpId() + getPath()+ File.separator;
		fileService.createDirectory(sp);
		boolean flag = fileService.upload(getMyUploadFileName(), sp, getMyUpload());
		FileInputStream fis = null;
		if(flag) {
			fis = new FileInputStream(getMyUpload());
			int size = fis.available();
			OaNetdiskConfig oaNetdiskConfig = new OaNetdiskConfig();
			oaNetdiskConfig.setHrmEmployeeId(getHrmEmpId());
			oaNetdiskConfig.setCompanyId(getCompanyId());
			OaNetdiskConfig temp = netdiskService.getOaNetdiskConfigByHrmEmpId(oaNetdiskConfig);
			if(temp != null) {
				double totalUsed = temp.getUsedSpace()+((double)size/1024/1024);
				if(temp.getTotalSpace()<totalUsed){
					throw new Exception("超过磁盘空间大小");
				}
				usedSpace = totalUsed;
				temp.setUsedSpace(totalUsed);
				temp.setLastmodiId(getHrmEmpId());
				temp.setLastmodiDate(UtilWork.getNowTime());
				
				netdiskService.SeveOaNetdisk(temp);
			}
			fis.close();
			fis = null;
			
		}
		setSuccess(flag);
		return SUCCESS;
	}
	
	/**
	 * 创建缩略图
	 * 
	 * @param file
	 *          上传的文件流
	 * @param height
	 *          最小的尺寸
	 * @throws IOException
	 */
	public void createMiniPic() throws IOException {
		String path2 = getRequest().getParameter("path2");
		String path3 = URLDecoder.decode(path2,"UTF-8");
		String isShare = getRequest().getParameter("isShare");
		isShare = URLDecoder.decode(isShare,"UTF-8");
		String filename = null;
		if(isShare.equals("false")) {
			filename = getROOTPATH() + File.separator + getCompanyId() + File.separator + getHrmEmpId() + path3 ;
		} else {
			filename = getROOTPATH() + File.separator + getCompanyId() + File.separator + path3;
		}
		File file = new File(filename);
		Image src = javax.imageio.ImageIO.read(file); 
		int new_w = src.getWidth(null);
		int new_h = src.getHeight(null); 

		BufferedImage tag = new BufferedImage(new_w, new_h, BufferedImage.TYPE_INT_RGB);
		tag.getGraphics().drawImage(src, 0, 0, new_w, new_h, null); // 绘制缩小后的图
		OutputStream os = getResponse().getOutputStream();
		ImageIO.write(tag,   "JPEG",   os);   
		os.flush();
		os.close();
		os = null;
	}

	// =====================================================================
	// ==============getter and setter methods, struts2 auto execute========
	// =====================================================================
	public String getNode() {
		return node;
	}

	public void setNode(String node) {
		node = node == null ? "" : node;
		this.node = node.equals("*") ? "" : node; // 处理根结点特殊id
	}

	public List<FileNode> getNodes() {
		return nodes;
	}

	public void setNodes(List<FileNode> files) {
		this.nodes = files;
	}
	
	/**
	 * @return the shareNodes
	 */
	public List<FileNode> getShareNodes() {
		return shareNodes;
	}

	/**
	 * @param shareNodes the shareNodes to set
	 */
	public void setShareNodes(List<FileNode> shareNodes) {
		this.shareNodes = shareNodes;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) throws UnsupportedEncodingException {
		this.path = path.startsWith("/*") ? "" : path;
		this.path = URLDecoder.decode(this.path, "UTF-8");
	}

	public File getMyUpload() {
		return myUpload;
	}

	public void setMyUpload(File myUpload) {
		this.myUpload = myUpload;
	}

	public String getMyUploadContentType() {
		return myUploadContentType;
	}

	public void setMyUploadContentType(String myUploadContentType) {
		this.myUploadContentType = myUploadContentType;
	}

	public String getMyUploadFileName() {
		return myUploadFileName;
	}

	public void setMyUploadFileName(String myUploadFileName) {
		this.myUploadFileName = myUploadFileName;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getName() {
		return name;
	}

	public void setName(String fileName) throws UnsupportedEncodingException {
		this.name = URLDecoder.decode(fileName, "UTF-8");
		//String fileName1 = new String(fileName.getBytes("ISO8859-1"));
		//String fileName2 = new String(fileName.getBytes("UTF-8"));
		//String fileName3 = new String(fileName.getBytes("GBK"));
		//this.name = fileName;
	}

	public String[] getPaths() {
		return paths;
	}

	public void setPaths(String[] names) {
		this.paths = names;
	}

	/**
	 * @param fileService
	 *            the fileService to set
	 */
	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}
	
	private String getHrmEmpId() {
		if(hrmEmpID == null) {
			hrmEmpID = ((SessionUser) LoginContext.getSessionValueByLogin(getRequest())).getUserInfo().getHrmEmployeeId();
		}
		return hrmEmpID;
	}
	
	private int getCompanyId() {
		if(companyID == null) {
			companyID = UtilTool.getCompanyId(getRequest());
		}
		return companyID;
	}

	/**
	 * @return the netdiskService
	 */
	public INetdiskService getNetdiskService() {
		return netdiskService;
	}

	/**
	 * @param netdiskService the netdiskService to set
	 */
	public void setNetdiskService(INetdiskService netdiskService) {
		this.netdiskService = netdiskService;
	}

	/**
	 * @return the isShare
	 */
	public String getIsShare() {
		return isShare;
	}

	/**
	 * @param isShare the isShare to set
	 */
	public void setIsShare(String isShare) {
		this.isShare = isShare;
	}

	/**
	 * @return the usedSpace
	 */
	public double getUsedSpace() {
		return usedSpace;
	}

	/**
	 * @param usedSpace the usedSpace to set
	 */
	public void setUsedSpace(double usedSpace) {
		this.usedSpace = usedSpace;
	}
	
	

}
