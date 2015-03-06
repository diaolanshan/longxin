package org.longxin.web.controller;

import java.io.File;
import java.io.IOException;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.LinkedList;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.longxin.web.controller.bean.FileMeta;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/filecontroller")
public class FileController
{
	protected static Logger logger = Logger.getLogger(FileController.class);
	
	public static final String FILE_ROOT = "D:/temp/files";
	
	LinkedList<FileMeta> files = new LinkedList<FileMeta>();
	FileMeta fileMeta = null;

	/***************************************************
	 * @param request
	 *            : MultipartHttpServletRequest auto passed
	 * @param response
	 *            : HttpServletResponse auto passed
	 * @return LinkedList<FileMeta> as json format
	 ****************************************************/
	@RequestMapping(value = "/upload/{folderName}/{componentId}", method = RequestMethod.POST)
	public @ResponseBody LinkedList<FileMeta> upload(
			MultipartHttpServletRequest request, HttpServletResponse response,
			@PathVariable int componentId, @PathVariable String folderName)
	{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		// 1. build an iterator
		Iterator<String> itr = request.getFileNames();
		MultipartFile mpf = null;

		// 2. get each file
		while (itr.hasNext())
		{
			// 2.1 get next MultipartFile
			mpf = request.getFile(itr.next());

			// 2.2 if files > 10 remove the first from the list
			if (files.size() >= 10)
				files.pop();

			// 2.3 create new fileMeta
			fileMeta = new FileMeta();
			fileMeta.setFileName(mpf.getOriginalFilename());
			fileMeta.setFileSize(mpf.getSize() / 1024 + " Kb");
			fileMeta.setFileType(mpf.getContentType());

			try
			{
				File folder = new File(FILE_ROOT + File.separator + folderName + File.separator + componentId);
				if (!folder.exists())
				{
					folder.mkdirs();
				}
				FileCopyUtils.copy(
						mpf.getBytes(),
						new FileOutputStream(folder.getAbsolutePath() + File.separator
								+ mpf.getOriginalFilename()));

			} catch (IOException e)
			{
				logger.error("Error while upload the attachment, detail information are : " + e.getMessage());
			}
			// 2.4 add to files
			files.add(fileMeta);
		}
		// result will be like this
		// [{"fileName":"app_engine-85x77.png","fileSize":"8 Kb","fileType":"image/png"},...]
		return files;
	}
	
	@RequestMapping(value = "/get/{folderName}/{componentId}", method = RequestMethod.GET)
	public @ResponseBody LinkedList<FileMeta> listAttachments(@PathVariable int componentId, @PathVariable String folderName)
	{
		LinkedList<FileMeta> attachments = new LinkedList<FileMeta>();
		
		File folder = new File(FILE_ROOT + File.separator + folderName + File.separator + componentId);
		if (!folder.exists())
		{
			folder.mkdirs();
		}
		
		for(File file : folder.listFiles())
		{
			FileMeta meta = new FileMeta();
			meta.setFileName(file.getName());
			attachments.add(meta);
		}
		
		return attachments;
	}

	/***************************************************
	 * @param response
	 *            : passed by the server
	 * @param value
	 *            : value from the URL
	 * @return void
	 ****************************************************/
	@RequestMapping(value = "/download/{folderName}/{componentId}/{fileName}", method = RequestMethod.GET)
	public void get(HttpServletResponse response,
			@PathVariable int componentId, @PathVariable String folderName,
			@PathVariable String fileName)
	{
		Path attachment = Paths.get(FILE_ROOT + File.separator + folderName
				+ File.separator + componentId + File.separator + fileName);

		try
		{
			response.setContentType(Files.probeContentType(attachment));
			response.setHeader("Content-disposition", "attachment; filename=\""
					+ fileName + "\"");
			FileCopyUtils.copy(Files.readAllBytes(attachment),
					response.getOutputStream());
		} catch (IOException e)
		{
			logger.error("Error while download the attachment, detail information are : "
					+ e.getMessage());
		}
	}
}