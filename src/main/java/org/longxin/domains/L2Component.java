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
 * L2Component generated by hbm2java
 */
@Entity
@Table(name = "l2_component", catalog = "longxin")
public class L2Component implements java.io.Serializable, Cloneable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5624533630709605459L;
	private Integer id;
	private L1Component l1Component;
	private String name;
	private String description;
	private String functionName;
	private Set<L2ComponentParameter> l2ComponentParameters = new HashSet<L2ComponentParameter>(
			0);
	private Set<L3Component> l3Components = new HashSet<L3Component>(0);

	public L2Component()
	{
	}

	public L2Component(String name)
	{
		this.name = name;
	}

	public L2Component(L1Component l1Component, String name,
			String description,
			Set<L2ComponentParameter> l2ComponentParameters,
			Set<L3Component> l3Components)
	{
		this.l1Component = l1Component;
		this.name = name;
		this.description = description;
		this.l2ComponentParameters = l2ComponentParameters;
		this.l3Components = l3Components;
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
	@JoinColumn(name = "L1")
	public L1Component getL1Component()
	{
		return this.l1Component;
	}

	public void setL1Component(L1Component l1Component)
	{
		this.l1Component = l1Component;
	}

	@Column(name = "NAME", nullable = false, length = 45)
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "l2Component", cascade= CascadeType.ALL)
	public Set<L2ComponentParameter> getL2ComponentParameters()
	{
		return this.l2ComponentParameters;
	}

	public void setL2ComponentParameters(
			Set<L2ComponentParameter> l2ComponentParameters)
	{
		this.l2ComponentParameters = l2ComponentParameters;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "l2Component", cascade= CascadeType.ALL)
	public Set<L3Component> getL3Components()
	{
		return this.l3Components;
	}

	public void setL3Components(Set<L3Component> l3Components)
	{
		this.l3Components = l3Components;
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

	protected Object clone() throws CloneNotSupportedException
	{
		L2Component l2Compoennt = (L2Component)super.clone();
		l2Compoennt.setId(null);
		
		if (this.l2ComponentParameters != null)
		{
			Set<L2ComponentParameter> clonedL2ComponentsParameters = new HashSet<L2ComponentParameter>();

			for (L2ComponentParameter l2ComponentParameter : l2ComponentParameters)
			{
				L2ComponentParameter clonedL2ComponentsParameter = (L2ComponentParameter) l2ComponentParameter.clone();
				clonedL2ComponentsParameter.setL2Component(l2Compoennt);
				clonedL2ComponentsParameters.add(clonedL2ComponentsParameter);
			}

			l2Compoennt.setL2ComponentParameters(clonedL2ComponentsParameters);
		}

		if (this.l3Components != null)
		{
			Set<L3Component> clonedl3Components = new HashSet<L3Component>();
			
			for(L3Component l3Component : l3Components){
				L3Component clonedl3Component = (L3Component) l3Component.clone();
				clonedl3Component.setL2Component(l2Compoennt);
				clonedl3Components.add(clonedl3Component);
			}
			
			l2Compoennt.setL3Components(clonedl3Components);
		}
		return l2Compoennt;
	}
}
