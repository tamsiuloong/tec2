package com.jeecms.common.office;
/**
 * @author Tom
 */

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeManager;
import org.springframework.beans.factory.annotation.Autowired;

import com.artofsolving.jodconverter.DocumentFormat;
import com.jeecms.common.upload.UploadUtils;
import com.jeecms.common.util.SystemUtil;
import com.jeecms.common.web.Constants;
import com.jeecms.core.entity.CmsConfig;
import com.jeecms.core.manager.CmsConfigMng;

public class OpenOfficeConverter {

	public void startService() {
//		DefaultOfficeManagerConfiguration configuration = new DefaultOfficeManagerConfiguration();
//		try {
//			System.out.println("准备启动服务....");
//			configuration.setOfficeHome(getOfficeHome());// 设置OpenOffice.org安装目录
//			configuration.setPortNumber(getPort()); // 设置转换端口，默认为8100
//			configuration.setTaskExecutionTimeout(1000 * 60 * 5L);// 设置任务执行超时为5分钟
//			configuration.setTaskQueueTimeout(1000 * 60 * 60 * 24L);// 设置任务队列超时为24小时
//
//			officeManager = configuration.buildOfficeManager();
//			officeManager.start(); // 启动服务
//			System.out.println("office转换服务启动成功!");
//		} catch (Exception ce) {
//			System.out.println("office转换服务启动失败!详细信息:" + ce);
//		}
	}

	public void stopService() {
		System.out.println("关闭office转换服务....");
		if (officeManager != null) {
			officeManager.stop();
		}
		System.out.println("关闭office转换成功!");
	}

	/**
	 * 转换格式
	 * 
	 * @param inputFile
	 *            需要转换的原文件路径
	 * @param fileType
	 *            要转换的目标文件类型 html,pdf
	 */
	public File convert(String inputFile, String outPath, String fileType) {
		// String outputFile = getFilePath()
		// +"/"+Calendar.getInstance().getTime().getTime()+fileType;
		String outputFile = UploadUtils.generateFilename(outPath, fileType);
		if (inputFile.endsWith(".txt")) {
			String odtFile = FileUtils.getFilePrefix(inputFile) + ".odt";
			if (new File(odtFile).exists()) {
				System.out.println("odt文件已存在！");
				inputFile = odtFile;
			} else {
				try {
					FileUtils.copyFile(inputFile, odtFile);
					inputFile = odtFile;
				} catch (FileNotFoundException e) {
					System.out.println("文档不存在！");
					e.printStackTrace();
				}
			}
		}
		OfficeDocumentConverter converter = new OfficeDocumentConverter(officeManager);
		File output = new File(outputFile);
		converter.convert(new File(inputFile), output);
		return output;
	}

	/**
	 * 转换格式
	 * 
	 * @param inputFile
	 *            需要转换的原文件路径
	 * @param fileType
	 *            要转换的目标文件类型 html,pdf
	 */
	public File convert(String inputFile, String fileType, boolean delOldFile) {
		String outputFile = UploadUtils.generateFilename(getFilePath(), fileType);
		if (inputFile.endsWith(".txt")) {
			String filecode = "";
			filecode=ConverEncoding.getFilecharset(inputFile);
			if (SystemUtil.isOSLinux()) {
				if (!filecode.equals(Constants.UTF8)) {
					try {
						Process process = Runtime.getRuntime()
								.exec("iconv -f " + filecode + "  -t utf-8 " + inputFile + " -c -s -o " + inputFile);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			} else {
				//UTF8编码的文本不需要转odt格式
				if (!filecode.equals(Constants.UTF8)) {
					String odtFile = FileUtils.getFilePrefix(inputFile) + ".odt";
					File tempFile = new File(odtFile);
					if (tempFile.exists()) {
						inputFile = odtFile;
					} else {
						try {
							FileUtils.copyFile(inputFile, odtFile);
							tempFile = new File(odtFile);
							inputFile = odtFile;
						} catch (FileNotFoundException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		OfficeDocumentConverter converter = new OfficeDocumentConverter(officeManager);
		File output = new File(outputFile);
		File oldFile = new File(inputFile);
		converter.convert(oldFile, output);
		if (delOldFile && oldFile.exists()) {
			oldFile.delete();
		}
		return output;
	}

	public File convertToPdf(String inputFile, String outPath, String fileName) {
		String outputFile = UploadUtils.generateByFilename(outPath, fileName, PDF);
		File tempFile = null;
		if (inputFile.endsWith(".txt")) {
			String filecode = "";
			filecode=ConverEncoding.getFilecharset(inputFile);
			if (SystemUtil.isOSLinux()) {
				if (!filecode.equals(Constants.UTF8)) {
					try {
						Process process = Runtime.getRuntime()
								.exec("iconv -f " + filecode + "  -t utf-8 " + inputFile + " -c -s -o " + inputFile);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			} else {
				//UTF8编码的文本不需要转odt格式
				if (!filecode.equals(Constants.UTF8)) {
					String odtFile = FileUtils.getFilePrefix(inputFile) + ".odt";
					tempFile = new File(odtFile);
					if (tempFile.exists()) {
						inputFile = odtFile;
					} else {
						try {
							FileUtils.copyFile(inputFile, odtFile);
							tempFile = new File(odtFile);
							inputFile = odtFile;
						} catch (FileNotFoundException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		OfficeDocumentConverter converter = new OfficeDocumentConverter(officeManager);
		File output = new File(outputFile);
		converter.convert(new File(inputFile), output);
		if (tempFile != null && tempFile.exists()) {
			 tempFile.delete();
		}
		return output;
	}

	public void init() {
		CmsConfig config = cmsConfigMng.get();
		OpenOfficeConverter coverter = new OpenOfficeConverter(config.getOfficeHome(), config.getOfficePort());
		coverter.startService();
		this.openOfficeConverter = coverter;
	}

	public void destroy() {
		this.openOfficeConverter.stopService();
	}

	public static void main(String[] args) {
		OpenOfficeConverter cov = new OpenOfficeConverter();
		Long s1 = System.currentTimeMillis();
		cov.startService();
		System.out.println("启动消耗时间+" + (System.currentTimeMillis() - s1) / 1000.0);

		OfficeDocumentConverter converter = new OfficeDocumentConverter(officeManager);
		File output = new File("/Users/mackbook/Desktop/office/");
		String inputFile = "测试.docx";
		if (inputFile.endsWith(".txt")) {
			String odtFile = FileUtils.getFilePrefix(inputFile) + ".odt";
			if (new File(odtFile).exists()) {
				System.out.println("odt文件已存在！");
				inputFile = odtFile;
			} else {
				try {
					FileUtils.copyFile(inputFile, odtFile);
					inputFile = odtFile;
				} catch (FileNotFoundException e) {
					System.out.println("文档不存在！");
					e.printStackTrace();
				}
			}
		}
		converter.convert(new File(inputFile), output);

		System.out.println("转换消耗时间" + (System.currentTimeMillis() - s1) / 1000.0);
		cov.stopService();
		System.out.println("停止消耗时间" + (System.currentTimeMillis() - s1) / 1000.0);
	}

	@Autowired
	private CmsConfigMng cmsConfigMng;
	private OpenOfficeConverter openOfficeConverter;
	private static OfficeManager officeManager;
	public static final String HTML = "html";
	public static final String PDF = "pdf";
	public static final String TXT = "txt";
	public static final String DOC = "doc";
	public static final String DOCX = "docx";
	public static final String XLS = "xls";
	public static final String XLSX = "xlsx";
	public static final String PPT = "ppt";
	public static final String PPTX = "pptx";
	public static final String WPS = "wps";
	private String officeHome = "/Users/macbook/Desktop/office/";
	private int port = 8100;
	private String filePath;

	public OpenOfficeConverter(String officeHome, int port, String filePath) {
		super();
		this.officeHome = officeHome;
		this.port = port;
		this.filePath = filePath;
	}

	public OpenOfficeConverter(String officeHome, int port) {
		super();
		this.officeHome = officeHome;
		this.port = port;
	}

	public OpenOfficeConverter() {
		super();
	}

	public OpenOfficeConverter getOpenOfficeConverter() {
		return openOfficeConverter;
	}

	public void setOpenOfficeConverter(OpenOfficeConverter openOfficeConverter) {
		this.openOfficeConverter = openOfficeConverter;
	}

	public String getOfficeHome() {
		return officeHome;
	}

	public void setOfficeHome(String officeHome) {
		this.officeHome = officeHome;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

}
