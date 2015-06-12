package org.longxin.domains;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

@MappedSuperclass
public abstract class ComponentParameter
{
    private Integer id;
    private String parameterName;
    private String parameterValue;
    private String unitName;
    private String options;
    private String minValue;
    private String maxValue;
    private Boolean isDraft;
    private String draftValue;
    private String changeReason;
    private Boolean scopeStatus;
    private Boolean searched;
    private String tempParameterValue;
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "ID", unique = true, nullable = false)
    public Integer getId()
    {
        return this.id;
    }

    public void setId(Integer id)
    {
        this.id = id;
    }
    
    @Column(name = "PARAMETER_NAME", nullable = false, length = 128)
    public String getParameterName()
    {
        return this.parameterName;
    }

    public void setParameterName(String parameterName)
    {
        this.parameterName = parameterName;
    }

    @Column(name = "PARAMETER_VALUE", length = 256)
    public String getParameterValue()
    {
        return this.parameterValue;
    }

    public void setParameterValue(String parameterValue)
    {
        this.parameterValue = parameterValue;
    }

    @Column(name = "UNIT_NAME", length = 45)
    public String getUnitName()
    {
        return this.unitName;
    }

    public void setUnitName(String unitName)
    {
        this.unitName = unitName;
    }

    @Column(name = "OPTIONS", length = 512)
    public String getOptions()
    {
        return this.options;
    }

    public void setOptions(String options)
    {
        this.options = options;
    }

    @Column(name = "MIN_VALUE", length = 128)
    public String getMinValue()
    {
        return minValue;
    }

    public void setMinValue(String minValue)
    {
        this.minValue = minValue;
    }

    @Column(name = "MAX_VALUE", length = 128)
    public String getMaxValue()
    {
        return maxValue;
    }

    public void setMaxValue(String maxValue)
    {
        this.maxValue = maxValue;
    }
    
    @Column(name = "IS_DRAFT")
    public Boolean getIsDraft()
    {
        return isDraft;
    }

    public void setIsDraft(Boolean isDraft)
    {
        this.isDraft = isDraft;
    }

    @Column(name = "DRAFT_VALUE", length = 256)
    public String getDraftValue()
    {
        if (this.draftValue == null)
        {
            return this.getParameterValue();
        }
        return draftValue;
    }

    public void setDraftValue(String draftValue)
    {
        this.draftValue = draftValue;
    }
    
    @Transient
    public abstract String getCategory();

    @Transient
    public String getChangeReason()
    {
        return changeReason;
    }

    public void setChangeReason(String changeReason)
    {
        this.changeReason = changeReason;
    }

    @Column(name = "SCOPE_STATUS")
    public Boolean getScopeStatus()
    {
        return scopeStatus;
    }

    public void setScopeStatus(Boolean scopeStatus)
    {
        this.scopeStatus = scopeStatus;
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

    @Transient
    public String getTempParameterValue()
    {
        if (this.tempParameterValue == null)
        {
            tempParameterValue = this.parameterValue;
        }
        return tempParameterValue;
    }

    public void setTempParameterValue(String tempParameterValue)
    {
        this.tempParameterValue = tempParameterValue;
    }
}

