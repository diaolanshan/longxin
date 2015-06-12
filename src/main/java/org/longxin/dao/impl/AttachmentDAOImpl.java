package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.AttachmentDAO;
import org.longxin.domains.Attachment;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class AttachmentDAOImpl extends HibernateDaoSupport implements AttachmentDAO
{

    @Override
    public void saveOrUpdateAttachment(Attachment attachment)
    {
       this.getHibernateTemplate().saveOrUpdate(attachment);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Attachment> getAttachmentByCategoryAndRefID(String category, int referenceID)
    {
        return this.getHibernateTemplate().find("FROM Attachment att WHERE att.category =? AND att.referenceId = ? ", new Object[]{category, referenceID});
    }

    @Override
    public Attachment getAttachmentById(int id)
    {
        return this.getHibernateTemplate().get(Attachment.class, id);
    }
    
    @Override
    public void deleteAttachment(Attachment attachment)
    {
        this.getHibernateTemplate().delete(attachment);
    }
}

