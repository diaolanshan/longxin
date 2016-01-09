package org.longxin.service;

import java.util.List;

import org.longxin.domains.Attachment;

public interface AttachmentService
{
    public void saveAttachment(Attachment attachment);
    
    public List<Attachment> getAttachmentByCategoryAndRefID(String category, int referenceID);
    
    public Attachment getAttachmentById(int id);
    
    public void deleteAttachmentsByCategoryAndRefID(String category, int referenceID);
    
    public void deleteAttachment(Attachment attachment);
}

