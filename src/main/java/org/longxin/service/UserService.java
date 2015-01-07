package org.longxin.service;

import java.util.List;

import org.longxin.domains.Users;

public interface UserService {

	public Users findUserByUserName(String userName);
	
	public List<Users> getAllUsers();
	
	public Users findUserByID(int userID);
}
