package org.longxin.dao;

import java.util.List;

import org.longxin.domains.Attachment;

public interface AttachmentDAO {

	public void saveOrUpdateAttachment(Attachment attachment);
	
	public List<Attachment> getAttachmentByCategoryAndRefID(String category, int referenceID);
	
	public Attachment getAttachmentById(int id);
	
	public void deleteAttachment(Attachment attachment);
}
