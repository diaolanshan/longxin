package org.longxin.util;

public enum Roles {
	ROLE_USER("普通用户", 1),
	ROLE_TECHNICALSUPPORT("技术人员", 2),
	ROLE_SUPERTECHNICALSUPPORT("高级技术人员", 3),
	ROLE_ADMIN("管理员",4);
	
	private String description;
	private int degree;
	
	Roles(String description, int degree)
	{
		this.description = description;
		this.degree = degree;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

    public int getDegree()
    {
        return degree;
    }

    public void setDegree(int degree)
    {
        this.degree = degree;
    }
}
