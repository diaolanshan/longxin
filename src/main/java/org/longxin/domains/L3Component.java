package org.longxin.domains;

// Generated 2015-1-17 22:30:04 by Hibernate Tools 3.4.0.CR1

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.CascadeType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * L3Component generated by hbm2java
 */
@Entity
@Table(name = "l3_component", catalog = "longxin")
public class L3Component implements java.io.Serializable, Cloneable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -9171484049534832143L;
	private Integer id;
	private L2Component l2Component;
	private String name;
	private String description;
	private String functionName;
	private Boolean template;
	private Set<L3ComponentParameter> l3ComponentParameters = new HashSet<L3ComponentParameter>(
			0);

	public L3Component()
	{
	}

	public L3Component(L2Component l2Component, String name,
			String description, Set<L3ComponentParameter> l3ComponentParameters)
	{
		this.l2Component = l2Component;
		this.name = name;
		this.description = description;
		this.l3ComponentParameters = l3ComponentParameters;
	}

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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "L2")
	public L2Component getL2Component()
	{
		return this.l2Component;
	}

	public void setL2Component(L2Component l2Component)
	{
		this.l2Component = l2Component;
	}

	@Column(name = "NAME", length = 45)
	public String getName()
	{
		return this.name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	@Column(name = "DESCRIPTION", length = 512)
	public String getDescription()
	{
		return this.description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "l3Component", cascade= CascadeType.ALL)
	public Set<L3ComponentParameter> getL3ComponentParameters()
	{
		return this.l3ComponentParameters;
	}

	public void setL3ComponentParameters(
			Set<L3ComponentParameter> l3ComponentParameters)
	{
		this.l3ComponentParameters = l3ComponentParameters;
	}
	
	@Column(name = "FUNCTION_NAME")
	public String getFunctionName()
	{
		return functionName;
	}

	public void setFunctionName(String functionName)
	{
		this.functionName = functionName;
	}
	
    @Column(name = "TEMPLATE")
    public Boolean getTemplate()
    {
        return this.template;
    }

    public void setTemplate(Boolean template)
    {
        this.template = template;
    }
	
	protected Object clone() throws CloneNotSupportedException{
		L3Component l3Component = (L3Component)super.clone();
		l3Component.setId(null);
		l3Component.setTemplate(Boolean.FALSE);
		if(this.l3ComponentParameters !=null){
			Set<L3ComponentParameter> clonedl3ComponentParameters = new HashSet<L3ComponentParameter>();
			for(L3ComponentParameter l3ComponentParameter : l3ComponentParameters){
				L3ComponentParameter cloneL3ComponentParameter = (L3ComponentParameter) l3ComponentParameter.clone();
				cloneL3ComponentParameter.setL3Component(l3Component);
				clonedl3ComponentParameters.add(cloneL3ComponentParameter);
			}
			l3Component.setL3ComponentParameters(clonedl3ComponentParameters);
		}
		return l3Component;
	}

}
