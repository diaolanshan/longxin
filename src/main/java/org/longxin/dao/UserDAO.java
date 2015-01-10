package org.longxin.dao;

import java.util.List;

import org.longxin.domains.Users;

public interface UserDAO {

	public Users findUserByUserName(String userName);

	public List<Users> getAllUsers();
	
	public void deleteUserByID(int userID);

	public Users findUserByID(int userID);

	public void saveUser(Users user);
	
	public List<Users> searchUsers(String keyword);
}
