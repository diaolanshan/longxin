package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.UserDAO;
import org.longxin.domains.Users;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class UserDAOImpl extends HibernateDaoSupport implements UserDAO
{
	@SuppressWarnings("unchecked")
	public Users findUserByUserName(String userName)
	{
		List<Users> users = (List<Users>) this.getHibernateTemplate().find(
				"FROM Users user WHERE user.username = ?", userName);

		if (users != null && users.size() > 0)
		{
			return users.get(0);
		}

		return null;
	}

	@SuppressWarnings("unchecked")
	public List<Users> getAllUsers()
	{
		return this.getHibernateTemplate().find("FROM Users");
	}

	public void deleteUserByID(int userID)
	{
		Users user = this.findUserByID(userID);
		this.getHibernateTemplate().delete(user);
	}

	public Users findUserByID(int userID)
	{
		return this.getHibernateTemplate().get(Users.class, userID);
	}

	public void saveUser(Users user)
	{
		this.getHibernateTemplate().saveOrUpdate(user);
	}

	@SuppressWarnings("unchecked")
	public List<Users> searchUsers(String keyword)
	{
		String wildcardKeyword = "%" + keyword +"%";
		List<Users> users = (List<Users>) this.getHibernateTemplate().find(
				"FROM Users user WHERE user.username LIKE ? OR user.telephone like ? ", wildcardKeyword, wildcardKeyword);
		return users;
	}

	public void editUser(Users user) {
		/*Session session = this.getSessionFactory().getCurrentSession(); 
		session.beginTransaction(); 
		Query query = session.createQuery("update longxin.users set DEPARTMENT="+
				user.getDepartment()+", role="+user.getRole()+", TELEPHONE="+user.getTelephone()+", USERNAME="+user.getUsername()+" where ID="+user.getId()); 
		query.executeUpdate(); 
		session.getTransaction().commit(); */
		this.getHibernateTemplate().saveOrUpdate(user);
	}
}
