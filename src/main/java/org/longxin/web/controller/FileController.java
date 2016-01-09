package org.longxin.web.controller;

import java.io.File;
import java.io.IOException;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.longxin.domains.Attachment;
import org.longxin.service.AttachmentService;
import org.longxin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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

    @Value("#{applicationSetting['fileRoot']}")
    String fileRoot;

    LinkedList<Attachment> files = new LinkedList<Attachment>();

    @Autowired
    UserService userService;
    
    @Autowired
    AttachmentService attachmentService;

    /***************************************************
     * @param request : MultipartHttpServletRequest auto passed
     * @param response : HttpServletResponse auto passed
     * @return LinkedList<FileMeta> as json format
     ****************************************************/
    @RequestMapping(value = "/upload/{category}/{componentId}", method = RequestMethod.POST)
    public @ResponseBody
    LinkedList<Attachment> upload(
        MultipartHttpServletRequest request,
        HttpServletResponse response,
        @PathVariable int componentId,
        @PathVariable String category)
    {
        // 1. build an iterator
        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf = null;

        // 2. get each file
        while (itr.hasNext())
        {
            // 2.1 get next MultipartFile
            mpf = request.getFile(itr.next());

            try
            {
                File folder = new File(fileRoot + File.separator + category + File.separator + componentId);
                if (!folder.exists())
                {
                    folder.mkdirs();
                }
                FileCopyUtils.copy(
                    mpf.getBytes(),
                    new FileOutputStream(folder.getAbsolutePath() + File.separator + mpf.getOriginalFilename()));

                files.add(persistToDB(category, componentId, mpf.getOriginalFilename()));
            }
            catch (IOException e)
            {
                logger.error("Error while upload the attachment, detail information are : " + e.getMessage());
            }
        }
        // result will be like this
        // [{"fileName":"app_engine-85x77.png","fileSize":"8 Kb","fileType":"image/png"},...]
        return files;
    }
    
    @RequestMapping(value = "/{category}/{attachmentId}", method = RequestMethod.DELETE)
    public String deleteAttachment(@PathVariable int attachmentId,
        @PathVariable String category)
    {
    	Attachment attachment = attachmentService.getAttachmentById(attachmentId);
    	
    	File attachmentFile = new File(fileRoot + File.separator + category + File.separator + attachment.getReferenceId() + File.separator + attachment.getFileName());
    	
    	if(attachmentFile.exists())
    	{
    		attachmentFile.delete();
    	}
    	
    	attachmentService.deleteAttachment(attachment);   
    
		return "/" + category.toLowerCase() + "/view";
    }
    
    @RequestMapping(value = "/upload/{category}/{componentId}/{parameterId}", method = RequestMethod.POST)
    public @ResponseBody
    LinkedList<Attachment> uploadParameterAttachment(
        MultipartHttpServletRequest request,
        HttpServletResponse response,
        @PathVariable String category,
        @PathVariable int componentId,
        @PathVariable int parameterId
        )
    {
        // 1. build an iterator
        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf = null;

        // 2. get each file
        while (itr.hasNext())
        {
            // 2.1 get next MultipartFile
            mpf = request.getFile(itr.next());

            try
            {
                File folder = new File(fileRoot + File.separator + category + File.separator + componentId);
                if (!folder.exists())
                {
                    folder.mkdirs();
                }
                FileCopyUtils.copy(
                    mpf.getBytes(),
                    new FileOutputStream(folder.getAbsolutePath() + File.separator + mpf.getOriginalFilename()));

                files.add(persistToDB(category, componentId, mpf.getOriginalFilename()));
            }
            catch (IOException e)
            {
                logger.error("Error while upload the attachment, detail information are : " + e.getMessage());
            }
        }
        // result will be like this
        // [{"fileName":"app_engine-85x77.png","fileSize":"8 Kb","fileType":"image/png"},...]
        return files;
    }

    private Attachment persistToDB(String category, int referenceId, String fileName)
    {
        UserDetails  userDetails  = (UserDetails ) SecurityContextHolder.getContext()
                .getAuthentication()
                .getPrincipal();
        
        Attachment attachment = new Attachment();
        attachment.setCategory(category);
        attachment.setFileName(fileName);
        attachment.setReferenceId(referenceId);
        attachment.setOwner(userService.findUserByUserName(userDetails.getUsername()));
        
        attachmentService.saveAttachment(attachment);
        
        return attachment;
    }
    
    @RequestMapping(value = "/get/{category}/{componentId}", method = RequestMethod.GET)
    public @ResponseBody
    List<Attachment> listAttachments(@PathVariable int componentId, @PathVariable String category)
    {
        return attachmentService.getAttachmentByCategoryAndRefID(category, componentId);
    }

    /***************************************************
     * @param response : passed by the server
     * @param value : value from the URL
     * @return void
     ****************************************************/
    @RequestMapping(value = "/download/{attachmentId}", method = RequestMethod.GET)
    public void get(
        HttpServletResponse response,
        @PathVariable int attachmentId)
    {
        Attachment attachment = this.attachmentService.getAttachmentById(attachmentId);
        Path file = Paths.get(fileRoot + File.separator + attachment.getCategory() + File.separator + attachment.getReferenceId()
                + File.separator + attachment.getFileName());

        try
        {
            response.setContentType(Files.probeContentType(file));
            response.setHeader("Content-disposition", "attachment; filename=\"" + attachment.getFileName() + "\"");
            FileCopyUtils.copy(Files.readAllBytes(file), response.getOutputStream());
        }
        catch (IOException e)
        {
            logger.error("Error while download the attachment, detail information are : " + e.getMessage());
        }
    }
}