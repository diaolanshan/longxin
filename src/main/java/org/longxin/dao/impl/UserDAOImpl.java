package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.UserDAO;
import org.longxin.domains.Users;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class UserDAOImpl extends HibernateDaoSupport implements UserDAO {

	@SuppressWarnings("unchecked")
	public Users findUserByUserName(String userName) {
		List<Users> users = (List<Users>) this.getHibernateTemplate().find(
				"FROM Users user WHERE user.username = ?", userName);
		
		if(users!=null&&users.size()>0)
		{
			return users.get(0);
		}
		
		return null;
	}
}
