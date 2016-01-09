package org.longxin.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.longxin.dao.AttachmentDAO;
import org.longxin.domains.Attachment;
import org.longxin.service.AttachmentService;
import org.longxin.web.controller.FileController;
import org.springframework.beans.factory.annotation.Autowired;

public class AttachmentServiceImpl implements AttachmentService
{
    protected static Logger logger = Logger.getLogger(FileController.class);
    
    public static final String FILE_ROOT = "D:/temp/files";
    
    @Autowired
    AttachmentDAO attachmentDAO;

    @Override
    public void saveAttachment(Attachment attachment)
    {
        attachment.setCreatedat(new Date());
        this.attachmentDAO.saveOrUpdateAttachment(attachment);
    }
    
    @Override
    public List<Attachment> getAttachmentByCategoryAndRefID(String category, int referenceID)
    {
        return this.attachmentDAO.getAttachmentByCategoryAndRefID(category, referenceID);
    }
    
    @Override
    public void deleteAttachmentsByCategoryAndRefID(String category, int referenceID)
    {
        List<Attachment> attachments = this.attachmentDAO.getAttachmentByCategoryAndRefID(category, referenceID);
        for(Attachment attachment : attachments)
        {
            attachment.setOwner(null);
            this.attachmentDAO.deleteAttachment(attachment);
            File folder = new File(FILE_ROOT + File.separator + category + File.separator + referenceID);
            if(folder.exists())
            {
                try
                {
                    FileUtils.deleteDirectory(folder);
                }
                catch (IOException e)
                {
                   logger.error("Error while delete folder " + folder.getPath());
                }
            }
        }
    }

    @Override
    public Attachment getAttachmentById(int id)
    {
        return this.attachmentDAO.getAttachmentById(id);
    }
    
    @Override
    public void deleteAttachment(Attachment attachment)
    {
    	this.attachmentDAO.deleteAttachment(attachment);
    }
}

