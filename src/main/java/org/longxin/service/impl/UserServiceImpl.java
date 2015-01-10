package org.longxin.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.longxin.dao.UserDAO;
import org.longxin.domains.Users;
import org.longxin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

public class UserServiceImpl implements UserService{
	
	protected static Logger logger = Logger.getLogger(UserServiceImpl.class);
	
	@Autowired
	UserDAO userDAO;
	
	public Users findUserByUserName(String userName)
	{
		return userDAO.findUserByUserName(userName);
	}
	
	public List<Users> getAllUsers()
	{
		return userDAO.getAllUsers();
	}
	
	public Users findUserByID(int userID)
	{
		return userDAO.findUserByID(userID);
	}
	
	public List<Users> searchUsers(String keyword)
	{
		return userDAO.searchUsers(keyword);
	}
}
