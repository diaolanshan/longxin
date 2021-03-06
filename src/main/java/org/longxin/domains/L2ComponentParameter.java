package org.longxin.domains;

// Generated 2015-1-17 22:30:04 by Hibernate Tools 3.4.0.CR1

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * L2ComponentParameter generated by hbm2java
 */
@Entity
@Table(name = "l2_component_parameter", catalog = "longxin")
public class L2ComponentParameter extends ComponentParameter implements java.io.Serializable, Cloneable
{
    /**
	 * 
	 */
    private static final long serialVersionUID = -446309577881678496L;

    public String CATEGORY = "L2COMPONENTPARAMETER";

    private L2Component l2Component;

    public L2ComponentParameter()
    {
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "L2_COMPONENT")
    public L2Component getL2Component()
    {
        return this.l2Component;
    }

    public void setL2Component(L2Component l2Component)
    {
        this.l2Component = l2Component;
    }

    protected Object clone() throws CloneNotSupportedException
    {
        L2ComponentParameter l2ComponentParameter = (L2ComponentParameter) super.clone();
        l2ComponentParameter.setId(null);
        return l2ComponentParameter;
    }

    @Override
    @Transient
    public String getCategory()
    {
        return this.CATEGORY;
    }
}
