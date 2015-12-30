package org.longxin.domains;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

@MappedSuperclass
public class Component
{
    private Boolean isDraft;
    
    private Boolean searched;
    
    @Column(name = "IS_DRAFT")
    public Boolean getIsDraft()
    {
        return isDraft;
    }

    public void setIsDraft(Boolean isDraft)
    {
        this.isDraft = isDraft;
    }

    @Transient
    public Boolean getSearched()
    {
        return searched;
    }

    public void setSearched(Boolean searched)
    {
        this.searched = searched;
    }
}

