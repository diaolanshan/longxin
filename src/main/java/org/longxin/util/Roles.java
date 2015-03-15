package org.longxin.util;

public enum Roles {
	ROLE_USER("普通用户"),
	ROLE_TECHNICALSUPPORT("技术人员"),
	ROLE_SUPERTECHNICALSUPPORT("高级技术人员"),
	ROLE_ADMIN("管理员");
	
	private String description;
	
	Roles(String description)
	{
		this.description = description;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}
}
