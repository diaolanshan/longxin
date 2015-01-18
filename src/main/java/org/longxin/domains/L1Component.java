package org.longxin.domains;

// Generated 2015-1-17 22:30:04 by Hibernate Tools 3.4.0.CR1

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * L1Component generated by hbm2java
 */
@Entity
@Table(name = "l1_component", catalog = "longxin")
public class L1Component implements java.io.Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2912980312734388140L;
	private Integer id;
	private Module module;
	private String name;
	private String description;
	private Set<L1ComponentParameter> l1ComponentParameters = new HashSet<L1ComponentParameter>(
			0);
	private Set<L2Component> l2Components = new HashSet<L2Component>(0);

	public L1Component()
	{
	}

	public L1Component(String name)
	{
		this.name = name;
	}

	public L1Component(Module module, String name, String description,
			Set<L1ComponentParameter> l1ComponentParameters,
			Set<L2Component> l2Components)
	{
		this.module = module;
		this.name = name;
		this.description = description;
		this.l1ComponentParameters = l1ComponentParameters;
		this.l2Components = l2Components;
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
	@JoinColumn(name = "MODULE")
	public Module getModule()
	{
		return this.module;
	}

	public void setModule(Module module)
	{
		this.module = module;
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "l1Component")
	public Set<L1ComponentParameter> getL1ComponentParameters()
	{
		return this.l1ComponentParameters;
	}

	public void setL1ComponentParameters(
			Set<L1ComponentParameter> l1ComponentParameters)
	{
		this.l1ComponentParameters = l1ComponentParameters;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "l1Component")
	public Set<L2Component> getL2Components()
	{
		return this.l2Components;
	}

	public void setL2Components(Set<L2Component> l2Components)
	{
		this.l2Components = l2Components;
	}

}
