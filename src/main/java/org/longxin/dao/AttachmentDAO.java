package org.longxin.dao;

import java.util.List;

import org.longxin.domains.Attachment;

/**
 * Interface for the service which used to access the database object.
 * @author ZER8SZH
 */
public interface AttachmentDAO {

	public void saveOrUpdateAttachment(Attachment attachment);
	
	public List<Attachment> getAttachmentByCategoryAndRefID(String category, int referenceID);
	
	public Attachment getAttachmentById(int id);
	
	public void deleteAttachment(Attachment attachment);
}
