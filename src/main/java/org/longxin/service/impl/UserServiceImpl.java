package org.longxin.service.impl;

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
}
