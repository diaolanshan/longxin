package org.longxin.service;

import java.util.List;

import org.longxin.domains.Users;

public interface UserService {

	public Users findUserByUserName(String userName);
	
	public List<Users> getAllUsers();
	
	public Users findUserByID(int userID);
	
	public List<Users> searchUsers(String keyword);
	
	public void addUser(Users user);
	
	public void editUser(Users user);
	
	public void deleteUser(int userID);
}
